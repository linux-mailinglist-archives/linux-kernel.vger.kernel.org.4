Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCA66B125E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjCHTqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjCHTpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:45:39 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59279BAD26;
        Wed,  8 Mar 2023 11:44:59 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328HibPX022877;
        Wed, 8 Mar 2023 19:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=A0ZFshvYnGP7dGpD0SI1DiisWc3dqfRx/rDRyzPpgCI=;
 b=yFqam0OWUBFN5s8nc2i0+6jic/7LZmEvq5OPda0L5SQg4M2hJqtWw7iXL3iLquKx+MSa
 IQfz405VRzYM8j8+ZkgsgHr16Akht2Jsafs8IpONHqzuT9OuWkvXXark4SMGStBjXqd0
 CyncOo3Bx4W25Ni2scEI9r+XSjm/mg5yBm0LGglzETRTkPoGIOmGFW5nmdy5Q7J7L0fk
 KzxQYzf5WLCLQ7TMzY+6G2JR1VreoTFI3bvRQ2dT9Z/A3dysOkHGFrom1EK3ylN4ThZs
 AdH6j7JsOKrNii2//w8IfugMc3AjmWpIDX4U0LwPaJlIrZyRrFiKeW/AEX4CtYw3OWVi 5w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p41620yax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:44:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 328IV6mv026460;
        Wed, 8 Mar 2023 19:44:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6g9u66fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:44:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fp2gDmfY61nEyOUZYe2nOHdSoDTodAeFl3gmvG15J4/BztqgAEF3ViGKTHeZHLKuU9u1j2wtvihs/CT/97pk4AdS7+C1o0AJenQ1IYIqBwvN3f/lno5fsd1S3OibWstph9eg6EXJufMbOomhQvIALHFpcv0mx/hvdr8AIeKplbYWO/GZJlaOJbV1SwdMe+pxwu7sHyd8E1lrymRIJpY79Z0544oJBQhHZEJMqs6Ck3AqIF9lH/NxKQ8W4QGbUC4Pkwk5LtH2xYhwT6yX1vP9NSARnNisHn9zc0Se1g3TvdNSh0DnGOCAyTU3+aoRitWBnSFW9Rh665NVpc4Hun4HUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0ZFshvYnGP7dGpD0SI1DiisWc3dqfRx/rDRyzPpgCI=;
 b=oT5fT2esXIUiHzpfRl1f5u3SbRhtcoFVYDJkAEhwJdJkuEcFxlYD7menkLQIFdlUzPw+XIT4DmiHjeKKS7ZUFsVz9eMEdHa1I4xNq2TPAmJTiFKchEm7GBgt/gc7xtYIz/9O+9MpWlT06yHloA/kS//mc0q2AoenD0D43Q3l1Va/A4AFYCmnBFmQNRF8bA8xFSi/9i2LK2GiGk7ip02VabrXlaylJcmdD+Rqa+I7LUWfU7GJOhPHTAGWZ9dQ64WXn0FNXPCA6fnU0GFyoK6QvbBrww+V6yugZR8OcbXburrLX7DImc/BoTh3YdtDTzpFZ5CTqvjpFPw7kgh/3JU4Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0ZFshvYnGP7dGpD0SI1DiisWc3dqfRx/rDRyzPpgCI=;
 b=vxMhNpL9d+6jPfvTn9SWOLwnukuaYSyfjjqnJpBWILGehBvM0uFpuqTvR325D62DbgmbbBxAyiuQJWoGnMOqCzBQe9IT7TQRup0vc5DCriIkBNPYeaJZKFredUnQYrRrHccLCU3wr6k5kV8LZIXKMuM0x9uttYD/Upfk6OV0Hec=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH7PR10MB7034.namprd10.prod.outlook.com (2603:10b6:510:278::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16; Wed, 8 Mar
 2023 19:44:16 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.027; Wed, 8 Mar 2023
 19:44:15 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     lee@kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/18] mfd: lp8788: remove MODULE_LICENSE in non-modules
Date:   Wed,  8 Mar 2023 19:43:03 +0000
Message-Id: <20230308194307.374789-14-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230308194307.374789-1-nick.alcock@oracle.com>
References: <20230308194307.374789-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0088.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::21) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH7PR10MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: 65087bc3-e382-4d57-4103-08db200d7f76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /YhiBFRmW7B10x+kMUKW5wydgwLnn3efUchwORlMjzf77jIsqxK+eOmtdISf21hRfIzU5JqeDIWID0Gkl5+kzCxH0J/OgLvdybty2wq5sOL40Nopz6AYoQpcwpqMmzyjepmlrZVbLAPCw47SF2AtMZM6vpOm7JWKT6KTB9g26TQeyKazS1h0V5dOg4chqmQ2zgZlJvyAOb416GKLIqBG8NIWYlGQQuTz+5vuuemECIvWY0l0JcZ/CP47EyBXY/PUvIHwpQ2zBNnvAPoeNGOukMEozK1HBP+1ARYCWzDYG2OIz2mXH0Jpi35012ci/CKQIkpF28bGAYiJyR2x8NhyAdSaZVqteAilkJ1fF2iJdcNHD2Bz9g8rgRjHtFpX2bpBXgmi1iVkO+YKlEZ8L5AZME9oLT1jYkbtRsTYMGYnyC7X6kv03jDXv1xoMTrMNicDabqkb1DavljZxp2ry83sklm9Lx7ImFLZfv8CecPqEkCZK2QKUuE2MlFfR/HT9SdvdZdD+BlvNoXd1gTBYBrZ6CfRGTy9hM+d7aMWJ1wXzvl1wjvo6xbaMs4Xxls/CfInNVFwQY35L1BzhG56rT6JsUlsYIi8W+EXJudkzYrG6qAcfy5HjNLAdV8ITTHaokidSyURRePtjUnrBI8S5C+Nrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199018)(44832011)(8936002)(6486002)(83380400001)(5660300002)(186003)(478600001)(1076003)(6666004)(36756003)(6506007)(6512007)(316002)(2616005)(86362001)(41300700001)(38100700002)(66556008)(8676002)(66946007)(66476007)(6916009)(2906002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?61sQUdNxB+JZFOu/RU5+JF5Z7LVbOJRzroOy146assRmJHL9RxQYgA66t3Ji?=
 =?us-ascii?Q?X0NU/368jCfcZbtivtA6qt7rk4FLVDWMLhwR2rjisL7kp4zcN544b38CnDGi?=
 =?us-ascii?Q?N2QmRnnAlgkZZhkssWXxDO2IWIn3ZVLdCnF210/tO6QA3EDMWv9kbHowpVox?=
 =?us-ascii?Q?DUcHOSRobpRcK253QVaxn6c2WHB/l6pBtVZAHWt9feMzrcHww4sa82pjL6ZJ?=
 =?us-ascii?Q?bKhydNlXK/a8G2ey+ghbRGQxt3p+uLYqKbMoVuLvm1+eqdZ2ZQtWNzMYq+Vq?=
 =?us-ascii?Q?At8A+9x5tjdP1KqvOFj13uwCW9Q3TgeL7ejl9lbQKuIXG+rHEj6+M4rqlbcL?=
 =?us-ascii?Q?tVpI0fLHzurXJxrktbado2pbHHIZLc4Ni5avBrna51/xM+9YHpGKzqLRDted?=
 =?us-ascii?Q?2xKiRotgZclaBCpjbWocL5jLz2GtvPIjEufWy8P+EZNWck0LrwIGOR2VuYKC?=
 =?us-ascii?Q?am0kcnSjRUdsgd5IS38PrqfBTrMMBfReV0GKdKpb21d4vfZr6+FDGwkfGPw/?=
 =?us-ascii?Q?HbWIGDtfA9HtmrBeqRdw/HxmECA7scylkTuSg/eHskl/zm72Fvk0evL2E+Ke?=
 =?us-ascii?Q?i3pkLflxPFAz6B/zewuO389VT3kiZzbhCFe8c7M/XxCrgqqqwmdHxnuTlQ05?=
 =?us-ascii?Q?TO24EDaWjf1G37kIcE+7VPqBvmP0hEWlQmwWDfGmucQ7b0y2OLZolSJoB3qa?=
 =?us-ascii?Q?X7Eu4Gmyr4W6Q9q18lWHsfaHuKAP3AaFZAgo1devdj8J98qU9c8l7azXLpdS?=
 =?us-ascii?Q?WrqfICJ5WzgqmnOY+zjsbv2Gwmyqu+mDispWcRtWDzItu/LfVYkZEb5qSJ0M?=
 =?us-ascii?Q?cg3twzTrFrA4DPnKU7aDjUeEujsPY/PWTEudPazbiWxNaujMrSvs+hjn+ynK?=
 =?us-ascii?Q?+WyGRsibUiPhKiooDRpRtKDMqF9zlumdqF477SVwdcY10z06yb+iP9O0BMtR?=
 =?us-ascii?Q?MVjN0CClB2X/c9hS5psy72MRkepFafQks3NxOmcP4WotmwzxYYS2nrJLGptk?=
 =?us-ascii?Q?mxsC3kKz9+OVugBfXXm/kA+Nt/ebl7YWFYupYDGosdAOX755IKFkXMcgEdIG?=
 =?us-ascii?Q?tEz61AVK7VE9iH86YQKCOMjLprqF5nKBxduJWxFnu1+Ji3uEmYZE0ZVeh2WP?=
 =?us-ascii?Q?T3I/4wfECC/v/SGKnyuVI1oZjPUlzdn2qRkaCSkcBXUnt3UivgbzzSu0ZCqV?=
 =?us-ascii?Q?32ymhmJsx8qVuW58Sy3qN4rgJRhI8JxKGWtVjm7+5YRoW0BPGZixY/+56JF0?=
 =?us-ascii?Q?sJOCZbqoUM07yLndgob655RT37RmZx2ohynA/5Vdn6eoAZE76E8lawFRwevr?=
 =?us-ascii?Q?UENhA8wSbEY4L0+8SMwNGm8R+/Q/TFSICffryFKlCW9UVy6ps4+ZlDoKOBS9?=
 =?us-ascii?Q?PcCUUPxsRYT6vIruZbgFPRAsN+Lb/SBDAPlgeuY4/arJvQNcR/ecT3q5fpGh?=
 =?us-ascii?Q?ybYgqhHLgXzsPZr44gg5CwK4982hmTSLTn9QxDgBDULzoyptVOIyyL7H+1FZ?=
 =?us-ascii?Q?G1y+eihH2I3fh9GBwkARcD/3gCtPtNrgf2Xt5T1YZUFNu/sxgWirmTP/Ngzr?=
 =?us-ascii?Q?ZcP5+qPNQg+g/Odo+blGcGCtxeEheA2wBZCscTSedQZ/6JiTHHbLYGC9Ww60?=
 =?us-ascii?Q?ijNpo3NI0B3M7MkZCTKE9To=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sZMcW1tgq1/UUpVOywWwG7gy2oNZ/9fpStSFkmR+MU00OJUkY0pe8GpFDN5UVod8jmBWJlrTa1aK5ve/kxOEyghOrO5YlP7DRXzEEK/cZm1rQMTQnLkPgDlty/Z0jtmV7aQenT79AKvIB60jInmXL+Y1GEMEre45CoZ8O/lFLxw/zR1fgl/tSi5LSw90z75/lFUK68VmmXYecnBXpo5oJbbVaw9zUQ4os+amlhGKjWusJxbIzuu1qtixfFDug+YqXFxULXXxmT7KFlfLuk7a/fTYzdFjcAZXg+KfZAIO6SJKGw5wkmG567ms0feMFD3B6rAp77cC4WKiKl/GHI+GLRIXI8H/BXHabZ3ABDZq5PlmjF316VqbhY+tJEjrCvqkGEvgQPpa3xskPqGMBKvA0pcKWiQniIoIq4tEzCHc8LuRomIE7kEkYS0e6U5rPlKhjXV4va0IY72qh8Sni9aI5HH7BX4GByY/YUXpMfKLa489IG4uyPe8a7DRQIbC0/VYgpe4CaNSwlc5cbKG7y1BRC3j7g2NqIcSFGjHaw/GWw3xJlzBzBSeaqsQA6kbxuW4+RTMB5D8hhNg83XSM5lrleGabtql1IxrdHhZUwSW+0lW8AhiHTDze2XyG9+BoUaPOXHTP6JZ8e170CwdytW79WkQLU1viYoEjEK/j5Cz2t3hinPQmLzr7ua9SdtgHNp9OOK0m4spFxvNWZ3qDcz0Hmjy7o9kuMLsWfv38rkCVbOp+y2PkDM7+05ocguzmDPreFI/l+Hd2p4HSiloniWZeMCa/nmDlzNK4KSVaLF0FQ0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65087bc3-e382-4d57-4103-08db200d7f76
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 19:44:14.9114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KrA/lVSj6+QPUeWwhHzOgtzmnolPAtzTRsKBHkieG9n0qhL2++CQ9uDwKQXIKfM21ECuYpkRhm24FENX0p7Teg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7034
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_14,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080166
X-Proofpoint-GUID: 4eZOn6XL_zHXbO8i9dFZ7qYUEo_AelQ8
X-Proofpoint-ORIG-GUID: 4eZOn6XL_zHXbO8i9dFZ7qYUEo_AelQ8
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
---
 drivers/mfd/lp8788.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/lp8788.c b/drivers/mfd/lp8788.c
index fe809b64147e6..18583addaae28 100644
--- a/drivers/mfd/lp8788.c
+++ b/drivers/mfd/lp8788.c
@@ -244,4 +244,3 @@ module_exit(lp8788_exit);
 
 MODULE_DESCRIPTION("TI LP8788 MFD Driver");
 MODULE_AUTHOR("Milo Kim");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

