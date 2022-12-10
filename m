Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC7E648EA0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 13:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiLJM16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 07:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiLJM1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 07:27:54 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D49512085
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 04:27:51 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id p8so11112156lfu.11
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 04:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hL8OKTsBpCIk5bwyuSbiSYJTAFZeqxkxeYJRIQBbLsI=;
        b=j68C+ikMs/qgvI6eAl3mR6uKQmL7kv2KHp+JRZU53Q/N88+iUr+p2v6CIuI71erJW5
         Kv3JL2g57VS6OlFbptNI+OECmru86ZDzOTKTVv2471EGB2fReFBRYQphW4WnAEst7Crd
         dx5WKaUGDOx2mNOD7oawEW/zxGx3MD+j7HN81uPzpuHZcCJoRDHrgtklW7a22DbqRz6h
         PrYwSVWxd7zwK/ybxDQM8dIn2q7mhHH/db62FR9FhztNT1HFZQM+bNvJPn+u7YS9rqqN
         0l6RC92m4WDP42qCkkbB3Co322drCtKqFD+Wd/mVEM08ZFAN/IPO7tKJsBfKdSVVgW+9
         eoqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hL8OKTsBpCIk5bwyuSbiSYJTAFZeqxkxeYJRIQBbLsI=;
        b=wG597Gv7HWUUFyKuusgHKWSb7dI3pV87hoo30RNO4TEjCqMMumT0go+UBsWvaYUHOg
         vRsMw30BnqkXBssd1tyBtjFWzvCeZzhfb/LdynzUIptEDZram08cDkj0hfd+/5zcapsx
         tQDrTWQPdW8+fjaqL0HI9kFveXr6C7NnCB3BGfJlrRDppLs37LfmPygGQSEv0L9+M+we
         dOle7BJW9qqUbVWqEc6JGgQ2UyrAs7Hqh0Scms5kxGRp18k8Nygm1Yj1OHQUhgzJz8RD
         jvpC12nkaDiWynd0PTfA8tTi0QtQw7RwZeo3SKFyi1iytDuFn7G9X4SqiEebIa/Qyrfl
         lvfw==
X-Gm-Message-State: ANoB5pkAML8sg96PyKkJFBNXezh4RSjsnhbnLRno0CjcU75Y0kh3Stzr
        4pQ8BLKdyGwwTkz1ailg95yN7Q==
X-Google-Smtp-Source: AA0mqf7AGRp7RmPuhnbe4sPSP0hV0BzPUCpU85osW+PHZPFuh8Edw1OB2T8RoQKQ7L8TkbHWEMiwDg==
X-Received: by 2002:ac2:4bcb:0:b0:4a4:68b9:66bc with SMTP id o11-20020ac24bcb000000b004a468b966bcmr2567653lfq.7.1670675269868;
        Sat, 10 Dec 2022 04:27:49 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id d9-20020a056512368900b004b57162edfasm696269lfs.117.2022.12.10.04.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 04:27:49 -0800 (PST)
Message-ID: <985e763d-2fa3-4c0c-4970-7c4b47c162c7@linaro.org>
Date:   Sat, 10 Dec 2022 13:27:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sdm845: move sound node out of soc
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221210115704.97614-1-krzysztof.kozlowski@linaro.org>
 <20221210115704.97614-3-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221210115704.97614-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.12.2022 12:57, Krzysztof Kozlowski wrote:
> The sound node is not a property of a soc, but rather board as it
> describes the sound configuration.  It also does not have unit address:
> 
>   sdm845-shift-axolotl.dtb: soc@0: sound: {} should not be valid under {'type': 'object'}
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 573b2394e63f..14a409f22bfd 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -3972,9 +3972,6 @@ lmh_cluster0: lmh@17d78800 {
>  			#interrupt-cells = <1>;
>  		};
>  
> -		sound: sound {
> -		};
> -
>  		usb_1_hsphy: phy@88e2000 {
>  			compatible = "qcom,sdm845-qusb2-phy", "qcom,qusb2-v2-phy";
>  			reg = <0 0x088e2000 0 0x400>;
> @@ -5349,6 +5346,9 @@ wifi: wifi@18800000 {
>  		};
>  	};
>  
> +	sound: sound {
> +	};
> +
>  	thermal-zones {
>  		cpu0-thermal {
>  			polling-delay-passive = <250>;
