Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B55630E2B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 11:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiKSK7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 05:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKSK72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 05:59:28 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394826A75F;
        Sat, 19 Nov 2022 02:59:28 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A736F5C0200;
        Sat, 19 Nov 2022 05:59:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 19 Nov 2022 05:59:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668855567; x=1668941967; bh=nxpA/TE2f4
        5QZ8/wmR+33Sg3Kp5V6ggqh5WzuAJE96w=; b=E0jZ3XpYJR1oN650kElec6hWIK
        ZQPFqN3MmzjDw/Y6aqW4AQ+jpnOVrseU7bL0H+Jp2l8bez0SeSujb/sXSam2Z7SX
        5WEUm85Jh7JeoZrpe/cEOj6waxvBjajAT3D4bqRyeP1tyOTIew2hn23qcg6QR6Wn
        fbWsCjwZSzgOl7QG4i92ua4g1hp+chq5VmjOOW1CxL8EJIy7oTtNM2CD514bsNbi
        bK9Yg3WQkFLi6ZN9duGOWJnOLeWwK6M64cY3AzEi3UEcmI3BYP4NGr8a+Dwn5b5H
        6J6dvAf6ZrI4r0tnX+AFD5n94binxOfaXBC9ixlaxmtQXKpw0mngP2GaxjzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668855567; x=1668941967; bh=nxpA/TE2f45QZ8/wmR+33Sg3Kp5V
        6ggqh5WzuAJE96w=; b=QlahImdWiC0rxFy1Xe6W42PrrQ1hR6MPGvDzfNNVkLxj
        msa6TylO7t8WXr5MCx8xk3IeJyUoxrU2SOEPlolQeU3+1Xcyv74njzr4phynsnDB
        YrClS+0PIl1I/6cgxzJo6BtuthK70kZxnN9h0Gj/wv960ImG9JdjOk4xfKuVE9wH
        aM5iUWUbzUamGA2uJKIBsaYfy+Upp9PE39A6UFCPHIhHIb4jco+9hYbf/TK+CbJj
        bMeoLJuCREWFwVpt/KqJFLGUbE06HBgWPk1UvxBqtWR6n5/DEkkHCvpTDvNYKZYX
        WTa3LsJgMYcG40LNCOG0K92KStHvpN18KNtOqpip0A==
X-ME-Sender: <xms:D7d4Y2PUZ1ExFu0dj_POSG1EBaSeQ2m-zOQ3dC9_iJ64xZbwGsYWpg>
    <xme:D7d4Y098QN9Pic1Iw5PxIv_ZessaMhHIPBkoOThKo7LTD8r1XOSCJQgS9BL64Kk2k
    GZkwJA5M87jqZk-Z0E>
X-ME-Received: <xmr:D7d4Y9Q_WBAHxyP1goHFNAaOBGTjmAFuTHHlptmq20qbxl4IU9XvOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrhedvgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpeffrghfnhgr
    ucfjihhrshgthhhfvghlugcuoegurghfnhgrsehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnhepvdehtdeludekgeevleefuedvudejieetheekvdfhteekffdujefh
    fedtudehvdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepuggrfhhnrgesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:D7d4Y2sRPzPlhw1wEtwFdUFm81qZLfFaTGAgAI9FAqxE2laBP1lcpg>
    <xmx:D7d4Y-dQaJBZu9FWM8a2Iol3OwHQLNtRgsJ30xxqhID1cfNsTNimBw>
    <xmx:D7d4Y62Y9JyDjZeH-uD2Fp86Gwv45n1ROBl0mrSKBS1xGDvBauiiKQ>
    <xmx:D7d4Y2QYT4PyzhrNyGvVWIN4U4LDOjVwwYuhUH32DWl3LRxX7uGUTQ>
Feedback-ID: i0e894699:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Nov 2022 05:59:25 -0500 (EST)
Date:   Sat, 19 Nov 2022 12:59:22 +0200
From:   Dafna Hirschfeld <dafna@fastmail.com>
To:     Paul Elder <paul.elder@ideasonboard.com>
Cc:     linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] media: rkisp1: Add NV16M and NV61M to output
 formats
Message-ID: <20221119105922.ktgpadbhhb4wsild@guri>
References: <20221117084217.3892680-1-paul.elder@ideasonboard.com>
 <20221117084217.3892680-2-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20221117084217.3892680-2-paul.elder@ideasonboard.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.11.2022 17:42, Paul Elder wrote:
>Add support for NV16M and NV61M as output formats. As NV16, NV61, NV12M
>and NV21M are already supported, the infrastructure is already in place
>to support NV16M and NV61M, so it is sufficient to simply add relevant
>entries to the list of output formats.
>
>Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
>Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Reviewed-by: Dafna Hirschfeld <dafna@fastmail.com>

>---
> .../platform/rockchip/rkisp1/rkisp1-capture.c | 22 +++++++++++++++++++
> 1 file changed, 22 insertions(+)
>
>diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
>index d4540684ea9a..7695ef134908 100644
>--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
>+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
>@@ -110,6 +110,16 @@ static const struct rkisp1_capture_fmt_cfg rkisp1_mp_fmts[] = {
> 		.uv_swap = 1,
> 		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUV_SPLA,
> 		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
>+	}, {
>+		.fourcc = V4L2_PIX_FMT_NV16M,
>+		.uv_swap = 0,
>+		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUV_SPLA,
>+		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
>+	}, {
>+		.fourcc = V4L2_PIX_FMT_NV61M,
>+		.uv_swap = 1,
>+		.write_format = RKISP1_MI_CTRL_MP_WRITE_YUV_SPLA,
>+		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
> 	}, {
> 		.fourcc = V4L2_PIX_FMT_YVU422M,
> 		.uv_swap = 1,
>@@ -237,6 +247,18 @@ static const struct rkisp1_capture_fmt_cfg rkisp1_sp_fmts[] = {
> 		.write_format = RKISP1_MI_CTRL_SP_WRITE_SPLA,
> 		.output_format = RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
> 		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
>+	}, {
>+		.fourcc = V4L2_PIX_FMT_NV16M,
>+		.uv_swap = 0,
>+		.write_format = RKISP1_MI_CTRL_SP_WRITE_SPLA,
>+		.output_format = RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
>+		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
>+	}, {
>+		.fourcc = V4L2_PIX_FMT_NV61M,
>+		.uv_swap = 1,
>+		.write_format = RKISP1_MI_CTRL_SP_WRITE_SPLA,
>+		.output_format = RKISP1_MI_CTRL_SP_OUTPUT_YUV422,
>+		.mbus = MEDIA_BUS_FMT_YUYV8_2X8,
> 	}, {
> 		.fourcc = V4L2_PIX_FMT_YVU422M,
> 		.uv_swap = 1,
>-- 
>2.35.1
>
