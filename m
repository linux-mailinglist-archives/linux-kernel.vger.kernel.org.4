Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFE86CBD18
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjC1LIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjC1LIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:08:30 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184C583C4;
        Tue, 28 Mar 2023 04:07:28 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id B6CF942525;
        Tue, 28 Mar 2023 11:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1680001647; bh=8npJkxrhJiggmPvfO97ErfoUO5wnE+piw2jVg85zRIw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=MraoQJXXebpmFmBJjVCoJF8UwSZJkw8u5JgxTxrsrsqbNWGgT7bntdzL3DWRYC4qk
         mkC2P5SF0oXBRpvApJ5Un9UKUBeCB/BnoI5YXOW71TgAiUTpO08nYzriLghnducs7w
         PwSyp37+QDuoq9RqJ8s5qETn3Ho/ZeZfrGR/tyxmcoSDTYEU1PDwmAVpYY/70+rRsQ
         ooSOtI3YBqgwFDVj+iLhIqk7JywPEnAJ/aTP/VqkL80XIcEyEcnVZXaPb3eD2Z69LK
         9OesnLAagbcB7ucdDjVFoS773tDoR7+Wrz/SH3DhmND4reZYuD2kn9FUvuPXp5ijct
         3h/CRQwqMNutA==
Message-ID: <468d23ae-114d-9d3c-1920-7cae8355c1b8@marcan.st>
Date:   Tue, 28 Mar 2023 20:07:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/2] arch: arm64: dts: apple: Disable unused PCIe ports
Content-Language: en-US
To:     Janne Grunau <j@jannau.net>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230214-apple_dts_pcie_disable_unused-v1-0-5ea0d3ddcde3@jannau.net>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <20230214-apple_dts_pcie_disable_unused-v1-0-5ea0d3ddcde3@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 23.07, Janne Grunau wrote:
> The t8103 and t600x device trees deleted unused PCIe ports. This was
> probably done to replicate Apple's device tree which doesn't has nodes
> for most unused hardware.
> A more accurate description of the hardware is to disable unused
> hardware.
> 
> This was discovered during the review of the t8112 device trees in
> https://lore.kernel.org/asahi/1ea2107a-bb86-8c22-0bbc-82c453ab08ce@linaro.org/
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> Janne Grunau (2):
>       arm64: dts: apple: t8103: Disable unused PCIe ports
>       arm64: dts: apple: t600x: Disable unused PCIe ports
> 
>  arch/arm64/boot/dts/apple/t600x-die0.dtsi      |  4 ++++
>  arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi | 11 -----------
>  arch/arm64/boot/dts/apple/t600x-j375.dtsi      | 11 +++++++++++
>  arch/arm64/boot/dts/apple/t8103-j274.dts       | 10 ++++++++++
>  arch/arm64/boot/dts/apple/t8103-j293.dts       | 15 ---------------
>  arch/arm64/boot/dts/apple/t8103-j313.dts       | 15 ---------------
>  arch/arm64/boot/dts/apple/t8103-j456.dts       | 10 ++++++++++
>  arch/arm64/boot/dts/apple/t8103-j457.dts       | 11 +++--------
>  arch/arm64/boot/dts/apple/t8103.dtsi           |  4 ++++
>  9 files changed, 42 insertions(+), 49 deletions(-)
> ---
> base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
> change-id: 20230214-apple_dts_pcie_disable_unused-03c08218b8af
> 
> Best regards,

Thanks, applied to asahi-soc/dt!

- Hector

