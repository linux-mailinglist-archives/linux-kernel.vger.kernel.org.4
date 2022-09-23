Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167485E7C5A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 15:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiIWNya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 09:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiIWNy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:54:27 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F7C13D1C9;
        Fri, 23 Sep 2022 06:54:25 -0700 (PDT)
Received: from p508fdb48.dip0.t-ipconnect.de ([80.143.219.72] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1obj8F-0007Bj-Ty; Fri, 23 Sep 2022 15:54:19 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, jacopo@jmondi.org,
        linuxfancy@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/3] arm64: dts: rockchip: px30: fix ov5695 camera probe
Date:   Fri, 23 Sep 2022 15:54:18 +0200
Message-Id: <166394125188.551974.9234507267741432877.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220620161321.1898840-1-tommaso.merciai@amarulasolutions.com>
References: <20220620161321.1898840-1-tommaso.merciai@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2022 18:13:17 +0200, Tommaso Merciai wrote:
> This series fix camera probing issue of ov5695 camera driver for px30 evb.
> Improve also the ov5695.c driver using using regulator_bulk_enable/regulatore_bulk_disable
> function in __ov5695_power_on/__ov5695_power_off functions instead of for loop
> 
> 1. max drive-strength for cif_clkout_m0
> 2. add mux for mipi-pdn pad
> 3. use rk gpio naming convention for reset-gpio of ov5695
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: rockchip: px30: max drive-strength for cif_clkout_m0
      commit: 8cde9667137f2ca8def8aef518305a78e5f55279
[2/3] arm64: dts: rockchip: px30: add mux for mipi-pdn pad
      commit: 921890cae252ed7b7e4d9f98f63515c25cc0aede
[3/3] arm64: dts: rockchip: px30: use rk gpio naming convention into reset-gpios
      commit: 19d4aaf640913c5a8f1b06c9ef46287c32635299

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
