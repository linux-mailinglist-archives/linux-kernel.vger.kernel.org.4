Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F37A5E8C1C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 14:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbiIXMNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 08:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiIXMNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 08:13:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D97EE11F1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 05:13:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 193DD6126D
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 12:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446ECC433D6;
        Sat, 24 Sep 2022 12:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664021585;
        bh=VyLMxWfneZ3rJhbjfHMq7D9mfK6vAql+dCxazpz2FcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=re+t2boxpL4KVGkisBN5BsjQuz0oxSeAZYXyheiKOY4pi1sR6kSKdqafy0/9Y9czJ
         IFvQKjmJFcjRv9upiokhfKYhkzetKVnMfem+ElegOP8XMcd7/Dq9LQpikwmNdEG7Qw
         X9f/Yr7Y7Bks8cmqkkbmR34kKF8SWDx3/tk/b4tVrtCvLWZbYCSmGLBZC2+7sbS0ht
         32qdiqTqwzFFXoO2T/U7ujnGFrUI9LxinHsQ5pTtF+1RQB+u6BAXQr38w6u6g9FPEG
         IIqt0/3/3M2EAi2tWF35dPxu0xZR42XXD8xtQQ2KoHCWAc7xQHldDOzMraqT1X9wVb
         MVvl2y/+8LvDQ==
Received: by pali.im (Postfix)
        id B23168A2; Sat, 24 Sep 2022 14:13:02 +0200 (CEST)
Date:   Sat, 24 Sep 2022 14:13:02 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: turris-omnia: Add ethernet aliases
Message-ID: <20220924121302.jtm4qv6vgpc33tav@pali>
References: <20220727130926.1874-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220727130926.1874-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PING?

On Wednesday 27 July 2022 15:09:26 Pali Rohár wrote:
> This allows bootloader to correctly pass MAC addresses used by bootloader
> to individual interfaces into kernel device tree.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  arch/arm/boot/dts/armada-385-turris-omnia.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> index f4eb6898aa6b..d2afa466e29a 100644
> --- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
> +++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> @@ -23,6 +23,12 @@
>  		stdout-path = &uart0;
>  	};
>  
> +	aliases {
> +		ethernet0 = &eth0;
> +		ethernet1 = &eth1;
> +		ethernet2 = &eth2;
> +	};
> +
>  	memory {
>  		device_type = "memory";
>  		reg = <0x00000000 0x40000000>; /* 1024 MB */
> -- 
> 2.20.1
> 
