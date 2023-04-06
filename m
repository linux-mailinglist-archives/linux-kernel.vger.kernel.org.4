Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE466D9DEF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239731AbjDFQvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjDFQvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:51:01 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BA512D;
        Thu,  6 Apr 2023 09:50:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1680799857; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Ezge/2AnwPX5r7ux3WkH950by4dkB1CzEVgkZxD5lzsm/GEJP7G+LrDOnwz0SDkYap
    YB1UOEYWnNknQ7yw7LnXQ6vKXDFhGPsyIDlV3Z28ZMojPHTGkgcT+Tv7WyaModxOQ1O/
    cKPtAk4gSDi6YyohyNfVFgn0k/shO+7YJZq0+Ze0DUPWGVXjH7SPStilp/vyc+IMNe7g
    EMnRUXbRUxN7YJ4cG8ZrJbt9t3P39WueVKk+6GHHg00Sgg3PQC7QYTZRVXxzXCBYKmxO
    OBdyAU0NVa4vyZUdC9WHf6x06c/u0F0rkrOWebUJm5P09/Rj9XdF+QYwAT+mWP2bXynW
    /qtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1680799857;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Po4jB73TIWWBeTAu+d62FJCT3IfHXN2fw64y3NL8YUc=;
    b=aV395fsbPeYRwUiAwjsP9tuMnca0N+9XkG0nOVroT8iyyugokDE3mH+x6p55jt9Y7S
    4gs0lygo01KNrnh7G76A6h/Q+AjLTmrEcKRWxufV5muGWrYtmaOSE468AoTkWJZ6u0KC
    dKi4h5i4dcHuUZ6qh7FTmIxVhjxuOkskFFeu6J+wuejoy4Am8q42h1u8a+Miq0AmgR/g
    ylSu/JDAkgWP673L/wdZlmZnzsVIU1CSaDsQA0KwQfmV5Z4rAulKoYTsuZeDBUXCvKUC
    d09csuP+s2YuDC/7n9xaon5Z2fGS4t4rxcZjHTr8uBTewqHAv1tHnsMH7LRsMPMqmxSh
    kikA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1680799857;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Po4jB73TIWWBeTAu+d62FJCT3IfHXN2fw64y3NL8YUc=;
    b=n3MYu7GrIGkxlvVqFPJH9wiGavr8VtfgcBaEL4ygpW/VdHgqSS5BE1wpOmYuKFajAJ
    U+KOozF+HPNq88s6NiiQff+h49P54dvj6aT9bT1Jom3LmwA4ylfKhbfNts4Lcr4R8h/C
    d4U8KDRzhJd5zmDEDUEP4E24UFg1ZBpa6L25y61KSGrdgm5WbZtgSjjduuItbac02RHX
    QqlyGGY5rnWCvyHKOBq16q3H7SIC5iqbC4H81GVRx6/kZ5YTQoSa1iRKwu6ST4uziOfn
    Yq6gdVk1irxPaytGQrclRn5B1kYuabXGhfR0nOHEXF0YYO0AApWbUedcRw7OWzsJgyEj
    Tc1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1680799857;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Po4jB73TIWWBeTAu+d62FJCT3IfHXN2fw64y3NL8YUc=;
    b=CHwxO3gV/nAVL2Pzv8pVYh8O+4Rxm0O01IA+AJdV+FikoTfdTpbdJg8/8I1ILYbAYe
    gpfdaZOg9GBTuKeK1BBw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA+pvh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az36GovD50
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 6 Apr 2023 18:50:57 +0200 (CEST)
Date:   Thu, 6 Apr 2023 18:50:55 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v8 5/5] arm64: dts: qcom: Add msm8939 Sony Xperia M4 Aqua
Message-ID: <ZC74b5yR2PF2_sYy@gerhold.net>
References: <20230330153222.2875121-1-bryan.odonoghue@linaro.org>
 <20230330153222.2875121-6-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330153222.2875121-6-bryan.odonoghue@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 04:32:22PM +0100, Bryan O'Donoghue wrote:
> Add a basic booting DTS for the Sony Xperia M4 Aqua aka "tulip".
> 
> Tulip is paired with:
> 
> - wcn3660
> - smb1360 battery charger
> - 720p Truly NT35521 Panel
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../qcom/msm8939-sony-xperia-kanuti-tulip.dts | 184 ++++++++++++++++++
>  2 files changed, 185 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 31e0ac97fc088..3f8321ecb7e5f 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -30,6 +30,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-serranove.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-thwc-uf896.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-thwc-ufi001c.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-sony-xperia-kanuti-tulip.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-daisy.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-mido.dtb
> diff --git a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
> new file mode 100644
> index 0000000000000..cb47bb2413a7c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
> @@ -0,0 +1,184 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022-2023, Bryan O'Donoghue.
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include "msm8939.dtsi"
> +#include "msm8939-pm8916.dtsi"
> +#include <dt-bindings/arm/qcom,ids.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +
> +/ {
> +	model = "Sony Xperia M4 Aqua";
> +	compatible = "sony,kanuti-tulip", "qcom,msm8939";
> +
> +	qcom,board-id = <QCOM_BOARD_ID_MTP 0>;
> +	qcom,msm-id = <QCOM_ID_MSM8939 0>, <QCOM_ID_MSM8939 0x30000>;
> +
> +	aliases {
> +		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
> +		mmc1 = &sdhc_2; /* SDC2 SD card slot */
> +		serial0 = &blsp1_uart2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	usb_id: usb-id {
> +		compatible = "linux,extcon-usb-gpio";
> +		id-gpio = <&tlmm 110 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&usb_id_default>;
> +		pinctrl-names = "default";
> +	};
> +};
> +
> +&mdss {
> +	status = "okay";
> +};
> +
> +&tlmm {
> +	usb_id_default: usb-id-default-state {
> +		pins = "gpio110";
> +		function = "gpio";
> +		bias-pull-up;
> +		drive-strength = <8>;
> +	};
> +};

FWIW the node order seems wrong here (m -> t -> p).

> +
> +&pronto {
> +	status = "okay";
> +
> +	iris {
> +		compatible = "qcom,wcn3660";
> +	};
> +};
> +
> [...]
> +&sdhc_1 {
> +	pinctrl-0 = <&sdc1_default_state>;
> +	pinctrl-1 = <&sdc1_sleep_state>;
> +	pinctrl-names = "default", "sleep";
> +	status = "okay";
> +};
> +
> +&sdhc_2 {
> +	pinctrl-0 = <&sdc2_default_state>;
> +	pinctrl-1 = <&sdc2_sleep_state>;
> +	pinctrl-names = "default", "sleep";
> +	cd-gpios = <&tlmm 38 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +};
> +
> +&usb {
> +	dr_mode = "device";
> +	extcon = <&usb_id>, <&usb_id>;
> +	status = "okay";
> +};
> +

Hm is there a special reason for forcing dr_mode = "device" here?
If the USB ID GPIO works properly you should be in device mode all the
time unless you plug in an USB OTG adapter. Seems a bit strange.

Thanks,
Stephan
