Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F076EDF97
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 11:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbjDYJpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 05:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbjDYJp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 05:45:28 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9C45BBA;
        Tue, 25 Apr 2023 02:45:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NepYPkVHhO9ZUgY84UmijyRV7fGRkSPycmcSV2JDsy9I12uxI1deiewqrjTJJrwJex3i4wLRf9m9qUOJOvOW1lgCyp8F56dhVDjVF5MJ/AZlbTHrmSvXhRie9Mr7fsuoGkDTUTyju9bqkyxL8MU85ywFNGtpEaLf9aOrm1PAJ4UqoTUHCy7KTuMxD0TboSJrhb+9/u28OImW9SFoUm7VSbhurs2GY5Vq4LqDq3wnAUm/XwsrZmKixJWe2FTeYNPiNitZjFa5wJMdoO/FHYXHGp76lM3DQk1pvnWmEd68GE3wdN5Q+DoWaOnp2TcfXm0A+z/RDLj5t7MFNToJT4EoPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/np1ssZ/vRL41pK51a5xuP3Pd/7WNHyAEgiJNx8ZtI=;
 b=GGb+NHgV9zhzuR/E+giLc+FdhwzD7HavzdubrZlqxogrUmFnsDI2FHSXggpa39uQbD92h04RhVetlAB8t8PBehjw72+9SXJlPuG63/rmrs+BOSJZn+YIbC7jQkd1TjBMMeOPtOXxCPbz0HK/6/EPAc3TPhi3NKbt3tuDq1LjbKyUjELTVYg3GEcDXBNJV21IbEYXfqL/tNATRBjz+BG4YSqD2GbMVwvG7E1N1ospHrDCj/cOmCXXFSicNIjTb10XPWLNTeeHnAP04IFYlUMY7Il6UMt6RGHrAzniGM7n4PtdOCMG8rIqUSnyoeutpLBTbAxyLBGDFqAHgaBGqbNgFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/np1ssZ/vRL41pK51a5xuP3Pd/7WNHyAEgiJNx8ZtI=;
 b=F5Ov3f4Bm0iEJAcGuRgzMQXUaSW5vRycLzeaI3FdFqcEZmt5jx0dQ5bb10rF969CjodpfOHmWZ6paAW8w/cDMYT0dbAmZ3r57dO4ZmGydcAwLuCApAn29UikNSd+X2kdzVCs9yZahTTlfrximSFJnGOkps88HCY+ftgzdmJJts8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from GV1SPRMB0046.eurprd08.prod.outlook.com (2603:10a6:150:84::17)
 by DU0PR08MB7995.eurprd08.prod.outlook.com (2603:10a6:10:3e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 09:45:24 +0000
Received: from GV1SPRMB0046.eurprd08.prod.outlook.com
 ([fe80::3734:409a:8031:4f54]) by GV1SPRMB0046.eurprd08.prod.outlook.com
 ([fe80::3734:409a:8031:4f54%3]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 09:45:24 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
Date:   Tue, 25 Apr 2023 11:45:11 +0200
Subject: [PATCH RFC v2 1/6] media: v4l2-ctrls: fix documentation of
 V4L2_CID_FOCUS_ABSOLUTE unit
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-feature-controls-lens-v2-1-faa8ad2bc404@wolfvision.net>
References: <20230406-feature-controls-lens-v2-0-faa8ad2bc404@wolfvision.net>
In-Reply-To: <20230406-feature-controls-lens-v2-0-faa8ad2bc404@wolfvision.net>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     libcamera-devel@lists.libcamera.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Matthias Fend <Matthias.Fend@wolfvision.net>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Riesch <michael.riesch@wolfvision.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682415922; l=1253;
 i=michael.riesch@wolfvision.net; s=20230425; h=from:subject:message-id;
 bh=DUug3cmze1JbFFjqafjKeI2QEmsiWz/5lD5k/gkcZ58=;
 b=40z38y3YqQBmvZU3HiBECHWzurcl45POnP1/YBhONJ1NWvd1gw6ma7sgzem1tfv6Mi9XXAMa3
 nFNM9CdEmF/Cf0aH9vwC3N4JgmhMLL4fX7bcklRpWRtPcuBVcbGarUm
X-Developer-Key: i=michael.riesch@wolfvision.net; a=ed25519;
 pk=1QQdXA2QbwdxaQn/VQK0hz04C8IBYhDowbK0hlNU4Ng=
X-ClientProxiedBy: VI1PR0802CA0032.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::18) To GV1SPRMB0046.eurprd08.prod.outlook.com
 (2603:10a6:150:84::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1SPRMB0046:EE_|DU0PR08MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4356f3-14d9-4cd8-b376-08db4571caad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AsHcqLnyJEAAFi+ENSoGCZxrqnKYvmvFjTOiJtRPoHzwWA2Mojxj3jgLu/zlpbYXrcxjU5XHncOQ+fZCRdEFkPmMiTMcVvfLuULeFkVaLNQItNhUDswHwfpREhJU6Flo2hgqovLjYzrDng6rIIrFt1H8WBmuuAOWnIA7WzWBLo6jjCpnalcXaRHSDRq7/XhPEhEOlzfpYt093qJg6vw16pESJq/kFpMyGZfwa8v0qVRxdhUL8BIOsNHZbQJvqXy/YO25ZJk7hzqpEVNO0yw0aFq+ODpBqrd4pBpNc/HIbSWLF+GJgSxbLQ3BDq2M5jh4PRjnMwkyyqku54/wB6dkbDBfB5uy2FAPgqALv8rFyzlqXHDldpsWgooluJ6u3qmMysr7ZuR8TyChQaKT7HhyT3AmfPlgoUsSpSwnRBkkDnC78j4828+mb6jn/tJv/9NqYOwntp3rLUXhL2pFV6G37BWgJ4aH/4GyGYatBFmYmBSZewYuXdW+mb3EiGB42zGL7kiW7jKI92ViKZKAOQA0UGsfeFdRZk7eXiyo2sCcTxdBTyEc0UFpQAS530ottx4BdRHD4WX/Mp4guZdQwUwyvzSlg/+zznnooueQFu+NorBr7J2Vhrc5QtDuGt/pzJs5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1SPRMB0046.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(366004)(39850400004)(346002)(451199021)(38350700002)(38100700002)(6506007)(6512007)(26005)(186003)(8936002)(2616005)(83380400001)(107886003)(44832011)(2906002)(8676002)(5660300002)(36756003)(478600001)(54906003)(6486002)(52116002)(316002)(6666004)(4326008)(6916009)(66556008)(41300700001)(66946007)(86362001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGtYcTRjRThpbWJYTE9BclhpZUF2VE43cUNyS0RkYmdPdDZOZkY2NHh3V0FN?=
 =?utf-8?B?c29JYWN6YlkrN0k3NzZZRlA1ZlR1VlM3THVVWjRwY09LL1hKWXFQMHZTRnJj?=
 =?utf-8?B?eGpBMWRJZlRXM054WUV3ME5NV2w3ZjZEbzdrYVlVdWt5L3oyTUltQ0lPVGR5?=
 =?utf-8?B?dmxRQ0NpbjA0cXUvenViOHgyVk93Yk5sRlpwbGYxeWpJVDNQa2ovYlpYR2VF?=
 =?utf-8?B?WHd3eEduc2lWWGVHRzZTR0daRmNLTmJwSlYzZzhCQ1Y5ck94YzNOUkxwL2I1?=
 =?utf-8?B?T0NHS1BPUmdxNXdEWXNvbnlJOHY5bExRSXJPbnBzVjhnT1A0MU9RVHY1V3dl?=
 =?utf-8?B?Uy85b3RKbCtrRU5MTXBEV1Qzc3JjMlJhdnRSUlpMaTdKQ0h4OGp3SWR1Zm1B?=
 =?utf-8?B?cVV6eDhkdS9SSDArZDJ2MlZHc3JUL1hQSmlFUDRXVFh2UGVMMG9TRUJ2Ly84?=
 =?utf-8?B?MnJVVHJMb3Y4dXE3dlYwL0M4dGxBOE1EVm02Y3Y5QnZ5U01Obmp0UVdydzN6?=
 =?utf-8?B?T0ZYdGtVQitDYVFlemJHOUxsdFlDSml1QUJhaC81MGdvNjdHWVE1UXlUVERh?=
 =?utf-8?B?MmlrS29XUlRROWk2ZEpoekNkd296MWJZaUNNVlo2MW1ZR1pUZ0xVRTd5LzZn?=
 =?utf-8?B?eW5zRTVncGRTcE1vQ2tpTnhHdVhRMEJ4RjNGdnNuT3B2Tzg0L3Zyd1VKZW1o?=
 =?utf-8?B?RVM5RmJtbStzaXdzajFCVklMeW1tUXQzWjFaMGJndzQ0dS9OdFJVNnhaUnZN?=
 =?utf-8?B?WUI4UWpneVg4LzJIcGN3QlFxdGhablAwUDJva0ZzRTZ5R2NlUHpYTy8waFBB?=
 =?utf-8?B?TFlnS2lSZzg1bzJhQzZOSFduNkZkREhsOVJ0TTVOUk01VDFNSkZ0bGJOQlhh?=
 =?utf-8?B?WFg3enNJZ29yVXkvcEI2UjBhZEZrVndnTlFIaC9uMUFpeS9GQWo4OWtERDhQ?=
 =?utf-8?B?WjZlOFA1d0Y2Y2tEZzFxTzVkSnNIRytUaW41TlZ0dkFqc3huTFlPS1pRUXQx?=
 =?utf-8?B?QkZKbkdRRk0wd1ZXM09WV1hFOVZGQzZHam9MM1BTSHpLWWY3a1poWUgxUWgx?=
 =?utf-8?B?RjZkSEUzKzBEVE5zY0l5ZG52R3JTOEdnYzg3bEFnaDA4VllYdDdDaGdMWk1V?=
 =?utf-8?B?WWtQaFpiQ1l4ZUpJTlRTOGxqenpXWGdoa1FEa2FpNzgraUJMUEZKeHdCRmNq?=
 =?utf-8?B?QmNZUE5idFd1bjFaTmIzd2NGM2dSNXpIK0JpQUtEcEpkWi9DYkxTR3FsRDFJ?=
 =?utf-8?B?STFxL1VuUXZmQlBuRnBHQXljTW16SDRpeFdXZU9mNHVjaWtRVnZvc2dZYllp?=
 =?utf-8?B?b05ITHdqanZuRHFteWZYNXlHZ01DQThaSHF0S05WdmtZVnNvbEZoVEJ3Tlls?=
 =?utf-8?B?bnMwbFhJWUdOTGJYdWozVFBWU3BZSzBoTWN3Y09LZnNmWE8rMkI1cXpUMldw?=
 =?utf-8?B?OEVGck1YZS9XOFhnOGhhb3RMMEVhZ0F6YnFkQWU0UThwZzJSUVVRSzhxRlg2?=
 =?utf-8?B?WXpLMTF6MHA0QWUva3BMeVc5UHJJcDlheHF3V1VTUlJPV2p6Y2Y0UURTMDhY?=
 =?utf-8?B?bC9TOEJFZlowWEEvRzBOUXpFSXJIMzVEOTRCVWtHcCtvL1RmZXpNRURKM3Bl?=
 =?utf-8?B?L2txK0g0aW1YTHByN3p1ZGYveW91NmJOR0huMWFJamlqamNaRmpSdVZWWEs1?=
 =?utf-8?B?cU1ndUtwWk1HNERIU0JIM2JiYUlqV3hQbHdaRk00MTduOWZmaEJIanp0cFBt?=
 =?utf-8?B?RVJlR3JwTExpbUVybkt5VWF1ZU56QjdsMDFMclNNcXFjdVJNSCtaeWpmNkUy?=
 =?utf-8?B?TjFkcVZGRXhIWG85cGFTS05xSlhqRjRtZ3lkVVRMb1lmKzJ1TTZaS1JMUm45?=
 =?utf-8?B?SDF2SkJkUmJZRVJxeTdKc1VOa1F1U3AzRHdiVjR0UDJGQVUrSVFTNnVuL0xt?=
 =?utf-8?B?TFdaQkU1bFNLcXlMcG02Z1RDeHFOWEdBL1VuV25NUDloZVpjRDBKRVRNRWtj?=
 =?utf-8?B?OXMvRVA0c1dHQlhMbnJpTUJ4a1cyQ1oyMFZUcENoYmlRNjVDcGFtNzZiTlVF?=
 =?utf-8?B?N21xcU41VktnY2JLa2FQb0Rramkyb0NKWFQ1RFBLMm5OODVNMXJGVThLMGVh?=
 =?utf-8?B?MUZ0dXBOZkRETkxJQnRwRHhad0tZSnhISlRiakdyNHFhdkJpTzdtSUl6Nm0z?=
 =?utf-8?B?cEE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4356f3-14d9-4cd8-b376-08db4571caad
X-MS-Exchange-CrossTenant-AuthSource: GV1SPRMB0046.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 09:45:23.9518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmseUhbvjM/qRoDvC7JYfFdSD75bfxI3qXkYxrfUqd3GsQs0OYvdQBDkzDLZAW2GXPk8D+K666yjzEdaMYGOtIPzHITSeHwo/8Y+kY+zaCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7995
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current unit description of the V4L2_CID_FOCUS_ABSOLUTE does not
make sense and was probably copy-pasted from V4L2_CID_FOCUS_RELATIVE.
Fix the unit description in the documentation.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
index daa4f40869f8..df29150dce7b 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
@@ -140,8 +140,8 @@ enum v4l2_exposure_metering -
 
 ``V4L2_CID_FOCUS_ABSOLUTE (integer)``
     This control sets the focal point of the camera to the specified
-    position. The unit is undefined. Positive values set the focus
-    closer to the camera, negative values towards infinity.
+    position. The unit is undefined. Larger values move the focus closer to
+    the camera, smaller values move the focus to infinity.
 
 ``V4L2_CID_FOCUS_RELATIVE (integer)``
     This control moves the focal point of the camera by the specified

-- 
2.37.2

