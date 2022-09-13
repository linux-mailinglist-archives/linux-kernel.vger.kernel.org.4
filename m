Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F285B7CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 23:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiIMVaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 17:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiIMVaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 17:30:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E9850078;
        Tue, 13 Sep 2022 14:30:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 563E9615CD;
        Tue, 13 Sep 2022 21:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC8DC433B5;
        Tue, 13 Sep 2022 21:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663104610;
        bh=Zl+H9wn8tNQcuqY+u/39q2o9zAh6YN3JsvPLJz2NN/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=No4oZ6UQUVrpCT/GNJRpOnh4G6oMPwYbbO9pCW8w09def5UqD+XAoUTEc6rtH54ej
         0ef2CO+iQ3TP/MHuz/KmD828xb1JnV/ulbs7onBmQCY4zLeLSU0iuN2uSGERWbZTDZ
         QBGXCVRzSUD5gsiUQ/NwmVjVuMDl625HqEyXxMZzSUwLR2bcU/SnR8RRsS3YPK7mJd
         MohBmknVTaayr51hYgbb1Tb/Y3ACCWsoXMQ9hfFyd4AcxhpkGCjcuU1TfYxZ1+BEqq
         000sNl0NgVJKKVIpBS7zdCoJFbdVNffnFGw2CWingwsggKMPDR1PoeQk63AqwVoqTR
         sxxCcURMV/rWw==
Date:   Tue, 13 Sep 2022 16:30:07 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 9/9] arm64: dts: qcom: sm4250: Add support for
 oneplus-billie2
Message-ID: <20220913213007.gdk27nxjzmagbdzn@builder.lan>
References: <20220910143213.477261-1-iskren.chernev@gmail.com>
 <20220910143213.477261-10-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910143213.477261-10-iskren.chernev@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2022 at 05:32:13PM +0300, Iskren Chernev wrote:
> Add initial support for OnePlus Nord N100, based on SM4250. Currently
> working:
> - boots
> - usb
> - buildin flash storage (UFS)
> - SD card reader
> 
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/sm4250-oneplus-billie2.dts  | 241 ++++++++++++++++++
>  2 files changed, 242 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index f4126f7e7640..5d2570b600e0 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -137,6 +137,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-polaris.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6350-sony-xperia-lena-pdx213.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm7225-fairphone-fp4.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> new file mode 100644
> index 000000000000..b9094f1efca0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> @@ -0,0 +1,241 @@
> +// SPDX-License-Identifier: GPL-2.0-only

Would it be possible for you to dual license this?

> +/*
> + * Copyright (c) 2021, Iskren Chernev <iskren.chernev@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "sm4250.dtsi"
> +
> +/ {
> +	model = "OnePlus Nord N100";
> +	compatible = "oneplus,billie2", "qcom,sm4250";
> +
> +	/* required for bootloader to select correct board */
> +	qcom,msm-id = <0x1a1 0x10000 0x1bc 0x10000>;
> +	qcom,board-id = <0x1000b 0x00>;
> +
> +	aliases {
> +	};
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		stdout-path = "framebuffer0";
> +
> +		framebuffer0: framebuffer@9d400000 {
> +			compatible = "simple-framebuffer";
> +			reg = <0 0x5c000000 0 (1600 * 720 * 4)>;
> +			width = <720>;
> +			height = <1600>;
> +			stride = <(720 * 4)>;
> +			format = "a8r8g8b8";
> +		};
> +	};
> +};
> +
> +&xo_board {
> +	clock-frequency = <19200000>;
> +};
> +
> +&sleep_clk {
> +	clock-frequency = <32764>;
> +};
> +
> +&reserved_memory {

As the number of nodes grow it would be nice if these were sorted
alphabetically.

> +	bootloader_log_mem: memory@5fff7000 {
> +		reg = <0x00 0x5fff7000 0x00 0x8000>;
> +		no-map;
> +	};
> +
> +	ramoops@cbe00000 {
> +		compatible = "ramoops";
> +		reg = <0x0 0xcbe00000 0x0 0x400000>;
> +		record-size = <0x40000>;
> +		pmsg-size = <0x200000>;
> +		console-size = <0x40000>;
> +		ftrace-size = <0x40000>;
> +	};
> +
> +	param_mem: memory@cc200000 {
> +		reg = <0x00 0xcc200000 0x00 0x100000>;
> +		no-map;
> +	};
> +
> +	mtp_mem: memory@cc300000 {
> +		reg = <0x00 0xcc300000 0x00 0xb00000>;
> +		no-map;
> +	};
> +};
> +
> +&usb3 {
> +	status = "okay";
> +};
[..]
> +&rpm_requests {
> +	regulators-0 {

Is there a reason why you don't call this node pm6125-regulators ?

> +		compatible = "qcom,rpm-pm6125-regulators";
> +
> +		vreg_s6a: s6 {
> +			regulator-min-microvolt = <320000>;
> +			regulator-max-microvolt = <1456000>;
> +		};
[..]
> +		vreg_l24a: l24 {
> +			regulator-min-microvolt = <2704000>;
> +			regulator-max-microvolt = <3544000>;
> +		};

Just as a heads up, by not ensuring that your regulators are in
high-power-mode you risk seeing brown-outs - something we keep running
into for e.g. SD-cards.

Regards,
Bjorn

> +	};
> +};
> -- 
> 2.37.2
> 
