Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E72D6D9E05
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239757AbjDFQ4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjDFQ4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:56:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21022108
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 09:56:31 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336EfPVM009591;
        Thu, 6 Apr 2023 16:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Kd4w+6qa7PC15ByVZRLBcWt3BEuzDjXllAuM20sUnMY=;
 b=f0sSWzfvLYMfl7BVO8ZhdTDk4FyM3g4yVd8O0WtKkKt4xisft22n/ztBM4XGxydDSt2n
 a3xOVoxvFGGEmBZ7XTAWLpGH+ocvp0WrgClaPyFj4Ezs4dXQC03O3A6GnqSCU820oBH/
 7LtzpIszoIh5ja1pPDxcgPVVnYM6fJjlVkgASJr64p4BD6BAfF9hXgCYe0qA6f/2z80R
 ISSNYFAG+8Irdv5axO77hehnr8syONvr+A6fv2xHhQMLkZ6do+CLQ2K17waxmzPdMUlp
 tPw4Xp4yvQXY3umU53ZncWHNwosRAJ8q77wbj9UscKtc+bYLnR2Etyd4xoeMPrNkZ5FI AA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppcnd3emg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 16:56:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 336FAuiL036535;
        Thu, 6 Apr 2023 16:55:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt3mgp60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 16:55:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpempBwPNWaxk5WrhEQCseyaR4Jf9AzZgrurPa8CiI02hQhYFd1puAr1dXUjtYW5H0SJYEjn9gBG/xgX0Spd1Rj/ajICDelYyxfOOFLIJVGYKD5JQ4+ZOGbc6WwhB6MuzQsTpDjTS6K5qb2WH766917oqvaLz5x09OR/KHHvhgFSVBkz86YjtAzO1UZI3A5AMLQIiv1UJZypEymw8LaSg648Nb2bwJhOC+eVxbWMMng3X9ccjWi3LbeQUIU2HKE2v1rePrDvWwFoBaUkfSeHJRBowRFrhxAVZ+exaud7CbCR9Ze14qOI/kPNLNSZG4TXdly5wVFk7RlKl8YCscUkyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kd4w+6qa7PC15ByVZRLBcWt3BEuzDjXllAuM20sUnMY=;
 b=WqlviWnz1DcMLZF6cdDFoGPTzvaU/X9fwY5uvLXzyLFSba5KukIa0Zdm25U9r6LylwoCjEYVF0yqyBfjZj1zFWTVtFIBJ8DtbuMyBM6am+a4sRWvrtF0gI1kiMzgBljHCotyPLVUL/sEOOSPXUyclUadKlnwq9dimNuvlHVO7RHXLkm821VAtSxhOa2Gq7RC15Dr5lCzF9h4mh0RxV4uRw7MHqq4KraFcENdu0cvis5or5UXL1W7yB+yiaX3R0IWTHJ1zEMAC2dwegEFPIvZIxCCeOCYSf/rP8B7n/NfEfKx0EwVLDmv3RkL8Lr/ev2xFwtaI/umLk43utX8YRtvVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kd4w+6qa7PC15ByVZRLBcWt3BEuzDjXllAuM20sUnMY=;
 b=S+yrpuPdDHmeh0U7+vgIfmX4Yj9cYLJHNKok0RSYItPe5yy+YuvWCMIvSAcJVj3/O2cADzMLVDL4ck828TFXz+Wbfjkx3dWuodyQCLI8zrJh+mDhITIS24u2jO1pamYKRPLomc75KsHiluD/QhnEbNvaiFZP17e/+zDMtQO0Rvc=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB7287.namprd10.prod.outlook.com (2603:10b6:208:3fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Thu, 6 Apr
 2023 16:55:57 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6%8]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 16:55:57 +0000
References: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
 <20230403052233.1880567-9-ankur.a.arora@oracle.com>
 <20230405202240.GE365912@hirez.programming.kicks-ass.net>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        tglx@linutronix.de, vincent.guittot@linaro.org, jon.grimm@amd.com,
        bharata@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 8/9] irqentry: define irqentry_exit_allow_resched()
In-reply-to: <20230405202240.GE365912@hirez.programming.kicks-ass.net>
Date:   Thu, 06 Apr 2023 09:56:07 -0700
Message-ID: <87o7o1lzko.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0344.namprd04.prod.outlook.com
 (2603:10b6:303:8a::19) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: cbad2ba6-80fa-4eb0-4e53-08db36bfca77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I6JOWz+NosnbNsOTbuqQFQQ7EbO77xMn6TU6SNhnOeu0Oya0BO6li6qoN27eKLwzEIKgxT/XOUMhmGHGL7Fzju2kvluzbCCp3MvnJPK64ncJV0/NeCIp4Srk470zlgiLjUGLxOXcnSnbNZFyqcshOrA//RHVfJB3peRLKwI/Utvqnd3OnwGGO7ghHj7Zoek7/t+o0CNGsl7k+6LIO+rD4brtYX1qfS89+ymH3GsGFRO2ndGhKQ9AplXitGOiWnvzwHcNPVsTGKBqj5N9Zgkhwq/TCF1qBpooXm1e49DhefxI5VQTiC6QkOakA9erA8MdIhG7i5Ovbl53rt+2l/isH8fXJH2nCq3t+rzgzfvIm8Yxwr+0yBN1IniTPWay7geXN2K3PgwSXCs/a6DzsStGEAyp0yK4WEM+VarHDimSojprD4ALM/nj+5CAklWIsemBAYEVpZTYPZABcl8rt2WybqJ9HK4jrMGsw9TEtnv+AczpiH520w/T5Jjg+6cp1ZIIjGmSqu8UOZdlezd3P+ypxaXQjE7NUPPKBLoKTcSpx2+OMtxckeGD3+DsM/oqUR7b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199021)(38100700002)(36756003)(7416002)(2906002)(5660300002)(86362001)(316002)(8676002)(8936002)(66556008)(66946007)(41300700001)(4326008)(6916009)(66476007)(2616005)(83380400001)(26005)(107886003)(6512007)(6506007)(478600001)(6486002)(186003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DhHb8cdG9nPvgleUTIIfqg750gShrmfeKvV20oTXu9ztme6skpqbXrMzd0sc?=
 =?us-ascii?Q?WtNz7roU4ZyBJ0TDrbpSPU8wmXjVhBBoMk2PUsOsNX+jxjKghDMgiqWbs3OM?=
 =?us-ascii?Q?d4RCDZxH1YjEqSTxcbkfF9boHQg6htXoFh1ZUEEZoFcDqEmsAsYnba8gVVpL?=
 =?us-ascii?Q?ZUb5IvcYJadmYBRs8k8OQl8Xtzq+B07RrN/ww+BDHHs6++UmjOy580o2eGZa?=
 =?us-ascii?Q?vnovV/Wf7BlAUAxtbILzuI8DisLSnvGWWQPlKF8RuxK/PXIsEzIOsPL2cMAy?=
 =?us-ascii?Q?CX2TORITaLLHE5S6L89Sg3mDOTYyMePY+NcL9Qd0jLf1VycOnJBOHAMpNyud?=
 =?us-ascii?Q?eBRpUVCdSw1NjiBKg82wR+5F3WrescLgKhvtRqfJ5PFrP5RaS9PYEbAQGmTf?=
 =?us-ascii?Q?TTkwKmyZV9s+XG7O40B0dh3JHvfgkW9R7wFhucLzBvnYBRIeF1++e4LQz5oD?=
 =?us-ascii?Q?cbQYvlitI4N+m+bprPZCij8UM9B0e9k5q+z/Jx8R5rIJ+qjkhmJwOv6Fgu3b?=
 =?us-ascii?Q?VuaPguEw67feHYqim0K47HlGK+3Qn7Evf6hJsivIgCZ6nCHeVLOy2AmK1dG/?=
 =?us-ascii?Q?oPqq7a4RrigHZce+Wg5uXfQ1Iuw25Z5BPbLthMV5xzxfISGSG//RqMRiVBjn?=
 =?us-ascii?Q?FtxqwnNT3B3XjNxPTLngq7RR8/gQNI+25vM1qaHfSmyylKzcrvDSU/aK2tCP?=
 =?us-ascii?Q?1y5RvJrcTj3v9JjzDCFtems24otjhbm0W5xO3JFBvB0tIhYMTPtl2o3HMdsK?=
 =?us-ascii?Q?2SNyc6vy3M4lPvQ8sk7v8mlCEF8Gdu3c+l8/N8/mm3OK50rBXEtC+9RZQQrb?=
 =?us-ascii?Q?1Zvlerb3H/ODoIkP9uejqGUc94tBXnPXO47gm6YUIMd0JmDos3o/HOTRE+yB?=
 =?us-ascii?Q?avbo75A32sN+NHA6Iua43s7W1y+i/PrHILQKHtNgdF0lwYxW9f7wEJ1Rhobh?=
 =?us-ascii?Q?Zl/JrX3Bdy3y/u50wUOK5qIs1SxeV88NJSDL/OPR43U1koEP4JqSoocDL62x?=
 =?us-ascii?Q?Exp6z8ELdsX6jNOEPn+GUVS8za36sIoQ6cgTfYMZexPgZe0TEb/Noy5Mxtya?=
 =?us-ascii?Q?IjCTwn5yi8G+6LW1UtTZBh+FVJFWwFK5FtbTw303uOLAbdC0AvYNyIqoaVku?=
 =?us-ascii?Q?QuY/tENIPUmzk+5jNncBfXUDHa1mG2PXy4TYlXM2Us+Cv2tfa8zpK7bbMlmT?=
 =?us-ascii?Q?CyxrvmwevD1OL/cxTG5ypFKIctke8kv0zPnawa2LVmqDlwWzBlYa6HTxN/IB?=
 =?us-ascii?Q?WjJWm8paYsuTCWQHHXMJD5wHgF/1fi6I/wYBKtQXkGoYg8soLrZxa5Y50hWB?=
 =?us-ascii?Q?LARS/dJym7ee+EufEGaIiJPmGTDHNK35dKYncAFkmUSSNcCO3x8vUOKxYCi+?=
 =?us-ascii?Q?mSKag+E/DaszymPfWqyz4DcjP6lsFYAHiFZGwXpNNFDJCwoARY66WjuQViL3?=
 =?us-ascii?Q?viRAs8pNw1pBv7y3paPAj0/9YTOqRMlkzOdilIDe+PRsrU3wKLUSz3Ib7nts?=
 =?us-ascii?Q?gh0a/fRWoANGpLNb+ycRP5ruFlpurarRkc/VSeJl14KmrPlCZr4E5Svu4Edb?=
 =?us-ascii?Q?jFUWIUO8aOhIHKLvgxXo13dBUErZEZxajpviKzqxZ7c+fZvY2rpE+Ov0qPuB?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?xZth9SHtB6x0J6AasVlMFD2o3guxKzbjzNESPYKlH80iUQgA7q0dg4UowKQC?=
 =?us-ascii?Q?TyUryWwF7wdZFY8oFKAAam65OLQg7lc6Nz88Sc0ekV+DzSLhkZi6f2+RnY3P?=
 =?us-ascii?Q?4mV1CuUke9uRjCXR1iRK093cmT7raOZNzWtnqYHCs+5rRLiYd1Z3+SX2qaIr?=
 =?us-ascii?Q?pqHLX3U2GTWF9deI3A6XxQeDuYuM8INvewOESgxWoViRkvVjDo9rCl0HY4Ay?=
 =?us-ascii?Q?0oXBv0RJy5XE/WdbqVzUsYMLBxEo5aU4MhWLjiHpXigIqnesgiPc0k8HiEeL?=
 =?us-ascii?Q?wjeK1AWjLqxOLJgqS/BID5GC27PLwAAck6ZI2iaBlzbn8niUccmTQK3Iuwej?=
 =?us-ascii?Q?CEjjXH5RT9R6yDGNX3duKWJ69VAxzzC9aonC/zUVoZNklR7nTGkyytxVtNmJ?=
 =?us-ascii?Q?Fh0QUVJB0ksXQ34m2Sy7Y3pQ/WikXOMuSy0VWL9L4FEZlfSNz6JPmvtNGKpx?=
 =?us-ascii?Q?hScloGuW8rX+tmNaTzr2fmfOTxMRQG66D4AbWlpu+PGZS6De8zYh/7dWwEPW?=
 =?us-ascii?Q?rvvj+i4KdDQgA5fJpr4fatwlbXAH5CHN1X6TqpoIYb5HyYE1OCyz4vox+eY8?=
 =?us-ascii?Q?XJx9RZdaWawwxSDmFA55w9e7g2WFT13MJ9QQj6ukhlDuwBZBIW21x+K0fKxa?=
 =?us-ascii?Q?+yS0kjzvzFeFU8y5tRMDH2pDWJGUTmDtQr2pufDQTkWUp1QSWEXUIrReyFfJ?=
 =?us-ascii?Q?OSeKkcxwat4dFWz0btt24AodZlU0K8vHXDZFmCDw8qzvH9FG5t+J5EDwCnvs?=
 =?us-ascii?Q?G4u1JIQGKVYsY7dN65LOmXlvLguj8fbsVUzLKUCy09CbNEKf8x90ODD0t7rF?=
 =?us-ascii?Q?Tk36CL/iLxJUnkFuWiCcrCFH7/w4z7Bzki4TVsWN12UDrXsbkkElDMapwkST?=
 =?us-ascii?Q?OkBcvpHR0saox69pUJ/8LU+jv3IuSa+wCY1m29LXrBOpGvotJodMWZsnrlQV?=
 =?us-ascii?Q?piY/KPqA5B7bavEbqKasM9M6oLsW0vTp9pPODRaw6fXxdT2d6ckjl1CKJ7AT?=
 =?us-ascii?Q?QIOSgFW3ee0gY+VIXGKnTthhJNvXwWMtfyQjevhUAvZ0tjGI7l1POMWGkiYh?=
 =?us-ascii?Q?Gv7Cl4E91wykib0aRxHPARBJOcPtQXS0f4ww2UG1Mr7+gGyn36ziqk2eEY93?=
 =?us-ascii?Q?4N461B5HJXxuwVcmn1MgwJFYaPKig0rACGpWPFV5ei/YW1kyTfSMOdA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbad2ba6-80fa-4eb0-4e53-08db36bfca77
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 16:55:56.9661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqRcLRP/ODMO7Z9se6+sEohcOfkLkyoAf2kejWloa274Fx5zOgNlRplniMe19T6m6gh6FHRANcmgV8vycwminLdaB0yOW69W57SReynYCZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7287
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_10,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060150
X-Proofpoint-GUID: VDA2fYfv32sO0ub4OYppHC4sMLCEzQlA
X-Proofpoint-ORIG-GUID: VDA2fYfv32sO0ub4OYppHC4sMLCEzQlA
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Peter Zijlstra <peterz@infradead.org> writes:

> On Sun, Apr 02, 2023 at 10:22:32PM -0700, Ankur Arora wrote:
>> Allow threads marked TIF_ALLOW_RESCHED to be rescheduled in irqexit.
>>
>> This is only necessary under !preempt_model_preemptible() for which
>> we reuse the same logic as irqentry_exit_code_resched().
>>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>  kernel/entry/common.c |  8 ++++++++
>>  kernel/sched/core.c   | 36 +++++++++++++++++++++---------------
>>  2 files changed, 29 insertions(+), 15 deletions(-)
>>
>> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
>> index be61332c66b5..f1005595ebe7 100644
>> --- a/kernel/entry/common.c
>> +++ b/kernel/entry/common.c
>> @@ -390,6 +390,9 @@ void raw_irqentry_exit_cond_resched(void)
>>  			preempt_schedule_irq();
>>  	}
>>  }
>> +
>> +void irqentry_exit_allow_resched(void) __alias(raw_irqentry_exit_cond_resched);
>
> Because typing raw_irqentry_exit_cond_resched() was too much effort?

Probably unnecessary but wanted to underscore that irqentry_exit_allow_resched()
handled a separate user path.

>> +
>>  #ifdef CONFIG_PREEMPT_DYNAMIC
>>  #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
>>  DEFINE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
>> @@ -431,6 +434,11 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
>>  		instrumentation_begin();
>>  		if (IS_ENABLED(CONFIG_PREEMPTION))
>>  			irqentry_exit_cond_resched();
>> +		/*
>> +		 * We care about this clause only in the dynamic !preemptible case.
>> +		 */
>> +		if (unlikely(!preempt_model_preemptible() && resched_allowed()))
>> +			irqentry_exit_allow_resched();
>
> This is wrong, if we have dynamic preemption then we have
> CONFIG_PREEMPTION and we'll have that irqentry_exit_cond_resched() call.
>
> Basically what you've written above is something like:
>
> 	static_call(foo); // raw_foo() when A, NOP if !A

Right, so:

CONFIG_PREEMPTION: raw_foo()
CONFIG_PREEMPTION && (preempt_dynamic_mode == preempt_dynamic_full): raw_foo()

This is NOP if CONFIG_PREEMPTION && preempt_dynamic_mode != preempt_dynamic_full.

> 	if (!A)
> 		raw_foo();

So I would call raw_foo() for the CONFIG_PREEMPTION=n case.

> What you really care about is the CONFIG_PREEMPTION=n case, but that you
> don't actually handle.

I don't see that. The CONFIG_PREEMPTION=n (or its dynamic version)
is being handled here.

Ignoring the RT case, preempt_model_preemptible() is either:
   IS_ENABLED(CONFIG_PREEMPT)
or:
   preempt_dynamic_mode == preempt_dynamic_full

So, I'm handling both the static and the dynamic case here.

if (!IS_ENABLED(CONFIG_PREEMPTION))
   raw_foo()
or
if (preempt_dynamic_mode != preempt_dynamic_full)
   raw_foo()

> And yeah, you've got the extra resched_allowed() thing in there, but
> that doesn't make it any better -- this is all quite horrible.

I don't disagree. There's a quite a lot of static/dynamic config options
here and adding this clause didn't improve things.

I think just going with a static call here for the allow-resched case
might have been cleaner. Alternately I'll see if it can be cleanly
folded in with the irqentry_exit_cond_resched() logic.

>>  		/* Covers both tracing and lockdep */
>>  		trace_hardirqs_on();
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 0d18c3969f90..11845a91b691 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>
>> @@ -8597,28 +8599,32 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
>>   * SC:preempt_schedule
>>   * SC:preempt_schedule_notrace
>>   * SC:irqentry_exit_cond_resched
>> + * SC:irqentry_exit_allow_resched
>>   *
>>   *
>>   * NONE:
>> - *   cond_resched               <- __cond_resched
>> - *   might_resched              <- RET0
>> - *   preempt_schedule           <- NOP
>> - *   preempt_schedule_notrace   <- NOP
>> - *   irqentry_exit_cond_resched <- NOP
>> + *   cond_resched                <- __cond_resched
>> + *   might_resched               <- RET0
>> + *   preempt_schedule            <- NOP
>> + *   preempt_schedule_notrace    <- NOP
>> + *   irqentry_exit_cond_resched  <- NOP
>> + *   irqentry_exit_allow_resched <- irqentry_exit_allow_resched
>>   *
>>   * VOLUNTARY:
>> - *   cond_resched               <- __cond_resched
>> - *   might_resched              <- __cond_resched
>> - *   preempt_schedule           <- NOP
>> - *   preempt_schedule_notrace   <- NOP
>> - *   irqentry_exit_cond_resched <- NOP
>> + *   cond_resched                <- __cond_resched
>> + *   might_resched               <- __cond_resched
>> + *   preempt_schedule            <- NOP
>> + *   preempt_schedule_notrace    <- NOP
>> + *   irqentry_exit_cond_resched  <- NOP
>> + *   irqentry_exit_allow_resched <- irqentry_exit_allow_resched
>>   *
>>   * FULL:
>> - *   cond_resched               <- RET0
>> - *   might_resched              <- RET0
>> - *   preempt_schedule           <- preempt_schedule
>> - *   preempt_schedule_notrace   <- preempt_schedule_notrace
>> - *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
>> + *   cond_resched                <- RET0
>> + *   might_resched               <- RET0
>> + *   preempt_schedule            <- preempt_schedule
>> + *   preempt_schedule_notrace    <- preempt_schedule_notrace
>> + *   irqentry_exit_cond_resched  <- irqentry_exit_cond_resched
>> + *   irqentry_exit_allow_resched <- NOP
>>   */
>
> This ^ is all complete nonsense.. irqentry_exit_allow_resched() is not
> a static call. It's an alias of raw_irqentry_exit_cond_resched which
> circumvents the static call entirely.

Yeah you are right. I added the SC:irqentry_exit_allow_resched
prematurely. Will fix.

Thanks for the detailed comments.

--
ankur
