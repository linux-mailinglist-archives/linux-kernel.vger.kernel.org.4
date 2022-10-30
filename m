Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CB9612C92
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 21:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiJ3UIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 16:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJ3UIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 16:08:31 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EE62FD;
        Sun, 30 Oct 2022 13:08:30 -0700 (PDT)
Received: from [185.156.123.69] (helo=phil.sntech)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1opEbX-0005ci-6p; Sun, 30 Oct 2022 21:08:23 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Kevin Hilman <khilman@baylibre.com>, linux-rtc@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>, kernel@collabora.com,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: (subset) [PATCHv2 0/6] Convert HYM8563 RTC binding to YAML
Date:   Sun, 30 Oct 2022 21:08:17 +0100
Message-Id: <166716040330.1678541.8752121289367549859.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221024165549.74574-1-sebastian.reichel@collabora.com>
References: <20221024165549.74574-1-sebastian.reichel@collabora.com>
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

On Mon, 24 Oct 2022 18:55:43 +0200, Sebastian Reichel wrote:
> This converts HYM8563 binding to YAML and fixes
> the existing DTs.
> 
> Changes since PATCHv1:
>  * https://lore.kernel.org/all/20221021170605.85163-1-sebastian.reichel@collabora.com/
>  * Added patches fixing the existing devicetrees (Rob Herring)
>  * Dual licensed the binding (Krzysztof Kozlowski)
>  * Added maxItems for clock-output-names (Krzysztof Kozlowski)
> 
> [...]

Applied, thanks!

[1/6] arm64: dts: rockchip: fix node name for hym8563 rtc
      commit: 67a9aeef44e42b1ac2becf5e61eae0880f48d9db
[2/6] arm64: dts: rockchip: remove clock-frequency from rtc
      commit: 2af5bbe32f50d196dd680478a889d12429b3e8cf
[3/6] arm: dts: rockchip: fix node name for hym8563 rtc
      commit: 17b57beafccb4569accbfc8c11390744cf59c021
[4/6] arm: dts: rockchip: remove clock-frequency from rtc
      commit: 6122f3be70d90a1b2a1188d8910256fc218376a9

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
