Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBB55FEEB4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 15:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiJNNeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 09:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJNNdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 09:33:55 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D992C1CCCDA;
        Fri, 14 Oct 2022 06:33:51 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id r13-20020a056830418d00b0065601df69c0so1843922otu.7;
        Fri, 14 Oct 2022 06:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kq5/ebrsEqAdq+lnMb1SAsxfcJticLXz1q7ZuOOQC6Y=;
        b=Zhac3L3483U6hp6//vy64J8s7DY93OpSziqYRYdrm4f1kSb9UzPEyUi48b0ghvuPuv
         BP4MXyjrcvfOioE92jJCwtNJY6WxKmiGzV9X+lwITLarPSBqMJggeS5SROfpHXBWE/v4
         86duklj6bu4Vp+Aopwhm+QNfmHBcmO+aCJpm5dFDTr70Fh26HQzrN33+AaI20bzD2bl+
         UOxoc6sG+niR7hAMjwRsAoXo+PXwx1kqAto19CuCwaiOH2+/m6obQ1VaDbsmQt9ryOcl
         zn+gQzU/ZMVM9iHfHDvk6IGfSCbdUYFxiVQOiRRabcXpT9U9cnhhUJmNVIbG878Eo3+a
         gpFw==
X-Gm-Message-State: ACrzQf0tHuvQMmJr/OKI9DGFlMs7bPu7x8U6XONrAE4IksrT6ha69HYb
        JV1GbQTeRHvGGw3z7cbMtQ==
X-Google-Smtp-Source: AMsMyM4snJ2dhsQfJcgGeNkepXUrpXQvek2C3C+Qg3MrK42fGYwjXIxLDmUmb9TTXyT2JokPTRX4Fw==
X-Received: by 2002:a05:6830:22cf:b0:661:a3ea:c010 with SMTP id q15-20020a05683022cf00b00661a3eac010mr2497906otc.156.1665754430886;
        Fri, 14 Oct 2022 06:33:50 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r4-20020a4ae5c4000000b004762a830156sm927945oov.32.2022.10.14.06.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 06:33:50 -0700 (PDT)
Received: (nullmailer pid 1785582 invoked by uid 1000);
        Fri, 14 Oct 2022 13:33:51 -0000
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, xu.yang_2@nxp.com,
        kernel@pengutronix.de, linux-imx@nxp.com, festevam@gmail.com,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        devicetree@vger.kernel.org, s.hauer@pengutronix.de, jun.li@nxp.com,
        robh+dt@kernel.org, gregkh@linuxfoundation.org, shawnguo@kernel.org
In-Reply-To: <20221014095148.2063669-7-peng.fan@oss.nxp.com>
References: <20221014095148.2063669-1-peng.fan@oss.nxp.com> <20221014095148.2063669-7-peng.fan@oss.nxp.com>
Message-Id: <166575377663.1772749.3652358895113916104.robh@kernel.org>
Subject: Re: [PATCH V2 6/6] dt-bindings: usb: ci-hdrc-usb2: add i.MX8DXL/M[M,N] support
Date:   Fri, 14 Oct 2022 08:33:51 -0500
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

On Fri, 14 Oct 2022 17:51:48 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX8MM/N compatible strings, which are compatible with i.MX7D.
> Add i.MX8DXL compatible string, which is compatible with i.MX7ULP.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


usb@10024000: 'clock-names' does not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm/boot/dts/imx27-apf27dev.dtb
	arch/arm/boot/dts/imx27-apf27.dtb
	arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dtb
	arch/arm/boot/dts/imx27-pdk.dtb
	arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dtb
	arch/arm/boot/dts/imx27-phytec-phycore-rdk.dtb

usb@10024000: clocks: [[1, 75], [1, 62], [1, 15]] is too long
	arch/arm/boot/dts/imx27-apf27dev.dtb
	arch/arm/boot/dts/imx27-apf27.dtb
	arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dtb
	arch/arm/boot/dts/imx27-pdk.dtb
	arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dtb
	arch/arm/boot/dts/imx27-phytec-phycore-rdk.dtb

usb@10024000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/imx27-apf27dev.dtb
	arch/arm/boot/dts/imx27-apf27.dtb
	arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dtb
	arch/arm/boot/dts/imx27-pdk.dtb
	arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dtb
	arch/arm/boot/dts/imx27-phytec-phycore-rdk.dtb

usb@10024200: 'clock-names' does not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm/boot/dts/imx27-apf27dev.dtb
	arch/arm/boot/dts/imx27-apf27.dtb
	arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dtb
	arch/arm/boot/dts/imx27-pdk.dtb
	arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dtb
	arch/arm/boot/dts/imx27-phytec-phycore-rdk.dtb

usb@10024200: clocks: [[1, 75], [1, 62], [1, 15]] is too long
	arch/arm/boot/dts/imx27-apf27dev.dtb
	arch/arm/boot/dts/imx27-apf27.dtb
	arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dtb
	arch/arm/boot/dts/imx27-pdk.dtb
	arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dtb
	arch/arm/boot/dts/imx27-phytec-phycore-rdk.dtb

usb@10024200: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/imx27-apf27dev.dtb
	arch/arm/boot/dts/imx27-apf27.dtb
	arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dtb
	arch/arm/boot/dts/imx27-pdk.dtb
	arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dtb
	arch/arm/boot/dts/imx27-phytec-phycore-rdk.dtb

usb@10024400: 'clock-names' does not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm/boot/dts/imx27-apf27dev.dtb
	arch/arm/boot/dts/imx27-apf27.dtb
	arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dtb
	arch/arm/boot/dts/imx27-pdk.dtb
	arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dtb
	arch/arm/boot/dts/imx27-phytec-phycore-rdk.dtb

usb@10024400: clocks: [[1, 75], [1, 62], [1, 15]] is too long
	arch/arm/boot/dts/imx27-apf27dev.dtb
	arch/arm/boot/dts/imx27-apf27.dtb
	arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dtb
	arch/arm/boot/dts/imx27-pdk.dtb
	arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dtb
	arch/arm/boot/dts/imx27-phytec-phycore-rdk.dtb

usb@10024400: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/imx27-apf27dev.dtb
	arch/arm/boot/dts/imx27-apf27.dtb
	arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dtb
	arch/arm/boot/dts/imx27-pdk.dtb
	arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dtb
	arch/arm/boot/dts/imx27-phytec-phycore-rdk.dtb

usb@12500000: reg: [[307232768, 512], [307233280, 512]] is too long
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb

usb@12500000: '#reset-cells', 'clock-names', 'reset-names', 'resets', 'ulpi' do not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb

usb@12520000: reg: [[307363840, 512], [307364352, 512]] is too long
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb

usb@12520000: '#reset-cells', 'clock-names', 'reset-names', 'resets', 'ulpi' do not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb

usb@12530000: reg: [[307429376, 512], [307429888, 512]] is too long
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb

usb@12530000: '#reset-cells', 'clock-names', 'reset-names', 'resets', 'ulpi' do not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb

usb@2184000: 'adp-disable', 'fsl,anatop', 'hnp-disable', 'srp-disable' do not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm/boot/dts/imx6sll-evk.dtb
	arch/arm/boot/dts/imx6sll-kobo-clarahd.dtb
	arch/arm/boot/dts/imx6sll-kobo-librah2o.dtb
	arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dtb
	arch/arm/boot/dts/imx6ul-kontron-n6310-s.dtb
	arch/arm/boot/dts/imx6ull-colibri-aster.dtb
	arch/arm/boot/dts/imx6ull-colibri-emmc-aster.dtb
	arch/arm/boot/dts/imx6ull-colibri-emmc-eval-v3.dtb
	arch/arm/boot/dts/imx6ull-colibri-emmc-iris.dtb
	arch/arm/boot/dts/imx6ull-colibri-emmc-iris-v2.dtb
	arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtb
	arch/arm/boot/dts/imx6ull-colibri-iris.dtb
	arch/arm/boot/dts/imx6ull-colibri-iris-v2.dtb
	arch/arm/boot/dts/imx6ull-colibri-wifi-aster.dtb
	arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dtb
	arch/arm/boot/dts/imx6ull-colibri-wifi-iris.dtb
	arch/arm/boot/dts/imx6ull-colibri-wifi-iris-v2.dtb
	arch/arm/boot/dts/imx6ull-tqma6ull2l-mba6ulx.dtb
	arch/arm/boot/dts/imx6ull-tqma6ull2-mba6ulx.dtb
	arch/arm/boot/dts/imx6ul-tqma6ul1-mba6ulx.dtb
	arch/arm/boot/dts/imx6ul-tqma6ul2l-mba6ulx.dtb
	arch/arm/boot/dts/imx6ul-tqma6ul2-mba6ulx.dtb
	arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dtb

usb@2184000: 'adp-disable', 'hnp-disable', 'srp-disable' do not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm/boot/dts/imx6dl-mba6a.dtb
	arch/arm/boot/dts/imx6dl-mba6b.dtb
	arch/arm/boot/dts/imx6dl-yapp4-draco.dtb
	arch/arm/boot/dts/imx6dl-yapp4-hydra.dtb
	arch/arm/boot/dts/imx6dl-yapp4-orion.dtb
	arch/arm/boot/dts/imx6dl-yapp4-ursa.dtb
	arch/arm/boot/dts/imx6q-bosch-acc.dtb
	arch/arm/boot/dts/imx6q-mba6a.dtb
	arch/arm/boot/dts/imx6q-mba6b.dtb
	arch/arm/boot/dts/imx6q-pistachio.dtb
	arch/arm/boot/dts/imx6qp-mba6b.dtb
	arch/arm/boot/dts/imx6qp-yapp4-crux-plus.dtb
	arch/arm/boot/dts/imx6q-var-dt6customboard.dtb
	arch/arm/boot/dts/imx6q-yapp4-crux.dtb
	arch/arm/boot/dts/imx6sl-tolino-shine2hd.dtb
	arch/arm/boot/dts/imx6sl-tolino-shine3.dtb
	arch/arm/boot/dts/imx6sl-tolino-vision5.dtb

usb@2184000: 'fsl,anatop' does not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm/boot/dts/imx6sx-nitrogen6sx.dtb
	arch/arm/boot/dts/imx6sx-sabreauto.dtb
	arch/arm/boot/dts/imx6sx-sdb.dtb
	arch/arm/boot/dts/imx6sx-sdb-mqs.dtb
	arch/arm/boot/dts/imx6sx-sdb-reva.dtb
	arch/arm/boot/dts/imx6sx-sdb-sai.dtb
	arch/arm/boot/dts/imx6sx-softing-vining-2000.dtb
	arch/arm/boot/dts/imx6sx-udoo-neo-basic.dtb
	arch/arm/boot/dts/imx6sx-udoo-neo-extended.dtb
	arch/arm/boot/dts/imx6sx-udoo-neo-full.dtb
	arch/arm/boot/dts/imx6ul-14x14-evk.dtb
	arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dtb
	arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dtb
	arch/arm/boot/dts/imx6ul-geam.dtb
	arch/arm/boot/dts/imx6ul-isiot-emmc.dtb
	arch/arm/boot/dts/imx6ul-isiot-nand.dtb
	arch/arm/boot/dts/imx6ull-14x14-evk.dtb
	arch/arm/boot/dts/imx6ul-liteboard.dtb
	arch/arm/boot/dts/imx6ull-jozacp.dtb
	arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dtb
	arch/arm/boot/dts/imx6ull-opos6uldev.dtb
	arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-emmc.dtb
	arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dtb
	arch/arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dtb
	arch/arm/boot/dts/imx6ull-phytec-tauri-emmc.dtb
	arch/arm/boot/dts/imx6ull-phytec-tauri-nand.dtb
	arch/arm/boot/dts/imx6ul-opos6uldev.dtb
	arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-emmc.dtb
	arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dtb
	arch/arm/boot/dts/imx6ul-pico-dwarf.dtb
	arch/arm/boot/dts/imx6ul-pico-hobbit.dtb
	arch/arm/boot/dts/imx6ul-pico-pi.dtb
	arch/arm/boot/dts/imx6ul-prti6g.dtb
	arch/arm/boot/dts/imx6ul-tx6ul-0010.dtb
	arch/arm/boot/dts/imx6ul-tx6ul-0011.dtb
	arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dtb
	arch/arm/boot/dts/imx6ulz-14x14-evk.dtb

usb@2184200: 'maximum-speed' does not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm/boot/dts/imx6qp-zii-rdu2.dtb
	arch/arm/boot/dts/imx6q-zii-rdu2.dtb

usb@2184200: 'reset-gpios' does not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm/boot/dts/imx6q-b450v3.dtb
	arch/arm/boot/dts/imx6q-b650v3.dtb
	arch/arm/boot/dts/imx6q-b850v3.dtb
	arch/arm/boot/dts/imx6q-dms-ba16.dtb
	arch/arm/boot/dts/imx6sx-nitrogen6sx.dtb

usb@2184400: 'fsl,anatop' does not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm/boot/dts/imx6sx-nitrogen6sx.dtb
	arch/arm/boot/dts/imx6sx-sabreauto.dtb
	arch/arm/boot/dts/imx6sx-sdb.dtb
	arch/arm/boot/dts/imx6sx-sdb-mqs.dtb
	arch/arm/boot/dts/imx6sx-sdb-reva.dtb
	arch/arm/boot/dts/imx6sx-sdb-sai.dtb
	arch/arm/boot/dts/imx6sx-softing-vining-2000.dtb
	arch/arm/boot/dts/imx6sx-udoo-neo-basic.dtb
	arch/arm/boot/dts/imx6sx-udoo-neo-extended.dtb
	arch/arm/boot/dts/imx6sx-udoo-neo-full.dtb

usb@30b10000: 'adp-disable', 'hnp-disable', 'srp-disable' do not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm/boot/dts/imx7d-mba7.dtb
	arch/arm/boot/dts/imx7s-mba7.dtb

usb@30b20000: 'adp-disable', 'hnp-disable', 'srp-disable' do not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm/boot/dts/imx7d-flex-concentrator.dtb
	arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dtb
	arch/arm/boot/dts/imx7d-mba7.dtb

usb@30b20000: 'hnp-disable', 'srp-disable' do not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm/boot/dts/imx7d-remarkable2.dtb

usb@32e40000: 'adp-disable', 'clock-names', 'hnp-disable', 'port', 'power-domains', 'srp-disable', 'usb-role-switch' do not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mn-ddr3l-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mn-evk.dtb

usb@32e40000: 'adp-disable', 'clock-names', 'hnp-disable', 'power-domains', 'srp-disable' do not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb
	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb

usb@32e40000: 'adp-disable', 'clock-names', 'power-domains', 'srp-disable' do not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dtb

usb@32e40000: 'clock-names', 'power-domains' do not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb
	arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtb
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dtb
	arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
	arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dtb
	arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2.dtb
	arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dtb
	arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dtb

usb@32e40000: 'clock-names', 'power-domains', 'usb-role-switch' do not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dtb
	arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dtb

usb@32e50000: 'adp-disable', 'clock-names', 'hnp-disable', 'power-domains', 'srp-disable' do not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dtb

usb@32e50000: 'clock-names', 'power-domains' do not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb
	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtb
	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb
	arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
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

usb@32e50000: 'clock-names', 'power-domains', 'usb1@1' do not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dtb

usb@40330000: 'adp-disable', 'hnp-disable', 'srp-disable' do not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm/boot/dts/imx7ulp-com.dtb
	arch/arm/boot/dts/imx7ulp-evk.dtb

usb@53ff4000: 'clock-names' does not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dtb
	arch/arm/boot/dts/imx25-karo-tx25.dtb
	arch/arm/boot/dts/imx25-pdk.dtb
	arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dtb
	arch/arm/boot/dts/imx35-pdk.dtb

usb@53ff4000: clocks: [[2, 9], [2, 70], [2, 8]] is too long
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dtb
	arch/arm/boot/dts/imx25-karo-tx25.dtb
	arch/arm/boot/dts/imx25-pdk.dtb

usb@53ff4000: clocks: [[2, 9], [2, 73], [2, 28]] is too long
	arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dtb
	arch/arm/boot/dts/imx35-pdk.dtb

usb@53ff4000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dtb
	arch/arm/boot/dts/imx35-pdk.dtb

usb@53ff4400: 'clock-names' does not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dtb
	arch/arm/boot/dts/imx35-pdk.dtb

usb@53ff4400: 'clock-names', 'maximum-speed' do not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dtb
	arch/arm/boot/dts/imx25-karo-tx25.dtb
	arch/arm/boot/dts/imx25-pdk.dtb

usb@53ff4400: clocks: [[2, 9], [2, 70], [2, 8]] is too long
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dtb
	arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dtb
	arch/arm/boot/dts/imx25-karo-tx25.dtb
	arch/arm/boot/dts/imx25-pdk.dtb

usb@53ff4400: clocks: [[2, 9], [2, 73], [2, 28]] is too long
	arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dtb
	arch/arm/boot/dts/imx35-pdk.dtb

usb@53ff4400: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dtb
	arch/arm/boot/dts/imx35-pdk.dtb

usb@73f80200: 'maximum-speed' does not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm/boot/dts/imx51-zii-rdu1.dtb

usb@78d9000: interrupts: [[0, 134, 4], [0, 140, 4]] is too long
	arch/arm64/boot/dts/qcom/apq8016-sbc.dtb
	arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dtb
	arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dtb
	arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dtb
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dtb
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dtb
	arch/arm64/boot/dts/qcom/msm8916-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dtb
	arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dtb
	arch/arm/boot/dts/qcom-apq8016-sbc.dtb
	arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dtb

usb@78d9000: reg: [[126717952, 512], [126718464, 512]] is too long
	arch/arm64/boot/dts/qcom/apq8016-sbc.dtb
	arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dtb
	arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dtb
	arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dtb
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dtb
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dtb
	arch/arm64/boot/dts/qcom/msm8916-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dtb
	arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dtb
	arch/arm/boot/dts/qcom-apq8016-sbc.dtb
	arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dtb

usb@78d9000: '#reset-cells', 'adp-disable', 'clock-names', 'hnp-disable', 'reset-names', 'resets', 'srp-disable', 'ulpi' do not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm64/boot/dts/qcom/apq8016-sbc.dtb
	arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dtb
	arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dtb
	arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dtb
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dtb
	arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dtb
	arch/arm64/boot/dts/qcom/msm8916-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dtb
	arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dtb
	arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dtb
	arch/arm/boot/dts/qcom-apq8016-sbc.dtb
	arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dtb

usb@7d000000: 'nvidia,needs-double-reset', 'nvidia,phy', 'operating-points-v2', 'power-domains', 'reset-names', 'resets' do not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm/boot/dts/tegra30-asus-nexus7-grouper-E1565.dtb
	arch/arm/boot/dts/tegra30-asus-nexus7-grouper-PM269.dtb
	arch/arm/boot/dts/tegra30-asus-nexus7-tilapia-E1565.dtb
	arch/arm/boot/dts/tegra30-asus-tf201.dtb
	arch/arm/boot/dts/tegra30-asus-tf300t.dtb
	arch/arm/boot/dts/tegra30-asus-tf300tg.dtb
	arch/arm/boot/dts/tegra30-asus-tf700t.dtb
	arch/arm/boot/dts/tegra30-beaver.dtb
	arch/arm/boot/dts/tegra30-ouya.dtb
	arch/arm/boot/dts/tegra30-pegatron-chagall.dtb

usb@7d000000: 'nvidia,phy', 'reset-names', 'resets' do not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm/boot/dts/tegra114-asus-tf701t.dtb
	arch/arm/boot/dts/tegra114-dalmore.dtb
	arch/arm/boot/dts/tegra124-jetson-tk1.dtb

usb@c5000000: 'nvidia,needs-double-reset', 'nvidia,phy', 'operating-points-v2', 'power-domains', 'reset-names', 'resets' do not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm/boot/dts/tegra20-acer-a500-picasso.dtb
	arch/arm/boot/dts/tegra20-asus-tf101.dtb
	arch/arm/boot/dts/tegra20-paz00.dtb

usb@f9a55000: reg: [[4188360704, 512], [4188361216, 512]] is too long
	arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dtb
	arch/arm/boot/dts/qcom-apq8026-lg-lenok.dtb
	arch/arm/boot/dts/qcom-apq8074-dragonboard.dtb
	arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dtb
	arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dtb
	arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dtb
	arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dtb
	arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-amami.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-honami.dtb

usb@f9a55000: '#reset-cells', 'adp-disable', 'clock-names', 'hnp-disable', 'phy-select', 'reset-names', 'resets', 'srp-disable', 'ulpi' do not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm/boot/dts/qcom-apq8074-dragonboard.dtb
	arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dtb
	arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dtb
	arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dtb
	arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-amami.dtb
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-honami.dtb

usb@f9a55000: '#reset-cells', 'adp-disable', 'clock-names', 'hnp-disable', 'reset-names', 'resets', 'srp-disable', 'ulpi' do not match any of the regexes: 'ethernet@[0-9a-f]$'
	arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dtb
	arch/arm/boot/dts/qcom-apq8026-lg-lenok.dtb
	arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dtb

