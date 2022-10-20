Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CF96060B6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 14:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiJTM4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 08:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiJTM4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 08:56:25 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE3A147D12;
        Thu, 20 Oct 2022 05:56:24 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id j188so22731305oih.4;
        Thu, 20 Oct 2022 05:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NEMOcZmNs8RQ67kXErCppy6OhsBrnXpckQEXUmNr7I4=;
        b=l0tgNyJztYzWINVNEw3yr2MIte465annmZnJ3dEJ2JF3OhnvKJEYlSZTpekbwd+kra
         oMJMAVSThQS3Xmp/jrlm/5NufaZ47lFY4f2jmXX/iM4Jg+BQ0pixUb0kllAx9loHB3Q5
         3jJM2tw7wQQuYqo/IcAOBRJ6G/eQ0ieFhbIl42ag5A/oSQysoKTg7TaEjJdyntKx0eWe
         2S7zOFAROBXXchqt71vojmmn4O0PHdLhORlGAfaScMRPYb9t2jk/lyDvdkaDLbc3WjQs
         SyyFjHiCqwAuXEE+9AJNt7d2k/jRonJuhhOgqv7aYyBgce6zvvBdcgg0zvre9zCJZjXb
         oN2A==
X-Gm-Message-State: ACrzQf0axccpT7nrEk5dJ0uQcVlMJIXEU9Rd3nwf9JJE/NImZlN8Uwj5
        o663wSPxn5Gna3mflxuiwA==
X-Google-Smtp-Source: AMsMyM6w1xk4tPAvBpUUEH4Ey72ivyy31TkXSLBRpnZzvfiDeaH9BZr77tOs+w+kQQLYF5rvuIZJtg==
X-Received: by 2002:a05:6808:1c0f:b0:355:4433:d3ee with SMTP id ch15-20020a0568081c0f00b003554433d3eemr8205757oib.96.1666270583375;
        Thu, 20 Oct 2022 05:56:23 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y13-20020a544d8d000000b0035437f4deefsm7736457oix.26.2022.10.20.05.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 05:56:22 -0700 (PDT)
Received: (nullmailer pid 1111921 invoked by uid 1000);
        Thu, 20 Oct 2022 12:56:23 -0000
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Peng Fan <peng.fan@nxp.com>, krzysztof.kozlowski+dt@linaro.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        shawnguo@kernel.org, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-spi@vger.kernel.org, s.hauer@pengutronix.de,
        robh+dt@kernel.org
In-Reply-To: <20221020103158.2273874-2-peng.fan@oss.nxp.com>
References: <20221020103158.2273874-1-peng.fan@oss.nxp.com> <20221020103158.2273874-2-peng.fan@oss.nxp.com>
Message-Id: <166626975547.1096642.8539184924637719626.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: fsl-imx-cspi: update i.MX8MP binding
Date:   Thu, 20 Oct 2022 07:56:23 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022 18:31:57 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8MP ECSPI is derived from i.MX6UL, so update the binding.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/spi/fsl-imx-cspi.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


spi@30630000: Unevaluated properties are not allowed ('num-chipselects' was unexpected)
	arch/arm/boot/dts/imx7d-flex-concentrator.dtb
	arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dtb

spi@30820000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dtb
	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dtb
	arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb
	arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb
	arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dtb
	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dev.dtb

spi@30820000: Unevaluated properties are not allowed ('compatible' was unexpected)
	arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dtb
	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dtb
	arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb
	arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb
	arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dtb
	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dev.dtb

spi@30830000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dtb
	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dtb
	arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb
	arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb
	arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dtb
	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dev.dtb

spi@30830000: Unevaluated properties are not allowed ('compatible' was unexpected)
	arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dtb
	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dtb
	arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb
	arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb
	arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dtb
	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dev.dtb

spi@30830000: Unevaluated properties are not allowed ('num-chipselects' was unexpected)
	arch/arm/boot/dts/imx7d-flex-concentrator.dtb
	arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dtb

spi@30840000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dtb
	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dtb
	arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb
	arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb
	arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dtb
	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dev.dtb

spi@30840000: Unevaluated properties are not allowed ('compatible' was unexpected)
	arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dtb
	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dtb
	arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb
	arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb
	arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dtb
	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dev.dtb

spi@43fa4000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dtb
	arch/arm/boot/dts/imx25-karo-tx25.dtb
	arch/arm/boot/dts/imx25-pdk.dtb

spi@43fa4000: Unevaluated properties are not allowed ('compatible' was unexpected)
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dtb
	arch/arm/boot/dts/imx25-karo-tx25.dtb
	arch/arm/boot/dts/imx25-pdk.dtb

spi@50004000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dtb
	arch/arm/boot/dts/imx25-karo-tx25.dtb
	arch/arm/boot/dts/imx25-pdk.dtb

spi@50004000: Unevaluated properties are not allowed ('compatible' was unexpected)
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dtb
	arch/arm/boot/dts/imx25-karo-tx25.dtb
	arch/arm/boot/dts/imx25-pdk.dtb

spi@50010000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dtb
	arch/arm/boot/dts/imx25-karo-tx25.dtb
	arch/arm/boot/dts/imx25-pdk.dtb
	arch/arm/boot/dts/imx53-ard.dtb
	arch/arm/boot/dts/imx53-cx9020.dtb
	arch/arm/boot/dts/imx53-kp-ddc.dtb
	arch/arm/boot/dts/imx53-kp-hsc.dtb
	arch/arm/boot/dts/imx53-m53evk.dtb
	arch/arm/boot/dts/imx53-m53menlo.dtb
	arch/arm/boot/dts/imx53-mba53.dtb
	arch/arm/boot/dts/imx53-ppd.dtb
	arch/arm/boot/dts/imx53-qsb.dtb
	arch/arm/boot/dts/imx53-qsrb.dtb
	arch/arm/boot/dts/imx53-smd.dtb
	arch/arm/boot/dts/imx53-tx53-x03x.dtb
	arch/arm/boot/dts/imx53-tx53-x13x.dtb
	arch/arm/boot/dts/imx53-usbarmory.dtb
	arch/arm/boot/dts/imx53-voipac-bsb.dtb

spi@50010000: Unevaluated properties are not allowed ('compatible' was unexpected)
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dtb
	arch/arm/boot/dts/imx25-karo-tx25.dtb
	arch/arm/boot/dts/imx25-pdk.dtb
	arch/arm/boot/dts/imx53-ard.dtb
	arch/arm/boot/dts/imx53-cx9020.dtb
	arch/arm/boot/dts/imx53-kp-ddc.dtb
	arch/arm/boot/dts/imx53-kp-hsc.dtb
	arch/arm/boot/dts/imx53-m53evk.dtb
	arch/arm/boot/dts/imx53-m53menlo.dtb
	arch/arm/boot/dts/imx53-mba53.dtb
	arch/arm/boot/dts/imx53-ppd.dtb
	arch/arm/boot/dts/imx53-qsb.dtb
	arch/arm/boot/dts/imx53-qsrb.dtb
	arch/arm/boot/dts/imx53-smd.dtb
	arch/arm/boot/dts/imx53-tx53-x03x.dtb
	arch/arm/boot/dts/imx53-tx53-x13x.dtb
	arch/arm/boot/dts/imx53-usbarmory.dtb
	arch/arm/boot/dts/imx53-voipac-bsb.dtb

spi@63fac000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/imx53-ard.dtb
	arch/arm/boot/dts/imx53-cx9020.dtb
	arch/arm/boot/dts/imx53-kp-ddc.dtb
	arch/arm/boot/dts/imx53-kp-hsc.dtb
	arch/arm/boot/dts/imx53-m53evk.dtb
	arch/arm/boot/dts/imx53-m53menlo.dtb
	arch/arm/boot/dts/imx53-mba53.dtb
	arch/arm/boot/dts/imx53-ppd.dtb
	arch/arm/boot/dts/imx53-qsb.dtb
	arch/arm/boot/dts/imx53-qsrb.dtb
	arch/arm/boot/dts/imx53-smd.dtb
	arch/arm/boot/dts/imx53-tx53-x03x.dtb
	arch/arm/boot/dts/imx53-tx53-x13x.dtb
	arch/arm/boot/dts/imx53-usbarmory.dtb
	arch/arm/boot/dts/imx53-voipac-bsb.dtb

spi@63fac000: Unevaluated properties are not allowed ('compatible' was unexpected)
	arch/arm/boot/dts/imx53-ard.dtb
	arch/arm/boot/dts/imx53-cx9020.dtb
	arch/arm/boot/dts/imx53-kp-ddc.dtb
	arch/arm/boot/dts/imx53-kp-hsc.dtb
	arch/arm/boot/dts/imx53-m53evk.dtb
	arch/arm/boot/dts/imx53-m53menlo.dtb
	arch/arm/boot/dts/imx53-mba53.dtb
	arch/arm/boot/dts/imx53-ppd.dtb
	arch/arm/boot/dts/imx53-qsb.dtb
	arch/arm/boot/dts/imx53-qsrb.dtb
	arch/arm/boot/dts/imx53-smd.dtb
	arch/arm/boot/dts/imx53-tx53-x03x.dtb
	arch/arm/boot/dts/imx53-tx53-x13x.dtb
	arch/arm/boot/dts/imx53-usbarmory.dtb
	arch/arm/boot/dts/imx53-voipac-bsb.dtb

spi@63fc0000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/imx50-evk.dtb
	arch/arm/boot/dts/imx50-kobo-aura.dtb
	arch/arm/boot/dts/imx53-ard.dtb
	arch/arm/boot/dts/imx53-cx9020.dtb
	arch/arm/boot/dts/imx53-kp-ddc.dtb
	arch/arm/boot/dts/imx53-kp-hsc.dtb
	arch/arm/boot/dts/imx53-m53evk.dtb
	arch/arm/boot/dts/imx53-m53menlo.dtb
	arch/arm/boot/dts/imx53-mba53.dtb
	arch/arm/boot/dts/imx53-ppd.dtb
	arch/arm/boot/dts/imx53-qsb.dtb
	arch/arm/boot/dts/imx53-qsrb.dtb
	arch/arm/boot/dts/imx53-smd.dtb
	arch/arm/boot/dts/imx53-tx53-x03x.dtb
	arch/arm/boot/dts/imx53-tx53-x13x.dtb
	arch/arm/boot/dts/imx53-usbarmory.dtb
	arch/arm/boot/dts/imx53-voipac-bsb.dtb

spi@63fc0000: Unevaluated properties are not allowed ('compatible' was unexpected)
	arch/arm/boot/dts/imx50-evk.dtb
	arch/arm/boot/dts/imx50-kobo-aura.dtb
	arch/arm/boot/dts/imx53-ard.dtb
	arch/arm/boot/dts/imx53-cx9020.dtb
	arch/arm/boot/dts/imx53-kp-ddc.dtb
	arch/arm/boot/dts/imx53-kp-hsc.dtb
	arch/arm/boot/dts/imx53-m53evk.dtb
	arch/arm/boot/dts/imx53-m53menlo.dtb
	arch/arm/boot/dts/imx53-mba53.dtb
	arch/arm/boot/dts/imx53-ppd.dtb
	arch/arm/boot/dts/imx53-qsb.dtb
	arch/arm/boot/dts/imx53-qsrb.dtb
	arch/arm/boot/dts/imx53-smd.dtb
	arch/arm/boot/dts/imx53-tx53-x03x.dtb
	arch/arm/boot/dts/imx53-tx53-x13x.dtb
	arch/arm/boot/dts/imx53-usbarmory.dtb
	arch/arm/boot/dts/imx53-voipac-bsb.dtb

spi@83fc0000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/imx51-apf51dev.dtb
	arch/arm/boot/dts/imx51-apf51.dtb
	arch/arm/boot/dts/imx51-babbage.dtb
	arch/arm/boot/dts/imx51-digi-connectcore-jsk.dtb
	arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dtb
	arch/arm/boot/dts/imx51-ts4800.dtb
	arch/arm/boot/dts/imx51-zii-rdu1.dtb
	arch/arm/boot/dts/imx51-zii-scu2-mezz.dtb
	arch/arm/boot/dts/imx51-zii-scu3-esb.dtb

spi@83fc0000: Unevaluated properties are not allowed ('compatible' was unexpected)
	arch/arm/boot/dts/imx51-apf51dev.dtb
	arch/arm/boot/dts/imx51-apf51.dtb
	arch/arm/boot/dts/imx51-babbage.dtb
	arch/arm/boot/dts/imx51-digi-connectcore-jsk.dtb
	arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dtb
	arch/arm/boot/dts/imx51-ts4800.dtb
	arch/arm/boot/dts/imx51-zii-rdu1.dtb
	arch/arm/boot/dts/imx51-zii-scu2-mezz.dtb
	arch/arm/boot/dts/imx51-zii-scu3-esb.dtb

