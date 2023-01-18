Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708B3672A9D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjARVg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjARVgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:36:23 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0F2611EA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:36:22 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30IKnEwR013473;
        Wed, 18 Jan 2023 21:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=9JrS/a6vk3TrECh93W6MOSmAGybL3BQh2+30qcj4tMs=;
 b=0SHU1zrdIxXqRh1ZP6O1dJI0ulFLg9r+fC7u8Ks50Hri6JiOXkrxJs4mPLfcy+xEK5lr
 Vjt4sc0cVvVrTTiKFElElMHq2IyKuDHj1feSj303EfAAoK6jB38xcpammCU+9fAzgA5G
 TdqvVmqL63SDI9Fu9FD7Y30HB5VDzKUziNfFFy/M5CjGUlvyKyy15bn9q55ZjqJItsZU
 9Z2OZuZCj4+Tn8BZpFYG3ygiVBIB4snv7Ujljc643nx2SVQM9rLA/DeaG3CnepxDgt/K
 Lx7FTsfo48MDovH6HLTzB0uKsDfiBAOdShhJ7at3B6BV5NBPoneh6cNwSBUJAxkM8trS tA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n40mdg656-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 21:35:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30IKSprj028441;
        Wed, 18 Jan 2023 21:35:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6quftm4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 21:35:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqSAKCeLT1pR7Y4zAGRE+1DQP7AGGp0lgu2dBRR74aEnFdw5jsvoNsSRGFcfkOYH9xRl5hMccgNSouijSEBe6IyzF1hhrXxzn7hXD115s62tTreFm1HjFRybZeu/JIiKLf+eoWwhXVsImbwZvY0FPJfnLfmOCTcbpDETT1wYcNaEGsr58GbTUHNx+yvsEiMBzW/aKBHkAFq1eklD1Rl64KsrXjknT8x+Y7fuOVaVvFzLZn6aM0HzOEP2e0OG837SvkODO7nwZwTsxi9vnGqghd3T9zSjNLl49F7wwhstB8xJVc+Z74i0U/Bddl+Sj4diTAXgtXMowQASOQ2GkAwyGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JrS/a6vk3TrECh93W6MOSmAGybL3BQh2+30qcj4tMs=;
 b=VaH1CGE3JRX/CH7ZLCRcRXubTPeb5GvMabUGkuwk3X9THY/JHU8J4fkX1qXtFTF/Y1NqnHjhPCBi61vf2dnuUttpTE/OU0KB1vULi6OtPIcL1VPmWiPq/gGy/wW3g+kqWbHAHwqEXIQR8XXLyw5Q8ZimYya04l7ZErzvFxnBqJYZtykaxfWi5PQhvnbcvjCGjsVoeLXhwFUQoaUJAoYZmrBwpuShtD+qmo1Dq7s8gePaBsaeGDy/Z8AjynNt6yv9A7AaJHScSgkF9smte1OQX2BsC1yyJLi61Crmcin2warSjHtgVVHvshd9cwIRxq1aQ8hGLZF+qRovx+FMF7q+cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JrS/a6vk3TrECh93W6MOSmAGybL3BQh2+30qcj4tMs=;
 b=RAxTJP3Zig18t6HevuQHbu2W3O72tsv6sG1zRtNxtGbV0DrLjsFxnO5p52S2hkVU3WLIIQkIOKwfg3uOvbkOhp8LgAxJ8CjknFSQiFeAqqb9uG+mNls7+vb/GMUfSm6dUKlipOfJWrklEQC114mkg3kzdC7XULc4JAALvN8imkE=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SA1PR10MB5710.namprd10.prod.outlook.com (2603:10b6:806:231::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Wed, 18 Jan
 2023 21:35:52 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%4]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 21:35:52 +0000
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
Subject: [PATCH v17 0/6] crash: Kernel handling of CPU and memory hot un/plug
Date:   Wed, 18 Jan 2023 16:35:38 -0500
Message-Id: <20230118213544.2128-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:a03:74::40) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SA1PR10MB5710:EE_
X-MS-Office365-Filtering-Correlation-Id: 76f4f7a1-2f7b-40b2-e4ef-08daf99bf8f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xWX1l2oXnjA4JWKySYk/cl5yBVttdjy0kLdr6t4Dtb+OYsBO0pDYFbEvT+jRtPBMIf1T3qFc6tUVi+w2zBldSmk3S7n4QWC2GwyHoI0vWJdIyp7U7//QGHebMmEIKwKE7AFKc2wEuCUErHSDxROx9ie3UhFHMbRFt+GrbFpGXR5u8IUsY2iHrEzqO9QZw9jsCLtSlBRol/D9UDdy4nHsOvu5sME1mFKT4jERE8KLaLlEVWZJl0xxZr2dCSXCTDp1diZSXvttDpMb6ufaoEXL1gCmjH5GoWT7z/hwbcdC1+d77x3722FUBm9Zz7OIbarV0FSUF9EqIzF2bC/lDxs1e4gH4ZD6EfQhm/pXHOpKMKkGbPbmUPe3vttDfdgk4MCADPnylKcEfP/lRSfIu3UYWzYZslSNL9XHERNmG5c3AV4nAAIU2WkHesZ7ulx0fbslUEk0uyLMmLoKUFpQ9p8einJ0BACBYevfiu2fRT8eXSzSMeOVZEdjXOHGwLoqNI98ngc2Arv0A1T1jUJ1jnXPDPwclnV8Xv5Hhu582cBP2pXl7SuwHtRJxgTVudXNh+COQDcc9gRMjUyYO2tcRNcS2DLguo2rsN18nI78jkigBQFD+1HYIKk4Wxjw15MikyxDxOdsIcJfpq0rRTZJ6SDtE50oS5TkV3yWa1DOvhBTk5xk8qa3GFPUXw1uJ2+H0zbQdx3Tf05gbVbxDalmBRVeGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199015)(36756003)(86362001)(316002)(66946007)(4326008)(66556008)(66476007)(8676002)(6486002)(966005)(41300700001)(7416002)(8936002)(5660300002)(478600001)(2906002)(83380400001)(38100700002)(186003)(26005)(6506007)(6512007)(6666004)(107886003)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Ao25lOFWY1WeP7C3gPkCqipcLzUgvBS3YaTkxS26rpNGYtGU/faLzsHnPLR?=
 =?us-ascii?Q?Yn5R3nTxNR271FQkyP+N1RpynDF/ld7b1QNOpGZsQIEjxvLylbpi7QDAe+Fj?=
 =?us-ascii?Q?aRGyd0XeSUCG1PHtd71BHbOi+KkW+D5xpUStCPPkDvNND/nTMhUiwqvSpXAl?=
 =?us-ascii?Q?ut80kQLdiTVP+4MIqvF4SHqND3ni5k6wGOLrMsVw7cnZWJC9qI4p46+2KMes?=
 =?us-ascii?Q?TK+KtasC7PjmA0mpyQpEcf136KaZlYYEJ0OINe2TS1d95yEASJhIl9Pnwvl6?=
 =?us-ascii?Q?fiatHsHL538UTaMQ+Ow+s7s97HAHNc6jHNuBCLyUJIr+oP2R8m0SlKrA8OxP?=
 =?us-ascii?Q?gxQE8rAXipyrwk6s6SwCtk/jq2t1aFxLJ8qE1mTI6OAFWO36LhjGhO6Va8vH?=
 =?us-ascii?Q?3zqwOnAy5FDS3RdDF0h++Z0ucNq18gsgOhG5DXz5a2sFvLQ9X2Q9DaQKzfW7?=
 =?us-ascii?Q?RfqxcQ18aFPbPwqlBStWsUUziygq4zH3wZUEzIsbw0Y1Brlj+ZAe7+TgH6We?=
 =?us-ascii?Q?lCNKVXo8pfo9tGC1fu9Ge00jE+BqreuU4GPJiN1HT6+jQnz0Q2W6fcDRV9E3?=
 =?us-ascii?Q?s2boyqEucI/S7f1B2fpaYJclYwCfg7Vj4YpMJZLvmjR2k2StwkcqPAgF2u48?=
 =?us-ascii?Q?mUPRY03JC0Pemu0vz0SJDt9jZVZqKeHXVDA+8nJB6uuWLfzm6YH7UjpjokiC?=
 =?us-ascii?Q?T3MixSdzQ2G6MBl/wHEsrWkEGrEnSk4GDBusR+u+AyRR82U1hC8sySCD2BUv?=
 =?us-ascii?Q?BQcIDHtLMnoBGM4cY9BGLre+0bhADOKRg0eHWtCRDiI1DY/rGFBhbYfBfbS0?=
 =?us-ascii?Q?aHt0GMmm5er04Jve+LP2MOlS2q81mvIjtH8iR3VoC/k/H7yqwvBJ72Z2QVdB?=
 =?us-ascii?Q?6y7K8+LBFPODAJJKi14VsRkeACi4TRdpogZYVeR0lht1b5+4m/IX15sMFvy9?=
 =?us-ascii?Q?rtAnc/MUZEM96uCxYE++fsS3IJsV4NqD90CjXYu0TNuxAg/36Syx22y5X1+8?=
 =?us-ascii?Q?5ju3CykAWjvyp9D8WuIPi1SYu+YMVPa/+wu4RX1qjKZymuHF6GIf/R8dujBq?=
 =?us-ascii?Q?oTZozB0y5/S5HZxWApIwPZfg12POosouLUayiGL4Cfth8zwQxF5a7U1i3M7s?=
 =?us-ascii?Q?r/9QeLlssOpq0HBKnF38wj5Kd9fGbNxwHe8bgcRjuNNpZD6uGX7WZsJLvU6W?=
 =?us-ascii?Q?GQ18PLbAmJISkYyvZiaUVUatnQivZCppftrUe4MVgL/qyuXVKOghutlKfoNF?=
 =?us-ascii?Q?bcHzd15ti7qh+2Njy6g/aVgnpBIo/pi7hnnsZlNVmoNi9Fvhxb8DCXlwkPLZ?=
 =?us-ascii?Q?cFGWpQ+pGwHr4pxjd6QVeySVZ20vEz0fO9CEOiaDpmRuVCefDzVkGOYpC+re?=
 =?us-ascii?Q?/9I8is28pc8ZKpJKVfEgV62XBZ5om6S+o7PbiWYCSZIrPDVokrYIMal8jCM0?=
 =?us-ascii?Q?YcVk+db5WUupB7QHYKi0N/bcJvu8JPiwBzg961a1SjpTzHjzCkGsqtmuNyET?=
 =?us-ascii?Q?RYe7Qf5+wuvGlQtLpvCnGIF72/7bF8Ky5sasyR+GajJ9p1N9DAfvBMVeIr9r?=
 =?us-ascii?Q?t5tT7gtgYkKWLF5OhIcjVXVvJqvIk6gDGX4U8ZNVvs364NdsWKFp8P0rRVGC?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?NK88ETc2v/MoIB6NCM58qU4UePeL0lrzY/XhOrbNwIAWXKwA2Y44prv/tmn0?=
 =?us-ascii?Q?jkWl5cjAnTkdvQKNhFAjVs/b66BmB5XWFgnfVXNkr1Pet4ZJiWctIQ9AKYv5?=
 =?us-ascii?Q?nRG1bIMxjlEp4T8dst501/peLRWc6tHkTnpO8RVAMK+B/EqNLezuogrfBCns?=
 =?us-ascii?Q?hTRi/y1qEtIDoC9Qc8gySMGygGlmej6ceJ01m4vRZbpks43v+9CRC5NHeRJ1?=
 =?us-ascii?Q?kG9Q0nnhrpDKIJK2IeVAmzhsvZdfLpiPwR+PMeSLPqD1PM/ft8uHYKe07/WO?=
 =?us-ascii?Q?H9oVs8d1L9HWT8v9g+kjBJbvwpPO3JAuSb+K7OeSpryfNEdzi4CJuXiLATd7?=
 =?us-ascii?Q?ASj5iS1aIOJH0b0fbmzqzU9CmRiP1YuBNiqUqXB7rXF9F8X4hLouWPcD3/XI?=
 =?us-ascii?Q?TP8QYrg3C0OJG8eInwLLI4OqmK3/qznW7ayNkm21NipULXHL5Zm5qiWLn+Bp?=
 =?us-ascii?Q?9FrG7SoXzH+bh71gJKm4lrd22dezcmg29ZSBmYx3tu03rLABZpPR2qU+GLKY?=
 =?us-ascii?Q?6j0ng30zGf/IKfQLka36YNJm55PWs13vQhiyfNYUjsUMb4QdS76lbKWeqZfu?=
 =?us-ascii?Q?qKGZRVrvxp+z3LJ5jjj9CMzJtzolxAsi8m+F6AThftJFBtcFPbP2WzOyXc+w?=
 =?us-ascii?Q?07VrCML++ALb3f3OH7SF6Cb0PIHcoRsVoNmXZ7QjalyJASsZkVGBm00SNNge?=
 =?us-ascii?Q?fgtdUhT28DMbrGOmXRxBLghsLIv8auNncuRGaUUfr2aK9+hUu3qoFjnus02x?=
 =?us-ascii?Q?aMuN9zXcax4q5UDimb/GwQsJ7as/E0MdiLz3XvuPm2xC0TWFkviMNslWWxj0?=
 =?us-ascii?Q?HWtXXeLj6k+VvzK8PFPai1xdc+1XDeXrMYIkpxzfl2OCzuKzUsiA7gc8rzdb?=
 =?us-ascii?Q?72ur3MuFh7S9etDZb7PdArVSqYXa+mkWybjKjQN3swnbeFIBQgps3U+f5dgn?=
 =?us-ascii?Q?cwOOGpOnC7gR8oapXJNjENtPVKLXPSXAAeoRAOCfbVyQ6t/sM00qi9g4G/vZ?=
 =?us-ascii?Q?a93ceuIpiM03kGh9oEso4UbciZ5p1oFu1MwPnm8TzXrNbKkknX/QETicR3Vr?=
 =?us-ascii?Q?xQg9OyNXEN18HrwfYbK7j4lRje/605VMQM8Klb9Ji0CnF0rcjTYwBIWA8r5d?=
 =?us-ascii?Q?CS6NOvuG7ACQPJaqGpXmCCLX/komYWIzz00vwOTlBIM9pnd9jz2QvwU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f4f7a1-2f7b-40b2-e4ef-08daf99bf8f3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 21:35:52.1933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82shGHAY66L6eYIajI9Rc4P5QmBSH1NLnbBM7v7UepwP3wZjjbFzIqUPRnL4lqPdszvRG2bVbDe0umUV/oxbToOwQm1cnpqfGKnxHMWBlyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5710
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301180180
X-Proofpoint-ORIG-GUID: RHUERqfJtw8GYh-pi8cF79_zEgwZDgwl
X-Proofpoint-GUID: RHUERqfJtw8GYh-pi8cF79_zEgwZDgwl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kdump service is loaded, if a CPU or memory is hot
un/plugged, the crash elfcorehdr, which describes the CPUs
and memory in the system, must also be updated, else the resulting
vmcore is inaccurate (eg. missing either CPU context or memory
regions).

The current solution utilizes udev to initiate an unload-then-reload
of the kdump image (eg. kernel, initrd, boot_params, puratory and
elfcorehdr) by the userspace kexec utility. In previous posts I have
outlined the significant performance problems related to offloading
this activity to userspace.

This patchset introduces a generic crash hot un/plug handler that
registers with the CPU and memory notifiers. Upon CPU or memory
changes, this generic handler is invoked and performs important
housekeeping, for example obtaining the appropriate lock, and then
invokes an architecture specific handler to do the appropriate
updates.

In the case of x86_64, the arch specific handler generates a new
elfcorehdr, and overwrites the old one in memory; thus no
involvement with userspace needed.

To realize the benefits/test this patchset, one must make a couple
of minor changes to userspace:

 - Prevent udev from updating kdump crash kernel on hot un/plug changes.
   Add the following as the first lines to the RHEL udev rule file
   /usr/lib/udev/rules.d/98-kexec.rules:

   # The kernel handles updates to crash elfcorehdr for cpu and memory changes
   SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
   SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

   These lines will cause cpu and memory hot un/plug events to be
   skipped within this rule file, with this changset applied.

 - Change to the kexec_file_load for loading the kdump kernel:
   Eg. on RHEL: in /usr/bin/kdumpctl, change to:
    standard_kexec_args="-p -d -s"
   which adds the -s to select kexec_file_load syscall.

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
v17: 18jan2023
 - Rebased onto 6.2.0-rc4
 - Moved a bit of code around so that kexec_load()-only builds
   work, per Sourabh.
 - Corrected computation of number of memory region Phdrs needed
   when x86 memory hotplug is not enabled, per Baoquan.

v16: 5jan2023
 https://lkml.org/lkml/2023/1/5/673
 - Rebased onto 6.2.0-rc2
 - Corrected error identified by Baoquan.

v15: 9dec2022
 https://lkml.org/lkml/2022/12/9/520
 - Rebased onto 6.1.0-rc8
 - Replaced arch_un/map_crash_pages() with direct use of
   kun/map_local_pages(), per Boris.
 - Some x86 changes, per Boris.

v14: 16nov2022
 https://lkml.org/lkml/2022/11/16/1645
 - Rebased onto 6.1.0-rc5
 - Introduced CRASH_HOTPLUG Kconfig item to better fine tune
   compilation of feature components, per Boris.
 - Removed hp_action parameter to arch_crash_handle_hotplug_event()
   as it is unused.

v13: 31oct2022
 https://lkml.org/lkml/2022/10/31/854
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
 - Rebased onto 6.0-rc4
 - Addressed some minor formatting items, per Baoquan

v11: 26aug2022
 https://lkml.org/lkml/2022/8/26/963
 - Rebased onto 6.0-rc2
 - Redid the rework of __weak to use asm/kexec.h, per Baoquan
 - Reworked some comments and minor items, per Baoquan

v10: 21jul2022
 https://lkml.org/lkml/2022/7/21/1007
 - Rebased to 5.19.0-rc7
 - Per Sourabh, corrected build issue with arch_un/map_crash_pages()
   for architectures not supporting this feature.
 - Per David Hildebrand, removed the WARN_ONCE() altogether.
 - Per David Hansen, converted to use of kmap_local_page().
 - Per Baoquan He, replaced use of __weak with the kexec technique.

v9: 13jun2022
 https://lkml.org/lkml/2022/6/13/3382
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
 - Resolved parameter usage to crash_hotplug_handler(), per Baoquan.

v6: 1apr2022
 https://lkml.org/lkml/2022/4/1/1203
 - Reword commit messages and some comment cleanup per Baoquan.
 - Changed elf_index to elfcorehdr_index for clarity.
 - Minor code changes per Baoquan.

v5: 3mar2022
 https://lkml.org/lkml/2022/3/3/674
 - Reworded description of CRASH_HOTPLUG_ELFCOREHDR_SZ, per
   David Hildenbrand.
 - Refactored slightly a few patches per Baoquan recommendation.

v4: 9feb2022
 https://lkml.org/lkml/2022/2/9/1406
 - Refactored patches per Baoquan suggestsions.
 - A few corrections, per Baoquan.

v3: 10jan2022
 https://lkml.org/lkml/2022/1/10/1212
 - Rebasing per Baoquan He request.
 - Changed memory notifier per David Hildenbrand.
 - Providing example kexec userspace change in cover letter.

RFC v2: 7dec2021
 https://lkml.org/lkml/2021/12/7/1088
 - Acting upon Baoquan He suggestion of removing elfcorehdr from
   the purgatory list of segments, removed purgatory code from
   patchset, and it is signficiantly simpler now.

RFC v1: 18nov2021
 https://lkml.org/lkml/2021/11/18/845
 - working patchset demonstrating kernel handling of hotplug
   updates to x86 elfcorehdr for kexec_file_load

RFC: 14dec2020
 https://lkml.org/lkml/2020/12/14/532
 - proposed concept of allowing kernel to handle hotplug update
   of elfcorehdr
---


Eric DeVolder (6):
  crash: move a few code bits to setup support of crash hotplug
  crash: prototype change for crash_prepare_elf64_headers()
  crash: add generic infrastructure for crash hotplug support
  kexec: exclude elfcorehdr from the segment digest
  kexec: exclude hot remove cpu from elfcorehdr notes
  x86/crash: add x86 crash hotplug support

 arch/arm64/kernel/machine_kexec_file.c |   6 +-
 arch/powerpc/kexec/file_load_64.c      |   2 +-
 arch/riscv/kernel/elf_kexec.c          |   7 +-
 arch/x86/Kconfig                       |  12 +
 arch/x86/include/asm/kexec.h           |  15 ++
 arch/x86/kernel/crash.c                | 125 ++++++++-
 include/linux/crash_core.h             |   8 +
 include/linux/kexec.h                  |  45 ++--
 kernel/crash_core.c                    | 337 +++++++++++++++++++++++++
 kernel/kexec_file.c                    | 187 +-------------
 10 files changed, 533 insertions(+), 211 deletions(-)

-- 
2.31.1

