Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBDA714B58
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjE2OAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjE2OAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:00:17 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B484E1BD;
        Mon, 29 May 2023 06:59:46 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f60b3f32b4so21113685e9.1;
        Mon, 29 May 2023 06:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685368770; x=1687960770;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oazLT5BoRo6P0OAkqDnaATq3SHdxnGOsyqxxTgo0/fk=;
        b=Yr9UREVC5MVPBvfc95ZNhA42fYbaK1DSNtGyVx1whY4H/m5XQ7zYjdwpgrakzzaJLd
         q0FAVIoycIYEy8ZPPmY2Ckg5WNX/F/ZnyM4dGU97je+EIcK/dnwyZiJMEuu7SHpWWYzk
         04sd7jnEcZux32/nUGrp/AoED1BfcM/9r0akQsOQQD8AZKqxrHz0QVAQYUzdlHgfCLuv
         bTeEBWckjLVw4U8jzHhStKmDCn04e+Xlv+ICWjhvvGG72I2X7CJ5/1HASsxWvu9JCefD
         lcKc5l14g7GD8c4oOPZL1XRBrLsDSwkUz0JGqTJHfape5aU/gzShejRz6HLh/XzQZhzf
         PclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685368770; x=1687960770;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oazLT5BoRo6P0OAkqDnaATq3SHdxnGOsyqxxTgo0/fk=;
        b=dNUt3tiAdBb5uC4NbCLAw9C8oLLTLtYy9EIjnWLrE0WmcUgvH2LI50Ncf62kfAyuIh
         tOmfUd99AANCX2pe4h7IytQ9OeNJcIDwN38DUnD1l0S/cJwnPpLAxXR7+1KDOSVcJ+n2
         uU0mt0nLZ2iSMxVHV6pFGTDFCGEOuFcIG6jwYA6pKH15fAnXib50lrgcypcyF27lzCFz
         H8Uug2NtxM48c3+E/Leun0nnRwY6H4xuBwMLIKZmbjCgzlmz6n/7YWRyv7LxHPnXr1Z/
         QoCi+r1Q7Txicvsxx5e2+3QGOv3rfR4kS/T/mPQrALvfEG1jycpHwBWOFEqLnv9Wug0m
         TT9w==
X-Gm-Message-State: AC+VfDwkMY9aWwGe3Fy2/gkuupyAXCoeK/jxEge9K/rZ17Zd+oftQWLL
        6zPt5WnNbLwXQpmbq1a2XNY=
X-Google-Smtp-Source: ACHHUZ4RDCeonMwGzDh6NAp931ShLAMt6/ZxYuWux62+rLsp2JN9Aml4izb+ej1Vg383g8EUUJJ+fw==
X-Received: by 2002:a05:600c:2196:b0:3f6:3da:1603 with SMTP id e22-20020a05600c219600b003f603da1603mr11566428wme.26.1685368769840;
        Mon, 29 May 2023 06:59:29 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d4c42000000b0030af15d7e41sm86803wrt.4.2023.05.29.06.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 06:59:28 -0700 (PDT)
Message-ID: <740d6471-b71c-3c3b-73e3-60fb5573c88e@gmail.com>
Date:   Mon, 29 May 2023 15:59:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 23/27] arm64: dts: mediatek: Add MT6331 PMIC devicetree
Content-Language: en-US, ca-ES, es-ES
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, jitao.shi@mediatek.com,
        xinlei.lee@mediatek.com, houlong.wei@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@collabora.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-24-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230412112739.160376-24-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
> MT6331 is the primary PMIC for the MediaTek Helio X10 MT6795 smartphone
> platforms: add a devicetree describing its regulators, Real Time Clock
> and PMIC-keys.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks


> ---
>   arch/arm64/boot/dts/mediatek/mt6331.dtsi | 284 +++++++++++++++++++++++
>   1 file changed, 289 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt6331.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt6331.dtsi b/arch/arm64/boot/dts/mediatek/mt6331.dtsi
> new file mode 100644
> index 000000000000..fcec8c07fe39
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt6331.dtsi
> @@ -0,0 +1,284 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2023 Collabora Ltd.
> + * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> + */
> +#include <dt-bindings/input/input.h>
> +
> +&pwrap {
> +	pmic: mt6331 {
> +		compatible = "mediatek,mt6331";
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +
> +		mt6331regulator: mt6331regulator {
> +			compatible = "mediatek,mt6331-regulator";
> +
> +			mt6331_vdvfs11_reg: buck-vdvfs11 {
> +				regulator-name = "vdvfs11";
> +				regulator-min-microvolt = <700000>;
> +				regulator-max-microvolt = <1493750>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-enable-ramp-delay = <0>;
> +				regulator-allowed-modes = <0 1>;
> +				regulator-always-on;
> +			};
> +
> +			mt6331_vdvfs12_reg: buck-vdvfs12 {
> +				regulator-name = "vdvfs12";
> +				regulator-min-microvolt = <700000>;
> +				regulator-max-microvolt = <1493750>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-enable-ramp-delay = <0>;
> +				regulator-allowed-modes = <0 1>;
> +				regulator-always-on;
> +			};
> +
> +			mt6331_vdvfs13_reg: buck-vdvfs13 {
> +				regulator-name = "vdvfs13";
> +				regulator-min-microvolt = <700000>;
> +				regulator-max-microvolt = <1493750>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-enable-ramp-delay = <0>;
> +				regulator-allowed-modes = <0 1>;
> +				regulator-always-on;
> +			};
> +
> +			mt6331_vdvfs14_reg: buck-vdvfs14 {
> +				regulator-name = "vdvfs14";
> +				regulator-min-microvolt = <700000>;
> +				regulator-max-microvolt = <1493750>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-enable-ramp-delay = <0>;
> +				regulator-allowed-modes = <0 1>;
> +				regulator-always-on;
> +			};
> +
> +			mt6331_vcore2_reg: buck-vcore2 {
> +				regulator-name = "vcore2";
> +				regulator-min-microvolt = <700000>;
> +				regulator-max-microvolt = <1493750>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-enable-ramp-delay = <0>;
> +				regulator-allowed-modes = <0 1>;
> +				regulator-always-on;
> +			};
> +
> +			mt6331_vio18_reg: buck-vio18 {
> +				regulator-name = "vio18";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-enable-ramp-delay = <0>;
> +				regulator-allowed-modes = <0 1>;
> +				regulator-always-on;
> +			};
> +
> +			mt6331_vtcxo1_reg: ldo-vtcxo1 {
> +				regulator-name = "vtcxo1";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +				regulator-ramp-delay = <0>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			mt6331_vtcxo2_reg: ldo-vtcxo2 {
> +				regulator-name = "vtcxo2";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +				regulator-ramp-delay = <0>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			mt6331_avdd32_aud_reg: ldo-avdd32aud {
> +				regulator-name = "avdd32_aud";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <3200000>;
> +				regulator-ramp-delay = <0>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			mt6331_vauxa32_reg: ldo-vauxa32 {
> +				regulator-name = "vauxa32";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <3200000>;
> +				regulator-ramp-delay = <0>;
> +			};
> +
> +			mt6331_vcama_reg: ldo-vcama {
> +				regulator-name = "vcama";
> +				regulator-min-microvolt = <1500000>;
> +				regulator-max-microvolt = <2800000>;
> +				regulator-ramp-delay = <0>;
> +			};
> +
> +			mt6331_vio28_reg: ldo-vio28 {
> +				regulator-name = "vio28";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +				regulator-ramp-delay = <0>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			mt6331_vcamaf_reg: ldo-vcamaf {
> +				regulator-name = "vcam_af";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-ramp-delay = <0>;
> +			};
> +
> +			mt6331_vmc_reg: ldo-vmc {
> +				regulator-name = "vmc";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-ramp-delay = <0>;
> +			};
> +
> +			mt6331_vmch_reg: ldo-vmch {
> +				regulator-name = "vmch";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-ramp-delay = <0>;
> +			};
> +
> +			mt6331_vemc33_reg: ldo-vemc33 {
> +				regulator-name = "vemc33";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-ramp-delay = <0>;
> +				regulator-always-on;
> +			};
> +
> +			mt6331_vgp1_reg: ldo-vgp1 {
> +				regulator-name = "vgp1";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-ramp-delay = <0>;
> +				regulator-always-on;
> +			};
> +
> +			mt6331_vsim1_reg: ldo-vsim1 {
> +				regulator-name = "vsim1";
> +				regulator-min-microvolt = <1700000>;
> +				regulator-max-microvolt = <3100000>;
> +				regulator-ramp-delay = <0>;
> +				regulator-always-on;
> +			};
> +
> +			mt6331_vsim2_reg: ldo-vsim2 {
> +				regulator-name = "vsim2";
> +				regulator-min-microvolt = <1700000>;
> +				regulator-max-microvolt = <3100000>;
> +				regulator-ramp-delay = <0>;
> +			};
> +
> +			mt6331_vmipi_reg: ldo-vmipi {
> +				regulator-name = "vmipi";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-ramp-delay = <0>;
> +				regulator-always-on;
> +			};
> +
> +			mt6331_vibr_reg: ldo-vibr {
> +				regulator-name = "vibr";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-ramp-delay = <0>;
> +			};
> +
> +			mt6331_vgp4_reg: ldo-vgp4 {
> +				regulator-name = "vgp4";
> +				regulator-min-microvolt = <1600000>;
> +				regulator-max-microvolt = <2200000>;
> +				regulator-ramp-delay = <0>;
> +				regulator-always-on;
> +			};
> +
> +			mt6331_vcamd_reg: ldo-vcamd {
> +				regulator-name = "vcamd";
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <1500000>;
> +				regulator-ramp-delay = <0>;
> +				regulator-always-on;
> +			};
> +
> +			mt6331_vusb10_reg: ldo-vusb10 {
> +				regulator-name = "vusb";
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-ramp-delay = <0>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			mt6331_vcamio_reg: ldo-vcamio {
> +				regulator-name = "vcam_io";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-ramp-delay = <0>;
> +			};
> +
> +			mt6331_vsram_reg: ldo-vsram {
> +				regulator-name = "vsram";
> +				regulator-min-microvolt = <1012500>;
> +				regulator-max-microvolt = <1012500>;
> +				regulator-ramp-delay = <0>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			mt6331_vgp2_reg: ldo-vgp2 {
> +				regulator-name = "vgp2";
> +				regulator-min-microvolt = <1100000>;
> +				regulator-max-microvolt = <1500000>;
> +				regulator-ramp-delay = <0>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			mt6331_vgp3_reg: ldo-vgp3 {
> +				regulator-name = "vgp3";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-ramp-delay = <0>;
> +				regulator-always-on;
> +			};
> +
> +			mt6331_vrtc_reg: ldo-vrtc {
> +				regulator-name = "vrtc";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +				regulator-ramp-delay = <0>;
> +				regulator-always-on;
> +			};
> +
> +			mt6331_vdig18_reg: ldo-vdig18 {
> +				regulator-name = "dvdd18_dig";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-ramp-delay = <0>;
> +				regulator-always-on;
> +			};
> +		};
> +
> +		mt6331rtc: mt6331rtc {
> +			compatible = "mediatek,mt6331-rtc";
> +		};
> +
> +		mt6331keys: mt6331keys {
> +			compatible = "mediatek,mt6331-keys";
> +			power {
> +				linux,keycodes = <KEY_POWER>;
> +				wakeup-source;
> +			};
> +			home {
> +				linux,keycodes = <KEY_HOME>;
> +			};
> +		};
> +	};
> +};
