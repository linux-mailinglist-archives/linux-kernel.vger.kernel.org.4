Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBD0673B7C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjASOPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjASOOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:14:23 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E1F7ED64
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 06:13:41 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 18so2998485edw.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 06:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2b72xzyYEwe+BDz0AdbUJhplbp7LG8mUHd24+FfdEnY=;
        b=hOcKUt8aJ03XfHinJXi9uOUSqHeneVvv6N9jD5QdyQNMSvFnZTMY+WhUULL5ql7AJG
         PlowfebVGvu9GvU4XbjGsohpSEXlw7aLbQL7fkIQ9aEKkaKQYseN0ZEMHL2KPrnB4YFx
         eDmAWmQ5fzwGKhMCp4Uxf57t2uum9sirXyERxZCx4lgcAEmrX0uWAvKZHPY3RRzwRYaK
         WifVWT858oxF1qSCYYSWsykK4Tm8UtbBKRu7dO+DEn75h8UUSAQ6jAAcHRW+aMmXkMgu
         kZBLtraClUixCEpDwIc91QcG3sJpZyVC5TzZewgiOBZYcOpujAn0CumNPKuW+YHExZVt
         YAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2b72xzyYEwe+BDz0AdbUJhplbp7LG8mUHd24+FfdEnY=;
        b=ijII7n0qGdAP1eQAdltafIp6Me6MdtAghvyQihBKpB2g1wDbijiM8c3kbxX80BPSAI
         otwN9rgxt+VG3r4wJbtBSbSIJziRONy6CGDoLNvIXLNIsUxUTZvjafvkucZ1shg/Sdvu
         05jPwHCz+cWvzmy+iU0jme0GWztwunTEk2aErn1laxU0sI9VIL6E5zrkz0d4H0Gmr9QR
         V3gZ+sfL18LbeexwCr4v9W5zdH2Ze7ghZvRtrrGLec6YTIF8KfloLrid7I40VX4m83bC
         a1Bt/GWwP7xCYgjotNRFxFmPwAz6eRfKXy0bAABsZMq98og6KHpIPDsmFDYVh0C/ZS2M
         K+TA==
X-Gm-Message-State: AFqh2koI8VH6LOVNhVzjHWA5Dw7PVgjeNsEFgV1haBv463AKxS1KfXtH
        wvpCqGQNbSfPVHs9ILC5zr1/Rg==
X-Google-Smtp-Source: AMrXdXuImw9mytoihWW77/1Cfkomh9Xw/jeOOR7Osdu4QWrGgo8E7yBIcJ6Axn3RyxTSuUO6uihIiA==
X-Received: by 2002:a05:6402:2405:b0:49d:1a59:176b with SMTP id t5-20020a056402240500b0049d1a59176bmr13326366eda.30.1674137620192;
        Thu, 19 Jan 2023 06:13:40 -0800 (PST)
Received: from [192.168.1.101] (abyk37.neoplus.adsl.tpnet.pl. [83.9.30.37])
        by smtp.gmail.com with ESMTPSA id dk1-20020a0564021d8100b0049be07c9ff5sm8549381edb.4.2023.01.19.06.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 06:13:39 -0800 (PST)
Message-ID: <65dde4c5-6189-d3a2-83a1-7a0cae9b70d0@linaro.org>
Date:   Thu, 19 Jan 2023 15:13:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sc7280-herobrine-audio-wcd9385:
 drop incorrect properties
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
References: <20230119122205.73372-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230119122205.73372-1-krzysztof.kozlowski@linaro.org>
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



On 19.01.2023 13:22, Krzysztof Kozlowski wrote:
> The sound card does not expose DAIs and does not use custom qcom
> properties, so drop '#sound-dai-cells', 'qcom,msm-mbhc-gnd-swh' and
> 'qcom,msm-mbhc-hphl-swh':
> 
>   sc7280-herobrine-crd.dtb: sound: '#sound-dai-cells', 'qcom,msm-mbhc-gnd-swh', 'qcom,msm-mbhc-hphl-swh' do not match any of the regexes: '^dai-link@[0-9a-f]$', 'pinctrl-[0-9]+'
> 
> Reported-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi
> index ae2552094cda..020ef666e35f 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi
> @@ -32,12 +32,8 @@ sound: sound {
>  			"TX SWR_DMIC6", "DMIC7_OUTPUT",
>  			"TX SWR_DMIC7", "DMIC8_OUTPUT";
>  
> -		qcom,msm-mbhc-hphl-swh = <1>;
> -		qcom,msm-mbhc-gnd-swh = <1>;
> -
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> -		#sound-dai-cells = <0>;
>  
>  		dai-link@0 {
>  			link-name = "MAX98360A";
