Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3477E6B124E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjCHTpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjCHTo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:44:27 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E57094F54;
        Wed,  8 Mar 2023 11:44:00 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328HibjQ022874;
        Wed, 8 Mar 2023 19:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=O0INB61mcO7lM8+ur+wboNoKYzpmUybq4SQvP3uhmJ0=;
 b=PgEXCmKB9eSjYXL3tXdBVCAEzVVwhWO4Nk+jup3O0ByeoX7jwIHN25vmecS4G2dlbU4s
 I4teHA/yqfPE1yLBb+haCfK+SkMMD1feWfjcxcIJH7i+6eaSzCjq00LlyE9ahIVqtFVi
 yTBzHYp0rguYOGCIG0eqHjkTHJ7XH5Sv+K2wimJnWxv1d+zPQfhgGPHgb4rzr58mC7UO
 1oM2HXzGFARSmCoqoh7oAQ15/iYcUKKZ/dqYVMxPqrd8VvEbY4K00hd+iBoZ50QPLnL9
 +MxaRd08EleYztAZ2PHXtZlLODokPmESUTTHfp6iUKBKm8H2O2LquDIiTVaXMmiKDMT8 aA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p41620y8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:43:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 328JRWiP015511;
        Wed, 8 Mar 2023 19:43:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6femr8tb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:43:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9GmZYK5FfaicNDUuuVkCmAf4mFUAlRNpqwqa0+eSzGOaYchjPt3IY0o/mqUpAIl8wE/Bko1JGM+Q2ghA8e+W1RDkJUZny5c8ib5apfCti9eQF3RjbWGSdo7vhAqVcaXZ/PLzNUzjycnT1j4rDAE/YACFVEppIZEUe9eVDUf0c4Zm+peFZYWcBbspKDRLiu2wBkk20jit4+3jQ8ASrBbGRHOZQzaP7uh6wFqvHX47SFrS+cPwuKb0iaEcj5InwN7TewVqr8r+NkfahAIoRHBFWs+23H6ltA+idrU1dVXNMfdq+WW0BVCNomFyskGD41hlcmOYT3UyH84GwRCAmSv6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0INB61mcO7lM8+ur+wboNoKYzpmUybq4SQvP3uhmJ0=;
 b=V/sDqrYQgF6kvTlPuu9tOMzgFIu/H3l7MFQ9tKj5GwUu1eHPWfrGQrWyqfFgcFrUNSiJm7ivPX0FZXkc7z5BvlxdvOu3789VrGot+9SrUVEcbeXoSktVkDAIb00TfEs2ynFAKSJVfSMABbaDbtoiDRwr2x6RLUHQz/YXwmtTMWaTOm0SvqZ3F8h62hrAS9OW75QV04454Vw9KDe52qs50xXamdIVU+YYqyo/UpYqQUJHf1MtJe60GijOVy4Gad+49oJj0Vt2uHCXuQHjgBSumStC/v5TX+PyU1vWsidDn91PAqttud6i1TAgUzA+PIh2cLDPs8YfwSzeT75bwXqXyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0INB61mcO7lM8+ur+wboNoKYzpmUybq4SQvP3uhmJ0=;
 b=RcLdS8WM1Iza62TVWcckVrnulysXcIwxbVeq/WG0jG1Iz5FQy0EEyt/OnegUbZdwoodohX8eXCdY/o0rTvBQQfd/BWSsTOiZbKjGHOi95stDFdEAY9jU4cYyeCMfarmV5qKBlaWjPFa/fUNJCYZPy11ac/4vvqlrbiXLkeGgOVY=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH7PR10MB7035.namprd10.prod.outlook.com (2603:10b6:510:275::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 19:43:43 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.027; Wed, 8 Mar 2023
 19:43:43 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     lee@kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 07/18] mfd: stmpe-i2c: remove MODULE_LICENSE in non-modules
Date:   Wed,  8 Mar 2023 19:42:56 +0000
Message-Id: <20230308194307.374789-7-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230308194307.374789-1-nick.alcock@oracle.com>
References: <20230308194307.374789-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::13) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH7PR10MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: cca60431-ba88-4deb-2c43-08db200d6c61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s7WtI5Wfx1I3BuFtc5aGyeZZhvDQR/qlg078jLV+m4sjKR95IUAvYpO3HYZnPfbpyVU5dViH2W8ajhQz1g1/OQ05hFAKG3/5kND6Ruyzi76ALV4nfBqePoXOk1HuKctbZxIX1PFMrB5eA5IpjyZ/FqlyhU8uZVmlS7pIFAyMGbn6V+gRPKUxyP2FIOVa2S+Bm+4+61+nuyKfkKLzr5NYprKAxN2oyp5MFRb4zJKzOCc5TA4hKqHWwXYCttrZmUeN62HnRJIEd13/NuMv11oarfZ7L1h0gWew6NzGA6kVmEfgaD9VCjOR2ogWyfomGSSBtjwdO7jO/XsK//1KQOFuIc03+9SiN2UTIz6dBBEZ5mO6GgOW00n5zEyE04tZbdasb66z9y+FqzwnTP0/zOc2K9UdJnNBlmXgJQ5lzr53wsWdVVxrMBq2uy12vdn/XBlGiiVnRNEvm165iapSRU56Q9NYZApFvKr8UwgKtcVAoIZ2j27zNGwReGh9o+Gix/0oNEPJPhWwEF0uMYMmZsww7e8ej1PyRxc5FVj+YzyE8r8GDmq3eDoLFKCZ61cV+U9bcSyym258GdcpRskdEa9doeRnSdUH6CCzDgbwRIqcWXo/Ffoekam2kU6Na1kn6tAfDOU8cUIKHV/EqFbLWWkJ5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199018)(5660300002)(44832011)(38100700002)(86362001)(8936002)(6916009)(36756003)(4326008)(8676002)(41300700001)(2906002)(66476007)(1076003)(6666004)(2616005)(6512007)(6506007)(186003)(83380400001)(316002)(478600001)(54906003)(66946007)(66556008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g7zxdJsJyVUk0nFPrBboUGxvO12/8MmmfWNCtmAP8ccF1fFFNI7wjox4AWS9?=
 =?us-ascii?Q?FVXyzNp+Q1Nheev267ATZ0pVu0fcp4Ii5olw2tg6Z5jyDE0GYnGE0hN8ELKL?=
 =?us-ascii?Q?BZdmtT0r1KWthg01YySKV2HeZdVHRX2AF7V3Sa4xnloviYaNP5/Lr32EnmJZ?=
 =?us-ascii?Q?femZh3BsKbMhBdWpMIuBHr2mnjjzVd3n7eWuxzIwx7VZVdQcUeT3QzabiNRb?=
 =?us-ascii?Q?Gfc0wGmkwuAPhWnXnWZgVAyfx8V/j8alNmazE8j1ZKvyQelqVrHPqDVJ4JrF?=
 =?us-ascii?Q?CDGcVub6qFrF4YJQ+c7eTGEtV9Lr42zE36YbHFMBpjB3hSWFmchNqL1mj1S5?=
 =?us-ascii?Q?VYvgeXb3o1s6zDu1RNtVpk1cC2OKhz1181zwnQi/B3BWGU5JVn0xUAlSwg28?=
 =?us-ascii?Q?jjK5Yw3eI48ATt1dWZOxRXVPdf6J3UQTH7KNtNK9ai2WjFWUVjmMZNbN6+rH?=
 =?us-ascii?Q?MTGHH6XPGtJxFwUIJYGHYe7jAUNS66z5bHAg8mYqftxHc4ULGneV61XGdWCL?=
 =?us-ascii?Q?pt38TMBASnzEbDSSAhyg4mPuR/yGNQ0t2AY3enF8C6Ro6MgXMqrrNx4QedyH?=
 =?us-ascii?Q?In85DBoBsV5tIoFq6EkUCzsvABtefaYG12Uqv/E2Xfwmr4bJva0r8WqTwabk?=
 =?us-ascii?Q?JbzgldNbH71PMQWqnDZKdiYaBHikpfYtXvb0RVFdhTttEVFBZ+6lCFJc0L55?=
 =?us-ascii?Q?dHAoT3SZ0pznf5/JotbgsKedfgWONK9dvY3ksymrGPr/UfkilCY3zrP8OygV?=
 =?us-ascii?Q?6zodlK90aUwzOhtic57/69D3wcuAFVg0o0E87n4sNzAzlySsqDUYgVRI77ZS?=
 =?us-ascii?Q?LOLwBTSLUX651ddgQhLtrUJb0agbk9rlzpGV/46z+od0t4cfqVRA2ewqMyW2?=
 =?us-ascii?Q?IwYRHvXVTxnVel667UfVq4pTxtIl8bU1pS6TUyOsaoJxlCey0qr9yyT9aISS?=
 =?us-ascii?Q?WWALsug2CDImt1RqfqAchTtFMGt+Xt8Uek059n+tGvAANNYLRYT0K9sIk2QR?=
 =?us-ascii?Q?dFNYDoqfxiOV/M+mGDzKjXCWEf1c5ObmywqnFkZswi3W+tsxeZbuCmkedOtf?=
 =?us-ascii?Q?4WZlLTG1+NdafjAVYNYlsduixW1uqMVTWVkJ5xncdSNUpvgMXPdNhVcfiyf4?=
 =?us-ascii?Q?oq08Sz4zA+vbKfcNSf64w8vlUlllCFd0pNz0tU5NGYXcbrHnOTo0HW9yPGx/?=
 =?us-ascii?Q?tCytS7hXyYsGe+RRyliFFgkGD+qg6c1JiJZJsNstC4sxsobpE3n9zdB5abxv?=
 =?us-ascii?Q?XOpmQSwpncNacVsLvYsQGZjQhhPfpqT1Y06xR47CgYiDUO+SwTUCf9sMh+Fq?=
 =?us-ascii?Q?qiJVhSKuxBiwRGMlpNaFJh2w8kcso42v13XOiIbbdNQxQIaoLTd/AoYDcHBS?=
 =?us-ascii?Q?5OsUPRH/4kpPF3/u9WQJHO08Zd83klgMwkXGbJOwaR9LxNSAc+5bkGJyabkF?=
 =?us-ascii?Q?ylwjnCy5rcuj7jHAXCvYqG25NflQb4ZQjHQ8AOGaf51NiySKkbhiOu0Kq5DH?=
 =?us-ascii?Q?LiR1x1pYevcdJsuAiqeEpXr2ffCXfqqkYf3g9mHIJ3j/vRu9wk6fesvJwaQE?=
 =?us-ascii?Q?Ir+dkvlwN3+X4B1B2tnOOl+DL66sQXydOTvVVQYyeHd2UHkH3/vKk/z+nbbV?=
 =?us-ascii?Q?zxcNODeHlC69oiAZ9nUUA3U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Ub/Kmmj2K8OzM/tCa16IuXwj8YJglNWv01SCvK211Hr+2rYUdI5vrfsevmCJ?=
 =?us-ascii?Q?GfQaSaaKM7Re4CzkvrtZ9mRumqhZAFv+RkOplxQ7IeCTVOMRwRHi/XNXLQvQ?=
 =?us-ascii?Q?mFMKfpI6dZoun66a73hNcE6rUmitZKVpb3PVm9ZDpbF1MMtk/aVKG8D7d54d?=
 =?us-ascii?Q?Sq5kGtKD8xp55Vj8ElICeUjmoJKOc3Uw84E17sUaiByNRfgHCN1Y32bl2ic+?=
 =?us-ascii?Q?bKZhAJB3ujsRwifwlNxZ/K/+Z0SnDuq+X1juNHyhstgyncPzFxi+bWCh6lHT?=
 =?us-ascii?Q?4ykH2oq3PG9FBL1Aw/BUVt6FQktYQh/AXqS/1XSYWqg77YZbuHafmsmfz/Pz?=
 =?us-ascii?Q?lzoGfULOlmccaww7uSTzgHcSK/bDdf1xMq+YsvdQYkzMoYuyuVio1Z0o1l37?=
 =?us-ascii?Q?9gsl49LptEP+/Jexv87zH+8ve+fpYFlk8+s24q2j/9NjgA61tV/5zX9IUMz6?=
 =?us-ascii?Q?Ls6lh+IWafxIgRk0KhKN4uJdgRUGO/EkP/Yb+d7X/zkWyvWSvJJmJCooF6Bj?=
 =?us-ascii?Q?nsYI/BTAdy07g4GjFbda2rujCKU4LyAytr+NILy67bKhSAyQjXAeCY9Gf0tL?=
 =?us-ascii?Q?z9GgLy/jg93wvR+ubl4zUMToq3/MR23muIW8/vyCNm8r6gWjeD7W6BojfjNv?=
 =?us-ascii?Q?ObU1GN/b1UrCpfr2pFuuyQ9jyLlDbfOpmwWm07KSN1Gkh0NagKaA6MFcLpy9?=
 =?us-ascii?Q?CauGVcFMNASiXcfxIpJSYI4GLNwAngy4WKwZcR1M/INqnBcffUDM2zkhcvh9?=
 =?us-ascii?Q?2DqspuQXf3xcnN6we8OYdS03MRVjP2x6xfXoY7W2c3Emw/x1zE08QQpsK9fu?=
 =?us-ascii?Q?1386spVk047nFMVN/Zz1YsdhbBhIGNdvXwM6ERcuTQ0gQ9L3I+qh1wTTACsg?=
 =?us-ascii?Q?43CwG+85T2+s9M4pu/YhzcUeOGquDqz5jXT7Ndtv4StPZY6n8Z0L8LqCH+Yc?=
 =?us-ascii?Q?4BPAS25mi5OmkKQH8q8tk4e2MLLdhVLjQfkkPP6RiGM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cca60431-ba88-4deb-2c43-08db200d6c61
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 19:43:42.8966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOPxjLZCoMMCJEPx6GyKS/PgM140yvKnN6OxqK4s1DnzGAYqQkKyJHPevPOuItBBc3ikUyaAS93kgxlPtk/c/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7035
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_14,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080166
X-Proofpoint-GUID: qc3DPJEGLuaryd8iweXmeRvFKIHvOtU3
X-Proofpoint-ORIG-GUID: qc3DPJEGLuaryd8iweXmeRvFKIHvOtU3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/mfd/stmpe-i2c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/stmpe-i2c.c b/drivers/mfd/stmpe-i2c.c
index d4944fc1feb18..7998e0db1e158 100644
--- a/drivers/mfd/stmpe-i2c.c
+++ b/drivers/mfd/stmpe-i2c.c
@@ -135,6 +135,5 @@ static void __exit stmpe_exit(void)
 }
 module_exit(stmpe_exit);
 
-MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("STMPE MFD I2C Interface Driver");
 MODULE_AUTHOR("Rabin Vincent <rabin.vincent@stericsson.com>");
-- 
2.39.1.268.g9de2f9a303

