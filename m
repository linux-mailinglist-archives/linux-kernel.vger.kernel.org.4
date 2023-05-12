Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997A5700EB1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238835AbjELSWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238644AbjELSWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:22:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E561A275
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:21:42 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4aQt021751;
        Fri, 12 May 2023 18:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=vsLFD4dVDOFW21XGcSvKmJrAPSFOY+0Jw3IhJz6RmFw=;
 b=fTFr2gXaRTK89SB2zGTd+b5FFRmQcMEYQ2mq41xEt5KQ5iAMNCaboEIi9Xikl0bPPeci
 ILAlQMyWaOGH3ZHtoDHBMuHmdJMs7nQlqNzsSEKJqftxOd3eQTkE3vmTzVZQE5+/daoG
 9dg4TLVsXuIV6x3QDaGM2bMdtCljvooUeFvD1coZB7nrOJUp0I2/+CNxgFSwkhRz/eoo
 84yUl1BF/BT7hG/NcD2LoXH1M4hEUa6AWxLW6e5jKIshQYxczoAIJc8w0dv6IkEkCkd7
 f06GYWMXQeIhjbtuXp/jTtUE5OYYCuLRnCwFZSdcw4pKVcqy23+lPGOueE05A/m526Yn 7Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf7793h30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CHaQV7011740;
        Fri, 12 May 2023 18:21:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf8156yrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YExGPVHpZLX4k5PfVk6DcSf8WwBme1ewBCZzrSLdYbI4DUbiDDoDwdI7Wf+6a6nmlaC1iZqBCj3tVIpupZfGQ9d+yF/YM8z7xU7AqFs8Ssc1d4bR/TDbrycjmCw//sPQAhOvo2uGZ0vRLri0fjBBsHwptaq0GWqfsksUBZk9E8VU4UunMnwEwv9/tUouhUtNd52eq526/1zPQf+GPKoh6NnTUrvyjJ1G17cdzjF0Xb1hP+cY0yekeTgXYzt4UIiEpT/lrpV1owe925QDyVqGWMvMINkDO5NMxWyjxSmuPOmP+Bi8lE0J8EUlV5sR8xnLBT2rpTmSv3ed/yGPBhm+nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsLFD4dVDOFW21XGcSvKmJrAPSFOY+0Jw3IhJz6RmFw=;
 b=Q5RxfCXBloU47lH8gfN1z/r8Oe+f9tdXgDNwyvxCDk0+IloD7VzRs8O3rkePvbHtjG2TzmjiD1ULi6h41WVkZ7BMeAUszvxcY6FvE78DWAt6mCZZ4zKEnJNWlJ1Xxr5e1YFWPW4sPqQQQfBEpjIDl+8ZUJxIonQwIHiWTVBxCbTKZwrm9EBV3ETdvXn0tn55na0ELHh9nntK4IIgzt2VLoK/13FBCED49Vm65BOTTN+s86TlOTWH1z58DG+p1bK6E5vyI7Xs+a4ERw0zlHUQ127aqe6nrQYZ0rZ+L61ukVIXGvVDmmOQX1InzWv/BvqIXHS1qcJWQyMjA1lxIqPsVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsLFD4dVDOFW21XGcSvKmJrAPSFOY+0Jw3IhJz6RmFw=;
 b=PP8XspECtzMnRVAPnpMiXZxFfiyHNXTy14JQlPDK+lKhpnzVqsDU4SY+K2QVm9fC+kmklH5O1+LoB8wZhovS54orFIvT3aRZPNdj95GC80kvjX+2hTU03cFrs4eAiE0WxwISZyux6ubYSK4SL1ws8iFX3/swpPsR0mjCEUT61tc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY5PR10MB6143.namprd10.prod.outlook.com (2603:10b6:930:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Fri, 12 May
 2023 18:21:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:21:32 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 16/35] maple_tree: Make test code work without debug enabled
Date:   Fri, 12 May 2023 14:20:17 -0400
Message-Id: <20230512182036.359030-17-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0271.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY5PR10MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: b6dc8788-83e9-4eb1-1361-08db5315b677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NBB+HZ8khRdcUct9TZ0KKH1EtUUw/lvgX1noGb23/MOZiHFPmIPNCDfm/06PRnnGhvRT82NSvTp4+ykZL+FDCIhOUBUHtZttGsbdDA88MY9romQ47eEz9to0sxJu38vp/KigmKyPzM4XauqXhwhdT5p+dGhfeoJTc25naAlb0EffhEkKd800vjzo/VAT4ETZgc0AsRfNHTU4R3v6lG3k65LQXSbTEK2jCmbYiltbRlTamp+G+cXVJeTNQvUPKhzHhbLlydZmgWrVQkXeb0E4HDFpjIAqDJ0Unbq9to9vM1IW2xdUnFzSXmGelgP6SupmWgSwrg3nLVfHjcj9FcLOhHFAd5n8pCyqYgkngRm3wIPzMmz3pNs/aqwPx+9en8hB0s5FMJm57uvgWnKOlChEMAo1HfG80Mb9xTIYqXVVzuQO5NT110a1T0LLtdzcqRQA4Grd5vRLhtdeRUUundZKoqV+UOR7Rc8FbUkciFO17W3gZbXx1Z7bnSNWZnY2Phy8hpPR0Ie371IWJkWCQI+XbbUxaq+YLtkHP5j7QiNYqTzF8leVUT9O33m496Jq9XpI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(2906002)(6486002)(66946007)(41300700001)(316002)(66556008)(8676002)(5660300002)(36756003)(4326008)(8936002)(66476007)(6916009)(107886003)(1076003)(86362001)(6666004)(26005)(6512007)(186003)(83380400001)(6506007)(2616005)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ge8IBuSgonzh274V9fy4aR1rLT3WJxfq9n+KdMcFAzv92t8+B7RqGBvHPn0G?=
 =?us-ascii?Q?2AcYWXJQFS9DtyZK4fHIOMT9xS9NkhCRND6880yLD1szrhMbEuLP0A5ErBJ/?=
 =?us-ascii?Q?99Ozlkno22Njb3plAOjYVxOiTcBrjYcIo8KCdbhbT1LscxlQBywSE1QdZ7Uc?=
 =?us-ascii?Q?M0CBGKgeDiW8wbtGv0FqobxDrWsbgb9pRFY7xyYMcMpDdF6QvDGHMccX9OVQ?=
 =?us-ascii?Q?lw6s0mFASkD1EAYw2Cw9+ar/ntwThIaK2QF22wrsGiSgFrHrLA09Vl9agdvF?=
 =?us-ascii?Q?8k5zJMl6y6MKDB25VIrYCJZHP4SjayVQ0Q2gUYtPn1HBMd70pfEiABWdtxB7?=
 =?us-ascii?Q?3breS5ZU1Wn1kuq8SmiSNODJugKtXrw4xV+Z8CvEuJ5PewxxkBzVC4DLLAdw?=
 =?us-ascii?Q?jqVP0qzfP/88/9wO7ZpCCfLaR4wf6vSG0/LPM5Bju5Ut/Xy7pin2hTjoY4Fx?=
 =?us-ascii?Q?+VpORAhNovY4k3r5RHz9+xVi6v638zneioG0uZvdWNFSoON8A3l1sREDreKj?=
 =?us-ascii?Q?GlG0X6HSf8lGZlZsLHfBBlMPMxuR+kLmOoUA0ldVWNrucTgSAuiSOoASmFyM?=
 =?us-ascii?Q?lGFj6UXPWqpARF11T2zh7HzJ6XqHxI4ZjDtBvQmM1QmLPZ5LPVrj52EtKvSU?=
 =?us-ascii?Q?fp/9A8j/vJF2m5AUalp5K4idn6mtM8/a9bxlv8jDYlPj/2gnmQZ7oJ/jhs07?=
 =?us-ascii?Q?+veSprQjy37LT5FksePwgaLRg5ak1tKJu6fr45pcqEcaYR/YuYqTVkjAQGI7?=
 =?us-ascii?Q?sAN4hN4GxU9KCT4MaZ0joC3oN3Gv2NESzJ+Q09inldot87zTVWZkTVrk61pO?=
 =?us-ascii?Q?yTnSvvaxyczEcB5H8BWQ4CUGxoLhtREHSulvY+jwWS92tnp3BhRMHdKaYfuW?=
 =?us-ascii?Q?Fyrj9WY9l7zLxfwtPi1VaNQ61QepwpaByB3RORLV4AVaMcDx3TM0obHEaWLo?=
 =?us-ascii?Q?DsfzbGZBhOFds6n+RSOEr/PB/SARUehFmLXuW/iOADMQtpcSFsnmcSNKU3VU?=
 =?us-ascii?Q?zj44pdxi2MW9zL32ThZJ5siLL4H0GMVbtaY7p7JpTrBmtq+U1N5X4cbxO2eV?=
 =?us-ascii?Q?/+JlUGYtjGCl5B/5pjzuby1in9cE4gHI63+2ziboEQtcd3FHMn/pwESwSAse?=
 =?us-ascii?Q?vnZ4rbHb/jWNMhInw7A8CK66KJIIFVGN1YYHtbfxH9LMo+LKRtkjOHXG4xhZ?=
 =?us-ascii?Q?1osyNYvakqjrm1oKRAsAGyUkK9XB4pT9qt1Wz/Q4/YZkMHCQhbL1Y8YMP7rK?=
 =?us-ascii?Q?5Q8DMv28G+pTs4AuNFM8Zt8rTMnxuVvt/J8bkKhilCUVe6J8yZLijCC4PmXJ?=
 =?us-ascii?Q?0FxzT5+3GsEaVKHozLs6E9SxcPN3p7HqsKYRkN9qZkfEmhZO5UN1RkygTLW6?=
 =?us-ascii?Q?UZCnOIpO6wmWbFUurtj79vNAlQTdGIysvlYautr8so95iNNr3b9YZz3vUtlp?=
 =?us-ascii?Q?cwP0AlUBEm6V53DE5XDNkPk1PSt6BmQJ9cQmvdYfLkqwL2Zi0fVLPEkkpRbD?=
 =?us-ascii?Q?FRRRQhUlnivvShSoDQ7yBNhPJfN9CmakiVF9m9eKyMOocpXn9Js6+mS7bR8F?=
 =?us-ascii?Q?L6Kxt38fETcKUJ47ps0W9S0qnGerjg8/FxdXfihmhlcsYtDt9ciPPA+V8XpC?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8c5aAb53FcRMd3K5Nv8rQl+GCvpesMwZPavnthMe0h18Y5QFpDs/qnksfMmyaL2PHQ/KYPjvMAKWNYNDQUU3uVa4MFvDDiEQj/NcM0kasmbnra8Mn6BQ9zYIQtf7jKCpe6FoY8S1hvsEbh1U+GJRa6Qkf240lVcLYtHNmE30OX5R5k1jqByOhuRfiQFy0RbCs9dFCHhBDtky2xdXi31NDo2sNeoy0fKkH+vUFPHQ9ypMu+QG8m1TUW0hGbmhiqd9Wy6NO+aJZqTWZCatbMlS0erpFiGvx0dgpivYeLecLLum5EV38FfCwcl8+kRH215GT78iCMe+uMYbHP2x5Ctzstou8mAZXg/BjOIqgN8dQz/F703rlw8IM3iaGHSWcDvoXuh3czDgoGKcVsuROIjnmBaqvJ1c+DSDQX6FRxPRY4Ftc2pxbvxLUSLu42hwE4Wf40VJLGsOdSc6/cq/Ik32VJTWX+8+vp2pl3rqm0HSOtagnYsT9tL/FfhUjYPlqhJ6XUZlmhKjTNUeapywWoh8vCEX5NO7RPTHh+fXG3M78z+ubZEyugnLMScU0yx3TL7Z28xIYn/aXmxapLXnT2kbDwDlLiij7dZv8y6VHgxi6nyk/qT/5mGLpBRqaStqevKWCGbbaGhbX19cwOq3Wz+tScDEMGPcDQYPcBmCKoqYYZ3P5uLbaQW+sgOEATIFd7o332r5b4U7kDHmwzCZSxNsV+jxZprHy0o0X/3nqzBzZhC4vII8shKPHEQcJ8ccFeOQcA/B410MpAYLDPLMvfHDZYE5rRD3e4D1DxBdi0YCf7F0fzsSDZrmbV8z3LLzSupOsCUfI64HirrRUX3/qY64xBtwu8Y/G2bD0Kc8Sus3uHDsc2nOR9oQJxdxC+mqiDEeQlowwj9ugKLGK/5fVOgXoA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6dc8788-83e9-4eb1-1361-08db5315b677
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:21:32.4761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TOVNffpnKP7EWekZluOC+rLUMuoQaMRFzyQdqMa3LEvEffjEgtUL/uEGfIYTbMlCtXKHQEuz/TCo7qCVQoVCRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6143
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-GUID: NgssMYgMZ5KHkwM3wUa8O8qOLsNbKrkD
X-Proofpoint-ORIG-GUID: NgssMYgMZ5KHkwM3wUa8O8qOLsNbKrkD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test code is less useful without debug, but can still do general
validations.  Define mt_dump(), mas_dump() and mas_wr_dump() as a noop
if debug is not enabled and document it in the test module information
that more information can be obtained with another kernel config option.

MT_BUG_ON() will report a failures without tree dumps, and the output
will be less useful.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/Kconfig.debug                | 10 +++++++---
 lib/test_maple_tree.c            | 27 ++++++++++++++++++++++++---
 tools/testing/radix-tree/maple.c |  1 -
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index be272aa2fc0a4..17ba96a3c7bfe 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2293,9 +2293,13 @@ config TEST_XARRAY
 	tristate "Test the XArray code at runtime"
 
 config TEST_MAPLE_TREE
-	depends on DEBUG_KERNEL
-	select DEBUG_MAPLE_TREE
-	tristate "Test the Maple Tree code at runtime"
+	tristate "Test the Maple Tree code at runtime or module load"
+	help
+	  Enable this option to test the maple tree code functions at boot, or
+	  when the module is loaded. Enable "Debug Maple Trees" will enable
+	  more verbose output on failures.
+
+	  If unsure, say N.
 
 config TEST_RHASHTABLE
 	tristate "Perform selftest on resizable hash table"
diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index d6929270dd36a..93b40a78c4f55 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -11,12 +11,33 @@
 #include <linux/module.h>
 
 #define MTREE_ALLOC_MAX 0x2000000000000Ul
-#ifndef CONFIG_DEBUG_MAPLE_TREE
-#define CONFIG_DEBUG_MAPLE_TREE
-#endif
 #define CONFIG_MAPLE_SEARCH
 #define MAPLE_32BIT (MAPLE_NODE_SLOTS > 31)
 
+#ifndef CONFIG_DEBUG_MAPLE_TREE
+#define mt_dump(mt, fmt)		do {} while (0)
+#define mt_validate(mt)			do {} while (0)
+#define mt_cache_shrink()		do {} while (0)
+#define mas_dump(mas)			do {} while (0)
+#define mas_wr_dump(mas)		do {} while (0)
+atomic_t maple_tree_tests_run;
+atomic_t maple_tree_tests_passed;
+#undef MT_BUG_ON
+
+#define MT_BUG_ON(__tree, __x) do {					\
+	atomic_inc(&maple_tree_tests_run);				\
+	if (__x) {							\
+		pr_info("BUG at %s:%d (%u)\n",				\
+		__func__, __LINE__, __x);				\
+		pr_info("Pass: %u Run:%u\n",				\
+			atomic_read(&maple_tree_tests_passed),		\
+			atomic_read(&maple_tree_tests_run));		\
+	} else {							\
+		atomic_inc(&maple_tree_tests_passed);			\
+	}								\
+} while (0)
+#endif
+
 /* #define BENCH_SLOT_STORE */
 /* #define BENCH_NODE_STORE */
 /* #define BENCH_AWALK */
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index ebcb3faf85ea9..cf37ed9ab6c4d 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -22,7 +22,6 @@
 #define dump_stack()	assert(0)
 
 #include "../../../lib/maple_tree.c"
-#undef CONFIG_DEBUG_MAPLE_TREE
 #include "../../../lib/test_maple_tree.c"
 
 #define RCU_RANGE_COUNT 1000
-- 
2.39.2

