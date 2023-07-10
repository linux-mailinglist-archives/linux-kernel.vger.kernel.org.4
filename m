Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C6374D8DF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjGJOVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbjGJOVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:21:39 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E04FD2;
        Mon, 10 Jul 2023 07:21:37 -0700 (PDT)
Received: from i53875a50.versanet.de ([83.135.90.80] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qIrlf-0001VJ-9u; Mon, 10 Jul 2023 16:21:35 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-rockchip@lists.infradead.org
Subject: Re: [RFT PATCH v2 1/3] arm64: dts: rockchip: correct wifi interrupt flag in
 eaidk-610
Date:   Mon, 10 Jul 2023 16:21:34 +0200
Message-ID: <2762773.BEx9A2HvPv@phil>
In-Reply-To: <168899855919.1747213.375800621361302991.b4-ty@sntech.de>
References: <20230707063335.13317-1-krzysztof.kozlowski@linaro.org>
 <168899855919.1747213.375800621361302991.b4-ty@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 10. Juli 2023, 16:16:20 CEST schrieb Heiko Stuebner:
> On Fri, 7 Jul 2023 08:33:33 +0200, Krzysztof Kozlowski wrote:
> > GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
> > These are simple defines so they could be used in DTS but they will not
> > have the same meaning: GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE.
> > 
> > Correct the interrupt flags, assuming the author of the code wanted same
> > logical behavior behind the name "ACTIVE_xxx", this is:
> >   ACTIVE_HIGH  => IRQ_TYPE_LEVEL_HIGH
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/3] arm64: dts: rockchip: correct wifi interrupt flag in eaidk-610
>       commit: 8183bb7e291b7818f49ea39687c2fafa01a46e27
> [2/3] arm64: dts: rockchip: correct wifi interrupt flag in Rock Pi 4B
>       commit: cfa12c32b96fd5b12f77d880d6a1ddd2a502756e
> [3/3] arm64: dts: rockchip: correct wifi interrupt flag in Box Demo
>       commit: 2d6f7e3938a7aba154c8e8afaddc8b7f1e0a1b56

we got one successful test and all the changes concern broadcom wifi
modules, I assume that this should work on all of them the same :-)


