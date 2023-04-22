Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B606EB85A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 12:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjDVKAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 06:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjDVJ76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 05:59:58 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AC01BCD
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 02:59:56 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4efea4569f5so169945e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 02:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682157594; x=1684749594;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fRbWMrtRPw5tKO1dZRharcTg4G5vu/RojnoHNMZk0Vs=;
        b=zhsOEGdeI+Scd7u+CJBH2RPUANEiwJt6aqS9afI/7PwJfQ7sQ6z6p0ToTX38xHSNnZ
         q5iieMqPQCPF3klGiU4nPkxpuSOF29e5ZMw7l3mYHV4oWry7WJ+r9CWuw8mNgbwXv6bf
         Gn4kBNGmja6T+OxQX4WrKWfc0IwzWxke+kYAmvM5APEFIsZ0/oGMeJG6ssAOPcl3rHHZ
         BrmUWyceF6of4Zu8JudVehVEGN8NqvolGd2/ilsCi8NcWoPWC/bgWeU/QMLNG5PssoB9
         pLuB8ZdE9tY0Fk5ON+iuJkNuQOW2fYBJKS2N/pZnRZaRGTKJ27SHpUL9joX/qTB/16gJ
         KrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682157594; x=1684749594;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fRbWMrtRPw5tKO1dZRharcTg4G5vu/RojnoHNMZk0Vs=;
        b=ZvUpe6CIC1PwWVeOjKBNUXyHORuzH1nm9jNsbIm1PnCz67J376zpgkTgeKXeU/gOMz
         vGPRBnohhGh1pcndR7dZ74IeAM7ksDUXFsP04uRKN3ytpOH6qPIruxBAk81IVICZ1k1x
         BB+6J5ArjDPMUrpjD/No/FiJiXbI48v5f2WOAFyBY7DB/p9MSdhwsjMgD6HIFcx32Bhm
         6RC2aF7Z58GlmxLLw03fglGbBxblUgc/HVQI5lngtjN1sj4z0Koijmg2VsKj+DFSXvly
         78+PiA1fjf5x1mhsxjcty0Wrr5jqpCy/c2YK06WyGofZTZFTJz4Aw/9cdeK7ca1AeKbd
         dZjA==
X-Gm-Message-State: AAQBX9fEwiDThXY2GNiUDuYfELvYO7768u+6RoQn5RbZnjyobE8UQeqB
        wZI2iZ+mpVwx7DlXhnROFw+d7w==
X-Google-Smtp-Source: AKy350Zgzg59kN7Ze0MMHfZgL8yLoD63YAcHDChKW1pjTA37p00j1SNnA6GCQ5FsFVgDkHG0VTk0Mw==
X-Received: by 2002:ac2:4f86:0:b0:4ec:e32f:3d29 with SMTP id z6-20020ac24f86000000b004ece32f3d29mr2069717lfs.51.1682157594670;
        Sat, 22 Apr 2023 02:59:54 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id o22-20020ac24356000000b004edd490cf77sm822804lfl.275.2023.04.22.02.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Apr 2023 02:59:54 -0700 (PDT)
Message-ID: <b9cd7b67-4aa6-3e84-41fe-61f2c7f0edaf@linaro.org>
Date:   Sat, 22 Apr 2023 11:59:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] ARM: dts: qcom: msm8974: align WCNSS Bluetooth node name
 with bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230421195437.31513-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230421195437.31513-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.04.2023 21:54, Krzysztof Kozlowski wrote:
> Bindings expect WCNSS Bluetooth child to be named "bluetooth":
> 
>   remoteproc@fb204000: smd-edge:wcnss: 'bt' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-msm8974.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index 939449a0c695..58e144957c5d 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -746,7 +746,7 @@ wcnss {
>  
>  					qcom,mmio = <&pronto>;
>  
> -					bt {
> +					bluetooth {
>  						compatible = "qcom,wcnss-bt";
>  					};
>  
