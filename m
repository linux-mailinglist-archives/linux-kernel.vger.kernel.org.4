Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F53650A72
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 11:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiLSKzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 05:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiLSKzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 05:55:35 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE746EE2E;
        Mon, 19 Dec 2022 02:55:31 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1p7Dnp-0004jl-4H; Mon, 19 Dec 2022 11:55:25 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v3 12/12] riscv: defconfig: Enable the Allwinner D1 platform and drivers
Date:   Mon, 19 Dec 2022 11:55:24 +0100
Message-ID: <8374887.T7Z3S40VBb@diego>
In-Reply-To: <20221208090237.20572-13-samuel@sholland.org>
References: <20221208090237.20572-1-samuel@sholland.org> <20221208090237.20572-13-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 8. Dezember 2022, 10:02:37 CET schrieb Samuel Holland:
> Now that several D1-based boards are supported, enable the platform in
> our defconfig. Build in the drivers which are necessary to boot, such as
> the pinctrl, MMC, RTC (which provides critical clocks), SPI (for flash),
> and watchdog (which may be left enabled by the bootloader). Other common
> onboard peripherals are enabled as modules.
> 
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>


