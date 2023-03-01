Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B37C6A768D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 23:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjCAWDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 17:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjCAWC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 17:02:59 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891C29765
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 14:02:56 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id k14so19590609lfj.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 14:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677708175;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IlzyAvkx+cNHeTdlOiUFp9T8jdzQ+cHooUeXeReP0yE=;
        b=Tl7C0/fYhJFkjVHLQfMqFUiI3UbzVavbUOpjcElir4NNiN5UrOWMRcbC44JKByc5AQ
         6C3Zt7Rx9rzZEqBJMvjSuosZ08RWYa+OF+fpa0Xei+mEWKW+Ij123VHyRJmd2setGn+Z
         sBbIXejwcAeYEN/U9mRuPxVXVOKPEwOUHFECVs2crpGU+TfV49g7/2mcVScBJjVn7Ehq
         I5Swg00QWtz8yj7biz2UeXr++OTBEGEi9LY6b4Kt/g1clcUWqXUbnyQhGQuZff1X7yw4
         xjwuKG9migIiX9Bg2to/MnPXY5xx16VOpeeCbnghAUqIMj/RFYHTRdRMwgad5l2AskLO
         wO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677708175;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IlzyAvkx+cNHeTdlOiUFp9T8jdzQ+cHooUeXeReP0yE=;
        b=QATZqE6JI6Nx01wKsxuAVUNp5LfoltpTzbiR50iYk0jad+0h6qCsHk5uw9G1OVgKg+
         I/C1KWbdpQuezyRNfsAq5BV7/JhJHbLeXWqq14QSceB+VhznvE26aU4igLbrzUK7FzGx
         ms4OEdWY89sj5kFLK5E4zTJfqOmf2YgVOgzQtm5V+zXs5snFVTqsV0R/2PXMEIX8fXCx
         IA/svi8MpvZ6xI3TV0qmUPp02oy9/rMpisdIuCOFQOXeySDiPiQbcWdtCUiY6QCf/R2P
         5Fi0LsAermBUlspqJsv22KDBap7pu110LblSOe/WWGotY/JT2BE/VgnSL4vYNbkOvdDr
         NV4g==
X-Gm-Message-State: AO0yUKU056hZ45P3uF+Zpqp7xoD3aihWErjqJQ8VwBhB5QwveRGM6BMf
        O1ni6JTKz7X0pZouSivygi7GMQ==
X-Google-Smtp-Source: AK7set8Q9LOoEa0pOZ3ciCM7XfPU6NrdIlSacbyooQMBE2v/a/wlaUBvgwCgYuuTBMNoPlmps8hV7w==
X-Received: by 2002:ac2:554e:0:b0:4dd:ad88:ba5c with SMTP id l14-20020ac2554e000000b004ddad88ba5cmr2037426lfk.4.1677708174720;
        Wed, 01 Mar 2023 14:02:54 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id q20-20020ac24a74000000b004d8540b947asm1881349lfp.56.2023.03.01.14.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 14:02:54 -0800 (PST)
Message-ID: <d6045df9-fe0f-f013-450e-5d3df4add46b@linaro.org>
Date:   Wed, 1 Mar 2023 23:02:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sc7180: Delete kingoftown-rev0
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     mka@chromium.org, swboyd@chromium.org,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230301185007.1101006-1-dianders@chromium.org>
 <20230301104859.2.I68cbe5d5d45074428469da8c52f1d6a78bdc62fc@changeid>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230301104859.2.I68cbe5d5d45074428469da8c52f1d6a78bdc62fc@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.03.2023 19:50, Douglas Anderson wrote:
> The earliest kingoftown that I could find in my pile of boards was
> -rev2 and even that revision looks pretty rough (plastics on the case
> are very unfinished). Though I don't actually have details about how
> many -rev0 devices were produced, I can't imagine anyone still using
> one. Let's delete support.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
Unless there are more kingoftowns on the horizon, the dtsi and ex-r1
dts can be merged.

Konrad
> 
>  arch/arm64/boot/dts/qcom/Makefile             |  3 +-
>  .../dts/qcom/sc7180-trogdor-kingoftown-r0.dts | 38 -------------------
>  ...n-r1.dts => sc7180-trogdor-kingoftown.dts} |  0
>  3 files changed, 1 insertion(+), 40 deletions(-)
>  delete mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r0.dts
>  rename arch/arm64/boot/dts/qcom/{sc7180-trogdor-kingoftown-r1.dts => sc7180-trogdor-kingoftown.dts} (100%)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index a51060378ddc..3ce51093ed8f 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -83,8 +83,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r3-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r3.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r4.dtb
> -dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-kingoftown-r0.dtb
> -dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-kingoftown-r1.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-kingoftown.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r0.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r1-kb.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r0.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r0.dts
> deleted file mode 100644
> index 3abd6222fe46..000000000000
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r0.dts
> +++ /dev/null
> @@ -1,38 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Google Kingoftown board device tree source
> - *
> - * Copyright 2021 Google LLC.
> - */
> -
> -/dts-v1/;
> -
> -#include "sc7180-trogdor.dtsi"
> -#include "sc7180-trogdor-ti-sn65dsi86.dtsi"
> -#include "sc7180-trogdor-kingoftown.dtsi"
> -
> -/ {
> -	model = "Google Kingoftown (rev0)";
> -	compatible = "google,kingoftown-rev0", "qcom,sc7180";
> -};
> -
> -/*
> - * In rev1+, the enable pin of pp3300_fp_tp will be tied to pp1800_l10a
> - * power rail instead, since kingoftown does not have FP.
> - */
> -&pp3300_fp_tp {
> -	gpio = <&tlmm 74 GPIO_ACTIVE_HIGH>;
> -	enable-active-high;
> -
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&en_fp_rails>;
> -};
> -
> -&tlmm {
> -	en_fp_rails: en-fp-rails-state {
> -		pins = "gpio74";
> -		function = "gpio";
> -		drive-strength = <2>;
> -		bias-disable;
> -	};
> -};
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dts
> similarity index 100%
> rename from arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r1.dts
> rename to arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dts
