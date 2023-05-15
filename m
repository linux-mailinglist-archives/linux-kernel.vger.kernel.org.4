Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2681D702C84
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241743AbjEOMR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241567AbjEOMR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:17:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F801BC;
        Mon, 15 May 2023 05:17:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C9F7612E1;
        Mon, 15 May 2023 12:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3B8C433EF;
        Mon, 15 May 2023 12:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684153044;
        bh=psCF5o/T20b4f4p5xyBgm+VFMGIPmacOnDTeHqQWNlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DV7A8KDiRX7WwTnraCg0WMuXXeMSe9TUv22YdSsAVSKkDRnrRfudnufc/OM9/+ozl
         obmG+zcn/tFyzRWHecyoilsVCK2W8I6d3Bx40D9R2DvfgBdN+hraamiIZVpmt/DXJ6
         v8FwPHPGzyqQJldVVKNUsf/5tpH4T01rz3N19EjUHjsQTUHWZXfhgM95gWhJptXt54
         JRLZJ9DXthn4YHRVmvw/4QgKYjuH+RWYoO/ZLmP3+bIDgVN5EhrgUt5g6CWC86ZBaH
         X2Eq1nJWrqIpJ/bJ0B0xMUIT5fCmeLDS7qzKiwZC2PnUg6BlBOwGEXCruVVez9Jn2M
         A99ehA/OFv+Bg==
Date:   Mon, 15 May 2023 13:17:17 +0100
From:   Lee Jones <lee@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 0/8] Add PMI632 PMIC and RGB LED on
 sdm632-fairphone-fp3
Message-ID: <20230515121717.GC10825@google.com>
References: <20230414-pmi632-v2-0-98bafa909c36@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230414-pmi632-v2-0-98bafa909c36@z3ntu.xyz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023, Luca Weiss wrote:

> Add support for the PMI632 PMIC in the spmi-gpio & qcom-lpg driver, add
> the dtsi for the PMIC and enable the notification LED on fairphone-fp3.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Changes in v2:
> - Add qcom,pmi632-gpio to all the needed places in yaml
> - Add patch documenting led path
> - Pick up tags
> - Drop vadc pre-scaling patch since it was applied
> - Link to v1: https://lore.kernel.org/r/20230414-pmi632-v1-0-fe94dc414832@z3ntu.xyz
> 
> ---
> Luca Weiss (8):
>       dt-bindings: pinctrl: qcom,pmic-gpio: add PMI632
>       pinctrl: qcom: spmi-gpio: Add PMI632 support
>       dt-bindings: leds: qcom-lpg: Add compatible for PMI632 LPG block
>       leds: qcom-lpg: Add support for PMI632 LPG
>       dt-bindings: mfd: qcom-spmi-pmic: Add PMI632 compatible
>       arm64: dts: qcom: Add PMI632 PMIC
>       arm64: dts: qcom: sdm632-fairphone-fp3: Add notification LED
>       Documentation: leds: Add "rgb:status" path
> 
>  .../devicetree/bindings/leds/leds-qcom-lpg.yaml    |   1 +
>  .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |   1 +
>  .../bindings/pinctrl/qcom,pmic-gpio.yaml           |   3 +
>  Documentation/leds/well-known-leds.txt             |   1 +
>  arch/arm64/boot/dts/qcom/pmi632.dtsi               | 165 +++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts  |  29 ++++
>  drivers/leds/rgb/leds-qcom-lpg.c                   |  15 ++
>  drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           |   1 +
>  8 files changed, 216 insertions(+)

Please rebase anything that is yet to be applied and submit a [RESEND].

Thank you.

> ---
> base-commit: 3f49aa65798675341eb9d4f947c40558564b2e6d
> change-id: 20230414-pmi632-4ae03225ae75
> 
> Best regards,
> -- 
> Luca Weiss <luca@z3ntu.xyz>
 

-- 
Lee Jones [李琼斯]
