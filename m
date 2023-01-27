Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF4867E4AF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjA0MKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjA0MJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:09:42 -0500
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF567922F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:03:11 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id me3so13054760ejb.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L+nKee/XbBGW3+yUBaZriE12dkxML7gdb0W0OXQfEAI=;
        b=VmCnAMspJnEDRlwDiJkVljuxmRQmeDxD65ky4Wm6OePT20M4ruBhJFGRAmCpBbGSvw
         qfYYHzR4SDdcEuryvuR38IGuG+38mVfh0FwJV5Dug7SUI9ngjfQm51mFawRoP1Mn3IK9
         f/Z0ezqRMVbOppCfyvr9VrFNk07tKJrPg5jEyiAdqD+jA0iKZa4pWGFFIiZMzQSkcRCG
         rCbfBWOoE916ZmWVQzYcJBp0Kt0Yj2XbFFH5/7wUqDm68HMjGYkOay60A93nGPmJ759u
         PpQfVWxUlgZZ60SPAH84f0ha7crA3UgCUPpBp5aJSeDQ5BHNnbqWq5gaiKdIWCe/1CGx
         7jZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+nKee/XbBGW3+yUBaZriE12dkxML7gdb0W0OXQfEAI=;
        b=CuIIW2DcfKsyh6lLwWN0NJlv5umiWHObVR6ar+u3PCLO3Y0IRf8s9WNHvkmZPwXDKY
         SmKFEcZGUef2T1ov2s6d4mZsg6N3IfDE1iccaVbAAUq6Zp1BAJ/rQIIcEZ3h4mkkSwUH
         8Q3uGfrF+dNwjqeuUs05u7WRyFm27JVjB5GaajoLOTjUXB9Bj92AMnTzzOrxCNlbnx3j
         sKIANdiWQRAq75VclLKkbsSHyVxYv6T3JrY7bG5je2E7jcuOkmUi6Brn5sWzTvtqlrZu
         aIYk16V6HT4PBLcjiZn8eLMMuuPgNOsWCSHqhh7j0bgfmKQ0wqRfq96GboixR0JhE5Dn
         X3lQ==
X-Gm-Message-State: AFqh2kr/g+JDR/S+lDueQo/yovJZtW0w+g0/+G0+VmiyvApperFeFRaO
        0ZHBJXrfHyVShQjKKGq5/3f9/Q==
X-Google-Smtp-Source: AMrXdXsOuo8qMqtqYGN5RfrmmdYh3OmDkRlCJU2aC5LWx7MQdTYl0+sEhndrGRKR3qdL++FzJf2NVg==
X-Received: by 2002:a17:906:8618:b0:877:5772:25f with SMTP id o24-20020a170906861800b008775772025fmr36834647ejx.60.1674820587106;
        Fri, 27 Jan 2023 03:56:27 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id rs14-20020a170907036e00b0084c6ec69a9dsm2085205ejb.124.2023.01.27.03.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 03:56:26 -0800 (PST)
Message-ID: <573c9b6f-984f-add4-7792-1df848918b5d@linaro.org>
Date:   Fri, 27 Jan 2023 12:56:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 07/11] arm64: dts: qcom: sm7225: align RPMh regulator
 nodes with bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230127114347.235963-1-krzysztof.kozlowski@linaro.org>
 <20230127114347.235963-7-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230127114347.235963-7-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.01.2023 12:43, Krzysztof Kozlowski wrote:
> Device node names should be generic and bindings expect certain pattern
> for RPMh regulator nodes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> index b86a1c6f08be..52bb48c02536 100644
> --- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> +++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> @@ -115,7 +115,7 @@ &adsp {
>  };
>  
>  &apps_rsc {
> -	pm6350-rpmh-regulators {
> +	regulators-0 {
>  		compatible = "qcom,pm6350-rpmh-regulators";
>  		qcom,pmic-id = "a";
>  
> @@ -244,7 +244,7 @@ vreg_l22a: ldo22 {
>  		};
>  	};
>  
> -	pm6150l-rpmh-regulators {
> +	regulators-1 {
>  		compatible = "qcom,pm6150l-rpmh-regulators";
>  		qcom,pmic-id = "e";
>  
