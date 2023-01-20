Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EA66753E1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 12:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjATLy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 06:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjATLy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 06:54:28 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD4E95776
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 03:54:21 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id mp20so13293510ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 03:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kmc13JZHLizSO1b5AizKEv/IyIZQ9QfOehjHXccN+1w=;
        b=CLZSCYGO/aEX2Amn4LQChgjEyceA9pOeKLM1F9VLp0w0AddgtEBcdn0oFUiET014Js
         2T5HtpgtzOPVEXzReAyPxqAvxX/P4tL025MHxF1tf8XmxRPQr3kLJ78PqU08Azj1Omdp
         ceqMWWixcYrE+3Z79Kqick7u1jJUzyy1U867afB0EII7Y5af/YjSAFzvcf59TwP4cSXV
         RdVGkrFGKQUX2I1nw5WjzX7NX/xWETCDkONmYS4vj52lM1vF7xV4iw+te75TEfP+VgvL
         bIfCfwMR1n8FmLfQza+dHoT4h3PSlvRH9B/m9UAk3ykb6deSrqtyVJHaCmkoXz6uWm5h
         ZqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kmc13JZHLizSO1b5AizKEv/IyIZQ9QfOehjHXccN+1w=;
        b=SOyD1nout5JcH/L4s9Dd/TNyuVtkj1YAfNeCH8K6XdpM7qddSzncOUgu1noTsy1bk1
         YwbFG7LTZd3XBUyfJyk585eLTv2mdlAA7USAcLbVmI1nVbaGCDAQjvCysT78fad9bxEW
         dN/CRqQEkd+t3+ptoyKnPyI337qMOaae262LjP7z3oHukKWrvUiE0403bOjHHep8FCcw
         HrrzYauzJYognLHgBgHfaFgON45Ar9hCjp8RGqFidsWu72m8rEWP+6c7oLQLC4bCtiIa
         QPqyHZGM2tVrcBAutaJKVorxqY8PGmL1YArM2j1tIprLFbEwZUThC9cBcnRxeNex4c03
         qkjw==
X-Gm-Message-State: AFqh2kpPlkMZrndpEmRrxsJfhAZfvD5T1zQ4z0dJpdBmJuIe6Nk3z7bI
        fmpQ7D4JeeQ8E52aOzCgPM8yIA==
X-Google-Smtp-Source: AMrXdXtltxSpa5eejB92LMqiZ3I1DCMYQXS6EmVQq6E1egTWhf1N0Cty8OY6f9KfwHdOiWtRk3/sSg==
X-Received: by 2002:a17:906:b14b:b0:864:1902:7050 with SMTP id bt11-20020a170906b14b00b0086419027050mr14397158ejb.69.1674215659576;
        Fri, 20 Jan 2023 03:54:19 -0800 (PST)
Received: from [192.168.1.101] (abyk37.neoplus.adsl.tpnet.pl. [83.9.30.37])
        by smtp.gmail.com with ESMTPSA id l6-20020a170906078600b0084d381d0528sm16576066ejc.180.2023.01.20.03.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 03:54:19 -0800 (PST)
Message-ID: <bc93f8cf-bf25-47b8-ca57-0653898dad25@linaro.org>
Date:   Fri, 20 Jan 2023 12:54:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm7225-fairphone-fp4: Enable CCI
 busses
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221213-sm6350-cci-v1-0-e5d0c36e0c4f@fairphone.com>
 <20221213-sm6350-cci-v1-4-e5d0c36e0c4f@fairphone.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221213-sm6350-cci-v1-4-e5d0c36e0c4f@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.01.2023 12:11, Luca Weiss wrote:
> Enable the CCI busses that have cameras connected to them.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> index f0e7ae630e0c..ed0cb70849d3 100644
> --- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> +++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> @@ -363,6 +363,26 @@ vreg_bob: bob {
>  	};
>  };
>  
> +&cci0 {
> +	status = "okay";
> +};
> +
> +&cci0_i2c0 {
> +	/* IMX582 @ 0x1a */
> +};
> +
> +&cci0_i2c1 {
> +	/* IMX582 @ 0x1a */
> +};
> +
> +&cci1 {
> +	status = "okay";
> +};
> +
> +&cci1_i2c0 {
> +	/* IMX576 @ 0x10 */
> +};
> +
>  &cdsp {
>  	status = "okay";
>  	firmware-name = "qcom/sm7225/fairphone4/cdsp.mdt";
> 
