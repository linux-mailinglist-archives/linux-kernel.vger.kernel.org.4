Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EE063CF57
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 07:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbiK3GtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 01:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbiK3GtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 01:49:06 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF0E45EDB;
        Tue, 29 Nov 2022 22:49:04 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 6962432008C3;
        Wed, 30 Nov 2022 01:49:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 30 Nov 2022 01:49:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669790940; x=
        1669877340; bh=Oo4m/M2CLmFBs936diTgoNkM47vJxV+hsa4z7Pi/W/c=; b=i
        UybVenTBMuICmg1qOTvvLhVZhFOCVQ2TUs07wvfeMI6oGBlIby4tTDTP2WehHFUq
        JuXJW3HKOX+xthigiaMlemR8XB4s+kw+U/8M354F7214xlZ/EwOYO7T/wp3rF5cV
        ostq0XKldLMxoF1pFJQRkR9rX/rGajiU5DtVdOqKgjRn4wLpUfeRS3jwnPzHJHql
        zok6S8GtW2rDEJAqn1q1Rji2/HVSbN/wzZ+IYgMiu6W/Sc1OPGnHV3Mfin+Rq9jA
        1cY6AwylGgipbF0XhfAxjum82IqFDAqqJBAazpPcR6s7pAlHZDkSPVO1/mxzBEAf
        PzH6M/GkQP7BRt9aBdlqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669790940; x=
        1669877340; bh=Oo4m/M2CLmFBs936diTgoNkM47vJxV+hsa4z7Pi/W/c=; b=W
        140O6eix5o9QGCjvzrQHyoM5YtS44aVc+YsF5ecHuZqgadvwyHJiiZd00p/NEMuw
        dMCEqKjGV5z9ra54AsBqsHTjfQ8jW1mkTJKj06WXMQsHQLlRhsUqQd0g+y/zd2fx
        7k5+jYaBmoYndpEVzWq6CrlDoAmKfxuewht9l/FelucM3wHt+6Fmedg+7rF71CIw
        mU0+W4m/x8+9yuMRG7chKUdk8/4D5tW3kf2RJYNnYDnCrfCg3qvbdGov5mBw3ar1
        xrzNVCPZ6TJujTYcUuCsLYYPSXJCTQ7oHWLLgcB+N0qA3GHAH1CliOzQKxVzTfL8
        QyDpIFS8bDSKlhCM8WbKw==
X-ME-Sender: <xms:2_yGYz0Y49q2bNvS5nkXckNWHbFLgDzTGWWRKbd-gvlkNS8gBa0hcA>
    <xme:2_yGYyE8qsDxm79tnHHpiJgqVlpAKjCU-fLs9ui8qF9fofJCXsA-lt0zeZUy_tGIg
    rAvDMjXkQuLA153jw>
X-ME-Received: <xmr:2_yGYz6YTf4tziAk4X2ZgRzInmxjOwq94ysEjs3vWVqAhS4hw6lDk3gLUyGNqCb859MAgTfrMEfvoZchab9PSFB8Lcd0R0sT7QwqMJ6gsSVDG8yXK0mOjtII3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtddvgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudfhffefhfffuddutedvffekteevieeugeefleelffeitddutdff
    udehgfdtfefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:2_yGY43y3F_JIzreruW5KaMjdYX6lCBtFKEAw0-f067mmFQXJj5nhw>
    <xmx:2_yGY2G4PW9MSLevbKpqlAOlAlCP15_qWMzLUU23c7FN2OPIqUE3Pg>
    <xmx:2_yGY59DQWmk2HPhM8j52r53VsjSu3g7Q7EGlXzBbfFZNbB-qMZTww>
    <xmx:3PyGYyH_b_OEbiRJP5xFF7ri_CaEbLmi19Chl0sOjTQDPTgy5yaciQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Nov 2022 01:48:58 -0500 (EST)
Message-ID: <d0344e62-b9ff-8465-9556-5562e195f4a3@sholland.org>
Date:   Wed, 30 Nov 2022 00:48:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 3/9] riscv: add the Bouffalolab SoC family Kconfig
 option
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20221127132448.4034-1-jszhang@kernel.org>
 <20221127132448.4034-4-jszhang@kernel.org>
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <20221127132448.4034-4-jszhang@kernel.org>
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

On 11/27/22 07:24, Jisheng Zhang wrote:
> The Bouffalolab bl808 SoC contains three riscv CPUs, namely M0, D0 and
> LP. The D0 is 64bit RISC-V GC compatible, so can run linux.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/Kconfig.socs | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 69774bb362d6..90256f44ed4a 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -1,5 +1,11 @@
>  menu "SoC selection"
>  
> +config SOC_BOUFFALOLAB

The options in this file are getting renamed soon, so this should be
named ARCH_BOUFFALOLAB. See

https://lore.kernel.org/linux-riscv/20221121221414.109965-1-conor@kernel.org/

Regards,
Samuel

> +	bool "Bouffalolab SoCs"
> +	select SIFIVE_PLIC
> +	help
> +	  This enables support for Bouffalolab SoC platforms.
> +
>  config SOC_MICROCHIP_POLARFIRE
>  	bool "Microchip PolarFire SoCs"
>  	select MCHP_CLK_MPFS

