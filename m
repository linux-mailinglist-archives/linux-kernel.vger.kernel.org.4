Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB156ACC30
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjCFSNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjCFSNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:13:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE2F2707
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 10:12:51 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326CxF3l013883;
        Mon, 6 Mar 2023 16:23:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=pwFHmqjBVzoowkQPsGI32YFDgdwu2nct2hyJC2lNrWY=;
 b=n/LPHOZey9T+RiyYvxpCES5sc9Cv4vaUTHlQ73eaUpC6KBNhWSjh7sM5WpRjbvPY4Bj3
 Ju2uD40vZDam3WlKGNeN879cC41YFu9jojpWIxV4nS5cPfw/Nlu/IEzBzzWj2f4xr3NX
 plcSxdlad2Lsy3vyuHNRyxocmlh2lKn2pN+Y2sJuIIpUxoc+pNJgL8U6LHnc67PbuNsm
 kRR7KdXaxqFuPbqxfg1RCqsSWkHoDYqKV05eOQolc3cUPbUaHoEY4n9jupFT+4vkz1S5
 z4TiXeDfli6ykZZlZyoASTW6LcZlQyAHC2baTghTPiZj3cpdhDIV8UNzcJs//FTFnU4s IA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p416wkaab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Mar 2023 16:23:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 326G0Fsc011448;
        Mon, 6 Mar 2023 16:23:02 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p4u2gfbc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Mar 2023 16:23:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHFIKtQLU0Cq4IniI94sWI2qB4Wu+jM/QQfBkmqaMsWl3uO9fhUaqOs7gMFw1ksOCpKgyHzRWO/t62zXRnkoiH3Z+1BBAeshPzC1v++HWCpljbeXJo1Ssfep4cugo8ZO4U1zvFVkjY7uFPQSzaADe8UyvGWkjI54yW8g5227Lej8RDUgBRWqj9PR5Oz86ipnABMRV0ZYUHvfhsikafVQ42rapD1kt9TayXSklDFL4PzZRBCJbrZxOjctCKqHRH1AdhMQKYneOWyuNfwnT/I8WLAvDcdt0gIqnV5uDvpjUCFsGO/EohvRlceh8+fJbPlm5lqgmYvwQ28/KcORMniUyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwFHmqjBVzoowkQPsGI32YFDgdwu2nct2hyJC2lNrWY=;
 b=ZeJkzaxm4WzTc1HMgRmS1MXVOG8IisIp++giOt+t3c46utlJnqD/QMVsC45tXBX/Os3Sp05nz7A5ATQGCSWUeqvepxAWoRiC5ByFJA1StpvOmVR3YWgFn5JYPiMR+ptVLxLRvWU7sZv5wYPDAanEBSTwluVs3e+YUit1TfFECMONCXvpcn+8mbWnRjK0Xf/poHSDNl+xDtStXIy5E+tORp+80WeaH1oLgSjOxSKX7uvTTBgfEDauWx1X7sMp+uaJ5PMwFwhPhg/VpMEeu1pUrgSc6FWzzoxgkDwT+DS1pYcogXi+8WdFVh1FI9YpjVwc+xfxRLgaCnUUKX/HHNnrvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwFHmqjBVzoowkQPsGI32YFDgdwu2nct2hyJC2lNrWY=;
 b=IVZEuWmeTa0PTwKa5eKPlBK+FnHCnvwz0qyBLPfH5NQubfO9tuwMeu+2wxefrcRVBOTjqoZOPtr4WQ6E2OMAZEdyhhrjrEc4nFm3f3uhn439USu/6eqHCqEWJJ9pVz77ktR6Otkx3Ouh7I64k1a9lAfxa4CGYx27WlZoFeTBuK4=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH7PR10MB6530.namprd10.prod.outlook.com (2603:10b6:510:201::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 16:23:00 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%8]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 16:23:00 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v19 5/7] x86/crash: add x86 crash hotplug support
Date:   Mon,  6 Mar 2023 11:22:26 -0500
Message-Id: <20230306162228.8277-6-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230306162228.8277-1-eric.devolder@oracle.com>
References: <20230306162228.8277-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0073.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::6) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH7PR10MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: f44a9081-e8df-4f30-0bec-08db1e5f0db1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JmVLaYWPid2WFKPhGw30PuPEGIvLabrdGYFQ6n1IoXJ3qSw4ke1G6J2H8LhPbXEQCSyd9sSlLF9NQxkJAv8n+Bp02LxKB3k9Qb6d5+Drh47khsKjoaoSwNKsKhJxwdPKyCzOWHLtfWnxWIY9UOatGsmyDIZt+MfRo5+XtXwvIoi4scX+G4zixZCc1qFaOJYGR1X0RNcsb7WyvTtxc5eWqG1lRr82k7/Qsi7KUDXFfrzOjp9lbPvAbWsFz+4Rd4tBsb6aJOTEmgO3I+WFXYttBaPhx/0Sif7Pqh2/jMm+rQpfd76BvNX5FdjwfOgQEPrhzOtHpKYCpfujiIHTIMArzQyuc5ftNxXzie80WOg8X3PKWx9Kra4f8oFC5akbBVU8CKv4IxOY4JRW89BrvJXFVPCM8KOdlPX4RWSBNpJgTLJ8gYIVTWz0HaKEnxkf02kl9Ip+XBEqkpQ2+0fL/YbI4qwd+V5DHGgQVy5tS4LMOr5T2Jcl9pRLnjm7LlVLZ1jqgy6ltwVIYA6jonMsPEehwDwsAWG4U7DbCMQXvtKMKA+lZ+231Fbj6yGz1BjWChKj1kEzIV0hBaYFrG3pHWMIcPtJdbuKEtZcIbFdI5PaTvzih29Rqd4qHDm1dIF8aPirN/ypZM0Gbe8JUFrvrB0Czw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(376002)(39860400002)(366004)(451199018)(66946007)(66476007)(5660300002)(4326008)(66556008)(41300700001)(7416002)(8936002)(8676002)(86362001)(36756003)(6486002)(478600001)(1076003)(6512007)(186003)(26005)(107886003)(6506007)(6666004)(2616005)(2906002)(316002)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eZ/SypIwtAAaja05VH7uMm7oZCvJgIRy5RV7BZq+qnH9UJPzzog/IDIYsP5x?=
 =?us-ascii?Q?0gtMFySPBRtfhMnZdrrlwxARi4pb9AKqahkIIZDRApBZJNTfn1Oc64qbOciK?=
 =?us-ascii?Q?phUzgZJdmHSDOOdfqxCs9x1akcHxAcQb2IV9sRlh2uy9dPfNU498+zAqiZdD?=
 =?us-ascii?Q?B7Rh1Zyw0RYQJgalWxaF9ZJyO0UvKUhinx7BWSIHN5wYAjU51eB4V4xMub9F?=
 =?us-ascii?Q?SvBj4lkINeXk2EWBqsG1f3S53ez1xS25wmMV2jgBMZCQOHbENxies/WSRsJZ?=
 =?us-ascii?Q?USMiXOeroJFi7YTpBmo3iKD1+kd6id2jkZgLNyBzfGrh0H2E6T/X14EKiju7?=
 =?us-ascii?Q?EzcWwYCs/J3A7/9Q6sayLXCWnZLwtP/cOZvcBc9Se28ac2nWmpakPaEsrsFR?=
 =?us-ascii?Q?vheVjpV+4GUW3jWSq3v3edAO9WzGBugiT0yUO/U7y3SsLWQlrwQqHrJGobvc?=
 =?us-ascii?Q?s+lScdDdxKLTGp6uLcAaivVEF+BjuY4OJNI+l8sY0QHaHPquAWiAU6VxrGDC?=
 =?us-ascii?Q?c8tP42KjTW83nJvXmookbkZwSi43DLeYxevqqRoMeF+f7ZA+iRPMfvj5u5M1?=
 =?us-ascii?Q?cKOhOkQyDoHWQlTnrlI9VtzBrsdGoFGpe0zIk4nT/qKG5dyzHl9IKooMmDTm?=
 =?us-ascii?Q?+iWNS+g1uAC5OFhqZX8fquwdNsUCxjhg4Hzj6Y7+bJfdUrirQq9qcV5DG56D?=
 =?us-ascii?Q?pdAKVIzKiHFyZDwZnqrayL2BYL9hVMvRBDnLy/3+Yyz8n2RXMtPa/rcOAzuR?=
 =?us-ascii?Q?MedU20IU4Tz3kWaPymvGSCM6X12UQF8Y2oamsHPCLwM8URq/RKDcXD1GBr1J?=
 =?us-ascii?Q?NB5zg8IoDEdRAelEtH3fUakL8ag9wDLd8pMmumMQwEnBSm+mBG6Vp5+9Nu3N?=
 =?us-ascii?Q?7shgkx5XXklvSeWlSUUbntTQlheKVZ4W6YEo57xx0ak0gAIL3vsWOo+aG8Hw?=
 =?us-ascii?Q?JRiG1n4hf1Ih1NyRXWymRi/5FEFi+Htd346qdtgwWGvPeN2ie4YvLoZyyuOT?=
 =?us-ascii?Q?IppaJUvZcm0eYUj1v2u6Q3E8yf+L/EytE/SLMZORE76YZeQn4ukkXyKN1jxf?=
 =?us-ascii?Q?4f/MloVXQy0L1bqQmcmsR5VcA07009VmZhccOfN9slLtJJgTK+K+G1JjVeAI?=
 =?us-ascii?Q?oAFUv1aZivaG7kxH5OwXeMHjil9pt63idNGY1FAFIKuNs29QvyzAvJm4y7eJ?=
 =?us-ascii?Q?GCSfUL/FYcuUJ/Nl1eRAmlIqFEBMYT16jMW8XYeqkgD6ocSmpX0TKGRB6sm9?=
 =?us-ascii?Q?+fzl07BWqy7kqe2mrGbhWsA1Vvf4vUVVouG24AEXRg99QvuRiTQ+vIeQaF0O?=
 =?us-ascii?Q?/zUF0dKxOGEcn51xoY05/xA3ak9NBQyRaeZnc+x7/Bhz9/ZkfTeAP+rADpXC?=
 =?us-ascii?Q?+1OsT6Alf/p8A8MK269jVG88vm9PXJPUiiYKO8gWs+f+bnZaTUekUJLdM5DS?=
 =?us-ascii?Q?V2yEVOH9ZRmF05eD93NM1oueZUVygC9TX4Tp5zK67lYUtp+FmwGWkNXUBJv3?=
 =?us-ascii?Q?BV6qU4mk0XAkMLL7lFFuBnICL4EpcFHpUplpohMwQSjL5ih54SXfYIJgqy5E?=
 =?us-ascii?Q?QnAOp2Hd1VpX0PtfX5xLjU1cqYIUOGvKua9O5c1QEWvOfAVcXSUKja82co/a?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?JaGWHsthGSjSoiuc4xxAgiulNjVCaROchFJHQ9iTHF5SwXRUkXSRQQqV+lZs?=
 =?us-ascii?Q?1WXY/JDI0OONlP0X3yWJOmSzaFEAuJiXeJeyz4e7gBNXF4NyTKjmcpU/yJvK?=
 =?us-ascii?Q?eofMZitBE4Ao1zcaVds1bxu0HhfYuFS9v87aDZ1eI1ppCrQzfGGp01qDsf4E?=
 =?us-ascii?Q?mCCOMZVvIZBwhhC58bbOhnyU7ZnrygDoppt/7nlWJ9sHGU9Otyzvkx/Cu1lT?=
 =?us-ascii?Q?e3zZBOEIvK9iryxisa4mxsnSZ6Y5shC32Xe+zAdyla+30J6SY+U6cZa7esjO?=
 =?us-ascii?Q?BNnJvN0nUt1kdhVcBDKxpY0lNNhCm2ZLI+DVKUA2IPMo1TEk8awf6Z+zLGUp?=
 =?us-ascii?Q?MKM0nfFAdg/56fkCdExnu/pg62CFbH/NJOET/FsqYdbpR4heytKjRhtrcdir?=
 =?us-ascii?Q?ua15CleLvD63iIUkeLBtZdxwhPgegvOlexooenq5gttYzu3ka/fgogA1sGxJ?=
 =?us-ascii?Q?Pacij3HcNE3hVOY2m6pioHJ0K9Az40enWtBYkeFLBWfFgNSs8rx36f8+S7Oa?=
 =?us-ascii?Q?av7muGYl9LIyguRCE6KFHPYKwANb+ZmT9CpakMu0kLcPPAlAmiX7xLGRx4SW?=
 =?us-ascii?Q?nSXqr2roevgfkSQ0qD0RGF1XyaMheT8tXJ3j6/HrWjx8n6rqtLmh5nfnJWev?=
 =?us-ascii?Q?SVRwNsqTggQ10aKnxMK3GcLFcvGKk39S5Ly1At1Rh8MudlNIZFtQxbsBIyMc?=
 =?us-ascii?Q?cxTsco8dH6SNdeywZMwT16JyOzITFmtHq8B0DN5oCZZg1jkU66MUauvfElHT?=
 =?us-ascii?Q?o9OFVjv8DvqltAbgwiL5Bg3qiVElBkvwbsId7MqrIxQiDPuHiueqwQgU2AZm?=
 =?us-ascii?Q?UF0hplfqq1GzMujiOQskeN9+uyDqFXIt/HLOxDSSiAAUdSwQYPvH7l/9JZvQ?=
 =?us-ascii?Q?NH73eNl4gi0om4j/czmjiEPAHhJUc496hKTMYnAolvZThEC1TAZ3NwW9IY63?=
 =?us-ascii?Q?i6VDzVZOja3VLGZgjQnLbgZRsTDMPNoQVRk9TU5sNwUhe3quDXMHJn7HQ/l1?=
 =?us-ascii?Q?LAxhxE7tNn/6csPjARbtIOITOO4gXY1R8p4i9UMeea5pnlBpNWz9xB070Lxu?=
 =?us-ascii?Q?dzlDxSG81zn+m8YRhAnaEBWnKIli52qghpITxjAJ0WwkeSHItWCJ2ofZwOZW?=
 =?us-ascii?Q?2w1x7S3ynPRjWZcCkMRY4xSPpUjP1XMjhL8CMTDx/U0dl5W0sseAZM8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f44a9081-e8df-4f30-0bec-08db1e5f0db1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 16:23:00.6927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMIo/bgoyNsTZ1lgo/43aPP8sfgaPpB+LbRV0FqIUGHFofgRqLPLGZ9URpb2VjKUGR/WcN4YSZ87XG/loYgZYAinxrTJCSr5uF0E30jutH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6530
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_10,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060145
X-Proofpoint-GUID: kMkOYiVsPQWLEPLy29RjK4JRFOxL9poZ
X-Proofpoint-ORIG-GUID: kMkOYiVsPQWLEPLy29RjK4JRFOxL9poZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CPU or memory is hot un/plugged, or off/onlined, the crash
elfcorehdr, which describes the CPUs and memory in the system,
must also be updated.

The segment containing the elfcorehdr is identified at run-time
in crash_core:crash_handle_hotplug_event(), which works for both
the kexec_load() and kexec_file_load() syscalls. A new elfcorehdr
is generated from the available CPUs and memory into a buffer,
and then installed over the top of the existing elfcorehdr.

In the patch 'kexec: exclude elfcorehdr from the segment digest'
the need to update purgatory due to the change in elfcorehdr was
eliminated.  As a result, no changes to purgatory or boot_params
(as the elfcorehdr= kernel command line parameter pointer
remains unchanged and correct) are needed, just elfcorehdr.

To accommodate a growing number of resources via hotplug, the
elfcorehdr segment must be sufficiently large enough to accommodate
changes, see the CRASH_MAX_MEMORY_RANGES description. This is used
only on the kexec_file_load() syscall; for kexec_load() userspace
will need to size the segment similarly.

To accommodate kexec_load() syscall in the absence of
kexec_file_load() syscall support, and with CONFIG_CRASH_HOTPLUG
enabled, it is necessary to move prepare_elf_headers() and
dependents outside of CONFIG_KEXEC_FILE.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/Kconfig             |  13 ++++
 arch/x86/include/asm/kexec.h |  15 +++++
 arch/x86/kernel/crash.c      | 119 ++++++++++++++++++++++++++++++++---
 3 files changed, 140 insertions(+), 7 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3604074a878b..2ca5e19b8f19 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2119,6 +2119,19 @@ config CRASH_DUMP
 	  (CONFIG_RELOCATABLE=y).
 	  For more details see Documentation/admin-guide/kdump/kdump.rst
 
+config CRASH_HOTPLUG
+	bool "Update the crash elfcorehdr on system configuration changes"
+	default n
+	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG)
+	help
+	  Enable direct update to the crash elfcorehdr (which contains
+	  the list of CPUs and memory regions to be dumped upon a crash)
+	  in response to hot plug/unplug or online/offline of CPUs or
+	  memory. This is a much more advanced approach than userspace
+	  attempting that.
+
+	  If unsure, say Y.
+
 config KEXEC_JUMP
 	bool "kexec jump"
 	depends on KEXEC && HIBERNATION
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index a3760ca796aa..1bc852ce347d 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -212,6 +212,21 @@ typedef void crash_vmclear_fn(void);
 extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
 extern void kdump_nmi_shootdown_cpus(void);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+void arch_crash_handle_hotplug_event(struct kimage *image);
+#define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
+
+#ifdef CONFIG_HOTPLUG_CPU
+static inline int crash_hotplug_cpu_support(void) { return 1; }
+#define crash_hotplug_cpu_support crash_hotplug_cpu_support
+#endif
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+static inline int crash_hotplug_memory_support(void) { return 1; }
+#define crash_hotplug_memory_support crash_hotplug_memory_support
+#endif
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_KEXEC_H */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 305514431f26..c9aaec9de775 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -42,6 +42,21 @@
 #include <asm/crash.h>
 #include <asm/cmdline.h>
 
+/*
+ * For the kexec_file_load() syscall path, specify the maximum number of
+ * memory regions that the elfcorehdr buffer/segment can accommodate.
+ * These regions are obtained via walk_system_ram_res(); eg. the
+ * 'System RAM' entries in /proc/iomem.
+ * This value is combined with NR_CPUS_DEFAULT and multiplied by
+ * sizeof(Elf64_Phdr) to determine the final elfcorehdr memory buffer/
+ * segment size.
+ * The value 8192, for example, covers a (sparsely populated) 1TiB system
+ * consisting of 128MiB memblocks, while resulting in an elfcorehdr
+ * memory buffer/segment size under 1MiB. This represents a sane choice
+ * to accommodate both baremetal and virtual machine configurations.
+ */
+#define CRASH_MAX_MEMORY_RANGES 8192
+
 /* Used while preparing memory map entries for second kernel */
 struct crash_memmap_data {
 	struct boot_params *params;
@@ -173,8 +188,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	crash_save_cpu(regs, safe_smp_processor_id());
 }
 
-#ifdef CONFIG_KEXEC_FILE
-
 static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
 {
 	unsigned int *nr_ranges = arg;
@@ -246,7 +259,7 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 
 /* Prepare elf headers. Return addr and size */
 static int prepare_elf_headers(struct kimage *image, void **addr,
-					unsigned long *sz)
+					unsigned long *sz, unsigned long *nr_mem_ranges)
 {
 	struct crash_mem *cmem;
 	int ret;
@@ -264,6 +277,9 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 	if (ret)
 		goto out;
 
+	/* Return the computed number of memory ranges, for hotplug usage */
+	*nr_mem_ranges = cmem->nr_ranges;
+
 	/* By default prepare 64bit headers */
 	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
 
@@ -272,6 +288,7 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 	return ret;
 }
 
+#ifdef CONFIG_KEXEC_FILE
 static int add_e820_entry(struct boot_params *params, struct e820_entry *entry)
 {
 	unsigned int nr_e820_entries;
@@ -386,18 +403,42 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 int crash_load_segments(struct kimage *image)
 {
 	int ret;
+	unsigned long pnum = 0;
 	struct kexec_buf kbuf = { .image = image, .buf_min = 0,
 				  .buf_max = ULONG_MAX, .top_down = false };
 
 	/* Prepare elf headers and add a segment */
-	ret = prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz);
+	ret = prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz, &pnum);
 	if (ret)
 		return ret;
 
-	image->elf_headers = kbuf.buffer;
-	image->elf_headers_sz = kbuf.bufsz;
+	image->elf_headers	= kbuf.buffer;
+	image->elf_headers_sz	= kbuf.bufsz;
+	kbuf.memsz		= kbuf.bufsz;
+
+#ifdef CONFIG_CRASH_HOTPLUG
+	/*
+	 * Ensure the elfcorehdr segment large enough for hotplug changes.
+	 * Account for VMCOREINFO and kernel_map and maximum CPUs.
+	 */
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		pnum = 2 + CONFIG_NR_CPUS_DEFAULT + CRASH_MAX_MEMORY_RANGES;
+	else
+		pnum += 2 + CONFIG_NR_CPUS_DEFAULT;
+
+	if (pnum < (unsigned long)PN_XNUM) {
+		kbuf.memsz = pnum * sizeof(Elf64_Phdr);
+		kbuf.memsz += sizeof(Elf64_Ehdr);
+
+		image->elfcorehdr_index = image->nr_segments;
+
+		/* Mark as usable to crash kernel, else crash kernel fails on boot */
+		image->elf_headers_sz = kbuf.memsz;
+	} else {
+		pr_err("number of Phdrs %lu exceeds max\n", pnum);
+	}
+#endif
 
-	kbuf.memsz = kbuf.bufsz;
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
@@ -410,3 +451,67 @@ int crash_load_segments(struct kimage *image)
 	return ret;
 }
 #endif /* CONFIG_KEXEC_FILE */
+
+#ifdef CONFIG_CRASH_HOTPLUG
+
+#undef pr_fmt
+#define pr_fmt(fmt) "crash hp: " fmt
+
+/**
+ * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
+ * @image: the active struct kimage
+ *
+ * The new elfcorehdr is prepared in a kernel buffer, and then it is
+ * written on top of the existing/old elfcorehdr.
+ */
+void arch_crash_handle_hotplug_event(struct kimage *image)
+{
+	void *elfbuf = NULL, *old_elfcorehdr;
+	unsigned long nr_mem_ranges;
+	unsigned long mem, memsz;
+	unsigned long elfsz = 0;
+
+	/*
+	 * Create the new elfcorehdr reflecting the changes to CPU and/or
+	 * memory resources.
+	 */
+	if (prepare_elf_headers(image, &elfbuf, &elfsz, &nr_mem_ranges)) {
+		pr_err("unable to prepare elfcore headers");
+		goto out;
+	}
+
+	/*
+	 * Obtain address and size of the elfcorehdr segment, and
+	 * check it against the new elfcorehdr buffer.
+	 */
+	mem = image->segment[image->elfcorehdr_index].mem;
+	memsz = image->segment[image->elfcorehdr_index].memsz;
+	if (elfsz > memsz) {
+		pr_err("update elfcorehdr elfsz %lu > memsz %lu",
+			elfsz, memsz);
+		goto out;
+	}
+
+	/*
+	 * Copy new elfcorehdr over the old elfcorehdr at destination.
+	 */
+	old_elfcorehdr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
+	if (!old_elfcorehdr) {
+		pr_err("updating elfcorehdr failed\n");
+		goto out;
+	}
+
+	/*
+	 * Temporarily invalidate the crash image while the
+	 * elfcorehdr is updated.
+	 */
+	xchg(&kexec_crash_image, NULL);
+	memcpy_flushcache(old_elfcorehdr, elfbuf, elfsz);
+	xchg(&kexec_crash_image, image);
+	kunmap_local(old_elfcorehdr);
+	pr_debug("updated elfcorehdr\n");
+
+out:
+	vfree(elfbuf);
+}
+#endif
-- 
2.31.1

