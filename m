Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E1C6DA151
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbjDFTbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjDFTbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:31:38 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33336C3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 12:31:37 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id k37so52225982lfv.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 12:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680809495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9kZ8mEB2dJOlrXABGLSLHAbWryJP74zULnJHHBI7aEk=;
        b=wzIf24UpJ/GF648SVbmBSebcn5SIf/+o6UZI/JS5M4IeYsJckfSRVlBqac+bHfPYhd
         SbxRtwZR4sobuPygpG7kD71pdBd1U2oKpYJ74K2ohi0RNiVi79vlUw5qGBikLaO0umXY
         r2gEEfI1xZN1hDc/ut/Fgl1Nnl4vf+lkt4UU+14Y1Q2yJmidAhn8eRJdIhxWwlI2VGow
         +puimkG4TMxQOL2INCMIDivLSf1lX1qh9pzcSeGNO392baJn+f4pl9atEzuPBtATkNOu
         pt99AqRMM6i3kPxcAwzVN3OM6bnSgK+g6wzNscdzPb1hoXDFWtYc+W8jpgahQgzaL+Kq
         Cp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680809495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9kZ8mEB2dJOlrXABGLSLHAbWryJP74zULnJHHBI7aEk=;
        b=Yl/yCj8af4ZYnz5Mo+y6u49QqFywQPVxVChmRtMVIFVhf6qtJWM1OdTi8ybQt/Syiv
         +ODbFIEQjPJdwGQWpIljgBZFuLtqzwz3B3kfqb2r67oa9ldNp4JF8vyHZs5yYWOQCcfU
         TcBPZrelYgAkCmcFM7xTDIjxUSIAFPdQrU2Vq7GlqxJDgUlpvpXkKO+jjht0E1yDaIfB
         CvlOLklxG3WoJpdKR5+drSV9v8S3JNFboGL2IT8UqP94+BhXOVJK6vi/Qixa+wUi3Aph
         dtlCoyt5Usa/j095FnwO4iNs7EfEl+Onoftrvn87k3XtFv2eyJWHnOynsFKeo499Gq2S
         Ajlw==
X-Gm-Message-State: AAQBX9c+NeZsYkf53JxHKnuxK4YXThi7j2aA98+hxO6QYEOxhhmyf0fB
        u+43k6tDuhRq4nKPbHJv4LhwFg==
X-Google-Smtp-Source: AKy350aEPxyYUMVmnkeGGTET+LX64v+Q7tAsrZnc9V4iE6ZUyMveIR/EWMUewYONFengBe7qUB62Ww==
X-Received: by 2002:a05:6512:3744:b0:4ea:e6b9:a8f with SMTP id a4-20020a056512374400b004eae6b90a8fmr1633953lfs.28.1680809495402;
        Thu, 06 Apr 2023 12:31:35 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id u26-20020ac243da000000b004e84896253asm384580lfl.251.2023.04.06.12.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 12:31:35 -0700 (PDT)
Message-ID: <7bec0262-8a20-9b6a-599f-5ba759e6bd6b@linaro.org>
Date:   Thu, 6 Apr 2023 21:31:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 1/4] arm64: dts: qcom: sc7180: Don't enable lpass
 clocks by default
Content-Language: en-US
To:     Nikita Travkin <nikita@trvn.ru>, agross@kernel.org,
        andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        quic_srivasam@quicinc.com, judyhsiao@chromium.org,
        mka@chromium.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230406150633.83351-1-nikita@trvn.ru>
 <20230406150633.83351-2-nikita@trvn.ru>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230406150633.83351-2-nikita@trvn.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6.04.2023 17:06, Nikita Travkin wrote:
> lpass clocks are usually blocked from HLOS by the firmware and
> instead are managed by the ADSP. Mark them as reserved and explicitly
> enable in the CrOS boards that have special, cooperative firmware.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 8 ++++++++
>  arch/arm64/boot/dts/qcom/sc7180.dtsi         | 4 ++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index 423630c4d02c..26def6e12723 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -785,6 +785,14 @@ alc5682: codec@1a {
>  	};
>  };
>  
> +&lpasscc {
> +	status = "okay";
> +};
> +
> +&lpass_hm {
> +	status = "okay";
> +};
> +
>  &lpass_cpu {
>  	status = "okay";
>  
_hm should come after _cpu alphabetically

w/ that

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 3c799b564b64..6f40301faa1c 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -3621,6 +3621,8 @@ lpasscc: clock-controller@62d00000 {
>  			power-domains = <&lpass_hm LPASS_CORE_HM_GDSCR>;
>  			#clock-cells = <1>;
>  			#power-domain-cells = <1>;
> +
> +			status = "reserved"; /* Controlled by ADSP */
>  		};
>  
>  		lpass_cpu: lpass@62d87000 {
> @@ -3669,6 +3671,8 @@ lpass_hm: clock-controller@63000000 {
>  
>  			#clock-cells = <1>;
>  			#power-domain-cells = <1>;
> +
> +			status = "reserved"; /* Controlled by ADSP */
>  		};
>  	};
>  
