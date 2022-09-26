Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957875EABF9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbiIZQEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbiIZQDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:03:30 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE2CA442;
        Mon, 26 Sep 2022 07:52:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 90E22CE10DE;
        Mon, 26 Sep 2022 14:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7C1C4347C;
        Mon, 26 Sep 2022 14:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664203938;
        bh=K88cm8bIsC2QQhtkF90EpbOoiLRIjlE5ymW1VbMAKXU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Tk6RJbMHalAj8Tp1/kdQw39Ie/imvaxkRVrFrJjf83J7bkWYPgN/RHc6QDA1L1/t0
         z+22Am2AK52EaxI/LJbYrcUxYQHUIgIVx8E+HigPAwnxoeAWRVOfhIzjFFQQY/Zw+Y
         L/r+kFbHtN1MC4ilwIZQ4Yoo6MuwF5YokIXyB85Vl2sELURjcCEIFt138pxVhcZ7oF
         yA3jJkyv/DRnvg7J7+6v8ca0vleDjYDq6uIRczUw135JUXy984NFOW0ok8GTYsoado
         77iAlTkHKUW+BDkPKoweHJBfWqM5gS06ZDdegZDWO9IKno72YAgYt+9AAV9e1yejzw
         sWo/A3xxf1gcw==
Received: by mail-vs1-f49.google.com with SMTP id d187so6797213vsd.6;
        Mon, 26 Sep 2022 07:52:18 -0700 (PDT)
X-Gm-Message-State: ACrzQf2W7u9a2tt5Tkr+H0T910FFL1iRBVrv/sTdkfBfiB7RlnTNsMwA
        0uXJ4PJxWup4lQOTZaZCt8eSnzLHul46KuDWDA==
X-Google-Smtp-Source: AMsMyM6A4G2VcWkO0zSLltuACdwFlc6zLZwHVE03TNWf8kj1nI9vAIwsB/GOnQVGeoo8Me9LSXI2N6k2vK9MmxSy5SE=
X-Received: by 2002:a05:6102:3211:b0:398:87ba:a1a6 with SMTP id
 r17-20020a056102321100b0039887baa1a6mr9369144vsf.0.1664203937059; Mon, 26 Sep
 2022 07:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1663254344.git.chiaen_wu@richtek.com> <9382254831bb6ed8c228398a68896b0e8e61c7c4.1663254344.git.chiaen_wu@richtek.com>
In-Reply-To: <9382254831bb6ed8c228398a68896b0e8e61c7c4.1663254344.git.chiaen_wu@richtek.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 26 Sep 2022 09:52:06 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+Zkgfq0q_XgpLEjHLPGSuG06L6y5YbzbiberNMWtAuJw@mail.gmail.com>
Message-ID: <CAL_Jsq+Zkgfq0q_XgpLEjHLPGSuG06L6y5YbzbiberNMWtAuJw@mail.gmail.com>
Subject: Re: [PATCH v11 1/8] dt-bindings: power: supply: Add MediaTek MT6370 Charger
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     pavel@ucw.cz, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sre@kernel.org, jic23@kernel.org,
        lars@metafoo.de, broonie@kernel.org, mazziesaccount@gmail.com,
        andriy.shevchenko@linux.intel.com, chiaen_wu@richtek.com,
        alice_chen@richtek.com, cy_huang@richtek.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        szunichen@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 4:49 AM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
>
> From: ChiaEn Wu <chiaen_wu@richtek.com>
>
> Add MediaTek MT6370 Charger binding documentation.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> ---
> v11
> - Add more detailed description of irqs.
> - Adujust the order of irqs
> ---
>  .../power/supply/mediatek,mt6370-charger.yaml      | 96 ++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/mediatek,mt6370-charger.yaml
>
> diff --git a/Documentation/devicetree/bindings/power/supply/mediatek,mt6370-charger.yaml b/Documentation/devicetree/bindings/power/supply/mediatek,mt6370-charger.yaml
> new file mode 100644
> index 0000000..fd491c5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/mediatek,mt6370-charger.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/mediatek,mt6370-charger.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT6370 Battery Charger
> +
> +maintainers:
> +  - ChiaEn Wu <chiaen_wu@richtek.com>
> +
> +description: |
> +  This module is part of the MT6370 MFD device.
> +  Provides Battery Charger, Boost for OTG devices and BC1.2 detection.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6370-charger
> +
> +  interrupts:
> +    description: |
> +      Specify what irqs are needed to be handled by MT6370 Charger driver.
> +      We need to use the IRQ "MT6370_IRQ_OVPCTRL_UVP_D" to know when USB
> +      is plugged in, and then the driver will enable BC1.2 detection.
> +      After the hardware of MT6370 completes the BC1.2 detection,
> +      IRQ "MT6370_IRQ_ATTACH" will be triggered, and the driver will know
> +      the result of BC1.2 detection.
> +      When the IRQ "MT6370_IRQ_CHG_MIVR" is triggered, it means that the
> +      hardware enters the "Minimum Input Voltage Regulation loop" and
> +      a workaround needs to be applied at this time.
> +      In summary, "MT6370_IRQ_OVPCTRL_UVP_D", "MT6370_IRQ_ATTACH" and
> +      "MT6370_IRQ_CHG_MIVR" are required in this charger driver.
> +    items:
> +      - description: irq of "USB is plugged in"
> +      - description: irq of "BC1.2 is done"
> +      - description: irq of "Minimum Input Voltage Regulation loop is active"
> +
> +  interrupt-names:
> +    items:
> +      - const: uvp_d_evt
> +      - const: attach_i
> +      - const: mivr

Now warning in linux-next:

/builds/robherring/linux-dt/Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb:
charger: interrupt-names:0: 'uvp_d_evt' was expected
 From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/power/supply/mediatek,mt6370-charger.yaml
/builds/robherring/linux-dt/Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb:
charger: interrupt-names:1: 'attach_i' was expected
 From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/power/supply/mediatek,mt6370-charger.yaml
