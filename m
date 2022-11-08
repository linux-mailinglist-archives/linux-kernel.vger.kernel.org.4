Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC27B621F52
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 23:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiKHWar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 17:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKHWaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 17:30:18 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EC8103D;
        Tue,  8 Nov 2022 14:30:11 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id a7-20020a056830008700b0066c82848060so9026078oto.4;
        Tue, 08 Nov 2022 14:30:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R1WKX3mhauPH6bKxydCd7dq3bfOqHAw8fJeX48VwC0I=;
        b=o+p7g2O1naByvyIf/EQAQWapsFb0Mx1S+5ZhFk489g7bZkEtCFnQ3rTxt4xj8i3UWt
         MMVU1h2L/812K+ffkx20M9QuJQUlIZCTvx8SSOrtv/WoXM4u5qoe0cGwr+eIjaYxoxzF
         NEGdABocQa5sNPUmc2NV1k3f7tKi2AVSkGzjXWk4anfct/W+20luTckU5tcrqlQetnbn
         4fngSrfEqTkcQF4p1T8nwRpGPwMQOo9XGBC9AFmKdu+UwNxiNx5EZxtxusk3gfUTi4Ub
         YUTTd1xBAoKbZJ9+zV/PEzsPQY3fqN0MuuQftam3rmItcM4TxjQkz3bny7fjsiI3vgqO
         Yinw==
X-Gm-Message-State: ANoB5pntdCGMDEefNXpe91BB3LBM1derPF3DL+tIS2JYZXkeZGg5IZL5
        n7ehDf0SN35UsxDd6e1H7w==
X-Google-Smtp-Source: AA0mqf4zvuBgBQtWRjglf80mZSS/pe7Lb0MVGC15SN46DgXXn1AcWsYO5Yj90DM7DAAiaxP3BQJhUA==
X-Received: by 2002:a9d:4814:0:b0:66d:81b:f06 with SMTP id c20-20020a9d4814000000b0066d081b0f06mr223823otf.297.1667946611045;
        Tue, 08 Nov 2022 14:30:11 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ca1-20020a056830610100b0066ca61230casm4099653otb.8.2022.11.08.14.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 14:30:10 -0800 (PST)
Received: (nullmailer pid 4095488 invoked by uid 1000);
        Tue, 08 Nov 2022 22:30:08 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Lee Jones <lee@kernel.org>, linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-leds@vger.kernel.org, linux-input@vger.kernel.org,
        Chen Zhong <chen.zhong@mediatek.com>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>
In-Reply-To: <20221005-mt6357-support-v4-4-5d2bb58e6087@baylibre.com>
References: <20221005-mt6357-support-v4-0-5d2bb58e6087@baylibre.com>
 <20221005-mt6357-support-v4-4-5d2bb58e6087@baylibre.com>
Message-Id: <166794645715.4092263.2351084357250073444.robh@kernel.org>
Subject: Re: [PATCH v4 4/9] dt-bindings: mfd: mediatek: Add bindings for MT6357 PMIC
Date:   Tue, 08 Nov 2022 16:30:08 -0600
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 08 Nov 2022 19:43:39 +0100, Alexandre Mergnat wrote:
> Currently, almost all MT63XX PMIC are documented mfd/mt6397.txt.
> Unfortunately, the PMICs haven't always similar HW sub-features.
> To have a better human readable schema, I chose to make one PMIC schema
> to match the exact HW capabilities instead of convert mt6397.txt to
> mediatek,mt63xx.yaml and put a bunch of properties behind
> "if contain ... then ..."
> 
> - add interrupt property
> - change property refs to match with new yaml documentation
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  .../devicetree/bindings/mfd/mediatek,mt6357.yaml   | 102 +++++++++++++++++++++
>  1 file changed, 102 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/rtc/mediatek,mt6397-rtc.yaml
Error: Documentation/devicetree/bindings/mfd/mediatek,mt6357.example.dts:26.35-36 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:406: Documentation/devicetree/bindings/mfd/mediatek,mt6357.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1492: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

