Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622F37223A9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjFEKh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjFEKh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:37:27 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8C7EC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 03:37:25 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-977c72b116fso285273766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 03:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685961444; x=1688553444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aOcvx95y08Gz26+xoTBjezMM0R9qofVzp0SopEjZHOQ=;
        b=rt0Rcc/eCQBeaPHqu7XDXzAGCyuRJOzkJQOyy1aX6nkGg+82+j5cbs4bVtgXqmWwII
         3Mh3y6GijeEiUvlu2xdPSaxfgGshRlGJRxrAzKA1KgHUGk9lc12YXCD5D4xZL7tKAs4u
         QmTxa9VKBOb8VbSZRT9i9Ci+sCZgCom+x7SYHO9kSgzq5ZJoHBzelKG2gmlIUtggDaz8
         m5hTOkfhdxICvVpYqFa24mYzCHL3Sb+OkTWvfaTuRQ5fqJZvwZUC5dR3ku0d2X5S1PZu
         hgKVPq/sgaJSnlTj4nFsGutvSIKoqBKb+WVR/f+nn4znyoCqsKw9Ra91e3kG4N/ALFdH
         YCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685961444; x=1688553444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aOcvx95y08Gz26+xoTBjezMM0R9qofVzp0SopEjZHOQ=;
        b=Ibp2GzHNFy/1cF+FwaflsBla/5NajDqJ6NL/uqXYMaP0BNbpfqE8Q9fyqG3IX/Vle7
         pObtBQbE+auqyIiohrFx3Sw1xKxHhDDxyMdIRi0992lOvKZZCkYvn6O2L0fJxGenMvMo
         CP17hBtk+f5CQRM8t6iuAI6MXPYX1+M1MY9eJI5FfUvmmlUcObsfRFfET0Mli+CWFo2Z
         zEjNwU1tGDRB3Yf9XRmeFtJNTSehe86+MuAHYr+2fQsWY5nLJLKLruLyrK4nYFv0lE2z
         GwR6rNHvtrafTKQPw4Px8muHywxDt39l1oooomWXnmfkMNFtzUoZDilzRse+QCrgC90e
         fG0g==
X-Gm-Message-State: AC+VfDwdIjnwLKwjEVfIR1IXuoOKXCjWkNRhr4yrbpEnj47Ss7Lt0gUY
        YxoC1jho++Oez8/h+w/2Vus9Vg==
X-Google-Smtp-Source: ACHHUZ48K2Razvdp0nA1z9juD0kw8ynNAAg6/azRFolmB6OaGaQUC8gJo44/8kdX7ZDfR6mnkTGLzQ==
X-Received: by 2002:a17:907:36c3:b0:960:ddba:e5c6 with SMTP id bj3-20020a17090736c300b00960ddbae5c6mr5332528ejc.22.1685961444353;
        Mon, 05 Jun 2023 03:37:24 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id kq6-20020a170906abc600b0096599bf7029sm4160816ejb.145.2023.06.05.03.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 03:37:23 -0700 (PDT)
Message-ID: <cd71ee53-391a-90fd-27ca-c174f2b24a94@linaro.org>
Date:   Mon, 5 Jun 2023 12:37:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: dts: qcom: Split sdm845-db845c to add headless
 support
Content-Language: en-US
To:     Amit Pundir <amit.pundir@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20230605094710.2037879-1-amit.pundir@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230605094710.2037879-1-amit.pundir@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/2023 11:47, Amit Pundir wrote:
> This is a follow-up of the upstream discussion,
> https://lore.kernel.org/linux-kernel/20230124182857.1524912-1-amit.pundir@linaro.org/T/#u,
> around adding a reserved memory region in sdm845-db845c
> for the framebuffer memory (the splash region set up by
> the bootloader) but the general opinion was to avoid
> adding that reserved memory for the headless DB845c
> usecase.
> 
> So this patch splits the sdm845-db845c into a common dtsi,
> a new sdm845-db845-headless DT, which disables the mdss
> display subsystem, and a new sdm845-db845c DT with an
> additional reserved-memory region for the framebuffer.
> 
> The default sdm845-db845c.dtb remains pretty much the same
> (with an exception of additional reserved-memory region),
> while others can use sdm845-db845c-headless.dtb for their
> headless systems.

You should describe the hardware in commit msg. What is "headless"? If
no HDMI plugged in, then it is a NAK because plug or unplugged HDMI
cable is not a property of a DTS.

> 
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> ---
> Please pick this after the lvs regulator nodes reordering patch
> https://lore.kernel.org/lkml/20230602161246.1855448-1-amit.pundir@linaro.org/T/#u.
> I'll rebase and resend this patch otherwise.
> 
>  arch/arm64/boot/dts/qcom/Makefile             |    1 +
>  .../boot/dts/qcom/sdm845-db845c-common.dtsi   | 1178 +++++++++++++++++
>  .../boot/dts/qcom/sdm845-db845c-headless.dts  |    9 +
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts    | 1172 +---------------

A lot of duplication. Are you sure you generated the patches with
correct -M/-C/-B arguments to rename or copy?

>  4 files changed, 1194 insertions(+), 1166 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-db845c-common.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-db845c-headless.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 4f9e81253e18..22876ea2e409 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -166,6 +166,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r3.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-db845c.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-db845c-headless.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-db845c-navigation-mezzanine.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-lg-judyln.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-lg-judyp.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-db845c-common.dtsi
> new file mode 100644
> index 000000000000..ecc4a851e29c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c-common.dtsi
> @@ -0,0 +1,1178 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019, Linaro Ltd.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include <dt-bindings/sound/qcom,q6afe.h>
> +#include <dt-bindings/sound/qcom,q6asm.h>
> +#include "sdm845.dtsi"
> +#include "sdm845-wcd9340.dtsi"
> +#include "pm8998.dtsi"
> +#include "pmi8998.dtsi"
> +
> +/ {
> +	model = "Thundercomm Dragonboard 845c";
> +	compatible = "thundercomm,db845c", "qcom,sdm845";

So it is the same hardware? Why compatible is in common part? I don't
understand this change.

Best regards,
Krzysztof

