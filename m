Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA39E630E27
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 11:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiKSKzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 05:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKSKzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 05:55:21 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A934920B2;
        Sat, 19 Nov 2022 02:55:20 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1ED415C0112;
        Sat, 19 Nov 2022 05:55:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 19 Nov 2022 05:55:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668855318; x=1668941718; bh=CIwr77lYrj
        EiDjN+lfmJBa8qTpOY2sqozIVlYRnXdhU=; b=Hmk/n8p3OvZWDV2jFpZZq2IZbG
        uVhTVcq1s+BL0vWBjOBJ9SoJ+74Xq2YeZAR4wGmsYj+UOSnFisapOunmqqYUIH7G
        k7EWWJDtLZWT66MaGKcTeVRvKZXBGc+s/ORIyn60H2ksXqBIfT81yHud0KtC7LcI
        tJzerUVlEoNx76CKuOvehncGS7gPDuO/L5ozWtJjNtnfi6MpSGFxOpKhYV2RqKVX
        mKaw6qipy7aCNSpEkPb6l0DNpye7QTcmA3mSoTS8yugKAGpLCqQI/RSDntOy/sMM
        x95HxmIi/D7b6MTtPloNvBh5NpxJWi2GiDJwxq36/9o+Jsyg9jlfBgwpNmRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668855318; x=1668941718; bh=CIwr77lYrjEiDjN+lfmJBa8qTpOY
        2sqozIVlYRnXdhU=; b=lNwUjvTWpmRNUVzK2Y2i31Wapj29V0azTxZPkj3TH3Xj
        IeNLDBlOhvo6AHPaLoWMuzMvo0qPuAurb2ieg0AdXbTIfGnOMKZDthY6utk12jEO
        Oz4m+gkvLTQ3OY+64JJUK0ZD6TJEAhauSK8yYb3JwI2iopARxKQ8RhwOB96rwUhR
        PUueNyRQmva5OmAIFnPqUVEWeIRV4IObYqBbw3bNs7wPtngTi5Kr+3M8UxSNZW9o
        sGoz7zalfjBudGyDfVm/zuxlD/X44DpA/bWxp4Bg8dUO1S2DfLFW78dT1Cr/B7SJ
        Dlf+xdxHQw58iq+ITrPpqzAToJ3XgeWImi0kL6YtgA==
X-ME-Sender: <xms:FbZ4Y579I-XB7wSjbSt-U0qwvOR5XkO9w3kiOhTh04el7yL3MHpjlA>
    <xme:FbZ4Y24Mzf_TWOZh72i8-J_pjUAJnSS908O8v1APKsJSLgR6soKzh9iw1OGGbaU7N
    Q3EfD60yJtc6Bh181M>
X-ME-Received: <xmr:FbZ4Ywd3QfTbjriFPRI6AC7lgneacQjr1AcTQIrNPq4mPKA3hjbnug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrhedvgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpeffrghfnhgr
    ucfjihhrshgthhhfvghlugcuoegurghfnhgrsehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnhepvdehtdeludekgeevleefuedvudejieetheekvdfhteekffdujefh
    fedtudehvdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepuggrfhhnrgesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:FbZ4YyJkJ-KjVecGPdMMxNYNtg9ogFvUjwh1ioLPQCSGPmYOlkvuAQ>
    <xmx:FbZ4Y9LyV7aUYOGKTJj1iT4g4QNpc1r6TNvHFIHzN6rxeCdNOhGi3w>
    <xmx:FbZ4Y7yrGR6YfkyYdphJHOT79cgKXmHfnC4kdjsXej4AoodGZceYLA>
    <xmx:FrZ4Y18GJE1wkYTEPgztTjgA3yeFt_OEcORBYvcRqJR04bfgJU4iOA>
Feedback-ID: i0e894699:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Nov 2022 05:55:15 -0500 (EST)
Date:   Sat, 19 Nov 2022 12:55:10 +0200
From:   Dafna Hirschfeld <dafna@fastmail.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: rkisp1: make const arrays ae_wnd_num and
 hist_wnd_num static
Message-ID: <20221119105510.26n7jk6tc4anu3f3@guri>
References: <20221102155117.144570-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20221102155117.144570-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.11.2022 15:51, Colin Ian King wrote:
>Don't populate the const arrays on the stack, instead make them
>static. Also makes the object code smaller.
>
>Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Dafna Hirschfeld <dafna@fastmail.com>

>---
> drivers/media/platform/rockchip/rkisp1/rkisp1-params.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-params.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-params.c
>index d8731ebbf479..3482f7d707b7 100644
>--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-params.c
>+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-params.c
>@@ -715,7 +715,7 @@ static void rkisp1_aec_config_v12(struct rkisp1_params *params,
> 	u32 exp_ctrl;
> 	u32 block_hsize, block_vsize;
> 	u32 wnd_num_idx = 1;
>-	const u32 ae_wnd_num[] = { 5, 9, 15, 15 };
>+	static const u32 ae_wnd_num[] = { 5, 9, 15, 15 };
>
> 	/* avoid to override the old enable value */
> 	exp_ctrl = rkisp1_read(params->rkisp1, RKISP1_CIF_ISP_EXP_CTRL);
>@@ -822,7 +822,7 @@ static void rkisp1_hst_config_v12(struct rkisp1_params *params,
> 	u32 block_hsize, block_vsize;
> 	u32 wnd_num_idx, hist_weight_num, hist_ctrl, value;
> 	u8 weight15x15[RKISP1_CIF_ISP_HIST_WEIGHT_REG_SIZE_V12];
>-	const u32 hist_wnd_num[] = { 5, 9, 15, 15 };
>+	static const u32 hist_wnd_num[] = { 5, 9, 15, 15 };
>
> 	/* now we just support 9x9 window */
> 	wnd_num_idx = 1;
>-- 
>2.37.3
>
