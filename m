Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A215FFCEB
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 03:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJPBhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 21:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiJPBho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 21:37:44 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD0C3DF3A
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 18:37:43 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id E31AF3200786;
        Sat, 15 Oct 2022 21:37:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 15 Oct 2022 21:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1665884262; x=1665970662; bh=UF
        LjsWQ8Ayimtdzmcr4gAgW5OtjjMdavo5hWLZwmoEg=; b=Gyo1Xi3loSZUgNK8aC
        EnmGOmMx2sOb1Z+M0f75SnhaJX94STEYgkCAEQgte7BpUlZO3ekdlZHPI5AVQuG4
        FbsHrN2DyK2qnHgFjWuJ7dlM0BQOnjuGwJjV3CsSMxZ9TjukW/Y6kxxSUngJXKQo
        PXWlemVYJyazFD1czqIplmBZQX3+6kyjphX5B1q8iFhTJGVv/0sEMoXyZvD4dzY2
        IcibWvi54irGLPot2KvZe5GKzCcQ6unszXMrRFNBU1g+37+4mIKJYbfpvnZUe7pO
        3siPCO6oJ19LA6aX6ZZn+iMO3kOvVx2l5RA4z9SmvgU7KhNXorkWkEbJADdWLDNG
        QeDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665884262; x=1665970662; bh=UFLjsWQ8Ayimtdzmcr4gAgW5Otjj
        Mdavo5hWLZwmoEg=; b=fuYJ+miz4AGBC8VgEAEfUYt9JUiC3HdrPHNb5J/RL+yj
        P3Ad7YwmqR5UqXV/QTzO+yashibeJVueIaC8DYqBp2xHGGBju8Pa1pLxFM7xbKFG
        bpt5qoEsGwImzM8dL+7pv7QfbMZMwfxIKFW0QipeKrb//pIULYHX9rlOZa5hCPDK
        A8on7dBGRDxjcZkULhBzkdDt8ivlqah/sA3LLMuNZ7zlsKD0cTklig2TBjfUYRpy
        pijN5sjpMAsg4+ZQ9o0G37jfi5D80D+u+yLCLFmnTyMXYAs+giCTUNzXBlg3jXki
        AX4FbHcrnYTEVK1N9SBWh+9rqeBZzUxRWSk1+iTe/g==
X-ME-Sender: <xms:ZmBLY-vayLefxR3RfT7lmp6SQSdO9pRs25I0F51-F7HkLYJwJt8kAA>
    <xme:ZmBLYzd0zpfYobd7vnDie_rp6xYj5_n9J3qSMpxdjkjuNLiXwnOeTaKpX0odx_bH8
    HCXZ7mrZC_IRCLITEs>
X-ME-Received: <xmr:ZmBLY5w9Zet8VOvBamE73QJje6_87cCjQ1T6fP4tt-9z_wzRHva6cGTwk5PY87kiIGx4TTB78obdYuyF-MCaI76kUMyCLm-pX49S>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekhedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhephefhhfettefgkedvieeuffevveeufedtlefhjeei
    ieetvdelfedtgfefuedukeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:ZmBLY5PPKIg0_WxhPo5VMSo0ABMQDfdTEWor1Kd3k928M0tMhO2Xjg>
    <xmx:ZmBLY-83prVI7vG7BC4LGDhCRTAIL9JayaHBKVdLIEXEzapTa7f_Dw>
    <xmx:ZmBLYxUnQQGH-f59uW7w6sOUhuF88kj8tUy946Djs7X8VibFkIZV-A>
    <xmx:ZmBLYwK0gOotl-N4tf3HzbvKMvRGu6GRiMwDcb66PDxsm2ylmoOTIg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Oct 2022 21:37:40 -0400 (EDT)
Date:   Sun, 16 Oct 2022 10:37:39 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     George Hilliard <thirtythreeforty@gmail.com>
Cc:     Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sound: dice: Fix "Firestudio" typo
Message-ID: <Y0tgY3OYlykkXV0U@workstation>
Mail-Followup-To: George Hilliard <thirtythreeforty@gmail.com>,
        Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20221015233330.8679-1-thirtythreeforty@gmail.com>
 <20221015233330.8679-2-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221015233330.8679-2-thirtythreeforty@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 15, 2022 at 06:33:29PM -0500, George Hilliard wrote:
> No functionality change, just a small cleanup before adding the
> Firestudio Mobile.
> 
> Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
> ---
>  sound/firewire/dice/dice-presonus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
 
Acked-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

> diff --git a/sound/firewire/dice/dice-presonus.c b/sound/firewire/dice/dice-presonus.c
> index 967cc3119a64..c85178e64667 100644
> --- a/sound/firewire/dice/dice-presonus.c
> +++ b/sound/firewire/dice/dice-presonus.c
> @@ -11,7 +11,7 @@ struct dice_presonus_spec {
>  	bool has_midi;
>  };
>  
> -static const struct dice_presonus_spec dice_presonus_firesutio = {
> +static const struct dice_presonus_spec dice_presonus_firestudio = {
>  	.tx_pcm_chs = {{16, 16, 0}, {10, 2, 0} },
>  	.rx_pcm_chs = {{16, 16, 0}, {10, 2, 0} },
>  	.has_midi = true,
> @@ -23,7 +23,7 @@ int snd_dice_detect_presonus_formats(struct snd_dice *dice)
>  		u32 model_id;
>  		const struct dice_presonus_spec *spec;
>  	} *entry, entries[] = {
> -		{0x000008, &dice_presonus_firesutio},
> +		{0x000008, &dice_presonus_firestudio},
>  	};
>  	struct fw_csr_iterator it;
>  	int key, val, model_id;
> -- 
> 2.38.0
 

Thanks

Takashi Sakamoto
