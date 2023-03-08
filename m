Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25716B125B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjCHTp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjCHTpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:45:33 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31121900B3;
        Wed,  8 Mar 2023 11:44:52 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328HiZGW010398;
        Wed, 8 Mar 2023 19:44:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=P8mtZeITATD6FpXngIMExRBPscSwXRW9lge1gdOLvI0=;
 b=Q4au5dXQWzNTDzhcWEm9u+WSH0NsrNX11INPfWjVPiVc/UPzqbwxmnlI/W2OEK3ANjHh
 b4HzdcHRi2QAG1gOtOiC2k9gI5RnA5Me4wgFcvJrqld02dAIugIArgxgQQ+LTzrnZaXc
 s6KlzMBtEgvOkqK/F9gTMw5xJgGx/+79YwUY3Jo5jr0ngp53DVUdZlcuYFkcyS6TPDTG
 zjCzx0LIgDvglXVFVYrxxVgXVFr7TXQtv4cM8r8WvSNGuVj8qUbXOqhX+zIv285eApAS
 ZZZna2UzNbNTEJNjFHYj1hHgCZEHxzJj+dRGP2xWLA+ICc0teC5IhmQxrACnRXmlTaH6 vA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p416ws1yj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:44:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 328IKaiB021665;
        Wed, 8 Mar 2023 19:44:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fr9816y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:44:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8MOy/4wMVcE0PtI01AZ0pzG1OkkiMJDqi5PTTMAfCRFB53fIjnNb8wz7bYAxk+DKxLzrlVkIAombmKrJj1+E9feuHK5ozVJtevEhrg9mb+qcwdfSUw3HLxsVj4RlHBKykUhncf4DfZqVB2IrhD9QMJ5hifi5kxyY4GsgEeWZpIzH22OhkcALp7Zl5gb/oaHmutfCY/O/BFjw0SnYfuu62K1HLJigx+zPK6sroOHnOLHQmWkc7eTXueUCf/4qPEWUA5cEb7HW10TZRdHSQYRFFx+QhBGYB1YgvSCs5QrNXWCM7zFU13GBwrMxspw+YXThFkIY93EbVvfGTjDaHoP7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8mtZeITATD6FpXngIMExRBPscSwXRW9lge1gdOLvI0=;
 b=FnhD/mqJtscENnmoM5uDl+pXR8YrDC4DX7chA44YNd5jz5aynlFFEP/5W8kojlhAYQWDxvBSZahC6QH3g6NOhXg/wggUTsSsVDKKv5LdetzmKWFsdXePg7YuZxw8JA2f5bGEdWsbGMRT8POcxvyoU2ibdujUjoI63yHdtB3OV3qMrlKq5bdUHNhgU8iboUyR6OrVxxHu9gjqRMJKCZUMAx6/Txm5z2HBrLELXwvhUy2hOBow2r9Bklyil4EXJkf7BRgub2NdMoOikE5VVvU41j/9dN6joGJEqVqe1kmwvTqlqkCL488ySBKGzAi9qvQ78YlN3Ei1Hfss7GQFpNt+yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8mtZeITATD6FpXngIMExRBPscSwXRW9lge1gdOLvI0=;
 b=YhyAU4RwALfbL8Jw3vEnnGFZBHtWB7bHvHQQBqm+lVDSBp768KAbX6lWLX0Q02CCC3JgaGQMgAJVwT+/D7z9uUlkSOdsQKfe7peN9ml4FahQ6tOrE3Hs+ACA8AorptyZjvFOsiRGm4xdvMpfnXaJohfEW8ptbspa4n0/YXUev/E=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH7PR10MB7034.namprd10.prod.outlook.com (2603:10b6:510:278::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16; Wed, 8 Mar
 2023 19:44:19 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.027; Wed, 8 Mar 2023
 19:44:19 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     lee@kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Subject: [PATCH 15/18] mfd: omap-usb-host: remove MODULE_LICENSE in non-modules
Date:   Wed,  8 Mar 2023 19:43:04 +0000
Message-Id: <20230308194307.374789-15-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230308194307.374789-1-nick.alcock@oracle.com>
References: <20230308194307.374789-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0319.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::19) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH7PR10MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c46f52f-0190-4cd1-9b79-08db200d81e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3+rX+UgFJdbmeIiuIeAu6z27ayh+8eTy/1CNAYIubWj8gpv2eHDfGmtLzst7FqM584vRWBenWGzIpo3odzm0848foPfEgygqPN4A8OLms5EydJtBP0oWBK3XI2477RRCnd49w0FubGReaB9eYkcbxG4U0+iW+2EW2GGvgAQrBSPPhtf+DKejcnOMfPUkk5ux2/jFhSiXsOymsbkgFUsvUHJkOMCK6wKbnVuBIZurckgOU5IyHah5y+YyiTBVTopRycm+WVA/yT65ykzUeuXvPJf1U/SMmeOO0YxhPvmieXdE5T4e1bb/CZxBKcxKHsbnfmkVIM3ZhoqlUHcf5p4lRW718zot4Tm7zth4NhDKkvB9Xcw+lLZCsiGnALGtgA4RH0AKAQtT1GSP2SX+dfAf9wBA3Z6NGL+zbnrA3qEogi5gWvbclsoqmxx27+gatkyXfrc+0u65/Y5BEPG5LHOPux9/AIDbi7EKgY8cXUSPAmuul/7anA0RwilS93NwVGwEsuTHXFbV3ZVLd6YGzS992skGWylx2yH7wZ38u5DYjh2rm3PQBCF4bGzaIX56beO1v48kbVfQauxe8kNX4Xu15OYfdNf4BFvaRHggeXY+CA+komTJ1mWLvKVGEufs7bIb+/Lkdo1l7pAqigXYh8K6Eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199018)(44832011)(8936002)(6486002)(83380400001)(5660300002)(186003)(478600001)(1076003)(6666004)(36756003)(6506007)(6512007)(316002)(2616005)(54906003)(86362001)(41300700001)(38100700002)(66556008)(8676002)(66946007)(66476007)(6916009)(2906002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YNSc9KiX+QP+kG0B2f5R6JYH092zXP54Gb6MUoAN1LwmeCtI++5vgumm+4Qk?=
 =?us-ascii?Q?In8kAGlTucZgYWXe/yayhRhdDjbI9pFm/88TbhzAfldM3FH1cKE8ynyUe2SW?=
 =?us-ascii?Q?nPagDbIZWIRv+YLKTQfeTWlVGOAo2rVUxyBb1pMwNJ3fBRJh21jigE1+Yu8N?=
 =?us-ascii?Q?k/GrRC5ERaRDUX/3EsbJu1RIcrgN1cRj2AipYHYtzQAKQVclhNbNnh/pXt5/?=
 =?us-ascii?Q?jgpjD/9CdhmNaUsRnw/Qa4QjkqEOmmIIMXGD/O3Vn6goxpAoYwLT5S/dbozj?=
 =?us-ascii?Q?UQnWHKzMdfbu/bWPfgecfqRA/E+ZZVVXYiY3U+XdFXFQF4nlKTQxzOY0/cz4?=
 =?us-ascii?Q?zl5eky3RHmSGeMFRoYn/TnAvUXTvXewlpg1Nnxd+nCJCtTAVTv7d32e1iNKw?=
 =?us-ascii?Q?opbcmVmvDD7OirIB7irssnUglNSE7xKBYNuVRicx9xibbrWo5MJD0SK9dM72?=
 =?us-ascii?Q?aY3HixktlPeSUMx7Z1kb42yejFnDLVGnkO5p7dv5ZUnO6Kkl6UKLYNOJ2OT8?=
 =?us-ascii?Q?wf0Zf9xbPgCasz5O8gI6je23p8YEV0A9o1w4GtJrqfwxD1iyo1Cd3sXbM57q?=
 =?us-ascii?Q?lLB3MIYTE0p5Wu1Yajnh4T8gu9oa/hQu7CH8vVqZcJDVLv7Gm+kSBX3S4xzC?=
 =?us-ascii?Q?8XzlanEa0r/XdW8E/DHeoBSJdD7pfwfCixkT5RcmRpCb6LjXdcUqoIFgZF2J?=
 =?us-ascii?Q?my5Qce+9C1JiRaMdErfzsPznHssoAFLVAi4ppnsFLh05JPLAOCUVB/9heKqJ?=
 =?us-ascii?Q?q3/dozxmCpDRidM9yCcY4Z5XlqkmMudjZQ1eeG3ogTSqOEeSdi30rg1K8o0V?=
 =?us-ascii?Q?ZA5M70YGAW5OnAVmD6yLs5ErYgp0dXlSPwJgH2MAhZouX57iBbHljFuggVDo?=
 =?us-ascii?Q?zUL7fPXAkAVtU8irnJbg31hKExyi67DBWRibnlxRuz1iQzWuRiZFh7xJFd8s?=
 =?us-ascii?Q?GRzMBVyWAF+GQV7IXMpvsLdmR20tTsMn4IwIFrVwBuPInpPPIpScGl6CADim?=
 =?us-ascii?Q?Upml7glFOfW/heS8y+pFBuvUhgxGKcVOXn88vuYJukdbOffdxMljgYzeflsh?=
 =?us-ascii?Q?k67BQ/Bd6C/oxxsH0c8HAzqJkWJF5SpXR7LLGym6LsbtXKxGIJYDZ8fDZvYo?=
 =?us-ascii?Q?1LjkRUvp0JDPBtjzs3C7FoXUlSlLniA20A68BwnMi/3t4UktqLHwwDFYebfr?=
 =?us-ascii?Q?v9e1fYmGtp50IFKCgtH8kgOmWyVxG275G9TSYDbRLYiOUOsmYTKRhan2txyl?=
 =?us-ascii?Q?MCmqt3NGIW6HvBSmMhCwmO59iae35vdpjwRuGiU1k454/ZiV9ug0j3PcRU+s?=
 =?us-ascii?Q?THlK9fZulDGezGHrnHXj1Dks39x/izvPngwi83ByWDxAOtHDgCBLrHquCiSW?=
 =?us-ascii?Q?9hi79NOkD454/cFmavOJ1zOTf831VtafWgTxYQFybMov1onhmTiMwmDl4USD?=
 =?us-ascii?Q?dcoAIvDRqaGAkEKzDUEU1gFFwLYMRSKmBXtW9ntrnh/Fw1csNWlBhOLTQFji?=
 =?us-ascii?Q?g2htgaiPPwO+Wm+NuF1LQl6v1SEUW6urqjhqtBDmKC5Xc8u4uekH309CtJir?=
 =?us-ascii?Q?JM0Uw/F+oyt5HijJUXRxg19HOYrbSk/s+DcM9GIsN8XISRdobly+cg5ESGPu?=
 =?us-ascii?Q?BCj1EA1fKMmsal/d2KxLr3s=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hwGoG3zM4V5Q4vQNZ81hOo+4DfqT1UIEJboIsJVfIQW62TrJsc/+yhaz7SfBMIFk/yzoSRTb0JqO10cJlCQKGc9Wvj5bODACULrJ2zLlSrgOa9iwa1i2wj2zhBE06faqUCHOPlIFkQwEGgU7S3HzjBc4jL/RE9boXex9WOkqlzLGDGWn3rznOI/YCOi7hQ6v3nlAaw32kZ/fvUFFOTZL43SxDmlBPE8lvNgrzghVsjYpOXlmcRdK+lBKok6O4/Am3dssh7dTMBXKoSY0DxCAc6AxvI8uiehjOfBgs2KyYbrrSNLCjoBuRRgDtbu02d7ERsJTbEqh1R5Vxt64iq9LdaRhMeGpvyFioiTpjbhKhZxZqggAoXbXYZliYXHcOnrmZJdEkSv9ZG211oIkB8iV7KHyT7QXFQzIikodu37GiRTjTcmsAh3rPYgJ+I0Cfk14Rw+fCIASjofrGJ6SnFLrmZpokzuY9H+IgrTTVA9wdHxbaMLthNrmmzk1NyzEPCAYUZGiDSubcgytDZn0xxoKblqun170a92I5Yni6RTmSDnFWeBJeBJBWc0UAUhvt9/FmMzmPB38Y7ugnmtzc3lXYN0eaK1QNpd8GomnmvfgaXNZZtbax5A9pjbWhnlnNvBB2xh/MVyemog5b8dZizMtBEU25+9ces4BnJP6NX9bTUXxcZvT4Yw7mCGc8i8mxphIKQ17b0yjCWquPMxrnGulC6wSZ7Giz9KtNtLwwW654gF6qJzhgGsu/1kPv3pTrLUCnbSDwwWf0SQacKSy5KnjHoWzYNuHDtOvdqaiZOH1282bKVcivE9ePRX7wmHmBXdx
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c46f52f-0190-4cd1-9b79-08db200d81e4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 19:44:18.9745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAyxWERiPvpnaXAYiETHLxKL/dPAWiTqIqCvNzlaHEk/C44yWBYKiRnYBWk38FXIWLrcoDc/DvZkKrp8Rcp/Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7034
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_14,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080166
X-Proofpoint-GUID: 8rK72INyymRmKGipiGyLVSWSJPFAl_ci
X-Proofpoint-ORIG-GUID: 8rK72INyymRmKGipiGyLVSWSJPFAl_ci
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
Cc: Tony Lindgren <tony@atomide.com>
Cc: Lee Jones <lee@kernel.org>
Cc: linux-omap@vger.kernel.org
---
 drivers/mfd/omap-usb-host.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 787d2ae863752..7f57751095938 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -853,7 +853,6 @@ static struct platform_driver usbhs_omap_driver = {
 MODULE_AUTHOR("Keshava Munegowda <keshava_mgowda@ti.com>");
 MODULE_AUTHOR("Roger Quadros <rogerq@ti.com>");
 MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
-MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("usb host common core driver for omap EHCI and OHCI");
 
 static int omap_usbhs_drvinit(void)
-- 
2.39.1.268.g9de2f9a303

