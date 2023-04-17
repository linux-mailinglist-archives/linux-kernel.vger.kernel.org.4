Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27556E45C8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjDQKxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjDQKw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:52:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51741976D;
        Mon, 17 Apr 2023 03:51:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D67F6124E;
        Mon, 17 Apr 2023 10:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD791C433EF;
        Mon, 17 Apr 2023 10:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681728571;
        bh=ziVA6an0IclPiTv5XXAnS129CvY6eq9Ui0ud26tLlWU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pnlzBaD2datLbMEEuWf8qpGLvnCe9TaMR7JX0TfTiVM14q5kUkGVSP6CXaYN9wjt9
         biSqEVVYsSs8uUIU0j67ehaj8JjecZXJBtdf8rAwcqraalik96YmsY0qtuNrh8Hf7E
         +C1Fya95z8EeZXji2v8L8AOSaH/18WObxmVEoxlaBuptn1CzOX9l+WmbmczVa1io1W
         RvKC6okQtnql7Vf7QuaxO94aubCdXDuHPfJiUDK/CX7hrQOJw6R8OPYjwgMCToMMP3
         dhd2y6M+vmkynLIunJK+Lx4F5SzWZCd4nacwg5hPCdXKFUl7hCXaz3Cw3gWzq+QKo7
         j4h5VXR1FUbgQ==
Message-ID: <0fdc2dd8-89d6-8282-d16d-946ec2cb87c4@kernel.org>
Date:   Mon, 17 Apr 2023 13:49:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 00/10] arm64: dts: ti: k3-am64: Add missing properties
 used in u-boot
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Nikhil M Jain <n-jain1@ti.com>, Tom Rini <trini@konsulko.com>
References: <20230414073328.381336-1-nm@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230414073328.381336-1-nm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/04/2023 10:33, Nishanth Menon wrote:
> Hi,
> 
> while attempting to cleanup u-boot, I noticed that u-boot had some
> additional nodes that were'nt in kernel.org, and this makes syncing the
> kernel.org patches back to u-boot hard.
> 
> So, sync the same.
> 
> Bootlogs: (SK and evm)
> https://gist.github.com/nmenon/6b09f55251225d3f3cce076c32a33bba
> 
> Baseline: next-20230413 (will be great if we can get into rc2 - will
> make u-boot sync easier)
> 
> Nishanth Menon (10):
>   arm64: dts: ti: k3-am64: Add general purpose timers
>   arm64: dts: ti: k3-am642-sk: Fix mmc1 pinmux
>   arm64: dts: ti: k3-am642-sk: Enable main_i2c0 and eeprom
>   arm64: dts: ti: k3-am642-sk: Describe main_uart1 pins
>   arm64: dts: ti: k3-am642-sk: Rename regulator node name
>   arm64: dts: ti: k3-am642-evm: Enable main_i2c0 and eeprom
>   arm64: dts: ti: k3-am642-evm: Describe main_uart1 pins
>   arm64: dts: ti: k3-am642-evm: Rename regulator node name
>   arm64: dts: ti: k3-am642-evm: Add VTT GPIO regulator for DDR
>   arm64: dts: ti: k3-am642-sk|evm: Drop bootargs, add aliases
> 
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 144 +++++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi  |  45 +++++++
>  arch/arm64/boot/dts/ti/k3-am64.dtsi      |  16 ---
>  arch/arm64/boot/dts/ti/k3-am642-evm.dts  |  76 ++++++++++--
>  arch/arm64/boot/dts/ti/k3-am642-sk.dts   |  69 ++++++++---
>  5 files changed, 313 insertions(+), 37 deletions(-)
> 

for this series:

Reviewed-by: Roger Quadros <rogerq@kernel.org>
