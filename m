Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475246CA6B0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjC0N7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbjC0N7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:59:07 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF09440CB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:59:05 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id y35so6618369ljq.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679925544;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tHuButm+JKrD0k0PAzu4NQYuzqahXjCrFzScIxc9JRs=;
        b=frd4XJIkuYQPEouh8pcHYEAwEO4OtXi8u3Ycmy/kGXdd5rJ0wsnz/tCXq9hZWx5qkz
         J9PMMi2fZe3O057Jy7dVKiojllW97UrNxKItbtkWNh2NGZE6S7LX4alQXpU7rr00+Xxh
         4szbpcgW0z/34e3L1I9IUDFJPDDYCLPQWAtIbfipK9j7usFwdz7dJbE+DfgKP7E4iSl8
         HJZGkf9SIIjJzUlk8P/2947GSzX0JUaRmProwQvZ7g5JqikLvnQyKYtGWaGJAorbREOS
         XnJ5sZ6RFj3j+3oNAleSIVY8dFkr3nePF8PZh6k4lBJYpEGAeaj75Pd6ud0j8GrFci2l
         Sihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679925544;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tHuButm+JKrD0k0PAzu4NQYuzqahXjCrFzScIxc9JRs=;
        b=OyAEwi7f51KSzgLCwKt0KAHxFGzhAzi1MKGl3XaBxfiBzuXP7wYdvF7f/h/BMuHzI7
         q2gLUytshqxtWgWijVadmvMj8+su+biQUZBd6aBQ5hxNn9wTSDiUWVEgChHTFnMfw8go
         O3Lpe3fmMuyY5MLQ60ALVRuGGoG6czqYgUr3fAdg0nv4uSVIALtcIT98wzKBJhrQ7FV/
         oigCCo0LtmFMWwjAgWtueUQDTUgbd717J1jJTzzxaoYk+KU7cYiLjh2dqJ0SAmqYKFz3
         oN2EOrNLmOm9vFSbp15m5hOOypR0O/Y9Wti9VEUtjUpDY+VLplcIslmlJkGkCOhqztaZ
         iNfA==
X-Gm-Message-State: AAQBX9fDp46yPPlLWNM0rvbmC/EXTBys2sfyJzb+9sJ4QTw6c9YQCoZ0
        I9tx4XRsibhYHVmNebTa3QoB6A==
X-Google-Smtp-Source: AKy350Z8Ok4/26x+lDsZoUOePn+2xXP1XrH5c+EGh54s1v1AVIDVT5VKIN/6xJAt2q8aXllTlPO2gQ==
X-Received: by 2002:a2e:9883:0:b0:293:5164:4f2b with SMTP id b3-20020a2e9883000000b0029351644f2bmr3686547ljj.8.1679925544144;
        Mon, 27 Mar 2023 06:59:04 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id k2-20020a2e8882000000b002a2e931fc48sm1595536lji.140.2023.03.27.06.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 06:59:03 -0700 (PDT)
Message-ID: <46082dde-d633-3b0a-6418-3c69f72962c2@linaro.org>
Date:   Mon, 27 Mar 2023 15:59:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-pmics: fix pon compatible and
 registers
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230327122948.4323-1-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230327122948.4323-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.03.2023 14:29, Johan Hovold wrote:
> The pmk8280 PMIC PON peripheral is gen3 and uses two sets of registers;
> hlos and pbs.
> 
> This specifically fixes the following error message during boot when the
> pbs registers are not defined:
> 
> 	PON_PBS address missing, can't read HW debounce time
> 
> Note that this also enables the spurious interrupt workaround introduced
> by commit 0b65118e6ba3 ("Input: pm8941-pwrkey - add software key press
> debouncing support") (which may or may not be needed).
> 
> Fixes: ccd3517faf18 ("arm64: dts: qcom: sc8280xp: Add reference device")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> index c35e7f6bd657..a0ba535bb6c9 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> @@ -59,8 +59,9 @@ pmk8280: pmic@0 {
>  		#size-cells = <0>;
>  
>  		pmk8280_pon: pon@1300 {
> -			compatible = "qcom,pm8998-pon";
> -			reg = <0x1300>;
> +			compatible = "qcom,pmk8350-pon";
> +			reg = <0x1300>, <0x800>;
> +			reg-names = "hlos", "pbs";
>  
>  			pmk8280_pon_pwrkey: pwrkey {
>  				compatible = "qcom,pmk8350-pwrkey";
