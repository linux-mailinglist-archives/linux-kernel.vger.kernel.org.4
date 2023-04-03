Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116836D50A1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbjDCSdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbjDCScy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:32:54 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E763AB7;
        Mon,  3 Apr 2023 11:32:51 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-17786581fe1so31789910fac.10;
        Mon, 03 Apr 2023 11:32:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680546771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYyVy/snGJqjQZr7MOg2KuFtqjR1UL00/hKQM++ILHc=;
        b=xDunxG8BzkJ73H9RCkigypI4qnknRwiLD235fTpMcRdgDVNgIN0GbtZ/TKZlC8aDDO
         mf8jnLhu3LpS7R8eaRlc7LZ4z9NOEiDQr4cKppnNnniG/pcv29l3/xWDvpPGsWVPine9
         KppMJ3C9xGp+fzr5xL7Z2G4hEFI65trtE/Qw9Eh2O7TeyLORcTDD4nzeVzLAbW5P60OV
         84jlcUHU35FTiZ2X4YOWx5/z4U6Ud5UkxOGkegrqTMT0k9Y0XIIyBREe/6/9MtVlY/n+
         a6jqDXR8+cYdwy8Zg2WJdJnIZ998uT/rbMfqbtwnef9IlZi62G09z/zogZAoBhLSkbo+
         onhA==
X-Gm-Message-State: AAQBX9f2suVqiXXfDFZkUjlCRnv5yh3mYNLmX1cjCmIrEvMyld2LPRJi
        KXyu5oHwEToPa+at0GpcBw==
X-Google-Smtp-Source: AKy350blJmcdZF5R/4BqOsx8DNqeMLH92xBA8mK6SNqOrYr7M9L0L5nMoc8O2STh58ZO+5pukMg3Tg==
X-Received: by 2002:a05:6870:a40f:b0:177:a3dd:a92d with SMTP id m15-20020a056870a40f00b00177a3dda92dmr150224oal.7.1680546771133;
        Mon, 03 Apr 2023 11:32:51 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id uq11-20020a056870df0b00b00176d49bb898sm3770737oab.44.2023.04.03.11.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 11:32:50 -0700 (PDT)
Received: (nullmailer pid 1335330 invoked by uid 1000);
        Mon, 03 Apr 2023 18:32:49 -0000
Date:   Mon, 3 Apr 2023 13:32:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v5] dt-bindings: timer: convert
 timer/amlogic,meson6-timer.txt to dt-schema
Message-ID: <168054670780.1333984.6325350392024796667.robh@kernel.org>
References: <20221117-b4-amlogic-bindings-convert-v5-1-63781bed4452@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117-b4-amlogic-bindings-convert-v5-1-63781bed4452@linaro.org>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 03 Apr 2023 09:24:06 +0200, Neil Armstrong wrote:
> Convert the Amlogic Meson6 SoCs Timer Controller bindings to dt-schema.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Batch conversion of the following bindings:
> - amlogic-efuse.txt
> - amlogic-meson-mx-efuse.txt
> - meson-wdt.txt
> - meson-ir.txt
> - rtc-meson.txt
> - amlogic,meson6-timer.txt
> - amlogic,meson-pcie.txt
> 
> Martin Blumenstingl was also added as bindings maintainer for Meson6/8/8b
> related bindings.
> 
> Remaining conversions:
> - meson,pinctrl.txt
> - pwm-meson.txt
> - amlogic,meson-gpio-intc.txt
> - amlogic,meson-mx-sdio.txt
> - rtc-meson-vrtc.txt
> - amlogic,axg-sound-card.txt
> - amlogic,axg-fifo.txt
> - amlogic,axg-pdm.txt
> - amlogic,axg-spdifout.txt
> - amlogic,axg-tdm-formatters.txt
> - amlogic,axg-spdifin.txt
> - amlogic,axg-tdm-iface.txt
> - amlogic,g12a-tohdmitx.txt
> - amlogic,axg-audio-clkc.txt
> - amlogic,gxbb-clkc.txt
> - amlogic,gxbb-aoclkc.txt
> - amlogic,meson8b-clkc.txt
> ---
> Changes in v5:
> - Removed applied patches
> - Link to v4: https://lore.kernel.org/r/20221117-b4-amlogic-bindings-convert-v4-0-34e623dbf789@linaro.org
> 
> Changes in v4:
> - Rebased on v6.3-rc1
> - Added Reviewed-by
> - Removed applied patch
> - Link to v3: https://lore.kernel.org/r/20221117-b4-amlogic-bindings-convert-v3-0-e28dd31e3bed@linaro.org
> 
> Changes in v3:
> - Dropped applied patches
> - Added acked/reviewed-by tags
> - patch 3: removed invalid secure-monitor property
> - patch 4: added a note on the commit message about the meson8 compatible
> - patch 9: fixed mmc compatible bindings
> - patch 1-: unified PCIe instead on PCIE + PCIe
> - Link to v2: https://lore.kernel.org/r/20221117-b4-amlogic-bindings-convert-v2-0-36ad050bb625@linaro.org
> 
> Changes in v2:
> - rebased on v6.2-rc1
> - patch 1: fixed power-controller, added const: amlogic,meson-gx-sm
> - patch 2: added const: amlogic,meson-gx-efuse, fixed secure-monitor type
> - patch 3: updated example subnodes to match reality
> - patch 4: added reviewed-by, added interrupts, added const: amlogic,meson8m2-wdt
> - patch 5: added reviewed-by, added const: amlogic,meson-gx-ir
> - patch 6: dropped applied
> - patch 7: dropped patch, replaced with deprecated in the title of the TXt bindings
> - patch 8: fixed title, added reviewed-by, added interrupt description
> - patch 9: fixed example indent, added reviewed-by
> - patch 10: fixed const: amlogic,meson-gx-mmc case, fixed indentation
> - patch 11: added reviewed-by, fixed title, fixed bindings after rebase, added clocks/clock-names as required
> - patch 12: added reviewed-by
> - Link to v1: https://lore.kernel.org/r/20221117-b4-amlogic-bindings-convert-v1-0-3f025599b968@linaro.org
> ---
>  .../bindings/timer/amlogic,meson6-timer.txt        | 22 ---------
>  .../bindings/timer/amlogic,meson6-timer.yaml       | 54 ++++++++++++++++++++++
>  2 files changed, 54 insertions(+), 22 deletions(-)
> 

Applied, thanks!

