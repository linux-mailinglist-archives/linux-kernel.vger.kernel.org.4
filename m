Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42C26EDF98
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 11:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbjDYJph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 05:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbjDYJp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 05:45:29 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A489349E1;
        Tue, 25 Apr 2023 02:45:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Px6aa72kGdAp7UhacPENjxbt8MTL1DnfYGMHC7m2hejWf67/U9WAKw4fzTfDThmGB5wpzIsK+1DKSlWr8LuyKK5jx/OPPXTv1la3PjsffbZVTQnbmj3aBaRWzRrzNYTMVOGnYJCVAZTexozLZSoFa1ixCZArYJnEqINvn7v1d3P3loFOGIrSRfbcpHOZhMWThgFMGHDCuJGUHLaZ53Nb8PENRjNMK2d2YT94j6WfUht4Iv+6a+8X7rmdjauozZ1x1iluP8W+anIMNpjM98ERRzPi6KG68knUu3bEbrq3fLAbpYlgiqX703NieXb2GxMKEI1ti28tghSEuasDbDQwgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxXCNgexyIvBtPa5jGHwEJC7cJJJcsFJu/5pNRqjkZA=;
 b=Oeq4P9gkcM1aQyJqlNQ12FVlPuFSsYAveW7fI7pjR3a5hSitezeZfQW5SbSgESvtS2Bj8L8Lm7EzsQkvIVgBP5g9m0iq8E6x7+2oJIqqCKSAMhJst34gfOXUgbh8ngB+Wn0iJkDvSi46vTIYYQv3AcRTQvQ07mEUeClJcBQFbPSOj0DDDafGH7Xi8hDo3Pscopnx4KXvq7SIag3gtnSFQtqCBwoxEisrsypFNhJF5OQ9oxTfxHVvG6SmatKTkNwqnjpdT1T2pwfrUd0+W/TkPTLr0PgNriFMVkkKV12zfsz93Nk5lO+4HWMHpOGokAklR9200OASHgx4EJcqP7kUXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxXCNgexyIvBtPa5jGHwEJC7cJJJcsFJu/5pNRqjkZA=;
 b=2KIhX28FNfHyIL/cMlg1QHhQ837QNIvxMrAQgJlSrihUjHPFdFOppTuiw07CJDeAoK3LCqd6TvQS2JGDqfXBwRl7/nTskLrHRyX/NF90E5EQtd4Xi1x6R4dyNConoofTWr679kVgrNuCj/6Z6nNWRwDiQ7cxRMndtBIgpD6JRuo=
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
Date:   Tue, 25 Apr 2023 11:45:12 +0200
Subject: [PATCH RFC v2 2/6] media: v4l2-ctrls: clarify documentation of
 V4L2_CID_FOCUS_RELATIVE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-feature-controls-lens-v2-2-faa8ad2bc404@wolfvision.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682415922; l=1208;
 i=michael.riesch@wolfvision.net; s=20230425; h=from:subject:message-id;
 bh=Z5D1yuiiYZHSN2KVN2mlLolGJK2gmtMfF0hmHJGrfto=;
 b=LXHawEo9oQqtbQzGztJgNDH3WWhhFRCI1ryQdpx7BYRlB4Ex+hx6H4F4zByuXAuutYY+Jz20t
 SHOy2Mxq74kA/GN+0gKGai1ajvg4u8fTcsmKY5gNUSrPVKwT9eICMHn
X-Developer-Key: i=michael.riesch@wolfvision.net; a=ed25519;
 pk=1QQdXA2QbwdxaQn/VQK0hz04C8IBYhDowbK0hlNU4Ng=
X-ClientProxiedBy: VI1PR0802CA0032.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::18) To GV1SPRMB0046.eurprd08.prod.outlook.com
 (2603:10a6:150:84::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1SPRMB0046:EE_|DU0PR08MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 52afc636-975a-4fe1-09f8-08db4571cb2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8EP7+qKIwGaLmqg7mcJGMBj4naK+R9JsR0NxMDfvrfauRXGfKBZ7kcBUwOFMqOxuzct7hlfU3i/xHzMO7cq7OTmE1iRcRjU6bAwhcu7uF9IfSveYoWJHD4xu1+gj+E34FGyZgCJ2dx2XLTsap01jEfaW0JetB2iWXcLoTjBzp4WYTjf5kKN8c5EZn3lpP+ea5kd7ljdMjRw/kdZdY0kUOlS1oRa0cjRTXc6l+wTHKVpAt5KdruLoUlx7ro29KbEnjJin0v+yEbzw/iaHVv9Yh9ASVztluKBSghDeYjiN38GdIrWIdDhJzNX0TbWDtUfqbGJXu5B+SP9tqza00wbsk/NAONiKc4B3DcEgHWYc3xQXNcCNxdkz5Xq5D1TwmBjOgHGUkbkiaSDFMlOqGS9JRVT/DovUlN8DhomyYADAtYg7aOUPpJYgbUR2xzf5AArTvrjaYvmA1Qu+zzN3kpPZq2e74XOCU4T/O68rnsxSjo1Q8np9gpQmADBhrXFGlkCBqScwCUxYDPzY0HVgbFJzqfi0UmuEYLzRKxjqqI8VSSfEUnTyMw6iRQZ9KeHlzyUrkj/4K576kaER+Y9taMNwFPj/krso+En8LqIkZfoZJZrjv5t5+tEqRHxHPlaja0yY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1SPRMB0046.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(366004)(39850400004)(346002)(451199021)(38350700002)(38100700002)(6506007)(6512007)(26005)(186003)(8936002)(2616005)(83380400001)(107886003)(44832011)(2906002)(8676002)(5660300002)(36756003)(478600001)(54906003)(6486002)(52116002)(316002)(6666004)(4326008)(6916009)(66556008)(41300700001)(66946007)(86362001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2MyakpCRUJOWWJSV0xZT1BuVlowV0UyTzkzMS9UZk8wVS9DdG92VFdQWVlP?=
 =?utf-8?B?Vnp0c2VzMm9uakRDOVl4YXdwN1dOTmR6WTRkVUsxNjJiQ2lmMWE0T3BIdTV2?=
 =?utf-8?B?NzcwUXRHb204Q1BaN3pHL3JEWnVHakhHMDJnWWpsOEphdjFKdUNyTFVRZEsr?=
 =?utf-8?B?UXhnK3FOMDIyOFYvMUh0anJrUXVmb3hBWGZtUW1XR1Z5a0xpQ3B1T1JNRGpj?=
 =?utf-8?B?RVF3bzlGWUhyd3JrVkt4aWpta2cyS0RBK21acWRZUm5QK1prUlF3ODlLYXJT?=
 =?utf-8?B?bkQ1YXlPWWUxWWd4eU5CNStiVENuOEQrY0hXL0hRbm95ZWYwSUFrNDhPY2FP?=
 =?utf-8?B?SnV5Z1djQmNRNXE0T2VuZ3NHYmxkZ01LaDNENy83czlZbnVoNW8rWHI5aEIx?=
 =?utf-8?B?MDcrNVN1MWMrZFE1cHVWUXZ3UEZBT0h6SVRlQ20yamt4SVpvY1lUWGpWcmw0?=
 =?utf-8?B?cnRQa3pmU1c2blBIbTd6bmVBNHV6NTZrOUEySlhDUDlRdGhTdEdsRERSZFdn?=
 =?utf-8?B?eDhlc2VONmp6UVFrS00vTEw1bEFqTzcvdC9leUtZQUtGWmRHSzRlUjVpNDFJ?=
 =?utf-8?B?aVhmQW9VTGR2Ymo5QjV1QzdTTTlHYThlUG5zRWM1U2xVUnB4djlpSFo5QnB0?=
 =?utf-8?B?RUhwcjlHWHF3SmljaFdIdHk2djhGNzhyVWtWNU8wTUU1OVhoblQwUHByaXp1?=
 =?utf-8?B?T3ZlT1NUcnFnYXVhQm9HVmtDRTVyTm1NZXNlYzh2SHFnM0JoWHROb1JyZU9q?=
 =?utf-8?B?TmZ5eUdRNW92SmhuZXhld0ZPYjQxdjhTU0hqajJVWk5QZ1RuUzhqWW5Zb0Iw?=
 =?utf-8?B?ZnVIY1pKeEdnZGJKdmE0L0JQdUtHMWkvSXdpTGVVSWppbTBobDd3OG5La3Ba?=
 =?utf-8?B?NFNuT25qVjR2Z2pLakh4eVBadWZ3T3I1UGVEcE1JN3ROcUtWRUxvTGVqazBx?=
 =?utf-8?B?S3I4NmtHYjY4N1JQTUU2TVlUS3RRQXhXVGkzUytZcVdiMGpjTTFFcnZRemlK?=
 =?utf-8?B?MGlXUzhJQk5ub0VYekNFSWdwZ1doZVVLQk95V2M1bWZybG9EcFlGZm42L2JU?=
 =?utf-8?B?RXNzbTVDSTNXd2hZUExyUzMrQ1FobHoxNVNpTDArZlJoSU5JdmwxMmdGOWNz?=
 =?utf-8?B?QmZ0UmJDNXlzZUUrWm1jbkNKTGMzYnBoVTF6Um11RUdCSGw3aTgwV2JoOUpZ?=
 =?utf-8?B?L3NaRDIxWTNrVWt5bXJ2Vlk2WWhaNy9pWWp1Z21ReldyLzVCM2RKU25RVzA1?=
 =?utf-8?B?WXpnbU15ZUZPU1ZFTmpvaEdSN1pJZkYrQks3YlhSMmkwb1AyaG9BT0hONE1O?=
 =?utf-8?B?dlRQL3NhQ1lYRGdnL09VbGJicWI0a2JiL3FtenFVRmM0QlBuOTlCMEZ2K1hT?=
 =?utf-8?B?UzhKS1JORlNXL2JOeFdWQjdvUzJtb1M5cjhjYnljK1owdnJ4TS9ZUUZKWHNj?=
 =?utf-8?B?SEZzQy91RWIycW5WU0xTRjdvNzFudjIrQ1NkUDVWYStzK2xpRjE1N1ZpVFVP?=
 =?utf-8?B?cjdESU9sMkdDWmdYdVFLb2h3WTJkRDRoSFVGaE5VWkpBUUc2T0R6U0pWemFj?=
 =?utf-8?B?K0lZWEc1N0dYTWZrdElEaStiVDNqQnVPMlY2UGlSWlRtU0o3SGd4aFpDb1pa?=
 =?utf-8?B?cHV3QXNRTm5oRVNDMTAyN1huWllmbEZVYkIxTFlEVFk3NnRmT1JIZWxXQi9Z?=
 =?utf-8?B?T1Y3VWhxUnp3cDJmWDljSEhsUGgxWDhGeVBOMXJieG1SMTBqNE5iOXNGVlJY?=
 =?utf-8?B?RkdEMytwWkVPdW5CZEtudUp1bEhtbHBsRXFRWUc3MFovY2xxSWtWcFJyQVg3?=
 =?utf-8?B?MVhRWXVtdlY4b2l0cWdzditvekkzclZJeERoeGtmU04vcUYwS1FCODBrMEN6?=
 =?utf-8?B?cGdpSmM2YXIwR2Vaa2kwZFhlS0x1cHN4blN2RHJ0QkNONi9TYStNbnNMZ1d6?=
 =?utf-8?B?ZFpGWVl0UkpORG8zc01waUxOSWx0R25pcFZ2YktBUHB3ZXRpSHNYd3d3VXFm?=
 =?utf-8?B?d0dEL25NbS8zd3MvdmhDaFRPUnBZRVZyZlJPVyt3bjlpU0R1TTBYYWtJWWNx?=
 =?utf-8?B?ODNza0g2RERzK0lLMVVuQnZjQWtyM1BYOEJkeGVqL0w3WW5MQ3R3MzdpMHpZ?=
 =?utf-8?B?MDRwT0NrR1hueW5VU0RrVlJWUFk5emNDY2pDVmRQSVIxTmxVRnpSejd2aG9a?=
 =?utf-8?B?K1E9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 52afc636-975a-4fe1-09f8-08db4571cb2c
X-MS-Exchange-CrossTenant-AuthSource: GV1SPRMB0046.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 09:45:24.6776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 867sJcN4MPM4n9lfWSdRdGjcNWjYwgSZDN2ejMkliwmeqecv4QLnUULHMxI1QfS11pdZOXJF47xooZ0OfgQshNFXL9ZWKFxLwBcvJle/KTk=
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

The control V4L2_CID_FOCUS_RELATIVE only makes sense if the device cannot
handle absolute focal point positioning with V4L2_CID_FOCUS_ABSOLUTE.
Clarify this in the documentation.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
index df29150dce7b..42cf4c3cda0c 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
@@ -147,7 +147,9 @@ enum v4l2_exposure_metering -
     This control moves the focal point of the camera by the specified
     amount. The unit is undefined. Positive values move the focus closer
     to the camera, negative values towards infinity. This is a
-    write-only control.
+    write-only control. It should be implemented only if the device cannot
+    handle absolute values.
+
 
 ``V4L2_CID_FOCUS_AUTO (boolean)``
     Enables continuous automatic focus adjustments. The effect of manual

-- 
2.37.2

