Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B1E74FABB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjGKWLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjGKWLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:11:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DC61987;
        Tue, 11 Jul 2023 15:10:46 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BIDDsJ011193;
        Tue, 11 Jul 2023 22:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=sJdYG9TJ5ptIRFIrt8AEeUT1n1ZOgrXWD30BKh22RXw=;
 b=B730hXWspKxIFzPsDkBCLW3TbN8j/P9oPAX/CXEKdtUj9uTDtSD+Z+n2b3tN8xkA2qbP
 MNUZxdahyX2QqOHwonC5cs6oK8FvhR4BjzMYtpW3Wra4ipQ7CCa9n7qJ5h/C2fj/5lDM
 v7LmRdMcnZAZ0Iu3tdThAQ5rNve/+8qqyMJ6xUhEqY2JXWDUOcZnVKp3Ox0JIBir2f6M
 tMxeAWIICtBUO89XSgYZva7XyObWmj16o2e8QpyA5/s0kO/eNlDODFT6Od+a4InLSOsa
 OGo7+Do6YaMckyfE4wlTlOzJ/eRshkiBfZBCkJOVvY0yzfEfZscZAB5pW0dyeLFZ7j5G CQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrfj63xxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 22:09:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36BLnjKf008288;
        Tue, 11 Jul 2023 22:09:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx8btb1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 22:09:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUO+eDAsJ6kNquJMWHFVBD1kaNI3AIEJG3r3zwqCLTMPEtKoXQ/kOgBzNe4h+xX3RPSg08O2Njp3s1SZNULXpjtqtLLy2H7CYQhPbj/ekhzrTkoc1rxAIvNm1v+5kCC4qST3J186yHIm+5pUy3JGrisam/SyyVaiqo6tZsQc9p7vO3nsIadmsOlSR1R5T4+ampCwIbVylD2R2JmjnwGpAuqqmZ2d2h8IDNKfoT28HVtCC2sx1mSrQAIMmg30NiITkXNIywwmE223Cdpctji/CFqtTJXWghGxc6ioVyx0jrWK+8kNe35VgxLT5wFE+PdZUpBIoR8MsbRIXd4KqFp4Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJdYG9TJ5ptIRFIrt8AEeUT1n1ZOgrXWD30BKh22RXw=;
 b=ZUhvJjlnHv9cjrAdPJ+uOBRgrTOBp3EpzvjBiYTGwO9e3dnY9K4Is4dFQ+HMW1Fm4yACZdRVIkh7qCUkDRh/d+PCXDrPuK3GXWsJqAw6zJ40tbX5MO26bUsZ33FMaH5yHyN2OMD0ZASIBASjbvt2ZK07mEsiBQqmbNYR2KNd1FIDbw0vFCQmPo1XKnMqxonHq0TvvCY/v9Qb4EzemcHj8FE2dykFS+E4GyMoctYi2MuGMEr8IBE7SJ3GPC0VSEt8VHpL+8vJUYVaIiJKmgvO3Ob6+HDYa9DUHXjV+SjMzAuH5a16Ejek+ewOrbyvTvFHKB5Cbl4SBNlKVE+Z/dZqQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJdYG9TJ5ptIRFIrt8AEeUT1n1ZOgrXWD30BKh22RXw=;
 b=yD29ExCrpmdnqrgTaYjIdWK3xGw0luEX/GhTKNu8rYd0sVZB4d7P0iGBmf8nSdAnFatOv5ZTGKwTYBvGCR1v8Hl8u5YZk2/G8VhXKUo8KGYgZniKCtGLEERaiY5fFGljeqBjPtDnfYWfX7CawKqk7tnbYl6DE8nn54sDKWwNqYQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB4775.namprd10.prod.outlook.com (2603:10b6:510:38::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Tue, 11 Jul
 2023 22:09:54 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6588.017; Tue, 11 Jul 2023
 22:09:54 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Jiaqi Yan <jiaqiyan@google.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>, stable@vger.kernel.org
Subject: [PATCH 2/2] hugetlb: optimize update_and_free_pages_bulk to avoid lock cycles
Date:   Tue, 11 Jul 2023 15:09:42 -0700
Message-ID: <20230711220942.43706-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711220942.43706-1-mike.kravetz@oracle.com>
References: <20230711220942.43706-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:303:8e::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB4775:EE_
X-MS-Office365-Filtering-Correlation-Id: 30e7a8e0-80dc-41ef-8262-08db825b8df0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dpmyNp5nzk/kh69KnARlekYnOH7h33pDQ85apHgfprMZx5yUThMCufUXEzwiWBZ2f0KqsIUKmYAuiXcvL1kdNDAoU/O0k5AN/yn//ZzIZ/wnG9zJQFVzgttRW/AiO3dWQWPXZco9rdwnk7EdrijQGg70V/wWKBFO0YeYMeQMvibx27JHV1R+eCBQiVD8kEgj0lW3qtgLsres/d6Bi+RmZzjX69ImaiKUYfWRqfWsYxM0de8TaJoxlg+0HiV0Akw6KYwyL1YNirm7kuRl0IrG/uDtkP+4pmDi7gtwYVLR8H7n2Pi5JLMta5Nq5GxtjNcKQ/SS/uGuUwvA1NWD8mZDoliPMiv6Asq8MVFWxUG8Hntc/aOglOqJM35WSVCYyICM9tAETwzjqUxmjtLaTMX4zlh+FdIkkAC69peUEhNA1mtyq6CyooT544vE0Q9Z1m10q44rrrDO1sqeD6lM/HBK7VaBWCDAQDWmlXX/cCTWPMgfTPipTA2JWzbcHJyTJBm8xefwIe9cgxMV1/XN0EHMEzjCKax2Q8TozW5u57uLcIGp55VsndLtrsSH/ndeF8QV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(366004)(346002)(136003)(451199021)(6486002)(186003)(54906003)(86362001)(6666004)(2616005)(478600001)(6506007)(1076003)(26005)(44832011)(7416002)(15650500001)(316002)(36756003)(8936002)(8676002)(41300700001)(5660300002)(83380400001)(6512007)(66476007)(66556008)(66946007)(2906002)(4326008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JYI5W7j+tdTzC/YSvdnug1hzyZVqlK+mgfAxG7BAPGGzoJNbnbA7BpQ8GJdf?=
 =?us-ascii?Q?hVJ+Tb+tZdsNbCWsbsgM7eppLyM0rxCIprnZJZy3nrBkiXcpvjUDTjN61Cb9?=
 =?us-ascii?Q?hL2mq8sCAwpu3pTWmkWC7XcOOvYquzLeyHAQCK9qKKmn57/7FNIdvwuD2W53?=
 =?us-ascii?Q?AZE8X4Ansi0Vnlpp0xt7/eFc+I1qsloVtBJpA2OuHhQgE8vveHLVfppsyeQn?=
 =?us-ascii?Q?Kz1TsgrE6VtQ8PHY/TrVi0Vym4HGEMWh0B/ZmvhbtlLxqDOpepInG0dbJ4BP?=
 =?us-ascii?Q?wjnSH2X8k/h6uiXBRy73y9NZ3jt1VHN3/b0i+DL/FF3q/RaG9xL3xmP9wFSj?=
 =?us-ascii?Q?icYSV68H7uxlCIoEh/nHx2Oa0+y0hAh2cZENOGzTUuF13Uoh+KZui5nGHJt2?=
 =?us-ascii?Q?AFieKr6EnYBdmbEKkw3yGab4AXKdGJdOnetAKHVLd6U4elX0KaR9/xucbl2w?=
 =?us-ascii?Q?hlr96eNai8n4A82Idb0+HzQvEKZ0elDfUAS3JYdzbDc1Wo3a8wn7Zf8JGJbm?=
 =?us-ascii?Q?bIqSsgc1DSXVkB1Yp2tpD+bI07zSCsZ/4SzcENXllPrm3A7GbPfCxHIxw7vk?=
 =?us-ascii?Q?8xAa02hYoAhQkkebT5xa7b9rPme0woDYPLC5qlHsHZja0qsYWgDN/5TCDN8C?=
 =?us-ascii?Q?CYxHhMclcIo3vpv2tnKcovrabF0AEsWv2oOKGBqhKJpd/PoaFUlW0aNZ8JQh?=
 =?us-ascii?Q?XvO2OI/slVnwOyMdJSn/MgpwslY1OR0WlRBQsSksgSHYCeEKLStxe2p7Rw+F?=
 =?us-ascii?Q?ZUNJgr9BKf8zjUrL+JL5xNBUcbvBUPbMZXqy2Yel1Lv+R7y9N4WmKsGPGmQ0?=
 =?us-ascii?Q?7J/C9/gOjOFI3pkb6aq7fajbqkpMjJnX/ZM3+tM2YgA7eq/GUIUeT6fZMNFt?=
 =?us-ascii?Q?3f3KgN1yujOioOaUnzkNriRU3OQ2Bf0Kv6j3f0TIHFQ+3Kkac8L1oGz2oMKk?=
 =?us-ascii?Q?FhkRE1nvOaFgmlx/NKEeq70jw3KWW/e0XJyl9EJaQtjM79z8tzgHxRUx1Das?=
 =?us-ascii?Q?ZbfTONP74K85FEviZkJS1Dr6HEgMiKVIWMkIXJ1c8TZKBQDdhTgyK1tA1/g1?=
 =?us-ascii?Q?tvqS6VbODwaeLYqnfReSEM/jepNsGXxPRdhXJBrhhCoHfY1Is8oUEzbh57ZE?=
 =?us-ascii?Q?nCW0TKgTd5w2Sw6Ps1wnBICLfNsz1a3+nslL4TnKDduISgP0j98dEHVIlzbV?=
 =?us-ascii?Q?0v1CCTLyOy3xkayw5YPGc5C9geu3sVSeZrLprjCEnxEkXKZRATjzj/l5p+/l?=
 =?us-ascii?Q?seN6a0+snQk6dcmN0hg6k8ioX3uWinX8BUIbbUTz325ARoKta8++o3YhJbXu?=
 =?us-ascii?Q?UBgyznfbMQCdHDoYnf0oN9DP8WAt+pBQ9TtRpiWdsmWWcmhG5pV1VHFTJVAK?=
 =?us-ascii?Q?6xDch8uRlt/o+ehUypa9JXTd1a2Ijp6TAVxuJvIEL9ur4nx5bmKPXTYgOSg3?=
 =?us-ascii?Q?HED+8RvweF1U2j8+DEnbAfRu5KKzAFCz7WD52W3CEqDuheZjB7fXuZCZALJ0?=
 =?us-ascii?Q?ltq6veyWNqrcvbw5SW576HxvaJwPkjU1uU6H8xbMlRtbzh+dpHB6erwEt51J?=
 =?us-ascii?Q?hckim7bFGoMVUSFQYV36lHt8BKBaoMth8KxUXRK1QnCxo7aTk90+eIvVMuua?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?exV0cB5lgJw7yLa9LCOGPFF/Jj58qZ8WqSGJtDS2Y2bHc8zlyc8gSaVYfPrr?=
 =?us-ascii?Q?4stdjZXchPi86vGJWCQGGcTjp1swDyy6SKKDsctfTHopXHrBypCJsEpwStMO?=
 =?us-ascii?Q?JDmqw42yEKME18pcXpKkn09XRkrAkp/3MZLtGqsaD1kMlC+Aaaec6r2nN2SZ?=
 =?us-ascii?Q?wnRai2PfGJPY7vZIdI2lNHImSvzfMaErX+Q9o9XyOFQtY+9glCFO9YDBJvd3?=
 =?us-ascii?Q?uLf1iaF31mbBZOVkMsB0IfL4y6VdRiNZKMA0OnZ/YJP0YSyowsAScPjAaTBF?=
 =?us-ascii?Q?/FCojMBkRrg0Yebj36hKDfDKe5plDF9FkaJt2AwXOeZIRDUEcaJ53yj7yDs6?=
 =?us-ascii?Q?0hiaBKxl6sdH0wukay/jJqjYtMdXSRv5DDd8Y2T9FRsKxubeKSLeAs4FSsOE?=
 =?us-ascii?Q?8lF+AqyYem2GxUkD8VYBzzdyqIweVm0CEaUy5pOfvC/Y32R9guT7cfvbY4Ft?=
 =?us-ascii?Q?dfuka9RjeqAIx47njwToj0Hf1VFFmD1HlM6Raake8cMIK19ayWN16LKkvJok?=
 =?us-ascii?Q?L31/ecnWUJSUTY0fnMvGnTl4qPeNz/Ie+1k8r1H1xGfAvwCKfjiq2Yax97ar?=
 =?us-ascii?Q?7LTkqqlgGnKyypgj4z4TMAayzVafyytvROC05h/GoxtSi4xPHIy7wLT4Qv8c?=
 =?us-ascii?Q?7AHMer5XNE10dbxzozghsZej3GZJXMlx3BdUzYwBPY0bLhLu0db9eyjdemeK?=
 =?us-ascii?Q?6FdXNi3iorMSNe5Uqkk/IvM5xsC80h3kU7qlYxjeoeelAj8ZfhAVSkTi/aig?=
 =?us-ascii?Q?1VRRSeEn8hG9YUfhw7jD9YqSXCn8ldITPGbmIJb23fwZKX5RinzfGKc/bvTb?=
 =?us-ascii?Q?ogO5m/wBHCGSJeJGHMVVZOGJz8/0gyMakJoSv7mzSaML8EWDfWPr0jVqpPi/?=
 =?us-ascii?Q?bSugFSuQ9Ecik/p7WhP0X00eGEYRLUs7mSrOPOZLIPvkDalF/Lsm8vsiD7+U?=
 =?us-ascii?Q?wd53xTtz2YcAVaCYy2Fhg6mBoTBSZ7HTF0gm39hKPCk06Vg9TgMVn2HHvR7p?=
 =?us-ascii?Q?0syr?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e7a8e0-80dc-41ef-8262-08db825b8df0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 22:09:53.9310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2v/hRvAo7zkngH0dyxoMRbSbIqXTXZZ/Z+QdYaFpKrHw/gKDVbCrxPiwqpitoD/xQGtkUhqFTHN8eEOyXco8aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4775
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_12,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307110202
X-Proofpoint-GUID: sz9sOU-g3vTel-g6IUEDkDhHKVQ3_okA
X-Proofpoint-ORIG-GUID: sz9sOU-g3vTel-g6IUEDkDhHKVQ3_okA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_and_free_pages_bulk is designed to free a list of hugetlb pages
back to their associated lower level allocators.  This may require
allocating vmemmmap pages associated with each hugetlb page.  The
hugetlb page destructor must be changed before pages are freed to lower
level allocators.  However, the destructor must be changed under the
hugetlb lock.  This means there is potentially one lock cycle per page.

Minimize the number of lock cycles in update_and_free_pages_bulk by:
1) allocating necessary vmemmap for all hugetlb pages on the list
2) take hugetlb lock and clear destructor for all pages on the list
3) free all pages on list back to low level allocators

Fixes: ad2fa3717b74 ("mm: hugetlb: alloc the vmemmap pages associated with each HugeTLB page")
Cc: <stable@vger.kernel.org>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1b67bf341c32..e751fced870a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1856,11 +1856,44 @@ static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
 {
 	struct page *page, *t_page;
 	struct folio *folio;
+	bool clear_dtor = false;
 
+	/*
+	 * First allocate required vmemmmap for all pages on list.  If vmemmap
+	 * can not be allocated, we can not free page to lower level allocator,
+	 * so add back as hugetlb surplus page.
+	 */
+	list_for_each_entry_safe(page, t_page, list, lru) {
+		if (HPageVmemmapOptimized(page)) {
+			clear_dtor = true;
+			if (hugetlb_vmemmap_restore(h, page)) {
+				spin_lock_irq(&hugetlb_lock);
+				add_hugetlb_folio(h, folio, true);
+				spin_unlock_irq(&hugetlb_lock);
+			}
+			cond_resched();
+		}
+	}
+
+	/*
+	 * If vmemmmap allocation performed above, then take lock * to clear
+	 * destructor of all pages on list.
+	 */
+	if (clear_dtor) {
+		spin_lock_irq(&hugetlb_lock);
+		list_for_each_entry(page, list, lru)
+			__clear_hugetlb_destructor(h, page_folio(page));
+		spin_unlock_irq(&hugetlb_lock);
+	}
+
+	/*
+	 * Free pages back to low level allocators.  vmemmap and destructors
+	 * were taken care of above, so update_and_free_hugetlb_folio will
+	 * not need to take hugetlb lock.
+	 */
 	list_for_each_entry_safe(page, t_page, list, lru) {
 		folio = page_folio(page);
 		update_and_free_hugetlb_folio(h, folio, false);
-		cond_resched();
 	}
 }
 
-- 
2.41.0

