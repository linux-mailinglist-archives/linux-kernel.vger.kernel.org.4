Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40A65F9E43
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 14:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbiJJMBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 08:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbiJJMBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 08:01:00 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B460346233;
        Mon, 10 Oct 2022 05:00:55 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id n83so12431403oif.11;
        Mon, 10 Oct 2022 05:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BB5C5dB8R9ENRGYGbuAkJYdFcwZHeHFPMA7Qnx1N4Po=;
        b=nve1PcMDHBYHJo4krQ2UT0takT8GT7eDzrYWWqge7lVbRCCNcfFDVl0a/KA9YztZny
         PrugzLQNO/kMDXBzLgaCyJRiSb2R70zveGRUt7ckLCEo8c00uhDc3ku7c2S1NRis2Fsp
         8SMuTtaTECrpPrnFAfBL6rntzVHVeHSq77n33g2+2RJFyqMdQ3YZuMh/66dFGz94G2vG
         3bNetMqTxLPgK+NgwN3qpt9baZNpkqpr9TKJ0xomJD+/SSob+vCpQo4tJfB3WJvpkwl8
         2yjn/AoNERIF7hApW1mec6IPvKWlcknDYKuTeJLNvCb4ZkiGXbHEvGv7VHKGHqPsG6Sc
         mm2w==
X-Gm-Message-State: ACrzQf2mJ4QBGUYd3KwnMnH24iZk7wsGIavT6teghAph8MvSy8PIeJUW
        hq0deGJv1tTBwQYXYxDTTg==
X-Google-Smtp-Source: AMsMyM7so91mjca1PxJAqekTE4APV934U2Cp5biFwGAriDr6yHsVVJRuVRhBi5ZKmglwrRSdFidPVA==
X-Received: by 2002:a05:6808:1142:b0:350:cbdd:c9d4 with SMTP id u2-20020a056808114200b00350cbddc9d4mr8440348oiu.124.1665403254375;
        Mon, 10 Oct 2022 05:00:54 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r4-20020acaf304000000b0035179b87ba5sm4141187oih.20.2022.10.10.05.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 05:00:53 -0700 (PDT)
Received: (nullmailer pid 412152 invoked by uid 1000);
        Mon, 10 Oct 2022 12:00:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Peng Fan <peng.fan@nxp.com>, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        kernel@pengutronix.de, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
        shawnguo@kernel.org, festevam@gmail.com
In-Reply-To: <20221010101816.298334-6-peng.fan@oss.nxp.com>
References: <20221010101816.298334-1-peng.fan@oss.nxp.com> <20221010101816.298334-6-peng.fan@oss.nxp.com>
Message-Id: <166540306019.408420.11115678117503768156.robh@kernel.org>
Subject: Re: [PATCH 5/6] dt-bindings: usb: usbmisc-imx: add clocks property
Date:   Mon, 10 Oct 2022 07:00:53 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Oct 2022 18:18:15 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add optional clocks property
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/usb/usbmisc-imx.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


usbmisc@2184800: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/imx6sl-evk.dtb
	arch/arm/boot/dts/imx6sll-evk.dtb
	arch/arm/boot/dts/imx6sll-kobo-clarahd.dtb
	arch/arm/boot/dts/imx6sll-kobo-librah2o.dtb
	arch/arm/boot/dts/imx6sl-tolino-shine2hd.dtb
	arch/arm/boot/dts/imx6sl-tolino-shine3.dtb
	arch/arm/boot/dts/imx6sl-tolino-vision5.dtb
	arch/arm/boot/dts/imx6sl-warp.dtb

usbmisc@32e40200: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb
	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtb
	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dtb
	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb
	arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dtb
	arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2.dtb
	arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dtb
	arch/arm64/boot/dts/freescale/imx8mn-ddr3l-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mn-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dtb
	arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dtb

usbmisc@32e50200: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb
	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtb
	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dtb
	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb
	arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb

