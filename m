Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717C46F03BA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243333AbjD0Jx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243083AbjD0Jxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:53:50 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A561BF6;
        Thu, 27 Apr 2023 02:53:47 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pryJo-0003ex-NL; Thu, 27 Apr 2023 11:53:40 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Lorenz Brun <lorenz@brun.one>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: fix USB regulator on ROCK64
Date:   Thu, 27 Apr 2023 11:53:39 +0200
Message-Id: <168258919354.412054.16852128323451606198.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230421213841.3079632-1-lorenz@brun.one>
References: <20230421213841.3079632-1-lorenz@brun.one>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2023 23:38:41 +0200, Lorenz Brun wrote:
> Currently the ROCK64 device tree specifies two regulators, vcc_host_5v
> and vcc_host1_5v for USB VBUS on the device. Both of those are however
> specified with RK_PA2 as the GPIO enabling them, causing the following
> error when booting:
> 
>   rockchip-pinctrl pinctrl: pin gpio0-2 already requested by vcc-host-5v-regulator; cannot claim for vcc-host1-5v-regulator
>   rockchip-pinctrl pinctrl: pin-2 (vcc-host1-5v-regulator) status -22
>   rockchip-pinctrl pinctrl: could not request pin 2 (gpio0-2) from group usb20-host-drv  on device rockchip-pinctrl
>   reg-fixed-voltage vcc-host1-5v-regulator: Error applying setting, reverse things back
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: fix USB regulator on ROCK64
      commit: be6f6bc717e135bd5494b4d27f703026dc48b8f0

As fix for 6.4

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
