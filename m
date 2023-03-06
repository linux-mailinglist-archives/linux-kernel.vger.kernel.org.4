Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B996ABB7F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjCFKQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjCFKPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:15:50 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE21BA278
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 02:15:12 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id a32so9019513ljr.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 02:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678097711;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U3pbhbSJq+ZjD9gAm1LG1AvuTXhrDcMqLXEUKg4jeqQ=;
        b=Dw/70j1shtqKVCMQRKqVeMr246XqcwpioJww0wYaTmKt3kAxYOwdCJWLg+HrdtGeko
         tIdefXbhRJAxVBDvqbdtnMEQPvCiBcrWFb820UcGPeyrci17H+ZwFjvvCHHw1qqpcDFz
         8zWxo8DtUzAm3KxxIbcp02sqaDpwu46qAP732vJCBamVbDb6ES79pbDxD6f3qQBkEnLa
         szY75sungEluCd7LDZ0FZ1Lc3RkilVnooc3iEOXEz8/kg4q5k099e8J5BZQhyPUshREX
         FwNSb+PEf6VH9JFWOzG9mO+jaWG7C3RsDretZfFhjJ4tctsjvBn+8UyCp+tTnnBM/Ef0
         nGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678097711;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3pbhbSJq+ZjD9gAm1LG1AvuTXhrDcMqLXEUKg4jeqQ=;
        b=0okiq31ZY99J/wydXrhd6F1+mFnMsj7AT8lzfwlWd1VXV8mEnS8wpPjcj8cV/HY3BA
         Ii1nwyjbAcO6IQBJGqZvvtI50CoRQdMvBru9mvvpDSjFmx3cFZZkLBARtQ45eU+yLoSc
         3+eRo91fTUSCHWGokW8vOK5TFkN+YJbydKWSLe5y2A8SGCfxCszP83Qucq79zP3/YsxS
         VvFC2zjq3x2Amje5RXyceVcQDXhPAOOhZK7ZZ2uHZXXyT2Fq/YIm/vraV5faxFb4wIJi
         Fdz8Rcg0xmw7bxQmI3v61YdHKdDzNlMa46mRYu64csM0KmOoYCOkxIruhGPH5Zo23Etq
         xQEQ==
X-Gm-Message-State: AO0yUKU9W/4/iIYVz1JVL3qRpwiL0dQ/WMDkMlmFX5kruxIwkvWPQEqr
        t0k03hiG9xfyz3EmkE8crKBn8Q==
X-Google-Smtp-Source: AK7set/6352seV4dB0uwZtsgIwCViYWmi4QRlYYXvs6JeuqengMsisaxhROtPxSZEMflZqm4c09ONQ==
X-Received: by 2002:a05:651c:199e:b0:295:9bb9:18c2 with SMTP id bx30-20020a05651c199e00b002959bb918c2mr3726329ljb.18.1678097711237;
        Mon, 06 Mar 2023 02:15:11 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id x2-20020a2e9c82000000b002935a8d9351sm1625753lji.55.2023.03.06.02.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 02:15:10 -0800 (PST)
Message-ID: <50724ddd-3fd8-a7aa-e9f5-67d87b7d56d4@linaro.org>
Date:   Mon, 6 Mar 2023 11:15:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] arm64: dts: qcom: pm660: align thermal node names with
 bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230305154308.241651-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230305154308.241651-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.03.2023 16:43, Krzysztof Kozlowski wrote:
> Bindings expect thermal node names to end with '-thermal', so fix pm660
> and pm660l:
> 
>   sda660-inforce-ifc6560.dtb: thermal-zones: 'pm660', 'pm660l' do not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/pm660.dtsi  | 2 +-
>  arch/arm64/boot/dts/qcom/pm660l.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm660.dtsi b/arch/arm64/boot/dts/qcom/pm660.dtsi
> index fc0eccaccdf6..4bc717917f44 100644
> --- a/arch/arm64/boot/dts/qcom/pm660.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm660.dtsi
> @@ -11,7 +11,7 @@
>  
>  / {
>  	thermal-zones {
> -		pm660 {
> +		pm660-thermal {
>  			polling-delay-passive = <250>;
>  			polling-delay = <1000>;
>  
> diff --git a/arch/arm64/boot/dts/qcom/pm660l.dtsi b/arch/arm64/boot/dts/qcom/pm660l.dtsi
> index f9b3864bd3b9..87b71b7205b8 100644
> --- a/arch/arm64/boot/dts/qcom/pm660l.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm660l.dtsi
> @@ -11,7 +11,7 @@
>  
>  / {
>  	thermal-zones {
> -		pm660l {
> +		pm660l-thermal {
>  			polling-delay-passive = <250>;
>  			polling-delay = <1000>;
>  
