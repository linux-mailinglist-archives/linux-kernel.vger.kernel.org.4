Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061C163CF51
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 07:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbiK3Gn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 01:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbiK3GnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 01:43:22 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A137264BB
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 22:43:19 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 2D96B32008C3;
        Wed, 30 Nov 2022 01:43:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 30 Nov 2022 01:43:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669790597; x=
        1669876997; bh=lntUmHMVl09jWwzPOK/afaD1n7te2cZMlPiqFMAMIAM=; b=S
        8kbnn+Dqdd+7HPcRi3dIsjSE1GweRVRTP27wUI1l+RKXyajw5IY0h96VMhXUa0KY
        VkIv5J4p9CqC7iazG6OQsCNb4FDTJE0UKrWwkFyVLx6nvVlwS08+hVMT0m3RDOuK
        F5nahZCtUtvBnx3dLceR9sPgSN0olU0gplervKVsnu7B2CufNfjNnGwiAZVrD7Wq
        BFFRBGzFN73PeRpw8sKqf7tTYCyWTNJ+UACDUtRSo3xEkAvvcvVeICzuS/N5hFWT
        SE2Ijodm4E/wLWCTeps38Z/FBvKmd2CP914QmLPaH7hbnimP0VSTr9WQow6M6Uts
        WsbiRwF3ihxsNhy0xf14w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669790597; x=
        1669876997; bh=lntUmHMVl09jWwzPOK/afaD1n7te2cZMlPiqFMAMIAM=; b=c
        0kTGr6Je9XBU8+OiVbwU8gWaYJTY+nGabuetTSGw1eEY3SHkQhh0lXMno/jpFVw6
        pFlC0EH6i9svWR+0NT3MU2uW7iF1w8gY5QxdKz3vV0/6hY5C/L6ixXv3AAeVLrQk
        oVexkxy13H8Kze6jXYrnMbGDhIy1b6rhWj+mrU00Uawtz+qMtjcks62RkpnPPEBx
        dtCYr7Jv/5AkqM9Z1Diy4edWLkSH965SSWINCQgct5j3cCnG/KE82ba458EyaPjQ
        T9qTQTQDnBZUCumatFJALGLdYZXdD/r4m91WDaWSrceNf6n2LgVR6jOYmM2sqZnQ
        IzwsVWpTORa9TpXirRwag==
X-ME-Sender: <xms:hPuGY1N0Q2U5smdzTf4Mu5nXlpczZrtDAEL5GzkSLQ3CQv4Yjcutcg>
    <xme:hPuGY381tTaUTF-acxFVLtZH9_Amsfnd-TkHDsgSA6uJRuWPDNdU2V9QPxqqZ0iGQ
    mlMySqWSWR0Uap0Rw>
X-ME-Received: <xmr:hPuGY0Q5rIMRkvMPJyLeaD9iZ05-f3zSpPmac3snUAJ_ZMy7HHM2VbIRYVYJoVFXrtDhmThcKndNDIm5MvgVzwy5Mxq07sO7EFVmzzFeuiNjaV4zqncu-Da9pA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtddvgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepjefgfffhudejfedtuedugeeutdetgfeiteffffehjeeugfeuvdeh
    jeetfedtffdtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:hPuGYxvmWtOZ0ZAZkBPt-W8G3DnmkWqsC3B7tU4da2GcESNSGsIFIw>
    <xmx:hPuGY9f_l2-vdU-UGo5RLxfKS7EcRGlbSIbv07XtMo_0hB5T8ZpbJw>
    <xmx:hPuGY920reA7nmLP43hB33Nde_FlddCzifZ7gUKcw_VC09BE0C4ySA>
    <xmx:hfuGYx75UibAIGRf21tcggTdzWaIt9T4tLR9oKSThmhDHSPQ-CPLnw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Nov 2022 01:43:16 -0500 (EST)
Message-ID: <834c5b42-1992-e444-fe7b-2c0a28d71f60@sholland.org>
Date:   Wed, 30 Nov 2022 00:43:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Aren Moynihan <aren@peacevolution.org>, Lee Jones <lee@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megi@xff.cz>, linux-kernel@vger.kernel.org
References: <20221123230741.2430813-1-aren@peacevolution.org>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH] mfd: axp20x: fix order of pek rise and fall events
In-Reply-To: <20221123230741.2430813-1-aren@peacevolution.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/22 17:07, Aren Moynihan wrote:
> The power button can get "stuck" if the rising edge and falling edge irq
> are read in the same pass. This can often be triggered when resuming
> from suspend if the power button is released before the kernel handles
> the interrupt.
> 
> Swapping the order of the rise and fall events makes sure that the press
> event is handled first, which prevents this situation.

Indeed. This is probably the simplest solution, but I think it deserves
a comment in at least one place that the order intentionally mismatches
the order of the bits in the register.

> Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> ---
>  include/linux/mfd/axp20x.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> index 9ab0e2fca7ea..a13ba2bdd01f 100644
> --- a/include/linux/mfd/axp20x.h
> +++ b/include/linux/mfd/axp20x.h
> @@ -432,8 +432,8 @@ enum {
>  	AXP152_IRQ_PEK_SHORT,
>  	AXP152_IRQ_PEK_LONG,
>  	AXP152_IRQ_TIMER,
> -	AXP152_IRQ_PEK_RIS_EDGE,
>  	AXP152_IRQ_PEK_FAL_EDGE,
> +	AXP152_IRQ_PEK_RIS_EDGE,
>  	AXP152_IRQ_GPIO3_INPUT,
>  	AXP152_IRQ_GPIO2_INPUT,
>  	AXP152_IRQ_GPIO1_INPUT,
> @@ -472,8 +472,8 @@ enum {
>  	AXP20X_IRQ_LOW_PWR_LVL1,
>  	AXP20X_IRQ_LOW_PWR_LVL2,
>  	AXP20X_IRQ_TIMER,
> -	AXP20X_IRQ_PEK_RIS_EDGE,
>  	AXP20X_IRQ_PEK_FAL_EDGE,
> +	AXP20X_IRQ_PEK_RIS_EDGE,
>  	AXP20X_IRQ_GPIO3_INPUT,
>  	AXP20X_IRQ_GPIO2_INPUT,
>  	AXP20X_IRQ_GPIO1_INPUT,
> @@ -502,8 +502,8 @@ enum axp22x_irqs {
>  	AXP22X_IRQ_LOW_PWR_LVL1,
>  	AXP22X_IRQ_LOW_PWR_LVL2,
>  	AXP22X_IRQ_TIMER,
> -	AXP22X_IRQ_PEK_RIS_EDGE,
>  	AXP22X_IRQ_PEK_FAL_EDGE,
> +	AXP22X_IRQ_PEK_RIS_EDGE,
>  	AXP22X_IRQ_GPIO1_INPUT,
>  	AXP22X_IRQ_GPIO0_INPUT,
>  };
> @@ -571,8 +571,8 @@ enum axp803_irqs {
>  	AXP803_IRQ_LOW_PWR_LVL1,
>  	AXP803_IRQ_LOW_PWR_LVL2,
>  	AXP803_IRQ_TIMER,
> -	AXP803_IRQ_PEK_RIS_EDGE,
>  	AXP803_IRQ_PEK_FAL_EDGE,
> +	AXP803_IRQ_PEK_RIS_EDGE,
>  	AXP803_IRQ_PEK_SHORT,
>  	AXP803_IRQ_PEK_LONG,
>  	AXP803_IRQ_PEK_OVER_OFF,
> @@ -623,8 +623,8 @@ enum axp809_irqs {
>  	AXP809_IRQ_LOW_PWR_LVL1,
>  	AXP809_IRQ_LOW_PWR_LVL2,
>  	AXP809_IRQ_TIMER,
> -	AXP809_IRQ_PEK_RIS_EDGE,
>  	AXP809_IRQ_PEK_FAL_EDGE,
> +	AXP809_IRQ_PEK_RIS_EDGE,
>  	AXP809_IRQ_PEK_SHORT,
>  	AXP809_IRQ_PEK_LONG,
>  	AXP809_IRQ_PEK_OVER_OFF,

You should also update APX288 and APX806, which name the IRQs "POK"
instead of "PEK" for some reason.

Regards,
Samuel

