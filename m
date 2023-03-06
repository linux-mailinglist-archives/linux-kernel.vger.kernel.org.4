Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90456ABD8D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjCFK7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjCFK7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:59:02 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0DF26CF6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 02:58:57 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id t11so12167699lfr.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 02:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678100335;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QRgn6w/cw+o3OrWZ0KAVWBOqokaY7DfR8nXqt+hZ3Y4=;
        b=M4hHV1gz16xRTvMY1WVyqb4288RwQGId5EadupcwMnOiBIE2zzjc/KCeqd4RyN0sRh
         G/n7IN3d43jqgDA+QBuspgXMsLn6H9inEy7g3H6QZJCwMlj++srpMN4d9dEEGGPpC238
         X2HSfy1kck96wJf9ANWaxtqVg3nwMWl6itR+Pjf54OI/BKs73D7MH39aaSiKJ1k20BGx
         hIjb646qxgVeaEXIKlQ7cr1k7Rnhb2qqhayTPg1jBRsbVfSEFwZy9Gql/sYfqwuAE92y
         TpyOQMlefITBzoHOauqqolzd2gy9scm+Ur28ODNC7yR+6o0vT/VuZeEKFwCOx/jQlygR
         vwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678100335;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRgn6w/cw+o3OrWZ0KAVWBOqokaY7DfR8nXqt+hZ3Y4=;
        b=bp4/arGQAYHEmN8A77DB1k+pEoHtX9yoypylaKS07m2Fs4Dnp3oYzlOcD94T0o7NzB
         NVeed5DScneA0LK8DVVtjtFvwGipesVgVVbTC6jqnFzCsM0YNf+MkT43xQqnpbEQaIvV
         F2gEBUvWY5XKsobLd5e80O7zJvDw2WWY0xy1yKr3y5sPM4ukA3Ksv9s27PlzqZI1kd2V
         j97g4yrqt0kNFTY3ksuTtHGDKqXt21st9KhHbRtX/zbptUuWFdrR4+luz3AskDMZVqTr
         pChVsF5snpf3bjP+5CHcqtD0TGZSiRvfrefNrKK1Q7bPI/9aP9hZtNmVR86hW9b9HEfL
         uzxQ==
X-Gm-Message-State: AO0yUKUbtYOWx3HzbSluyxqPijnadQygVQFICz2iSPMM9R3RLC5Hilbr
        2/tZELTgq3rzTpeN/vzX5STYyQ==
X-Google-Smtp-Source: AK7set8g/vDN/ZR2gT8pA6AHURXz+9Eu5DRbBnBlfOs/lKMCtmxQvsfrYlJyzV6AOOghaq4vMWXpFA==
X-Received: by 2002:ac2:4a90:0:b0:4cb:d3:3b99 with SMTP id l16-20020ac24a90000000b004cb00d33b99mr2771264lfp.36.1678100335433;
        Mon, 06 Mar 2023 02:58:55 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id u16-20020ac24c30000000b004d53e991be0sm1609436lfq.146.2023.03.06.02.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 02:58:55 -0800 (PST)
Message-ID: <cfd37a3d-a74c-7567-668a-45975dc2b93b@linaro.org>
Date:   Mon, 6 Mar 2023 11:58:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 09/11] arm64: dts: qcom: msm8994: correct RPMCC node name
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230305125954.209559-1-krzysztof.kozlowski@linaro.org>
 <20230305125954.209559-9-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230305125954.209559-9-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.03.2023 13:59, Krzysztof Kozlowski wrote:
> The bindings expect RPM clock controller subnode to be named
> 'clock-controller':
> 
>   apq8094-sony-xperia-kitakami-karin_windy.dtb: smd: rpm:rpm-requests: 'rpmcc' does not match any of the regexes: '^regulators(-[01])?$', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/msm8994.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
> index 9ff9d35496d2..768fe2326933 100644
> --- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
> @@ -242,7 +242,7 @@ rpm_requests: rpm-requests {
>  				compatible = "qcom,rpm-msm8994";
>  				qcom,smd-channels = "rpm_requests";
>  
> -				rpmcc: rpmcc {
> +				rpmcc: clock-controller {
>  					compatible = "qcom,rpmcc-msm8994", "qcom,rpmcc";
>  					#clock-cells = <1>;
>  				};
