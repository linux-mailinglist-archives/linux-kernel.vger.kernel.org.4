Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B64630E31
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 12:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiKSLDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 06:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbiKSLDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 06:03:34 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596BB1020;
        Sat, 19 Nov 2022 03:03:29 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id C7C3C5C004E;
        Sat, 19 Nov 2022 06:03:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 19 Nov 2022 06:03:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668855808; x=1668942208; bh=93HYdnB82U
        fc0zGbkKCa09oD/bVcHkhM7pWrtDnGP1E=; b=LNgHGobtvH87z8OzQzsw3NUFs8
        ZKD9DQ2e0x7bS5UlrFvTz37OrvmY9nfYYKPW92rtx4e/eipP8EsuDw+VN2uXHMLL
        V1A+7+PYEKHr/HPu4dT3sfvo6NtYSDgpYr/advbExSywAKrI+s8g/Ila20hS2ZzE
        1ZBnOTcp9P6TvZrbLpbFP+gjV7pVVIJZpCMxN2D5zsTbJLR9r5Lq5Yu4+I1k+Ihx
        merwCp4yKbXNFvyvFBYGn4Qa1zcNqscitznhyFo7KAfXxoF9aH+ol2DSSA42/IsK
        NiyHYdp0pIFcqW+EMu01ffWR/a4j5SKNr+ky24UFGLOUkjCYq3zvmrtxuCwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668855808; x=1668942208; bh=93HYdnB82Ufc0zGbkKCa09oD/bVc
        HkhM7pWrtDnGP1E=; b=wZTZOsXUtSDYR3lU0RoAXXBqTOjrXnD26dC7RnPZyokP
        Uy4HMu+KzXEA6SuiJPG5l6GIJRCqoSI811bOR4h//gYr+cSvHi6yqcNp/jucyDlr
        +ZKLxa1kZFvX3WdOVhGLcIXtt5GdxPkypugf0hQvu18Rdlj2K+DskLI5wsv/xaUe
        VImkluF1eEGooypqa61p56j6XLQQDakIzFx31yV+sRcDGDa2Wx++T/23ZQXb2BoP
        INIIxZZpyZxoc8PEtf7Ko4U06N+QjKMkprSYIxxdMETsjVULPa2OTsEFlUeT9VUK
        Y2X5XEaSlQHqv+qZX1GwG9I+N9jR6WeFpOZ7JRILkQ==
X-ME-Sender: <xms:ALh4Y8vw7jF1lY94w5NPGY47HcfRQ_jBJLIHWYHuuL5ATSMQimQz3w>
    <xme:ALh4Y5cELTwPbrW3A-KZBjl_N-_dihVoW_c7OmCYZ0oRCPvyiKx5wvbsmPlYEWYQ0
    2KWWZXCjTZnv463SbE>
X-ME-Received: <xmr:ALh4Y3z23jVii9TSbeCdAkRseOu8gPrWnG5DUyIFZXllWzu0sfX8PA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrhedvgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpeffrghfnhgr
    ucfjihhrshgthhhfvghlugcuoegurghfnhgrsehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnhepvdehtdeludekgeevleefuedvudejieetheekvdfhteekffdujefh
    fedtudehvdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepuggrfhhnrgesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ALh4Y_PGlUh2dqzV71rUx7UcAx0KNCwTucLh6LRwZqDwJHH3YBLt6A>
    <xmx:ALh4Y8_Ly9a0xPt3p__bwWa5HuWFBoDJU8PFL8bzWCVUriPOT_AAjA>
    <xmx:ALh4Y3VdnHPDirsRGgwwgd0wzU5PpmEunccYpj0MbVmvAkLi12P-VA>
    <xmx:ALh4Y3W3CAuc76TTzD-OoRMdRABRqBPHLPwm-CGpGQKhYlQeZpfq6g>
Feedback-ID: i0e894699:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Nov 2022 06:03:25 -0500 (EST)
Date:   Sat, 19 Nov 2022 13:03:22 +0200
From:   Dafna Hirschfeld <dafna@fastmail.com>
To:     Paul Elder <paul.elder@ideasonboard.com>
Cc:     linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Helen Koike <helen.koike@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: Re: [PATCH v3 03/14] media: rkisp1: Add and use rkisp1_has_feature()
 macro
Message-ID: <20221119110322.4drj7qqtp46vjcnn@guri>
References: <20221118093931.1284465-1-paul.elder@ideasonboard.com>
 <20221118093931.1284465-4-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20221118093931.1284465-4-paul.elder@ideasonboard.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.11.2022 18:39, Paul Elder wrote:
>From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
>Simplify feature tests with a macro that shortens lines.
>
>Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>Reviewed-by: Paul Elder <paul.elder@ideasonboard.com>
>Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
>---
> .../media/platform/rockchip/rkisp1/rkisp1-common.h |  3 +++
> .../media/platform/rockchip/rkisp1/rkisp1-dev.c    | 14 +++++++-------
> 2 files changed, 10 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
>index a1293c45aae1..fc33c185b99f 100644
>--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
>+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
>@@ -111,6 +111,9 @@ enum rkisp1_feature {
> 	RKISP1_FEATURE_MIPI_CSI2 = BIT(0),
> };
>
>+#define rkisp1_has_feature(rkisp1, feature) \
>+	((rkisp1)->info->features & RKISP1_FEATURE_##feature)

maybe instead of that string concatination you can remove the 'RKISP1_FEATURE' prefix from the
enum

thanks,
Dafna

>+
> /*
>  * struct rkisp1_info - Model-specific ISP Information
>  *
>diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
>index f2475c6235ea..e348d8c86861 100644
>--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
>+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
>@@ -206,7 +206,7 @@ static int rkisp1_subdev_notifier_register(struct rkisp1_device *rkisp1)
> 		switch (reg) {
> 		case 0:
> 			/* MIPI CSI-2 port */
>-			if (!(rkisp1->info->features & RKISP1_FEATURE_MIPI_CSI2)) {
>+			if (!rkisp1_has_feature(rkisp1, MIPI_CSI2)) {
> 				dev_err(rkisp1->dev,
> 					"internal CSI must be available for port 0\n");
> 				ret = -EINVAL;
>@@ -338,7 +338,7 @@ static int rkisp1_create_links(struct rkisp1_device *rkisp1)
> 	unsigned int i;
> 	int ret;
>
>-	if (rkisp1->info->features & RKISP1_FEATURE_MIPI_CSI2) {
>+	if (rkisp1_has_feature(rkisp1, MIPI_CSI2)) {
> 		/* Link the CSI receiver to the ISP. */
> 		ret = media_create_pad_link(&rkisp1->csi.sd.entity,
> 					    RKISP1_CSI_PAD_SRC,
>@@ -390,7 +390,7 @@ static int rkisp1_create_links(struct rkisp1_device *rkisp1)
>
> static void rkisp1_entities_unregister(struct rkisp1_device *rkisp1)
> {
>-	if (rkisp1->info->features & RKISP1_FEATURE_MIPI_CSI2)
>+	if (rkisp1_has_feature(rkisp1, MIPI_CSI2))
> 		rkisp1_csi_unregister(rkisp1);
> 	rkisp1_params_unregister(rkisp1);
> 	rkisp1_stats_unregister(rkisp1);
>@@ -423,7 +423,7 @@ static int rkisp1_entities_register(struct rkisp1_device *rkisp1)
> 	if (ret)
> 		goto error;
>
>-	if (rkisp1->info->features & RKISP1_FEATURE_MIPI_CSI2) {
>+	if (rkisp1_has_feature(rkisp1, MIPI_CSI2)) {
> 		ret = rkisp1_csi_register(rkisp1);
> 		if (ret)
> 			goto error;
>@@ -590,7 +590,7 @@ static int rkisp1_probe(struct platform_device *pdev)
> 		goto err_unreg_v4l2_dev;
> 	}
>
>-	if (rkisp1->info->features & RKISP1_FEATURE_MIPI_CSI2) {
>+	if (rkisp1_has_feature(rkisp1, MIPI_CSI2)) {
> 		ret = rkisp1_csi_init(rkisp1);
> 		if (ret)
> 			goto err_unreg_media_dev;
>@@ -611,7 +611,7 @@ static int rkisp1_probe(struct platform_device *pdev)
> err_unreg_entities:
> 	rkisp1_entities_unregister(rkisp1);
> err_cleanup_csi:
>-	if (rkisp1->info->features & RKISP1_FEATURE_MIPI_CSI2)
>+	if (rkisp1_has_feature(rkisp1, MIPI_CSI2))
> 		rkisp1_csi_cleanup(rkisp1);
> err_unreg_media_dev:
> 	media_device_unregister(&rkisp1->media_dev);
>@@ -630,7 +630,7 @@ static int rkisp1_remove(struct platform_device *pdev)
> 	v4l2_async_nf_cleanup(&rkisp1->notifier);
>
> 	rkisp1_entities_unregister(rkisp1);
>-	if (rkisp1->info->features & RKISP1_FEATURE_MIPI_CSI2)
>+	if (rkisp1_has_feature(rkisp1, MIPI_CSI2))
> 		rkisp1_csi_cleanup(rkisp1);
> 	rkisp1_debug_cleanup(rkisp1);
>
>-- 
>2.35.1
>
