
import Foundation

class NewsChallengeDataManager {
    
    let localDataManager: LocalNewsChallengeDataManager
    let remoteDataManager: RemoteNewsChallengeDataManager
    
    init(localDataManager: LocalNewsChallengeDataManager,
         remoteDataManager: RemoteNewsChallengeDataManager) {
        
        self.localDataManager = localDataManager
        self.remoteDataManager = remoteDataManager
    }
}
