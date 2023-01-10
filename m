Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D69664E08
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbjAJV3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbjAJV3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:29:16 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B170760CFE
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:29:11 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ALGs7j030302;
        Tue, 10 Jan 2023 21:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=HWdBF1Wlcs9D9iqHgpLX6ouOUWk7M0HHi9i4cwaLOUU=;
 b=gRaCsTfUIBzx95Yz7G2YzaxsO3ttrccPO0pbzgPbu4JOYwEXa9TfgAxiKYZb/+5GbPZ0
 KltVcuBZj0vDBbkBEsLXi2mp2kQvEy/648iBPi6ZA5a3YMtmrb+PcHks7D6SM/FKlde1
 xfhI+XpWviHZU4ohce0sJ36z5i+TH78jK7LIj1HNSmfm029a6TQn5lx0T1vG5ZJep0Eo
 yAr2RLDc6SjRva+ft+qQv0Jo8J0xXQdv7FsJcpWtTeckUY/G6B8a1k6A/WWuDVfUz9MV
 YQEJnkH6lGWkTOqjbHnTs+0MJtgF12XLj21Gn7iqKSBscMxVb8DAoNFN24e4/D167KDu zg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n14nf9t20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 21:28:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30AL8cBX013069;
        Tue, 10 Jan 2023 21:28:52 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1fp4gngq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 21:28:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enYiR0rA6BOEgu8ucj18ec30RZOSZIdqztKuksE5kdnhwS05oCjYwD+ADBQ9223Vw/PT23VzQJY9Q/TFtvFOVnRv0XlLlYiNRmYvs2TsPTF8utx/6l/lmFDtiSm+0OwEcBpyUEOI2kTXB2r+/IbgYqw7P5r7bDTawGMO87KHQqdTzOyyLU+O8pBsvd+b/u7iKBGSv7LYY4rO5SBvXEJthcjGgyZaSHgiW2a/3tldG2qQb7IJJ/7SqNFHFrfGmAEGV9j5l1nPh9NocnRkhNSFaXZmhh7vTXIraOwxjS/AbntoFgz9pz7ux5jR1sNZYEhOdT36y1pBtIoOplksx+l5bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWdBF1Wlcs9D9iqHgpLX6ouOUWk7M0HHi9i4cwaLOUU=;
 b=Jkzie+AX+KOu4xGrzjPpDEaDxp4IIOMtF8mtVCq2ToUXX5widJDWI6vNZlKdZScJ8ccFEgHozI5U87zmBrlPKP9T7b49PTw16RcC1MBve/PuHs0zPT965nzmO5bV0eSok3plo54QPw9DWq4oTAcW00LwmpEj6X/G1JlpClkN67q1DLjLJmi6a5+0g7p/THBMwCfNEa7yfmFpTVrTdzHQCMYAoJLuJhHaqPQD+77Lg6Rzw/qVXPBBhJoNjCqhHVONpz5OvmtJKmkwFfzJDPwjvLtrEg6HxmUx+SHGZMOCWuGuWUaFqm1/egmlpKBfDjSl2u4Sl2ysyx7bbNLVu1gsWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWdBF1Wlcs9D9iqHgpLX6ouOUWk7M0HHi9i4cwaLOUU=;
 b=IczihHzODhEkVWjSMY8OhzRFtwbT4+YeHNryldNrNyRTBcTle+iq48p//f1svgYOwQ+OsB//xnZAmo7T6b6O8tjI8xby7IU9PG8NXMSZar+dzjIXwpqcTzU2qAIY45W/eHKmPgNvn7oY6clbdzQ+acM6YXc6PL1GSe0A8buBw1A=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by DS7PR10MB5133.namprd10.prod.outlook.com (2603:10b6:5:3a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 10 Jan
 2023 21:28:38 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Tue, 10 Jan 2023
 21:28:38 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v2 3/8] mm/hugetlb: convert dequeue_hugetlb_page functions to folios
Date:   Tue, 10 Jan 2023 15:28:16 -0600
Message-Id: <20230110212821.984047-4-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110212821.984047-1-sidhartha.kumar@oracle.com>
References: <20230110212821.984047-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0016.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::8) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|DS7PR10MB5133:EE_
X-MS-Office365-Filtering-Correlation-Id: 1443c24d-3124-4b07-f278-08daf351a2dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Zy0KqXr5QXuevtZouKUoXH/g+00Z74A9TBRoFB4mMgxpT0EgIAU3PzqUgtQCcK1T8E5ZLaQlBXu7AEkVbqGRw6B1hRbaowgIfDqjxivKTSI5Jirpx80bXB+/CuSPY137hKyJARoEKeDAiTm7JqQqe1YbqqEzGxbju0EOcgMo1U3qJB79t2HzAeUacKMacHmUAQU6eg8vfeXldEAIdYRnEzOp0ysjhSD07Uuqow5ri3sHcu4ENHgERtSecR11yENJrHn0BIuUtW/J/4e2nHJUu10wlDMvVAgypOF4SVwEJaR9HKDvL3NdMWt0JFF7XpPoL0d5uBcL+4AJGweYt91GNFA6yOe4yZ7pEYDJJ+8BzQ7il3z6dj3KN1bdbapJJYFeHC5n7Hjc7WdLAU43OHhPuGBGQmTb3YkfKVt5j/K95Ic5ElJqriW3219a94dTY1U4xyTBlVBlqtmEogCiXoTzLOTEZYlsAeBJmMs9y+lC+E2xmVLXQfRpgcKDZ5xIIj0v5BB2Wh9WZvG9nyKpxZIX/pJL7Qt7HFJBvaXyNuyxv34WFxcxOCV9zmFCB0In4AXXeQtSZhZ/7hAShNotI5ewhtV0VPp2wcYFgm+MUKzSlc4fK+HEBv9Y0ar9cBmWTRtwyq4cOSgDatcr4hVVg5yOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199015)(38100700002)(316002)(36756003)(5660300002)(2906002)(41300700001)(44832011)(86362001)(8936002)(66556008)(66946007)(4326008)(8676002)(66476007)(83380400001)(6512007)(478600001)(6486002)(1076003)(6506007)(2616005)(107886003)(186003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rftnzb3txsJvaKEUskxY25Xi0ehcYAgD5j5sE0VcKHQcujzbhtvknSAFUZTH?=
 =?us-ascii?Q?t6gCZ4AHCR42cYzyTQxqkHObAOpvxEs50pdpEMUck7kO59RLTckJ1h+acIAD?=
 =?us-ascii?Q?JtV9Ao4Chie6gP7orAttU2/jghag5K+nLBb0domvtM4Aigtu0axf9Gh7j2wL?=
 =?us-ascii?Q?Uh1Wp7wQQDgjWg5fRM2lydJqU2EjIokMAOy8yFzpaOtusZ4X4h1KFHl3TeVE?=
 =?us-ascii?Q?3afYCnFYL6kOpAJF8ew7Gxo5ab/r6696aclv2W06rDh2ZetiBVbRHfZIvIl4?=
 =?us-ascii?Q?Q4fkDZZ8PctsoxefTZHAxu4fnkz+bKHmPK6d4/ZsZo2yzpab531JwSbFQcV6?=
 =?us-ascii?Q?wf+zLL4yQNy3k9uRRepH4XqGjutGp1wfec8ftzsb5FXDqA1ECyBA30vw4612?=
 =?us-ascii?Q?go2CeEEWG0E8KzbBP+DVnAE1ov/vxsInVmsNImUOj6tMj9K/zBXaRZcp9dxE?=
 =?us-ascii?Q?bXKLEgNDAXp9zPfBlup3V+Hlt5pR9220iweXY3SygltLCj9W+xVDyn33iq1N?=
 =?us-ascii?Q?4fq6Myfh/NmnN/vLnSU2LVYJbT3iOj0VCh8tvIUvvxt8tLBgsHRdwRwkU3Rv?=
 =?us-ascii?Q?s9MfDNEJY6a/AviNbEatTS2JY8fvHVyM1q4RBJBzNUQnG34xTqsrIya+1dU9?=
 =?us-ascii?Q?UVIBKWdplBr53eLWMeZ5+ypwikanZBpJcV6kArGviZzRZZYk7IuihZPpQqu7?=
 =?us-ascii?Q?RISFEsRjGNcneBvlZaEo826BmfS9EBgniwqmiypyICLh7Q50lODfhy1Ky2xF?=
 =?us-ascii?Q?3+QQq5+Qo5jpuNT8Jzt7mIpaoy+YsDLHGk22dCK0zK/EdHOI14HviAyWvS/G?=
 =?us-ascii?Q?REJj3AynQqDhRjrsyLRHUcLAsurijyCiZbyxYjIld2E5UnBC1rpt/+s35u39?=
 =?us-ascii?Q?5TLHDYqQ16Mmo3C20Ly5dbXXPDJYjPCLTi9y8i2qKYLKTCK+YzeiQwwo4tik?=
 =?us-ascii?Q?DVt+QiahM+hdfsmQ2cE2C8Hf8E4vAmK5crU1WhbhMeR4lOSRMQ58sZwbhJs0?=
 =?us-ascii?Q?+mhPjCHVrUY9sgPvBlwthIwvtCDJjY/3D9mr+uTokZCKkYz+A7ovZv2dPmv+?=
 =?us-ascii?Q?pItxsfbAxeyRebg+2YKEFtAch+xOG1eDQaQKSR67drfxnqk3nsdHnX6pUn9X?=
 =?us-ascii?Q?Oue6TwU2X+NO61CJiBzVcb36ogcYL9oWqEqqqCoyjrtRXJj+G9fA9VozXBKR?=
 =?us-ascii?Q?zak0XwrsfXO8xUxmBjxXrfpRZi3fudvCqN85tNH4cJ2TB8zvCvWdCMF/zher?=
 =?us-ascii?Q?DUMfpoUM/yIvu9L5o/5BtEQQgjSMlXkbxcNj+vMgCXxekJTSiLXz//msec8a?=
 =?us-ascii?Q?EuYSn99DxZier0FRUgwgM9vHJOLiCf4JD/uoD/0B5yHsIe7LhVJvAQeU9peE?=
 =?us-ascii?Q?G1zjTUT09nK5539k/phFyf+WiaaWLZLWbcitJ3pkJscmo4KYXdODjaAtu5rU?=
 =?us-ascii?Q?LzJU65QvsZPLhYhYAKX9sssExChrPIp+A8Yulp95QxdobctquQzcQF+iJgIA?=
 =?us-ascii?Q?yrCNSvSb4Yl41PGE1E4htNVRl1RQU8/t3KJOUIkvOvPz6sVfCW7jZEPCGLTT?=
 =?us-ascii?Q?f0RPC+yKsoWyqT97DQXFEsVjclfV4TqQewDNnfamiiagPRbLmNzTWFyh0NXd?=
 =?us-ascii?Q?q4g5/V5EXbJVzD+1fUB2qPM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?wC3G+f4Oh53egn+YRzZ426/KOrVQrxBwBcmsBwiwKq1inEzs1CI2OyLiXP8Y?=
 =?us-ascii?Q?JWXlWXq+xqeWjdOXFSxvw+65nKnNWQO2dx/OTAHTv1Ip6Tn7ZW+UX1TX/IIU?=
 =?us-ascii?Q?3paR6weNaJNDhZFciIArqKjsMJakEPVouGo0qAUeHLEvLe6tGNB3PfWb/qEH?=
 =?us-ascii?Q?IF6aTitgSNKe5dgL+Xjnb9HMR2Xei8txhlHsdThZ/vlasJikYW1s+Hx+7aFR?=
 =?us-ascii?Q?r2cS7TevkbFSPxy3eAkpFtHRXSzWSSzjnLw4p1Mx8srMgrIWp7GbMHpPHJxD?=
 =?us-ascii?Q?0wBp3pMCppDQ7fJAD7654yRSZxE8U1LHZkvyb/r0d0F95CdAkyQkz0jsysaV?=
 =?us-ascii?Q?WtzY4xke2ABAJfIw+1neIZL7287kwX8dQmHs0AHvU76xNbygPdPi3T3szKXW?=
 =?us-ascii?Q?yHMM9m2c0eu0L/LuyOpOo2xmsqjOEIdN0SdrdOPee9bMY+S5ZJj0rEs/Tkfd?=
 =?us-ascii?Q?2Ma3WxodapzzrmUURUwCUrsiCqdNQi4A9t3ODonCSqXA9RIUTiK3/Q4wRL+9?=
 =?us-ascii?Q?IBqtPQIegbbTDxTzoZxfcTb9yqxnt+Gd6yjqFmnlSYqboqQPmifq1dutN4Jq?=
 =?us-ascii?Q?nULj4bW4Tlzn6gKvbYbshqsMV/3ABmUEjSjQS2m1Wh71b12xnTYYtjMm25z0?=
 =?us-ascii?Q?pNYOJMFthpRWANRli81tamNbgjIYcwmUR3n+jHSOkRCrgklz0n98aZO23hQ9?=
 =?us-ascii?Q?6ZpQmmfyiE/6ufXi2CcdNpbgTmsf9XmQyel6XhlOPd6tUsXEaxJHxB5kD27q?=
 =?us-ascii?Q?6l0UVBl3716Qt6lvvs0eLkGLrkXexYeFxvriQkQy92Qq2NTeR2xfIVDesKV6?=
 =?us-ascii?Q?tJwEwRtioWTXL/H6w4cykVwA6HqU3XefpuFA9XpTOPCc+waCHMxIaJmlPHDu?=
 =?us-ascii?Q?eXmRcF9QhbuGiB4DsR+3QkEmXRtwh1I30bFixHmEzIWoYznLDSiJ6rCweXoM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1443c24d-3124-4b07-f278-08daf351a2dd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 21:28:38.1700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gXKdbphwEECgzz85cTJlsHLqAubDRk++Tw3AnoTHsXrjFuo9sWB93nj+sEIXfBiSl00LJ99BlU49tT6wC/U/n+YN4a0VmdytxQ59MfdW6IQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_09,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100142
X-Proofpoint-ORIG-GUID: F8pDYTWsLqR7dy66Ea6uKUhzx4AvaDMC
X-Proofpoint-GUID: F8pDYTWsLqR7dy66Ea6uKUhzx4AvaDMC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dequeue_huge_page_node_exact() is changed to dequeue_hugetlb_folio_node_
exact() and dequeue_huge_page_nodemask() is changed to dequeue_hugetlb_
folio_nodemask(). Update their callers to pass in a folio.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 56 ++++++++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9155bb5ee570..c206a8c1ddb6 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1140,32 +1140,33 @@ static void enqueue_hugetlb_folio(struct hstate *h, struct folio *folio)
 	folio_set_hugetlb_freed(folio);
 }
 
-static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
+static struct folio *dequeue_hugetlb_folio_node_exact(struct hstate *h,
+								int nid)
 {
-	struct page *page;
+	struct folio *folio;
 	bool pin = !!(current->flags & PF_MEMALLOC_PIN);
 
 	lockdep_assert_held(&hugetlb_lock);
-	list_for_each_entry(page, &h->hugepage_freelists[nid], lru) {
-		if (pin && !is_longterm_pinnable_page(page))
+	list_for_each_entry(folio, &h->hugepage_freelists[nid], lru) {
+		if (pin && !folio_is_longterm_pinnable(folio))
 			continue;
 
-		if (PageHWPoison(page))
+		if (folio_test_hwpoison(folio))
 			continue;
 
-		list_move(&page->lru, &h->hugepage_activelist);
-		set_page_refcounted(page);
-		ClearHPageFreed(page);
+		list_move(&folio->lru, &h->hugepage_activelist);
+		folio_ref_unfreeze(folio, 1);
+		folio_clear_hugetlb_freed(folio);
 		h->free_huge_pages--;
 		h->free_huge_pages_node[nid]--;
-		return page;
+		return folio;
 	}
 
 	return NULL;
 }
 
-static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask, int nid,
-		nodemask_t *nmask)
+static struct folio *dequeue_hugetlb_folio_nodemask(struct hstate *h, gfp_t gfp_mask,
+							int nid, nodemask_t *nmask)
 {
 	unsigned int cpuset_mems_cookie;
 	struct zonelist *zonelist;
@@ -1178,7 +1179,7 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
 retry_cpuset:
 	cpuset_mems_cookie = read_mems_allowed_begin();
 	for_each_zone_zonelist_nodemask(zone, z, zonelist, gfp_zone(gfp_mask), nmask) {
-		struct page *page;
+		struct folio *folio;
 
 		if (!cpuset_zone_allowed(zone, gfp_mask))
 			continue;
@@ -1190,9 +1191,9 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
 			continue;
 		node = zone_to_nid(zone);
 
-		page = dequeue_huge_page_node_exact(h, node);
-		if (page)
-			return page;
+		folio = dequeue_hugetlb_folio_node_exact(h, node);
+		if (folio)
+			return folio;
 	}
 	if (unlikely(read_mems_allowed_retry(cpuset_mems_cookie)))
 		goto retry_cpuset;
@@ -1210,7 +1211,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 				unsigned long address, int avoid_reserve,
 				long chg)
 {
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	struct mempolicy *mpol;
 	gfp_t gfp_mask;
 	nodemask_t *nodemask;
@@ -1232,22 +1233,24 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
 
 	if (mpol_is_preferred_many(mpol)) {
-		page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
+		folio = dequeue_hugetlb_folio_nodemask(h, gfp_mask,
+							nid, nodemask);
 
 		/* Fallback to all nodes if page==NULL */
 		nodemask = NULL;
 	}
 
-	if (!page)
-		page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
+	if (!folio)
+		folio = dequeue_hugetlb_folio_nodemask(h, gfp_mask,
+							nid, nodemask);
 
-	if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
-		SetHPageRestoreReserve(page);
+	if (folio && !avoid_reserve && vma_has_reserves(vma, chg)) {
+		folio_set_hugetlb_restore_reserve(folio);
 		h->resv_huge_pages--;
 	}
 
 	mpol_cond_put(mpol);
-	return page;
+	return &folio->page;
 
 err:
 	return NULL;
@@ -2331,12 +2334,13 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
 {
 	spin_lock_irq(&hugetlb_lock);
 	if (available_huge_pages(h)) {
-		struct page *page;
+		struct folio *folio;
 
-		page = dequeue_huge_page_nodemask(h, gfp_mask, preferred_nid, nmask);
-		if (page) {
+		folio = dequeue_hugetlb_folio_nodemask(h, gfp_mask,
+						preferred_nid, nmask);
+		if (folio) {
 			spin_unlock_irq(&hugetlb_lock);
-			return page;
+			return &folio->page;
 		}
 	}
 	spin_unlock_irq(&hugetlb_lock);
-- 
2.39.0

