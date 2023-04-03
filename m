Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFB16D3CD1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 07:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjDCFXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 01:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjDCFXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 01:23:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103443C28
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 22:23:13 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 332MwUai024750;
        Mon, 3 Apr 2023 05:22:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=A+gbjMRQ73fBFl4pqWuQodz1X3vjS3hPwXVwaIKhxTY=;
 b=x12Br4NU5hCMefRthWdz/zXcq/h36XvBZA48N62EX/+ton8v+E3dG+tJGyTl+HWC5CYa
 3R/xWCSHtFlGQ0TvYHzP+HCDkeqyMDCmtxNcJQR3tjyg4OaIHP/X8EPGwKzmn589Z+kV
 o895JU7vuzXpwWg5ecYA+4wU6UsmXKKq+bxDCKRNHDsDFa5zq0WdqQr1LbybRdn3fvYW
 4ZrSZb6OZF62Xjpl3O0pBAehieMZIDnAebyoLvZhTYbBSr2axYUAnyI4kMiwlHjZYivP
 S3Uv33xF03xhMj6Vm500pHUJHyY/WiCm00wEO6qKDvE0SmgD7pq4fwa+lX8OOJdeW+iB KA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppc7tt43u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 05:22:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3332axZw001034;
        Mon, 3 Apr 2023 05:22:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt3eu93b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 05:22:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PK38zv7jQIUEySx9bR3gfkcP96Y/lsJNJ/2lLjaN4SCHIAK6YNGdOCeG9fWdPGIT94L3bSiq9gEePfG9musfn7D5ep+hELd6pHwAbBa76odzDVgwkeqQ+SW8jBwEeN2xPXuDROqVs7HzPbYgJTAXX1X716tXTJ87TTOCbzj1xkD56r+Bj6Rf4GT7P5smXznd3AsW18NMzKTpOD08wzNxuq8Is97dY1m1J9zyMqz0/+9LGhnY++qe4SKzB99y0rQlLyPwkX+958qqGNm4w8+ZtPueeeg3p+8itmMZUvUTY/u2V9DMXBSuqNA6vGThZR6ZjS1+85IOD16Ac2KIdJAf9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+gbjMRQ73fBFl4pqWuQodz1X3vjS3hPwXVwaIKhxTY=;
 b=NqhwkBJ3T/wnZAMZD5mxvms9F0PXji9OnAwpss5ihUcnnVHufroYwY2SI+hRZbVsjR0jSkufPUAQvu18d4edzGm6DeZr4wBPoqxdJ5uRyNSz2FYrhHP0GBt/6gzXEu0OkH3Hxi45LqU++QB+w0LEd/7T54t0A1It0xYjpfXA1E+SUEGyiNFEQy/1mtr21GkCtsbVvldgJpwDrFdxKY4x9J+xT4PwIW8SAuJ5lXRkMfJQzQ+c3l8OsNWlzwFw3dO8g+wBMYSev8Mf/WrTRD4rMKYtNekUt89lFXejm5MlhRL3h8tbbaS5HfKCJgzs2uEa+Cn5RKsQjTQv5GdSZMwTnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+gbjMRQ73fBFl4pqWuQodz1X3vjS3hPwXVwaIKhxTY=;
 b=gZnsbqt1OxjTPRecjJxa+fqCRJ3Tf4P/dVWfyJ0tpvTBW9djklyptSjocH+6t7VzT+SuNxkbV3bQtoHx7X/uusH3+bfjsYWMos/rh/KY3sd1HmkMdSoGV5K3Y9iCG4vjkt/OrGlrqY21ih96ObA3+mRhMdzUOf1nKO1Pxe0zUHU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ0PR10MB6398.namprd10.prod.outlook.com (2603:10b6:a03:44a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 05:22:30 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6%8]) with mapi id 15.20.6254.029; Mon, 3 Apr 2023
 05:22:30 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        willy@infradead.org, mgorman@suse.de, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de,
        vincent.guittot@linaro.org, jon.grimm@amd.com, bharata@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH 2/9] huge_page: get rid of {clear,copy}_subpage()
Date:   Sun,  2 Apr 2023 22:22:26 -0700
Message-Id: <20230403052233.1880567-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
References: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0266.namprd04.prod.outlook.com
 (2603:10b6:303:88::31) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ0PR10MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: e6a7e217-89be-4ce1-1099-08db34036b92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hyOmS+UFryA5XzOiwc0PreKDQKORHMZ/T0+Z6zKBBhDZP6xUWuulAkf4F2T7HUUdU+MbLk8dLNHOyL2/pLq4VDin1P+t99ziABeDAjdmUtX1fqbZ84ydFA8Mf1AmaTRgePtlIzAGMkOF9nWhaZWTCfBRwRn0ZxpB8BOIztkhN02ZeQSVOIAIBAqe7TRnDJMVcxrAjz2ty2RLMmro6KTgoYNlPz25jN1T5ZkSq3/1Jmt89NxonohqRT8D7thWSslUcsdVd/k7E6Obh1rRmKa8JCQgHQpgfPptdCzPNzs6eYf8YOJzQbouQi/hfGrb9KTXNQiujSt4ERvuEHxx6EnZzq7Vs2wwJjvdG/wu36MahN4XqTrsd3PwzipuzNQ/J9BLMBGwWdklHcbvi+06WDofvBWXZUvsPCgHp0qIjy2rYDsewD0JhaT+eRy0tPhDZzaft0LAIr0G4YD5vgMHIaOrCeV9vTpsxJgkUwG4OmV8w2Ui9Wed8wFtJmskmxZ0qT/W5/Qfd1plm3kBhy7AAkh23ze7XO90/lNBb1mrwVdCOg/5V2OT/NOsgN8YftfXYdoMvyFz7umRBPKisXNxQwF00zK/jVmyJcFQkDdRoOU33t84z2rmAxYdOCNndRRdyno34BdKCka0MJDv29/19dRKKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199021)(2906002)(8936002)(38100700002)(41300700001)(7416002)(5660300002)(103116003)(36756003)(86362001)(478600001)(316002)(6486002)(107886003)(2616005)(1076003)(6512007)(6506007)(26005)(6666004)(8676002)(4326008)(83380400001)(66476007)(66556008)(66946007)(186003)(26583001)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j0GKmuPQY6MndwSvByy3LbGQ10SgoBLdvUkrTeVi4lfI5ahCqdVRGXHtJH8I?=
 =?us-ascii?Q?obDGgh3plyLEKF+ZDdwqCySZRx9YvhY7H8GplmD10B/hZ0TLwggl9lu9GJ2H?=
 =?us-ascii?Q?UbsjD2G8mm3hSS7p0oo8cBJyInE/7qmZK8sHAgvNpeQI6tq6O5mCwa2IY/Jb?=
 =?us-ascii?Q?OaHxDEE+2R+In9N53UCFb81bNqT6y+SOr2+dCDCur5fbPKuiF5lXu+rnR4WH?=
 =?us-ascii?Q?4bHALYa4P2VLg1hTFQyN1us4l8a8ZaKL3ohobCiNL256715/gI5O4j23+k6t?=
 =?us-ascii?Q?yLhNfnKX9ey62NwBuBeOrt2456IcVU5bJxw+C4LHAnXuKkaA8ZKKPECZ5iVn?=
 =?us-ascii?Q?dpgQQwng5Zzj3c9PfUKX2Kzn9KorwsVl23SOY6i+x9TdmZmv/LDH/N1Vnt9h?=
 =?us-ascii?Q?rFCsJLeAX3Aq3lpeldhiYcxFSFzi7LLM1/u/CvbCgoipZFsfX5xFf08M5ipH?=
 =?us-ascii?Q?v5n92AvKfk18m5VWfFZ+ZsXfIatOY62ov91ggRrJElTA8YSGUUXbJMshpNJM?=
 =?us-ascii?Q?c7ZXzqqM9/S5xFn0BKWf3rbZghJN71HHGP8so5B9o9GnBUoIragBNNRLaQrh?=
 =?us-ascii?Q?XTPIyYTF7QIVcm5z0bKRyt+0/eTedLG3X2bzD6WPd4q3OKym31K5OH5gmZI2?=
 =?us-ascii?Q?ilgA29Q1Z+2j8WoLb+6UJvuWOfLx27HER2w6GsqM8A2ekoMsau9FXnvh7SVk?=
 =?us-ascii?Q?IMcyCttW521Mho5YRrv67yPdeyfV551e0cgujGmsKq//Xo12C3cixP/RFvqA?=
 =?us-ascii?Q?VU01WbdHvezZBOwl//2cHKyUcdqHpxhgHTMwwZDnx8eBy17+3LQjJaZ58yqZ?=
 =?us-ascii?Q?yCKXnj+KQOVHlVJC34cK028zD0C+fcMpEh5aY8zrkR1JpEQnul3tVkiG/wXE?=
 =?us-ascii?Q?alZX4CNliASaavRC3yD+pSwYnm3nLmV6bw0jykTjtTUMTSEzlxD8gnz30Gxv?=
 =?us-ascii?Q?VCwzt12YzVjXMoDZ/sjiRW8g53ChLGG1cSHHEznc8OyATgDQqksnyebOSGoL?=
 =?us-ascii?Q?2gkAymU1RX9CbuzB+sh8UGf1jwTQ27te7v15Atl+YZiX582isRJsJH3gIIEo?=
 =?us-ascii?Q?d2/+Cxp0H5KgOJFr9jACfb2J1Gc2LywOm+wJrsCcJ/1nAZn6dKKxlMVA9twZ?=
 =?us-ascii?Q?fivlJozfF8I7h10yg/agx6Nec6RO/keO/Cqw9S8bq44U+rGrL2lxzxauLFmV?=
 =?us-ascii?Q?JiESyGHAJAEFAXAsow/gUX+eeksXdREEPjVO9OW84aZNFr8oy6BdinpLegmw?=
 =?us-ascii?Q?+8ImWpjB1SLVJT500o1A4WEJzevGvv4gGyunmmVy9bH6/w909/3zgiAFY7SB?=
 =?us-ascii?Q?WCsqawIZyXkdnWPV2hEV0U8PSmpjp+V/qObAXsm1vrASPYO749JN13Oiot/j?=
 =?us-ascii?Q?2PmkzUUKXDSEXNF5gUaTE0e2YiWUgTPKbrwUzoicqKaV/yKvzNK6jAd3ivrN?=
 =?us-ascii?Q?LwtGCiZ1Z59XYi0DNvhuMaCg+7K5HVdDXwJzW8DCv7IbyJIxkaHJLu14MkIP?=
 =?us-ascii?Q?G6Ithez8PgytJ8egQZhDJJdCl1JlALSylGtm7dArE/cs1IwAWL49QbDlMnRV?=
 =?us-ascii?Q?u7xzae3LCyq9MavaFWIs04TvhpjnvehG1fz/qImr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?kNquaCKMtyHag+0Yg+H3/LTeiyLlfuLyHzIqhWalNpR7d+qq3pLDIcdy/L4O?=
 =?us-ascii?Q?1ApYlf75EQBlhv0LfBW16Vq0bDmHma2r5EAE/LY4JOhV0xeAR6K40oMhlDyC?=
 =?us-ascii?Q?kw2fX0/1QaUzHBeX01GXyGMEdFtVQTXaPDnbFdY/YfTllVPDS0HlFEb/7WiU?=
 =?us-ascii?Q?5EKf65zhOj4mnAt4vGxZaFrz9Hx07fU0J0y/0jistZ9SglfDcPdQ+L7rjYpd?=
 =?us-ascii?Q?MuHi60Rl0qDbaGJ6nhU91sawHkT9oYPfvT/K5Zb2Ir6F0VQgki60jP+uc3/q?=
 =?us-ascii?Q?tKQfdzYwnaWJ3RfOpZPXzqQSpm8oyTv0j3Fe5jQWDuzXGbSdu/exjYDiTyyB?=
 =?us-ascii?Q?cjU2f2G42IvkGQLGQOJEHDfvSE1yZ2GZGedJlrJEC4FKSvMqEObOVG7HEU2r?=
 =?us-ascii?Q?py+pE1Ojhq5EtOMtL5uqn0Ap3oq1A9KgG2WY9LhVh3I33FKaJgklfDW8lXms?=
 =?us-ascii?Q?i4BVrOA/PBEVnv83h32Uhs2NNdc2ZfdfWMFf7Q1xJF6/7oUcNntsoRAvp+Gg?=
 =?us-ascii?Q?xYfd72CfQ+psLollm7d4C5R7Ww9Mq3lNnMML/YOjy8NDjvb0zBuGWd6WNudq?=
 =?us-ascii?Q?s4ZLmyYCMCXiV5o4gJjEe5LdvFZdx5rGlE9ZRMRQKKt/Q385F8NhM2pxZvI1?=
 =?us-ascii?Q?8kzI0XfeOZE2CKZGzfBqPWrwzocg/SZ4bK8dZos9s07uUHtd7P/BQObfob9N?=
 =?us-ascii?Q?XlzHW8u3/vavcoeAYH5CpQCDlqo05L/HrXdj577Kl/R8PRG7S3Y9ezxBoT0y?=
 =?us-ascii?Q?efaOhGdNueQ1gw+qr/aR2Uh/J9bmsAQh1TlSHjiteOJD5/sn5b8x6og8UV8o?=
 =?us-ascii?Q?teFFjgCgn9kc89XBkXDRBosn5M0FQV7jokEI6TUcxW0Nsf4TX/qljbhsYPlC?=
 =?us-ascii?Q?z1J1XSMsLXXShJdbgTlHZp0XGDGmXU4bJbzPA466Bv33aqWv+IkbkcCLF5ps?=
 =?us-ascii?Q?iX5y/R23HgrbBYxueagRmn816GiJcsDdy/4clV/EwsqQtCoxZ5wKRUWO8t24?=
 =?us-ascii?Q?PdEDIKj0l4gc1T4O5WbAo1nVkhSEbaRCR0CIeIwBbpSJ1/JaySB35lXZxjSa?=
 =?us-ascii?Q?0tD8t3+LI3X9pi+Dim7YbHAkiPpl+uOdpjFz/idLxPlsRHNftrImTawF0jIr?=
 =?us-ascii?Q?CNaAfg+vZ8dTtPR9eNTYm+fyEYMrjtmgp49NOM+ZJpQGrQu+y2DgRnc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a7e217-89be-4ce1-1099-08db34036b92
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 05:22:29.9656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SM97iqTUjbDjuwc9MF3gvVh6t3meW7PO7sazvOEB2EbZ3LrjlimRfaySfs9gjiCEeF2Ms5n40C8pz+khJZt2zTTP+KAzOJxWAbF7tcRazPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6398
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_02,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030039
X-Proofpoint-ORIG-GUID: YPAMp7xC3Fv8wlTX6rHaL5Ti_UiHFRq4
X-Proofpoint-GUID: YPAMp7xC3Fv8wlTX6rHaL5Ti_UiHFRq4
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clear/copy_subpage():
 static void clear_subpage(unsigned long addr, int idx, void *arg)
 static void copy_subpage(unsigned long addr, int idx, void *arg)

take as parameters: an index, a post indexing virtual address,
and a base page * which is then resolved using the index.

Instead just use clear/copy_user_highpage() directly.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 mm/memory.c | 46 ++++++++++++----------------------------------
 1 file changed, 12 insertions(+), 34 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index d54bc27a35ca..6da97e6c7d21 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5645,13 +5645,6 @@ static void clear_gigantic_page(struct page *page,
 	}
 }
 
-static void clear_subpage(unsigned long addr, int idx, void *arg)
-{
-	struct page *page = arg;
-
-	clear_user_highpage(page + idx, addr);
-}
-
 void clear_huge_page(struct page *page,
 		     unsigned long addr_hint, unsigned int pages_per_huge_page)
 {
@@ -5674,7 +5667,7 @@ void clear_huge_page(struct page *page,
 		/* Process subpages at the end of huge page */
 		for (i = pages_per_huge_page - 1; i >= 2 * n; i--) {
 			cond_resched();
-			clear_subpage(addr + i * PAGE_SIZE, i, (void *)page);
+			clear_user_highpage(page + i, addr + i * PAGE_SIZE);
 		}
 	} else {
 		/* If target subpage in second half of huge page */
@@ -5683,7 +5676,7 @@ void clear_huge_page(struct page *page,
 		/* Process subpages at the begin of huge page */
 		for (i = 0; i < base; i++) {
 			cond_resched();
-			clear_subpage(addr + i * PAGE_SIZE, i, (void *)page);
+			clear_user_highpage(page + i, addr + i * PAGE_SIZE);
 		}
 	}
 	/*
@@ -5695,9 +5688,9 @@ void clear_huge_page(struct page *page,
 		int right_idx = base + 2 * l - 1 - i;
 
 		cond_resched();
-		clear_subpage(addr + left_idx * PAGE_SIZE, left_idx, (void *)page);
+		clear_user_highpage(page + left_idx, addr + left_idx * PAGE_SIZE);
 		cond_resched();
-		clear_subpage(addr + right_idx * PAGE_SIZE, right_idx, (void *)page);
+		clear_user_highpage(page + right_idx, addr + right_idx * PAGE_SIZE);
 	}
 }
 
@@ -5719,31 +5712,12 @@ static void copy_user_gigantic_page(struct page *dst, struct page *src,
 	}
 }
 
-struct copy_subpage_arg {
-	struct page *dst;
-	struct page *src;
-	struct vm_area_struct *vma;
-};
-
-static void copy_subpage(unsigned long addr, int idx, void *arg)
-{
-	struct copy_subpage_arg *copy_arg = arg;
-
-	copy_user_highpage(copy_arg->dst + idx, copy_arg->src + idx,
-			   addr, copy_arg->vma);
-}
-
 void copy_user_huge_page(struct page *dst, struct page *src,
 			 unsigned long addr_hint, struct vm_area_struct *vma,
 			 unsigned int pages_per_huge_page)
 {
 	unsigned long addr = addr_hint &
 		~(((unsigned long)pages_per_huge_page << PAGE_SHIFT) - 1);
-	struct copy_subpage_arg arg = {
-		.dst = dst,
-		.src = src,
-		.vma = vma,
-	};
 	int i, n, base, l;
 
 	if (unlikely(pages_per_huge_page > MAX_ORDER_NR_PAGES)) {
@@ -5762,7 +5736,8 @@ void copy_user_huge_page(struct page *dst, struct page *src,
 		/* Process subpages at the end of huge page */
 		for (i = pages_per_huge_page - 1; i >= 2 * n; i--) {
 			cond_resched();
-			copy_subpage(addr + i * PAGE_SIZE, i, &arg);
+			copy_user_highpage(dst + i, src + i,
+					   addr + i*PAGE_SIZE, vma);
 		}
 	} else {
 		/* If target subpage in second half of huge page */
@@ -5771,7 +5746,8 @@ void copy_user_huge_page(struct page *dst, struct page *src,
 		/* Process subpages at the begin of huge page */
 		for (i = 0; i < base; i++) {
 			cond_resched();
-			copy_subpage(addr + i * PAGE_SIZE, i, &arg);
+			copy_user_highpage(dst + i, src + i,
+					   addr + i*PAGE_SIZE, vma);
 		}
 	}
 	/*
@@ -5783,9 +5759,11 @@ void copy_user_huge_page(struct page *dst, struct page *src,
 		int right_idx = base + 2 * l - 1 - i;
 
 		cond_resched();
-		copy_subpage(addr + left_idx * PAGE_SIZE, left_idx, &arg);
+		copy_user_highpage(dst + left_idx, src + left_idx,
+					   addr + left_idx*PAGE_SIZE, vma);
 		cond_resched();
-		copy_subpage(addr + right_idx * PAGE_SIZE, right_idx, &arg);
+		copy_user_highpage(dst + right_idx, src + right_idx,
+					   addr + right_idx*PAGE_SIZE, vma);
 	}
 }
 
-- 
2.31.1

