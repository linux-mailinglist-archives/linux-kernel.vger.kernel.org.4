Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715066272B7
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 22:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbiKMV2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 16:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbiKMV2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 16:28:51 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9135D13DC8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 13:28:50 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 06A6F5C0049;
        Sun, 13 Nov 2022 16:28:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 13 Nov 2022 16:28:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1668374930; x=
        1668461330; bh=DKRADKismR+EALDLxnUsDhSyAvnnS4TZCWXbLtxP85E=; b=P
        vZonr4P5dZQMqyzopHHAON92z8PXU8ODFraRxBVGhJjVAMScqayapfuk2fExcyaL
        iNUfWfWkWOqSJY6o2IU6ZxCURZetu8PALgJi6AhP6l4Mnv/p40e0r6asE78QJUct
        zDGJrqz+iFTHvqZ6fThcCLaxpAuJUwX4PXgAWpE17/hABwWlrKL3CLfi9XHGH+x3
        h4RrLF2Sf4Uyy9K0qos1N/qq7L17WxSWLLigiww+RopdqBv/kXjUnrjZCqKhMckY
        AnURrE9lK2Wr4WHw6BOUDIZgZWBhUGlyN3XOrid4G5a6zP/IfVxIzg2kr7a91umd
        onHTIVRnrDiL568OcL6hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1668374930; x=
        1668461330; bh=DKRADKismR+EALDLxnUsDhSyAvnnS4TZCWXbLtxP85E=; b=p
        2zn5sA4iwx6UablgjPYSbLC9AS5h/h+iXMTUIlmLylK2iDDfKlelWnZEdQP8knl2
        QN7NZCSXDP7jywZOQ0JxxuV2gbIf9hVTC51LMxhbGbpbIIkTSRVyWVs5+Mbv+pVJ
        MQPRcukD1kTbkgp6FDH5NRnOTqVqCGWMJvPogQwq/giz6fQVpY6XedWbY0D4ng1Q
        yklicX5P83ded+A3n+t9cik8a1HJ634JrHUHzSlpCHxO0T0HVscOFY4elLAoyThY
        oO4aR1kZHH3TUxEX3wf4qcAaUI7I2GYiXKVNeu9sdkxPVJwEwNU8Ax+uNXxfXLyG
        rt0o1kJIO7hr+T4tDl6JQ==
X-ME-Sender: <xms:kWFxY66RcxmWIpRMZVgv0NbJKVBzryU-AXT2j9TDJ-L_dzvbGeJLoA>
    <xme:kWFxYz53dSNPJVHaPuki399rJrXPLz58VbXftQ7snkTDDxSuux1jdkb6j4qI1XqX-
    tkt8-reHYFwqwSAMQ>
X-ME-Received: <xmr:kWFxY5fRrUpPHInFDURD68NVCNwDVlCMtVDpf3gsasAHEP0kaFdMZ5bTMqyRYbuTgepnSVrH0q4dFkXpEp-uyGw8-nzy9eQoS2kmgPGf5rJwnr0Pb-ogWd7xYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedtgdduhedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfvvehfhffujggtgfesth
    ejredttdefjeenucfhrhhomhepufgrmhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghl
    sehshhholhhlrghnugdrohhrgheqnecuggftrfgrthhtvghrnhepjefgfffhudejfedtue
    dugeeutdetgfeiteffffehjeeugfeuvdehjeetfedtffdtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnug
    drohhrgh
X-ME-Proxy: <xmx:kWFxY3JTZ2SUjEeZfHnCGar4j25PiW-rzBla_3HIOB8E1UjHUOH9PA>
    <xmx:kWFxY-K3UpoyNy4j4gDzUwxp2iIUaH-V4mEZcaLttrIr4Q0608SCPw>
    <xmx:kWFxY4zzqwdKXm_idDnksR4Mwejk9MmZJD9RHmVMdGGHfiaTUxtyxg>
    <xmx:kmFxY_pMQyZEiMlp_UlR8jR0iaS8O1ibmN6ezktYrFv4EM5BJq9psQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Nov 2022 16:28:48 -0500 (EST)
Message-ID: <c1564dfb-b092-d8ae-8600-0cab7f99b2ae@sholland.org>
Date:   Sun, 13 Nov 2022 15:28:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     ye.xingchen@zte.com.cn, fengzheng923@gmail.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        chi.minghao@zte.com.cn
References: <202211111641514826535@zte.com.cn>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH] ASoC: sunxi: use devm_platform_get_and_ioremap_resource()
In-Reply-To: <202211111641514826535@zte.com.cn>
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

On 11/11/22 02:41, ye.xingchen@zte.com.cn wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  sound/soc/sunxi/sun50i-dmic.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Acked-by: Samuel Holland <samuel@sholland.org>

