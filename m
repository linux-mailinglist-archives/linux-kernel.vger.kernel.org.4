Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DB064CCFC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 16:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238785AbiLNPXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 10:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238760AbiLNPXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 10:23:08 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E6C186FD;
        Wed, 14 Dec 2022 07:23:07 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id n205so2879075oib.1;
        Wed, 14 Dec 2022 07:23:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ouDI6cnOaIoztk2PRALWy4IKONuGF1DSjCqpxbYNJxk=;
        b=EZCNNcD3mUIsxutMw6KEJ6hR9vxkBucPxl8VtmEJdsWwe3AXuIAazEFa9JGnhCTJZp
         QLQcesXv2ZrTdIzI7btfpg2K+vnVrz+cUKaRn9TpWzbSYVseGZT+u+Yg97J9uo/xg7I6
         TaLSUT4/iZ8HmolvaArLJEd73ciMxLYYiiYDdLnmei/Ni2b+WdE6K37DFDQ/93E5i/CF
         H7zADkW48OaSUz/kFGuWXlJkrc9kNUMXPfeJ2S8vm7t+uSBojJs0KKSakkRBiTzOQ9fL
         v0lZYsJGBEnxa18pOpGAJG4pdNKLcADPS5nlA4L9DxiBFBULjClbXMGcZIDMfW3KNtde
         wSKw==
X-Gm-Message-State: ANoB5pk+pDUq4THY/KQEdjToJKcqc+ccztMthme9rmDkK+rwGjpCeC+d
        ckf/NQkBtRxfD8hNtWFEbw==
X-Google-Smtp-Source: AA0mqf4oHWFQDFbHrb0un5jDmskwu4sWe12M9AHaugqiwUAK2YPl2aiDgHY2kxekG6aUz82yumTWYw==
X-Received: by 2002:aca:e18b:0:b0:35a:5645:171a with SMTP id y133-20020acae18b000000b0035a5645171amr12256377oig.13.1671031386915;
        Wed, 14 Dec 2022 07:23:06 -0800 (PST)
Received: from robh_at_kernel.org (rrcs-98-6-157-194.sw.biz.rr.com. [98.6.157.194])
        by smtp.gmail.com with ESMTPSA id 13-20020aca0f0d000000b0035e461d9b1bsm5728492oip.50.2022.12.14.07.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 07:23:06 -0800 (PST)
Received: (nullmailer pid 1084187 invoked by uid 1000);
        Wed, 14 Dec 2022 15:23:05 -0000
Date:   Wed, 14 Dec 2022 09:23:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bernhard =?iso-8859-1?Q?Rosenkr=E4nzer?= <bero@baylibre.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        khilman@baylibre.com
Subject: Re: [PATCH v5 0/7] Add minimal MT8365 and MT8365-EVK support
Message-ID: <20221214152305.GA1080797-robh@kernel.org>
References: <20221213234346.2868828-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221213234346.2868828-1-bero@baylibre.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 12:43:39AM +0100, Bernhard Rosenkränzer wrote:
> This adds minimal support for the MediaTek 8365 SOC and the EVK reference
> board, allowing the board to boot to initramfs with serial port I/O.
> 
> v5:
>   - Reorder top-level entries in mediatek,mt8365-pinctrl.yaml to match
>     example-schema
>   - Use consistent quotes
> 
> v4:
>   - Remove pins-are-numbered references that have been holding things up
>     now that the patches removing it from dt-bindings have landed in linux-next
> 
> v3:
>   - Remove a number of components that are not yet supported (they will
>     come back alongside the corresponding drivers)
>   - Address issues found by dt_binding_check (mostly fixing pinctrl
>     bindings)
>   - Address issues pointed out in comments
>   - Reorder patches
> 
> v2:
>   - Add missing dt-bindings documentation
>   - Small cleanups addressing issues in v1 pointed out by Krzysztof Kozlowski
> 
> Bernhard Rosenkränzer (4):
>   dt-bindings: arm64: dts: mediatek: Add mt8365-evk board
>   dt-bindings: irq: mtk, sysirq: add support for mt8365
>   dt-bindings: mfd: syscon: Add mt8365-syscfg
>   dt-bindings: pinctrl: add bindings for Mediatek MT8365 SoC
> 
> Fabien Parent (3):
>   dt-bindings: usb: mediatek,mtu3: add MT8365 SoC bindings
>   dt-bindings: usb: mediatek,mtk-xhci: add MT8365 SoC bindings
>   arm64: dts: mediatek: Initial mt8365-evk support
> 
>  .../devicetree/bindings/arm/mediatek.yaml     |   4 +
>  .../interrupt-controller/mediatek,sysirq.txt  |   1 +
>  .../devicetree/bindings/mfd/syscon.yaml       |   1 +
>  .../pinctrl/mediatek,mt8365-pinctrl.yaml      | 197 ++++++++++
>  .../bindings/usb/mediatek,mtk-xhci.yaml       |   1 +
>  .../bindings/usb/mediatek,mtu3.yaml           |   1 +
>  arch/arm64/boot/dts/mediatek/Makefile         |   1 +
>  arch/arm64/boot/dts/mediatek/mt8365-evk.dts   | 163 +++++++++
>  arch/arm64/boot/dts/mediatek/mt8365.dtsi      | 343 ++++++++++++++++++
>  9 files changed, 712 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-evk.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8365.dtsi

You've missed the subsystem maintainers on this series. gregkh/linux-usb 
for USB for example. They can pick up the individual patches.

Rob
