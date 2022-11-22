Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28F6633DAE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbiKVNaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiKVNaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:30:20 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7FF654DE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:30:18 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id p141so10897404iod.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dm0//d6JJKLg4z718XzAPVhh62trEUD6ZDpSJwczExg=;
        b=BtF8ulQZQ4WXR4TMGpJnAXggX7Iyf3LmIN4v5nSyI/bX0bQrETvbHcz8yreip0lSar
         GBwUwowvPSWfXP+ONRjQz/Fr6Yqkm9AnfX22hXG9/mXvJ7DL0FqVEctbecc6s2FpO4VE
         awmQGKnECC+H0Zx0Fih2CBanENIboX45FNQeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dm0//d6JJKLg4z718XzAPVhh62trEUD6ZDpSJwczExg=;
        b=QkgoGWkdalTtC7Y6MRuwBKxcuqqKmlBcbTr/Yr8QL87+mGKVixvQLPsgeGswqmGsrm
         Auin6vdjm/JB0HiZHeNz6UguvMaAgL9e5G9yIfG+TZs2YYKtHQ1j4GUUuZ0xsZv7JrWG
         AgNqualf9yxuun3JpYeVfGUPEngNssH4nMcCOctfRzn4kGK5Y9lo4G6sHxnpsuuVJ80O
         gNiXKl+vLGsmTLww61EPchZLa9JMvn7G/LVnz+aKLpxdz9DIFNOukzDNUfF0viFdtPUR
         GubdT/SDBLkaaFfDEtTMTGEZ9dD/oMnv9QlRItlED5nqUJQ7NjJTgNS2fktrJxumOu8B
         bYgg==
X-Gm-Message-State: ANoB5pnFntximXfwkkmzDwIQO0vu0xw3v0YnZORiHs+5xETCd/3fAHCz
        KYF+MRCFEKYkEMW/bbnXnG9RkQ==
X-Google-Smtp-Source: AA0mqf7ciSA6ysbKaiV1F9m5x7GxJbpxiDud1qi2X/OVChX0uyWBaPCya1+b8FznPwhLnvSzubr/qQ==
X-Received: by 2002:a02:6d53:0:b0:372:f7ed:9f78 with SMTP id e19-20020a026d53000000b00372f7ed9f78mr4228223jaf.245.1669123817846;
        Tue, 22 Nov 2022 05:30:17 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id h16-20020a05660208d000b006a49722dc6dsm5207186ioz.11.2022.11.22.05.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 05:30:17 -0800 (PST)
Date:   Tue, 22 Nov 2022 13:30:17 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Owen Yang <ecs.taipeikernel@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bob Moragues <moragues@chromium.org>,
        Harvey <hunge@google.com>, Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sc7280: Add DT for
 sc7280-herobrine-zombie
Message-ID: <Y3zO6aY0xANk4Qlb@google.com>
References: <20221122203635.v2.1.Ie05fd439d0b271b927acb25c2a6e41af7a927e90@changeid>
 <20221122203635.v2.2.I4d4d860a675d86d328135e5e5f88aefb69a852ab@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221122203635.v2.2.I4d4d860a675d86d328135e5e5f88aefb69a852ab@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 08:37:03PM +0800, Owen Yang wrote:
> Add DT for sc7280-herobrine-zombie
> 
> arch/arm64/boot/dts/qcom/Makefile
> arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-lte.dts
> arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dts
> arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi

Drop this

> Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
> ---
> 
> (no changes since v1)

A diff between v1 and v2 shows that this is not correct, please provide
accurate change logs

>  arch/arm64/boot/dts/qcom/Makefile             |   2 +
>  .../dts/qcom/sc7280-herobrine-zombie-lte.dts  |  15 +
>  .../boot/dts/qcom/sc7280-herobrine-zombie.dts |  16 +
>  .../dts/qcom/sc7280-herobrine-zombie.dtsi     | 310 ++++++++++++++++++
>  4 files changed, 343 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-lte.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 384f2fa50646..e3226d7894ad 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -101,6 +101,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r1-lte.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-zombie.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-zombie-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-lte.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-lte.dts
> new file mode 100644
> index 000000000000..2f1da87e5005
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-lte.dts
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Zombie board device tree source
> + *
> + * Copyright 2022 Google LLC.
> + */
> +/dts-v1/;
> +
> +#include "sc7280-herobrine-zombie.dtsi"
> +#include "sc7280-herobrine-lte-sku.dtsi"
> +
> +/ {
> +	model = "Google Zombie with LTE";
> +	compatible = "google,zombie-sku512", "qcom,sc7280";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dts
> new file mode 100644
> index 000000000000..0246c12b2f40
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dts
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Zombie board device tree source
> + *
> + * Copyright 2022 Google LLC.
> + */
> +
> +/dts-v1/;
> +
> +#include "sc7280-herobrine-zombie.dtsi"
> +#include "sc7280-herobrine-wifi-sku.dtsi"
> +
> +/ {
> +	model = "Google Zombie";
> +	compatible = "google,zombie", "qcom,sc7280";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
> new file mode 100644
> index 000000000000..15832620ff5d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
> @@ -0,0 +1,310 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Zombie board device tree source
> + *
> + * Copyright 2022 Google LLC.
> + */
> +/dts-v1/;

This was added in v2. It isn't needed, the .dts files which include this file
already make this declaration.
