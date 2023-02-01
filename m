Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D758C6796D5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbjAXLmG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 24 Jan 2023 06:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbjAXLmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:42:00 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB002CC49;
        Tue, 24 Jan 2023 03:41:56 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pKHfs-0007oa-LG; Tue, 24 Jan 2023 12:41:12 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Tony Huang <tonyhuang.sunplus@gmail.com>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Markus Pargmann <mpa@pengutronix.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-tegra@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 2/2] dt-bindings: mmc: correct pwrseq node names
Date:   Tue, 24 Jan 2023 12:41:10 +0100
Message-ID: <2739129.BEx9A2HvPv@diego>
In-Reply-To: <955f4b2a-a750-11a2-0423-72023935723b@linaro.org>
References: <20230120085722.171965-1-krzysztof.kozlowski@linaro.org>
 <2138388.Mh6RI2rZIc@diego> <955f4b2a-a750-11a2-0423-72023935723b@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 24. Januar 2023, 09:17:12 CET schrieb Krzysztof Kozlowski:
> On 20/01/2023 10:38, Heiko St�bner wrote:
> > Am Freitag, 20. Januar 2023, 09:57:22 CET schrieb Krzysztof Kozlowski:
> >> Node names should be generic and should not contain underscores.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.yaml   | 2 +-
> >>  Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml | 2 +-
> >>  Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml | 2 +-
> >>  3 files changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.yaml b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.yaml
> >> index 911a5996e099..588be73168fa 100644
> >> --- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.yaml
> >> +++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.yaml
> >> @@ -41,7 +41,7 @@ additionalProperties: false
> >>  examples:
> >>    - |
> >>      #include <dt-bindings/gpio/gpio.h>
> >> -    sdhci0_pwrseq {
> >> +    pwrseq {
> > 
> > [applicable for all 3 examples]
> > 
> > hmm, power-sequences are not necessarily tied to an address and I guess
> > it will be very much a common case to have multiple ones on a system.
> > 
> > So might it be better to follow other patterns (like leds) to number them
> > or suggest a "foo-pwrseq" / "pwrseq-foo"?
> 
> In such cases one can add number or descriptive suffix (pwrseq-0,
> pwrseq-foo), just like we do for regulators. However the examples have
> here only one node and in such case "pwrseq" is enough.

ok, when that is already part of the schema then all is fine :-)

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


