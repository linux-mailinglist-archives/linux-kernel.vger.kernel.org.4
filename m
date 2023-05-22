Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B208170B35A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 04:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjEVCwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 22:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjEVCvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 22:51:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700D4A0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 19:51:50 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34LMJmCF027086;
        Mon, 22 May 2023 02:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=ijkjgDBlrocZHMJHEqv+wHUnbT48ejMnmOLMUUhbyC8=;
 b=kzz5Eo+CC8I8rhJ5Iipo35BCDEKJSgb7Rg7riRPvNdDZqyzbYwvZ4tKgb29omglORU/J
 I/uZ3re8e77jQ15JwPTzQ6pgGO/n0nekn6LVRvaGzz0nv7f/pWgd1isSi5P+7y4KemG2
 7LPYA0cGjkaFU1cLbbN5QKJI83kKi6eJkBi4ts1mWLLZ61jEmkHd4C6wnBwesGCBDWYX
 60qB4aMu8nlBFO3W4W1mSuEFNjTN69CqGtcmSGA1ky6l24l/Ro0rkseEGSQRCzJl4VUf
 Nn8FAZUpKuMnKJ1sljB2CE7tukYxPC1clxnf+Q1m2wUQhQHD+Ckzu91U0gfeRBluBaDb cw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp44hq79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 02:51:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34LN3faN028764;
        Mon, 22 May 2023 02:51:36 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2p4dga-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 02:51:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDtkO+d5GWHMWhg79e/Do93+5k8kqf6TBOD/fSufBU9rqctkyO3+98ep88ZKBN45dpms8eg6Z7O3gvAsshuAz7pdiijzGOTUxo7vpOTza0RBQGnFfKFuuq1NedJtJHzNX3a6Mo+MVoDbzFIYLDmYaQLItJ30nIQ5S/Y8jCbYGmhOlkACHwPqbzfzwtqPDI3AMDnBHC1hu24b/shvG+ptjwRmsOdGSd9Z52h+LbzXi4b3AiXmec1NFcaODZdTa58oNhLTeO8/MtiuqWrq6+CdxR6ypEO+0ubgTKvQuFwvGoMPDlco/JEzSxnWc6ZqUAIA3fMKeHJ+kJiY89ks0Qnyrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijkjgDBlrocZHMJHEqv+wHUnbT48ejMnmOLMUUhbyC8=;
 b=aSGJK70eE7h7jv84BGVAyVU6qSua+Nxf7ds9CVIPMgAGDgF7uh23pI6kMcwMyazn41l5JCHE8FdzxftQFrZUlZJLNEPvKPRjvkw7W+FOJaOKw6z06Jsw7XFToxIuc7+SRXI1eMANBKuNVadoGqPWcYgMNT9fTno23pqNQnoYh05URH5u+veR3eMVLd66paWLHPl2zP7x34mOjiES3QPS/gejP6JJMQVv5OxADoWuHjMfRLUonBlZMY0fqBZia1kv+nBW2Q0Jgbtx5ZPJYlU7K7Ns5kRuvjvhvuItAA77nnFrKLIbvPC1YxQJrpEbxsND3pepWBtufcKlKCuFXUQHvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijkjgDBlrocZHMJHEqv+wHUnbT48ejMnmOLMUUhbyC8=;
 b=U8HKcJnG9N5Ll6CUU/2FqhheKlBTqmrK6v96StrtuMy/gA5oF6NMLk+E/VM4xT3nJdDf5POXtH1rtyaHrSg79PdyoNCH8sOS1KG7/dnmVjGZXWL7xincDyn5+e8Z/P7+Sn/tsTKG1bKSarvSlpOlmLONHeROcX9tdbJggXcrJrU=
Received: from IA0PR10MB7255.namprd10.prod.outlook.com (2603:10b6:208:40c::10)
 by CO6PR10MB5620.namprd10.prod.outlook.com (2603:10b6:303:14b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 02:51:32 +0000
Received: from IA0PR10MB7255.namprd10.prod.outlook.com
 ([fe80::6f12:fcdf:da87:2bfe]) by IA0PR10MB7255.namprd10.prod.outlook.com
 ([fe80::6f12:fcdf:da87:2bfe%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 02:51:32 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
        axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps regression
Date:   Sun, 21 May 2023 21:51:24 -0500
Message-Id: <20230522025124.5863-4-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230522025124.5863-1-michael.christie@oracle.com>
References: <20230522025124.5863-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR14CA0007.namprd14.prod.outlook.com
 (2603:10b6:610:60::17) To IA0PR10MB7255.namprd10.prod.outlook.com
 (2603:10b6:208:40c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7255:EE_|CO6PR10MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: b7d4cb17-79d4-4948-7d8b-08db5a6f7362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: frTPgAOgT8bLtuRaMf0Ab/KKmzh62aBsJb5N5uxpGMVkzCdnljo4j0yR6sxhD3RL3Dcx3BEpPB788qt+fYJ6c061cFMtG5vjRa+gvthAexNSqwLKt6Q0hOXditx74K/Fx/K+XGR87E4T6M0adc8YXPaPlY/a79ZviAP+bO2zok1GjpGltjw03F6z+pqDOc0q3Ez8Vh9S1CGRhW+TZduZTY165nq1TgVb4iwrcKTttjOjAGwzdTQQX1qN6WCojv2gFxl06UoFuU+laOstyI+VFdHzHe/xKaEkoQhKcBtIZetl0hdnBvVt10fUy9gri9txkTNhuQrPXlEhOSFR3oFHSSzXqjrH8KeZ6aA7S2fyp6KCG1lZC4mwRmqhT3DUtVKHMwOwy8hqHytlEJRgZs3BiNNxk+YVHqAwI6S0lJPtK6qQGSgquwGRPnznvOLOPWNuYYlqYlUeAGbnNkh8fHDjM2IrV0esywP91WVmzFHOaaZm95zo4+sc3NYDirjPuo0iXuN+fSdGTO65yARMYj0FglhXiGLtmvfsU9sWKc8lZZO6VZn8W9KQBIABhojOHFvGsE+cGqxIH64r9TYJw8pzSgBcnzhPV7a5ZY9xlXouo1M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7255.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(921005)(38100700002)(8676002)(8936002)(7416002)(5660300002)(6512007)(6506007)(1076003)(26005)(186003)(2906002)(2616005)(36756003)(83380400001)(107886003)(86362001)(316002)(6666004)(478600001)(66556008)(66476007)(4326008)(66946007)(41300700001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wpt324eoDtRPqHdtx7z1H6Brvy2HRomKJDhtYMFkBCjhNMTfz8fov2XMI+Jc?=
 =?us-ascii?Q?tfC7fG/Djyxq8ORcopEKjAC7srKaFLnGJTYu0UJljZ68GGycxI1Ox35x8nyJ?=
 =?us-ascii?Q?KaJx/8vJ4DY1BbeBdjo+CkFqMDwV23O0mzB+hBPLv3gVa8aDb/+iGnuktbk7?=
 =?us-ascii?Q?jbcbwJpnSYw4iG2EJUSKNf6SexgeMv8x6Tc2DH/OEGwzzeTHA29iVuWBzuUC?=
 =?us-ascii?Q?M2OH4x4MTUHHXuYCuBn3bLIrCNrIUnvKSFc+OZKQml5piydkpNxSj7NDp0Ei?=
 =?us-ascii?Q?C/KgJljniq4obbwB5apSPO+PhsLgTdti1YRige122POGj68EHp1VRJuQVN9Q?=
 =?us-ascii?Q?Xjo7I/wqYIm5voOp0wfygLHKUx23fGXV/9VbqGm0zMMWFuA1qDBjYDtjs/9h?=
 =?us-ascii?Q?7UUXHtDHbu/yh1VFdADI24ZVGfjgXUNrBVomoDWDT8+bon9KSpPHwLMExewN?=
 =?us-ascii?Q?5XCiY3mpxGtgGDZh+RRACBd2vMmmM04Aq8a0iPVlSmecuqDJOamqeKc1M5vd?=
 =?us-ascii?Q?EJlaw9duwk2dGp45EEN4j7tmXWZJ7y1lllGgC3Jfb9MXsSKuX1+7PbzAAfrk?=
 =?us-ascii?Q?oIJqXVYmDOOmiIvTLY41lrZZIxHAoO4M0WMcC1M1OesLNW4dmdMyfzgmQA/k?=
 =?us-ascii?Q?C0QVCN1N55ZhPOtTtfWlX9XADglgJXYPN/QqeTnDO8IK68WiWnCBVR57l39w?=
 =?us-ascii?Q?7QTx7x4T2W1Gjj/8sNeIDD/EvvjYcnu99cQv/XRuDdb3K9VZPuUtMJ8cZN3G?=
 =?us-ascii?Q?N+JXwRxteM+NV86F9FqW9ueAJrhYfD452eSYt3HW0ttlR4IQpVHlJAG1XXel?=
 =?us-ascii?Q?gTLXZhpqXjpRKi+ZedqGA/iREnVv7n37Bz3aq2O0gyaM2QG2M1Vtagk4JQgW?=
 =?us-ascii?Q?+VbL1AJgrRFs2usphlelLpWsMZChaPjc4K5chzhFZG2P049bY/bjbPKHqEOU?=
 =?us-ascii?Q?oakdwpJ9RKQ514dApWFI+YiPSP2qeEDXrm0bIJGnjph2gshN+vW0pFZd/fu6?=
 =?us-ascii?Q?frhbCXQhdXUIcuaCkP/Toaobccr6gXl78/Tp3xZZIRfcf84JOfbSXKYcgnVH?=
 =?us-ascii?Q?T7J1gIBNgffId4YMh4Npzf9t9PdZGHqUdX1EgH07Udv6F191srVF3/GCM304?=
 =?us-ascii?Q?agBOGPEWhWY2/pG++9Yaip8puEVCWz62hRFBPqEnGdrP3RyneDM6TvdD3pPR?=
 =?us-ascii?Q?1gin5DH2OXR1khv1DoCsE/2Hd+23IeE9E5Yb1sjpH/hOI55XkUtuD6EgSyRz?=
 =?us-ascii?Q?0Rxwik9aPP5DtupzMYudlp1y0osJkFMH6HT9HBa+F+RKkEYJZ52Y7HWVqRFg?=
 =?us-ascii?Q?gPSjLeg5dqX9g/B/9cDl0y7yXsOaVOSykUcQGExx2emeTvNaB9jv5E668IRj?=
 =?us-ascii?Q?Pg0m0aIBarwPaQ2nX0HeNKTR+wIiDqfkgCJ0yBVcUKDRiZ3JNB9hHLTzvuTl?=
 =?us-ascii?Q?ae6d56jrspDxsERIowXYN/WoNuE+V42DZn8XWCx7b3rtfcE/7ZBz4XdCGGfE?=
 =?us-ascii?Q?2YMwa5Zv6pf1JQOxkx4/25aF3QJi/CSU5oyKdrqcdQvS3SW5tMOKPsGqSQoI?=
 =?us-ascii?Q?O70QTzKxEvVfAPTnavt6NNyx45F2TVZXRwE4dDH7v4kL13TFUsrEy1Td94Ae?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?tFpxXG9FOAM0WSuIP7RwqoWvdlGUHtTCGJpE8C2YYNUXWPisUR6soDqhx0lu?=
 =?us-ascii?Q?g4XssJmRHqpzA7YxGELmYtz5s2nIgXVW0m9o3Xmw2WJUw9vdpZi/wnmlJzva?=
 =?us-ascii?Q?VC4mbA9xbLcfnjX+z00/j6nex8bj/U1DDLxcwh/K667XZBct7otivKQYrpQY?=
 =?us-ascii?Q?wsn9pOpxcVY50a0zgykDNplMuvEh1zAJkxtIq7jLwJ+iZ98ZM69edJBXcpYD?=
 =?us-ascii?Q?5q8wr8rGXYbZKmUism4uj0pK8fOhhK3fBm7kXsDUvXJfZjIV8QwGbYGZkg80?=
 =?us-ascii?Q?r5mKEj/fiBsf2nHl5Lh4Obbdy/06bZZMhxjNAoCIl8ZFkRYTF0+0oHDuny38?=
 =?us-ascii?Q?tVNBcGuCCWnnOKt7n0aIrD+h8og2RPSdqsd+QMpOLsTeG53wh1q7hWpHT9Lf?=
 =?us-ascii?Q?nVYHYJvS9n6jzgQKuDvbSzhJnaYj7MFVI40AjSA4tDkAV/4eH/5EZwPzZttD?=
 =?us-ascii?Q?PpWv+CdrFDF2+YSsDcd0XqWHEaT+NOgSiA8HgMvjJvLQAqHAC2TnvheBSK5t?=
 =?us-ascii?Q?hilTJXFwGP/rcejNudvX/hseKMFJzLOo9y9A7xRIhTMuC71J6/I20Eff0LuW?=
 =?us-ascii?Q?sx/pFCmBiCv+vqq46KshdL9UyLk/JfrUsPVT+kTv/zG/KITu2wpEGge7S6u6?=
 =?us-ascii?Q?E412G6vXlDsIHnyQsgExxrtR59SqkdNKqUsaZBg+Iou+ipYrt1Ibr5WH/am7?=
 =?us-ascii?Q?msFanLY1DFL3H89yhR6IFFbqSVOTnUhHoY+WfjSJ2DE1q1WkF63dVVMdJ5lf?=
 =?us-ascii?Q?43WledC6RF1iVTEnovXh92IJ9VlJhR3NREf0mJJnjQlqEYeQh91cIHPid0xJ?=
 =?us-ascii?Q?iqhIRNJoAJUdwGPNuGyyEGXYHr5ogl6/MUgVLUMD7LMzv80u/904TWj5qwlW?=
 =?us-ascii?Q?ZcMnSRdJ5nnnnftia0XycRDAai7I1kGrWbj7V1f8mFXUc2/1mIV6ELpSHfny?=
 =?us-ascii?Q?CNGxqhvqOmAvXa+UapOsFDs3QSYLOiOYGHng9ewt+v4qhxWUwTryKoDnqZZr?=
 =?us-ascii?Q?1JDW7Yu4snOtgRi2qsBe5aGb8bHoBZkmLo8o37iT1A+5zKYZeOYqHWnqY8PT?=
 =?us-ascii?Q?+/syLTFj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d4cb17-79d4-4948-7d8b-08db5a6f7362
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7255.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 02:51:32.8068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0qprVmQgHAQ+9ypZb81ycBgDl4qalQAHM8g2Itmcvi3tUYdW1MsKDLP/I8Ovy8MfsGWTZjrnw3dCNILxDnXqQ0SAyY1Mv9Kj4VxFVRJIiW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5620
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-21_18,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305220022
X-Proofpoint-GUID: PXD3Gu8djwdr2-27Q1SgyzfwCK2FY3yX
X-Proofpoint-ORIG-GUID: PXD3Gu8djwdr2-27Q1SgyzfwCK2FY3yX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When switching from kthreads to vhost_tasks two bugs were added:
1. The vhost worker tasks's now show up as processes so scripts doing ps
or ps a would not incorrectly detect the vhost task as another process.
2. kthreads disabled freeze by setting PF_NOFREEZE, but vhost tasks's
didn't disable or add support for them.

To fix both bugs, this switches the vhost task to be thread in the
process that does the VHOST_SET_OWNER ioctl, and has vhost_worker call
get_signal to support SIGKILL/SIGSTOP and freeze signals. Note that
SIGKILL/STOP support is required because CLONE_THREAD requires
CLONE_SIGHAND which requires those 2 signals to be suppported.

This a modified version of patch originally written by Linus which
handles his review comment to himself to rename ignore_signals to
block_signals to better represent what it now does. And it includes a
change to vhost_worker() to support SIGSTOP/KILL and freeze, and it
drops the wait use per Oleg's review comment that it's no longer needed
when using CLONE_THREAD.

Fixes: 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c      | 17 ++++++++++++++++-
 include/linux/sched/task.h |  2 +-
 kernel/fork.c              | 12 +++---------
 kernel/signal.c            |  1 +
 kernel/vhost_task.c        | 16 ++++------------
 5 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index a92af08e7864..bf83e9340e40 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -338,6 +338,7 @@ static int vhost_worker(void *data)
 	struct vhost_worker *worker = data;
 	struct vhost_work *work, *work_next;
 	struct llist_node *node;
+	bool dead = false;
 
 	for (;;) {
 		/* mb paired w/ kthread_stop */
@@ -349,8 +350,22 @@ static int vhost_worker(void *data)
 		}
 
 		node = llist_del_all(&worker->work_list);
-		if (!node)
+		if (!node) {
 			schedule();
+			/*
+			 * When we get a SIGKILL our release function will
+			 * be called. That will stop new IOs from being queued
+			 * and check for outstanding cmd responses. It will then
+			 * call vhost_task_stop to tell us to return and exit.
+			 */
+			if (!dead && signal_pending(current)) {
+				struct ksignal ksig;
+
+				dead = get_signal(&ksig);
+				if (dead)
+					clear_thread_flag(TIF_SIGPENDING);
+			}
+		}
 
 		node = llist_reverse_order(node);
 		/* make sure flag is seen after deletion */
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 537cbf9a2ade..249a5ece9def 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -29,7 +29,7 @@ struct kernel_clone_args {
 	u32 io_thread:1;
 	u32 user_worker:1;
 	u32 no_files:1;
-	u32 ignore_signals:1;
+	u32 block_signals:1;
 	unsigned long stack;
 	unsigned long stack_size;
 	unsigned long tls;
diff --git a/kernel/fork.c b/kernel/fork.c
index ed4e01daccaa..9e04ab5c3946 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2338,14 +2338,10 @@ __latent_entropy struct task_struct *copy_process(
 		p->flags |= PF_KTHREAD;
 	if (args->user_worker)
 		p->flags |= PF_USER_WORKER;
-	if (args->io_thread) {
-		/*
-		 * Mark us an IO worker, and block any signal that isn't
-		 * fatal or STOP
-		 */
+	if (args->io_thread)
 		p->flags |= PF_IO_WORKER;
+	if (args->block_signals)
 		siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
-	}
 
 	if (args->name)
 		strscpy_pad(p->comm, args->name, sizeof(p->comm));
@@ -2517,9 +2513,6 @@ __latent_entropy struct task_struct *copy_process(
 	if (retval)
 		goto bad_fork_cleanup_io;
 
-	if (args->ignore_signals)
-		ignore_signals(p);
-
 	stackleak_task_init(p);
 
 	if (pid != &init_struct_pid) {
@@ -2861,6 +2854,7 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 		.fn_arg		= arg,
 		.io_thread	= 1,
 		.user_worker	= 1,
+		.block_signals	= 1,
 	};
 
 	return copy_process(NULL, 0, node, &args);
diff --git a/kernel/signal.c b/kernel/signal.c
index 8050fe23c732..a0f00a078cbb 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2891,6 +2891,7 @@ bool get_signal(struct ksignal *ksig)
 
 	return ksig->sig > 0;
 }
+EXPORT_SYMBOL_GPL(get_signal);
 
 /**
  * signal_delivered - called after signal delivery to update blocked signals
diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index b7cbd66f889e..7a2d7d9fe772 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -31,22 +31,13 @@ static int vhost_task_fn(void *data)
  */
 void vhost_task_stop(struct vhost_task *vtsk)
 {
-	pid_t pid = vtsk->task->pid;
-
 	set_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags);
 	wake_up_process(vtsk->task);
 	/*
 	 * Make sure vhost_task_fn is no longer accessing the vhost_task before
-	 * freeing it below. If userspace crashed or exited without closing,
-	 * then the vhost_task->task could already be marked dead so
-	 * kernel_wait will return early.
+	 * freeing it below.
 	 */
 	wait_for_completion(&vtsk->exited);
-	/*
-	 * If we are just closing/removing a device and the parent process is
-	 * not exiting then reap the task.
-	 */
-	kernel_wait4(pid, NULL, __WCLONE, NULL);
 	kfree(vtsk);
 }
 EXPORT_SYMBOL_GPL(vhost_task_stop);
@@ -75,13 +66,14 @@ struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg,
 				     const char *name)
 {
 	struct kernel_clone_args args = {
-		.flags		= CLONE_FS | CLONE_UNTRACED | CLONE_VM,
+		.flags		= CLONE_FS | CLONE_UNTRACED | CLONE_VM |
+				  CLONE_THREAD | CLONE_SIGHAND,
 		.exit_signal	= 0,
 		.fn		= vhost_task_fn,
 		.name		= name,
 		.user_worker	= 1,
 		.no_files	= 1,
-		.ignore_signals	= 1,
+		.block_signals	= 1,
 	};
 	struct vhost_task *vtsk;
 	struct task_struct *tsk;
-- 
2.25.1

