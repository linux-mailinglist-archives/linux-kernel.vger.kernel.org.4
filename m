Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA806273E0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 01:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbiKNAek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 19:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiKNAei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 19:34:38 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3BCE093
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 16:34:38 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 73892320090B;
        Sun, 13 Nov 2022 19:34:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 13 Nov 2022 19:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1668386074; x=
        1668472474; bh=JWCaNPNku2WcRjI/vXx0mmk36Axrc/QAZnO/9E8Yb7w=; b=y
        y22+SBeTE7NzkvoXCyHhjM6xpNFCWAvcSNd7siC+iuQK1hQ4ib7ndqvq7aQ93RuZ
        vaxIQukHGGc8/k438DT8lYuCMpbAW3SbBEjpYd/MXl2bHDtpWZi66EFKqxxptUAY
        3SdYyYXrso+ps7tWXUk8kGz0+g0AOWODdk6RpdKvIIY0gUbIIBVxjA4uN1oeHPJY
        MDNgt1MoKZF1YLfeiMDHn0YMqAQeWWBMX4o5wd8H/yEJUMu+LzC7ol1WLg/ZtoQ5
        FdAWhQPiKSL0Q3LeERpjFygM0TL30WBDKO/9OjFxOd0mA/YI7DkSF5Lp/HGKVbxE
        FESRdYk5foVfDSGVkcabA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1668386074; x=
        1668472474; bh=JWCaNPNku2WcRjI/vXx0mmk36Axrc/QAZnO/9E8Yb7w=; b=n
        Eno6uAakEAYLLVaDHC0LEFNZrsvt7InkYfGKW02JsZNoB5NYmYHcpzxjkGEkUJOC
        usJ1qC7bxoei3mN//citsERdGVUMDKuKAdT3Ax24CWCvDsJzTUgdyUmbIWUNO7/m
        FJrUxQTpqpg5tF95DcIP3KFH099V2Y7gxv9mNrxreCPtEM3Bs6/yQw7isDE1T4tO
        WqnaL3pVj1F7JPL++G0eRFSxJk8+LeTq+gCYnKa6mhiu45IjZ7X0kcIRqZDX+AdN
        5kCodwAIrd/c9849xAx3lG3ZhQZkXBaLOo0AAJlw0e2ilqWWMaEqvMmALbDcHOOg
        y0qUNIBa4wr9ZXDaMJ88w==
X-ME-Sender: <xms:GY1xYyaNF6NDggmi_3DifoUnlfwV4I6jULPz-Qh27t3_30yH2ZK_DA>
    <xme:GY1xY1ZZ1fSgKXsI1lizha-HCdDNChZNe3FT0kn0-Cs9rR4CAot1Z8y4Pf8PcOQJD
    n99cpV7olspEjSg1A>
X-ME-Received: <xmr:GY1xY8-lwtN8I2jZhb-n2YEzNwcKxcteXbMu2clAfJa-o4Ziz-uRWLMTjrDr_wTsD0PhTuA2bb_dMLchpyHQrK9IL-mnEAIGtC5S8rtRh6fLOM2G_B-jeiU6eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedugddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepkeejleelfeeitdfhtdfgkeeghedufeduueegffdvhfdukeelleef
    tdetjeehuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:GY1xY0r_j6w2S0xGO5los7x39XP_Kk5v2-pOaGdTyDJ_imH7FyT5Nw>
    <xmx:GY1xY9ryJ5mbbNHysbNscHlyIVJ9XypKCs901i7SfJTRl-cw4olKdA>
    <xmx:GY1xYyTfEIhVfFoyUMrxtWUiPei6J5QeeAIQinB9Cpqid9jLCFuh6g>
    <xmx:Go1xY6jvOI51jgUTtVrqrARqAYXuX0AB3vFDsCmRPBLIaG_8kQTIkg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Nov 2022 19:34:32 -0500 (EST)
Message-ID: <22ca0f6f-1e2e-3dc0-46f8-8399889c240c@sholland.org>
Date:   Sun, 13 Nov 2022 18:34:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 06/26] drm: sun4i: Use the dev_pm_ops provided by modeset
 helper
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20221107175106.360578-1-paul@crapouillou.net>
 <20221107175106.360578-7-paul@crapouillou.net>
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <20221107175106.360578-7-paul@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/22 11:50, Paul Cercueil wrote:
> Use the drm_mode_config_pm_ops structure exported by
> drm_modeset_helper.c, which provides the exact same PM callbacks.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-sunxi@lists.linux.dev
> ---
>  drivers/gpu/drm/sun4i/sun4i_drv.c | 24 ++----------------------
>  1 file changed, 2 insertions(+), 22 deletions(-)

Reviewed-by: Samuel Holland <samuel@sholland.org>

