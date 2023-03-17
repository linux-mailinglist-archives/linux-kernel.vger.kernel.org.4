Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C43C6BF3C4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjCQVWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjCQVWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:22:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8EAC7950
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 14:22:14 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HKSsR0008688;
        Fri, 17 Mar 2023 21:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=M93HLaJLOeumEU9xgRQGN7V3DjfIfNKal2885ctY0fU=;
 b=qTdhuDpGZ0DguTd3IdmdB+Beeaj5ufhWimHrfFvkDwTlozimqqWeJp1RHzZG2+ciZ0r5
 3a2FfeHp5X7wPoU8hW6xd1ZsuWGekL55I7sJiuE73cBpYhO6XLAZ83mBBY4qGIBxoLrV
 wYL051/qV0iwZvzjUADU6xIUxkPUHgsOQjjRqeAh5fb4XZu7npZ69dhaUNy2pnmd5rc6
 wmwP+l/14g8e73cr9vGo+KDSEFiuiUrwTfT0/VGHvwNEr8D3isxBeVUQvyTXK85uUrEn
 2fWWH6VCwa8jrKWy3cbzQAQxguqLLcwTTlwEdpzrC/ywwbeO4LeSg3HclQTRRhp7spqx NQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs2avqbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 21:21:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32HJNAAe001117;
        Fri, 17 Mar 2023 21:21:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pbqq78jcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 21:21:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsnsVq8kxpFhUMoiWM6UedebKyLw4fnMEte4l6gpxftVNMads9ocRJpmzVnIfFGa0nPMW7eddd5lVI6+3OZgdXQlE1f3RpfNXN1pl2gbzsjRB4tR4kWEFadKoXtsrgSteZLIaaOKfi+df/sM9XjwNm+ofES/PIef5f7XIn9yC6IIj5pSj7dJc4/OBbuET3Jy/dVMRqL0Uv4DdZOiF9wo/sZdA5tmqLAm//ioQfu2g1f7kHGsIrdc7fhKtU1EBWguRBRHA/QbSX044RpjtLFMwMctS+WIYDyfUspCt5BjLNu8kExQSMf/RkxNqE5YYx6k4niOKewyKmTlnmisLoQdyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M93HLaJLOeumEU9xgRQGN7V3DjfIfNKal2885ctY0fU=;
 b=Vmf++BydXdRik1u4PovueNdU9HxxbsolwTErt+HMOOZw8ymu1nWJesevIbaxCYe+ch91QrTzLsX6TOgXkmj+gxxwHZHQxCHUA7BLR5uw0criGfaXikQ+sMzN0VYefMjKzwhL+eGijwy6ZJ6Kp4QE4rLm66CQ2JHA5BdhaOcyJrGpm3oBKTzosXMam57Mru5w7m7GZCUlAXdZ3DdZ18c8OW1n/2389siOa3zchZmLx0uNwBeDxbW1Hm5gVy8Svcm73d9E6IazQIGaAIR1QcPI/OjUz2zY8UGt52Wj3FrHkhLR4/N3kOAIR6rj9RqqelVE9aplbnkbtaVkfwCAhF7YxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M93HLaJLOeumEU9xgRQGN7V3DjfIfNKal2885ctY0fU=;
 b=QzHhQsTS50xt/lHar917EF2ROCb2VigaVK8CShUg/9zVd/SnCyM5g5QZhc6BmggcGD5loFC+/Zj1aKvMQ4tziyH5XmqsHJfcJ7AMbIIHPc0oRU1oQCk64Qb7NlsF6gCdNZ2m2u4udicTRjekSTlc1PCWhoAFqStqapUFLWVR+YQ=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CH0PR10MB7483.namprd10.prod.outlook.com (2603:10b6:610:18e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Fri, 17 Mar
 2023 21:21:40 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%9]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 21:21:39 +0000
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
Subject: [PATCH v20 0/8] crash: Kernel handling of CPU and memory hot un/plug
Date:   Fri, 17 Mar 2023 17:21:21 -0400
Message-Id: <20230317212128.21424-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0504.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::11) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CH0PR10MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: 79996cd4-5d75-4cb7-b2b5-08db272d98e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NDIjPTsNLMiQjE0QDQgfiiPPUZYNCG5AjlRGrdqYHEN+n2H71XASkArof7tM0LRTjPDpUIyHEn/w0iVBkGsewT6V5mNvJ+VSkR+6mUEogFCeuRpqPS3SSrgTIVnRnhCHyJ1Y73Ewa/Ai2mZi28499Mjp/Eru0yPeGnmny+FIZmwSjCynZ0uhYpsmSXRIC+tDEg4AQ10vzr5zXOmiJUqTttY1wa8HtrKfOmWziqaMtP/uEbKXD7u2aoISOEgZ1/Djz8bk9bCpo0n4eJgCppO+61PF2RfX/4A1COKaEYSZ3pk4//5gTmAhaUG8macfcsSbJoFBEWVOVtv05XWNvYWQfkHK6yIeTnbivdMnoI7eyljtDTMKmSJ3dv7S2ImEMxZ00FEUw2gtx/P7swK3o9qDYrlS8+6hOqs0Cpcx//I7tk+pDe/rt2pzerswgoX7k5UWdR0l1n6GD9OwISitA7lIS3EgAtxYd70ulaKGcGsUm/lAQUMWwKIhCXtAQ13WqS99B5IbLHzY7cf1SPFjUHIrvWwLlYI98Wp0aPGrfqitqt2v/Plo1zBi1pJGuQTSgxVjRfDGpSQY0s46uqC1L9SYn4Zlvf08jS88SAqLuZHfXcKivw/Xfeje0CN7SeANLZm3QS28T4mDfWZA78yiy7oTHejebR2QK+NN7VskX9Vtjfg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199018)(86362001)(36756003)(38100700002)(2906002)(41300700001)(66556008)(66946007)(4326008)(8936002)(478600001)(66476007)(6486002)(2616005)(5660300002)(83380400001)(30864003)(8676002)(107886003)(7416002)(186003)(1076003)(26005)(316002)(966005)(6506007)(6666004)(6512007)(66899018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8DrtxX6zlPEKRvXpC85TVhemGTC8Qwc61T8UHg1dgzmC5Yrumn9AcPDSqaUV?=
 =?us-ascii?Q?gS9YtS3AeYeyR+xGOECeJdTmwNhChDwmNz5WBZAeX1Sqn0jLIgbkmH+sn1QW?=
 =?us-ascii?Q?V/tosbE8QF8+S1j3ElMvUHXW5SuSFzyyV3FbvvMkCabmE5xgqBMiq1MegODx?=
 =?us-ascii?Q?uk6EHuVkkHeu0RCaHcKkS+p7Yh7wp8RkEgJBWM1/hU415JfjfkK85dEPBEp7?=
 =?us-ascii?Q?9/Kt1pJMyg1OdZKDxG6mVjWL7/7B58C1nhrJmebKyeHXqDh3NUKz58FN+RyL?=
 =?us-ascii?Q?U6d941+ndTwj0S2hzPe1a/oXxcEwNsFhMDzHPlRuWvIBYXk/j0V0znvEtaT6?=
 =?us-ascii?Q?0bspymXYxTA6nmuz60+ktTIvPS0PLzduVkIZR0B10gxI+KdLMWgp63MsilL4?=
 =?us-ascii?Q?xw5nzXthoV6AosgDyfbbHlgocwRB4pQMeZe1uEpZa2AlO+vn6FI8yMlX2xCu?=
 =?us-ascii?Q?AfrD+91KF4UQOzRgwR7Z016iMLgdcmhz4EOD002H1nxQ+Z+JIfDMSePuHee2?=
 =?us-ascii?Q?lVR9SfhZ/aHHqSaY9Ffm+nZebQZhocz0QQEO3J1NxGUuODZpAdNlFtdW0xCP?=
 =?us-ascii?Q?KPHfkqNNK7KIZdAI7ZJyNlEEj8iU1m3ge2o9EwD4n+0BSTPk+YurrwqLEojs?=
 =?us-ascii?Q?x5MpPr6POhB8s/O+fK2R3qv/Fl/UmlBGYUY7evcMivM9umhOjsUqnFIs2HOG?=
 =?us-ascii?Q?PTCMErHpGjiwGtAk1rPAJQdxTbeXzAWVTv2deMrG3zsK7p40D4xO44lUDvPj?=
 =?us-ascii?Q?j6Jd+e7WbUedgPfsxaJeMR9b5hyzjUE7eF9CjsSH9dNw+kT8pjxkX8cmaDfq?=
 =?us-ascii?Q?+hDzSwhQGUc50OVVtFu3vR8wFhKe4Bk7YJ1qFnG8fn5ScfMPFFBdLWxr+UHK?=
 =?us-ascii?Q?qPB6wiA2veuZnlpluvkrUVHXeC7IqTPq4hTcdyQ1W1SGvh2nrHepOnGKzHo+?=
 =?us-ascii?Q?BhCJzgnlsmjJbX63eCMju9Rk18GNE2RY6nnergReKMpOiLYoK9ZlFHJ8fD/R?=
 =?us-ascii?Q?NnJ2MtS6bNChzi1y/KjoEQoL/rJmpSrZcG86CWYhz92f5/j1v4wEEHFqtYEc?=
 =?us-ascii?Q?8UKQ72TMzC94JyGVx/spFfxlXE60Un8u9bhkYsuwPwN+tBT6Y1N5Qf+C2m5U?=
 =?us-ascii?Q?9+f1CuKDOb323pZTQLfJ+jeZpJKMHhW2vxz49zXtMy1zGbHGxPGih7lmH18+?=
 =?us-ascii?Q?kkHJlg9FvtnIz/OzKJZAVTPbKgxiMu3TnNP2D+9YTQyOfTHYh4eb9jZBOMMO?=
 =?us-ascii?Q?8qhoXeBLNb8XzNKKk1Z2Lghp6noSBJPnojkpRqIFcZW5YiVl4/W0CPsj2Rni?=
 =?us-ascii?Q?qY2ohy8HF50CD4wIr0FfcMI6aVYfVV5Up18HIcm6zV1BfhdD0clMMFCqpqj8?=
 =?us-ascii?Q?47wdGOSJksav5M5gPRnZS5sejU0fyTlrN0Z6xSb1yUUWKC1ggWihvgs1/QFn?=
 =?us-ascii?Q?/L/rn8V+7O/+ZNXaWgUy24KadVOPkAdDOr9szwOmBNUnvPCsJ+M4Mgf0Jnle?=
 =?us-ascii?Q?VQJrLX05ri9oFU8gzycc2ppiyv61uabGtIz7Dd7knv/JrU/9BZIuW57gKpvz?=
 =?us-ascii?Q?tn8TwG2HRektQ3BUulsw8/z0KJeKQsz2YLt6dX2JixYV/Hx2IQw0gNykJOdW?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?OqD1KzanJrlWYm/69HxOk9svzWkdrYGDSTrHjIZbiU0C2ZgkTt31RyenSH+E?=
 =?us-ascii?Q?iUvsQQGNXdibEr9Rrc4Z+KRnRPW0yNuOyZWwDSuO8asZl7FGBBLPox4VhpwZ?=
 =?us-ascii?Q?7adJucFjlHwjnGyxoKw09MF5FsmumqqyMGlUOsRancmZ9ufuV6gh4vrGkKoh?=
 =?us-ascii?Q?kWTygN+kKqfnQV5kPmm07/EeqeTHRvjW9NzPXTbMu73vEgURZ8DOuCCsrTIO?=
 =?us-ascii?Q?P7SPodtuHoicgwc98MlvYCMqKedt0Ud02pQq3BWvo4JyPh9L5laV6nTTbcun?=
 =?us-ascii?Q?DzMEOPqlH3uDxZS6CJYpigLuVAkI7sGiRQkM+lBjZvhmyTS6DBKwVahQlWGT?=
 =?us-ascii?Q?w527AOSOdWHMBqI+eU5/PSNygiJSSMzNtqhyE2n6/luvpPvGn3vwlsr0H3ny?=
 =?us-ascii?Q?5XR8gBl8BSviqcK73Mfdwh0X6xYuyzCZ6Ua9NY0UWkHfRwRWh9lhf1f9/1S3?=
 =?us-ascii?Q?e1NwcsU6d7R4+yofti8NM0QbBFqVs9xY9uEYrwdU6JsdqjOvUBAjYppoXP5w?=
 =?us-ascii?Q?ocs3G+icIv0IhLTjWY7lBvTiWEXxxQteucW1/RBcVND4cDOROKRXMMCR0LQA?=
 =?us-ascii?Q?ozIB0OIotmcdk5suXM/4jZ8iBF6qFGv9RhLX9UoN94FL28ol5cShLuUzOrd5?=
 =?us-ascii?Q?ANksjgNqr+SAYBi6DMftzk74kLu+SThNBF0LAQ9vR0NthWyWE81pgeiwu2tH?=
 =?us-ascii?Q?cgDplZdTOF8jqfOYLQOmKBP4OCljICRUbrI5jHldA82s2xdAg3p/g7VAgxOq?=
 =?us-ascii?Q?bDRyzSrLs8WA+fyjkkB8MAgVhRUG/AOqnIjcIbMlDm4yWa1fa33uWqjuyooC?=
 =?us-ascii?Q?B10T85AtNtWGiQ4r1pmvfAw5CYq4oWBZBsq+0o9o0H7qjYFtD11hfkkLEkRA?=
 =?us-ascii?Q?UHOHSuuiIc0f5Q8JPRvw1WSbDTvShVhaEzmP+Fk+YGEts9DZj5COslHTZuA5?=
 =?us-ascii?Q?FWN5QLUx1GRPKEkKhWcXwkOevLjW6FKOKiYrIC4bC6xsDykUu2+wRxH5tRKQ?=
 =?us-ascii?Q?PIOQ3akXZT7TSpj8zUKbUmYiZUr8uv9OuktHo+Rv42RNvbk4G5r3rzEIwDFa?=
 =?us-ascii?Q?1vEclAUMci7g19hAmpqvaivCdlK35F66ZIBH/3s0F5hTAhHuH0nFBktWA4xy?=
 =?us-ascii?Q?tWX/Iw88RTLzwypZsMMWCMSw6qyaL39aQwjk51oQB3dPH2Bqj2qh86o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79996cd4-5d75-4cb7-b2b5-08db272d98e5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 21:21:39.8228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q9FZfr1a/YDoLRN2GIaUdw60UzqcRG1vuveD85YEdgVia0bJ8KLUMTds+RN0v//gAW4aZ8rtzACCuFliMJtoqxYYatWAVRi3kKNoX/GkZbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7483
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_17,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170150
X-Proofpoint-ORIG-GUID: _QHSUV-Prm52794KYTPH1vOo1mZshgFs
X-Proofpoint-GUID: _QHSUV-Prm52794KYTPH1vOo1mZshgFs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once the kdump service is loaded, if changes to CPUs or memory occur,
either by hot un/plug or off/onlining, the crash elfcorehdr must also
be updated.

The elfcorehdr describes to kdump the CPUs and memory in the system,
and any inaccuracies can result in a vmcore with missing CPU context
or memory regions.

The current solution utilizes udev to initiate an unload-then-reload
of the kdump image (eg. kernel, initrd, boot_params, puratory and
elfcorehdr) by the userspace kexec utility. In the original post I
outlined the significant performance problems related to offloading
this activity to userspace.

This patchset introduces a generic crash handler that registers with
the CPU and memory notifiers. Upon CPU or memory changes, from either
hot un/plug or off/onlining, this generic handler is invoked and
performs important housekeeping, for example obtaining the appropriate
lock, and then invokes an architecture specific handler to do the
appropriate elfcorehdr update.

Note the description in patch 'crash: change crash_prepare_elf64_headers()
to for_each_possible_cpu()' and 'x86/crash: optimize cpu changes' that
enables further optimizations related to CPU plug/unplug/online/offline
performance of elfcorehdr updates.

In the case of x86_64, the arch specific handler generates a new
elfcorehdr, and overwrites the old one in memory; thus no involvement
with userspace needed.

To realize the benefits/test this patchset, one must make a couple
of minor changes to userspace:

 - Prevent udev from updating kdump crash kernel on hot un/plug changes.
   Add the following as the first lines to the RHEL udev rule file
   /usr/lib/udev/rules.d/98-kexec.rules:

   # The kernel handles updates to crash elfcorehdr for cpu and memory changes
   SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
   SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

   With this changeset applied, the two rules evaluate to false for
   cpu and memory change events and thus skip the userspace
   unload-then-reload of kdump.

 - Change to the kexec_file_load for loading the kdump kernel:
   Eg. on RHEL: in /usr/bin/kdumpctl, change to:
    standard_kexec_args="-p -d -s"
   which adds the -s to select kexec_file_load() syscall.

This kernel patchset also supports kexec_load() with a modified kexec
userspace utility. A working changeset to the kexec userspace utility
is posted to the kexec-tools mailing list here:

 http://lists.infradead.org/pipermail/kexec/2022-October/026032.html

To use the kexec-tools patch, apply, build and install kexec-tools,
then change the kdumpctl's standard_kexec_args to replace the -s with
--hotplug. The removal of -s reverts to the kexec_load syscall and
the addition of --hotplug invokes the changes put forth in the
kexec-tools patch.

Regards,
eric
---
v20: 17mar2023
 - Rebased onto 6.3.0-rc2
 - Defaulting CRASH_HOTPLUG for x86 to Y, per Sourabh.
 - Explicitly initializing image->hp_action, per Baoquan.
 - Simplified kexec_trylock() in crash_handle_hotplug_event(),
   per Baoquan.
 - Applied Sourabh's Reviewed-by to the series.

v19: 6mar2023
 https://lkml.org/lkml/2023/3/6/1358
 https://lore.kernel.org/lkml/20230306162228.8277-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0
 - Did away with offlinecpu, per Thomas Gleixner.
 - Changed to CPUHP_BP_PREPARE_DYN instead of CPUHP_AP_ONLINE_DYN.
 - Did away with elfcorehdr_index_valid, per Sourabh.
 - Convert to for_each_possible_cpu() in crash_prepare_elf64_headers()
   per Sourabh.
 - Small optimization for x86 cpu changes.

v18: 31jan2023
 https://lkml.org/lkml/2023/1/31/1356
 https://lore.kernel.org/lkml/20230131224236.122805-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0-rc6
 - Renamed struct kimage member hotplug_event to hp_action, and
   re-enumerated the KEXEC_CRASH_HP_x items, adding _NONE at 0.
 - Moved to cpuhp state CPUHP_BP_PREPARE_DYN instead of
   CPUHP_AP_ONLINE_DYN in order to minimize window of time CPU
   is not reflected in elfcorehdr.
 - Reworked some of the comments and commit messages to offer
   more of the why, than what, per Thomas Gleixner.

v17: 18jan2023
 https://lkml.org/lkml/2023/1/18/1420
 https://lore.kernel.org/lkml/20230118213544.2128-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0-rc4
 - Moved a bit of code around so that kexec_load()-only builds
   work, per Sourabh.
 - Corrected computation of number of memory region Phdrs needed
   when x86 memory hotplug is not enabled, per Baoquan.

v16: 5jan2023
 https://lkml.org/lkml/2023/1/5/673
 https://lore.kernel.org/lkml/20230105151709.1845-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0-rc2
 - Corrected error identified by Baoquan.

v15: 9dec2022
 https://lkml.org/lkml/2022/12/9/520
 https://lore.kernel.org/lkml/20221209153656.3284-1-eric.devolder@oracle.com/
 - Rebased onto 6.1.0-rc8
 - Replaced arch_un/map_crash_pages() with direct use of
   kun/map_local_pages(), per Boris.
 - Some x86 changes, per Boris.

v14: 16nov2022
 https://lkml.org/lkml/2022/11/16/1645
 https://lore.kernel.org/lkml/20221116214643.6384-1-eric.devolder@oracle.com/
 - Rebased onto 6.1.0-rc5
 - Introduced CRASH_HOTPLUG Kconfig item to better fine tune
   compilation of feature components, per Boris.
 - Removed hp_action parameter to arch_crash_handle_hotplug_event()
   as it is unused.

v13: 31oct2022
 https://lkml.org/lkml/2022/10/31/854
 https://lore.kernel.org/lkml/20221031193604.28779-1-eric.devolder@oracle.com/
 - Rebased onto 6.1.0-rc3, which means converting to use the new
   kexec_trylock() away from mutex_lock(kexec_mutex).
 - Moved arch_un/map_crash_pages() into kexec.h and default
   implementation using k/unmap_local_pages().
 - Changed more #ifdef's into IS_ENABLED()
 - Changed CRASH_MAX_MEMORY_RANGES to 8192 from 32768, and it moved
   into x86 crash.c as #define rather Kconfig item, per Boris.
 - Check number of Phdrs against PN_XNUM, max possible.

v12: 9sep2022
 https://lkml.org/lkml/2022/9/9/1358
 https://lore.kernel.org/lkml/20220909210509.6286-1-eric.devolder@oracle.com/
 - Rebased onto 6.0-rc4
 - Addressed some minor formatting items, per Baoquan

v11: 26aug2022
 https://lkml.org/lkml/2022/8/26/963
 https://lore.kernel.org/lkml/20220826173704.1895-1-eric.devolder@oracle.com/
 - Rebased onto 6.0-rc2
 - Redid the rework of __weak to use asm/kexec.h, per Baoquan
 - Reworked some comments and minor items, per Baoquan

v10: 21jul2022
 https://lkml.org/lkml/2022/7/21/1007
 https://lore.kernel.org/lkml/20220721181747.1640-1-eric.devolder@oracle.com/
 - Rebased to 5.19.0-rc7
 - Per Sourabh, corrected build issue with arch_un/map_crash_pages()
   for architectures not supporting this feature.
 - Per David Hildebrand, removed the WARN_ONCE() altogether.
 - Per David Hansen, converted to use of kmap_local_page().
 - Per Baoquan He, replaced use of __weak with the kexec technique.

v9: 13jun2022
 https://lkml.org/lkml/2022/6/13/3382
 https://lore.kernel.org/lkml/20220613224240.79400-1-eric.devolder@oracle.com/
 - Rebased to 5.18.0
 - Per Sourabh, moved crash_prepare_elf64_headers() into common
   crash_core.c to avoid compile issues with kexec_load only path.
 - Per David Hildebrand, replaced mutex_trylock() with mutex_lock().
 - Changed the __weak arch_crash_handle_hotplug_event() to utilize
   WARN_ONCE() instead of WARN(). Fix some formatting issues.
 - Per Sourabh, introduced sysfs attribute crash_hotplug for memory
   and CPUs; for use by userspace (udev) to determine if the kernel
   performs crash hot un/plug support.
 - Per Sourabh, moved the code detecting the elfcorehdr segment from
   arch/x86 into crash_core:handle_hotplug_event() so both kexec_load
   and kexec_file_load can benefit.
 - Updated userspace kexec-tools kexec utility to reflect change to
   using CRASH_MAX_MEMORY_RANGES and get_nr_cpus().
 - Updated the new proposed udev rules to reflect using the sysfs
   attributes crash_hotplug.

v8: 5may2022
 https://lkml.org/lkml/2022/5/5/1133
 https://lore.kernel.org/lkml/20220505184603.1548-1-eric.devolder@oracle.com/
 - Per Borislav Petkov, eliminated CONFIG_CRASH_HOTPLUG in favor
   of CONFIG_HOTPLUG_CPU || CONFIG_MEMORY_HOTPLUG, ie a new define
   is not needed. Also use of IS_ENABLED() rather than #ifdef's.
   Renamed crash_hotplug_handler() to handle_hotplug_event().
   And other corrections.
 - Per Baoquan, minimized the parameters to the arch_crash_
   handle_hotplug_event() to hp_action and cpu.
 - Introduce KEXEC_CRASH_HP_INVALID_CPU definition, per Baoquan.
 - Per Sourabh Jain, renamed and repurposed CRASH_HOTPLUG_ELFCOREHDR_SZ
   to CONFIG_CRASH_MAX_MEMORY_RANGES, mirroring kexec-tools change
   by David Hildebrand. Folded this patch into the x86
   kexec_file_load support patch.

v7: 13apr2022
 https://lkml.org/lkml/2022/4/13/850
 https://lore.kernel.org/lkml/20220413164237.20845-1-eric.devolder@oracle.com/
 - Resolved parameter usage to crash_hotplug_handler(), per Baoquan.

v6: 1apr2022
 https://lkml.org/lkml/2022/4/1/1203
 https://lore.kernel.org/lkml/20220401183040.1624-1-eric.devolder@oracle.com/
 - Reword commit messages and some comment cleanup per Baoquan.
 - Changed elf_index to elfcorehdr_index for clarity.
 - Minor code changes per Baoquan.

v5: 3mar2022
 https://lkml.org/lkml/2022/3/3/674
 https://lore.kernel.org/lkml/20220303162725.49640-1-eric.devolder@oracle.com/
 - Reworded description of CRASH_HOTPLUG_ELFCOREHDR_SZ, per
   David Hildenbrand.
 - Refactored slightly a few patches per Baoquan recommendation.

v4: 9feb2022
 https://lkml.org/lkml/2022/2/9/1406
 https://lore.kernel.org/lkml/20220209195706.51522-1-eric.devolder@oracle.com/
 - Refactored patches per Baoquan suggestsions.
 - A few corrections, per Baoquan.

v3: 10jan2022
 https://lkml.org/lkml/2022/1/10/1212
 https://lore.kernel.org/lkml/20220110195727.1682-1-eric.devolder@oracle.com/
 - Rebasing per Baoquan He request.
 - Changed memory notifier per David Hildenbrand.
 - Providing example kexec userspace change in cover letter.

RFC v2: 7dec2021
 https://lkml.org/lkml/2021/12/7/1088
 https://lore.kernel.org/lkml/20211207195204.1582-1-eric.devolder@oracle.com/
 - Acting upon Baoquan He suggestion of removing elfcorehdr from
   the purgatory list of segments, removed purgatory code from
   patchset, and it is signficiantly simpler now.

RFC v1: 18nov2021
 https://lkml.org/lkml/2021/11/18/845
 https://lore.kernel.org/lkml/20211118174948.37435-1-eric.devolder@oracle.com/
 - working patchset demonstrating kernel handling of hotplug
   updates to x86 elfcorehdr for kexec_file_load

RFC: 14dec2020
 https://lkml.org/lkml/2020/12/14/532
 https://lore.kernel.org/lkml/b04ed259-dc5f-7f30-6661-c26f92d9096a@oracle.com/
 - proposed concept of allowing kernel to handle hotplug update
   of elfcorehdr
---


Eric DeVolder (8):
  crash: move a few code bits to setup support of crash hotplug
  crash: add generic infrastructure for crash hotplug support
  kexec: exclude elfcorehdr from the segment digest
  crash: memory and cpu hotplug sysfs attributes
  x86/crash: add x86 crash hotplug support
  crash: change crash_prepare_elf64_headers() to for_each_possible_cpu()
  x86/crash: optimize cpu changes
  workaround

 .../admin-guide/mm/memory-hotplug.rst         |   8 +
 Documentation/core-api/cpu_hotplug.rst        |  18 +
 arch/x86/Kconfig                              |  13 +
 arch/x86/include/asm/kexec.h                  |  15 +
 arch/x86/kernel/acpi/boot.c                   |  19 +-
 arch/x86/kernel/crash.c                       | 129 ++++++-
 drivers/base/cpu.c                            |  14 +
 drivers/base/memory.c                         |  13 +
 include/linux/crash_core.h                    |   9 +
 include/linux/kexec.h                         |  49 ++-
 kernel/crash_core.c                           | 319 ++++++++++++++++++
 kernel/kexec_core.c                           |   6 +
 kernel/kexec_file.c                           | 187 +---------
 13 files changed, 580 insertions(+), 219 deletions(-)

-- 
2.31.1

