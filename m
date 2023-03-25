Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02366C8DD8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 13:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjCYMIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 08:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjCYMIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 08:08:12 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24814113FA
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:08:09 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id e11so4271474lji.8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679746087;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FrB9b88U0h+qwt/THj6bEYac8jJtD2V/B+CqKc3E+oc=;
        b=oXxa1rTManxlzoFbdkuPS19JV97ZHVrIu4gKS5lWrKjZVg/oUL0XBesH3Yqa1wMGu+
         C2/5l1dCJYyIOpU9RmuY2G5ibpem3gwt9QPgCl92TdQWzBU2sAt2j5AU0j7nPRqHRyqe
         XP8NeVz1hQ56wpHF2AQgz56UntQkCjXmJz6wPHSFDWiQOAiqBRpaSe4p/YHy/xgZtHDN
         lYSqHcCTPInEt4m7PshgOt9HfzKUy6her5NO30acbR2Gt2e1x7xH3VicGzFP/ZYqVSEd
         cIufDceDalCFwvSFc6lXaK8a4Y3WzganlocKkXgHhe1CeW9hiFHUds7DcbQ/okYCTTiC
         xS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679746087;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FrB9b88U0h+qwt/THj6bEYac8jJtD2V/B+CqKc3E+oc=;
        b=hH7xd0IdkKLhxK8PuQZ7c3cKcxarVXZ71l2NzhzUbyY/mow3NPYnbh4nFIw3lgQNqm
         npWivaccjzcTW+4e+ESIc48Fi61e6M5gsywitnUNK7abeC7aK4YIc1hJN/d2pD7WF+wH
         7eaG7Px6i1U6TJTFHzDWwUgb/ovQiuvFMejuzk3yOd06LvCD93sosV2racrNJVV8vV1T
         IqmbE45X8zwZEVtDfHKWAWmtkpf8u2BOZ1KMEfPg2x4E5TRennK263tn2mlDmKoBWHc0
         TK7aDgqtBQiK2nrbLjfTRx2Ndu0g7/zBpAH51VmJs8aJDcIO4mKERn4XnPaCe+2LYWEx
         jSyA==
X-Gm-Message-State: AAQBX9cXf0NAgXUBNluLobJ17B5xIFlrXdKoVtn3oCs7JglCMngf1BtX
        DLl5iTuWj9hbGrs2Hulc/9VlCg==
X-Google-Smtp-Source: AKy350ZHPkspQ8jAARW91n+j92RdBtsfoXpoACwO244WO/pUiV9aIBT2RBltE88Hf4Eqn3iosTmnPA==
X-Received: by 2002:a2e:988a:0:b0:29b:d235:2c50 with SMTP id b10-20020a2e988a000000b0029bd2352c50mr1932193ljj.25.1679746087430;
        Sat, 25 Mar 2023 05:08:07 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id w7-20020ac24427000000b004db4f2f08f7sm3796784lfl.28.2023.03.25.05.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Mar 2023 05:08:07 -0700 (PDT)
Message-ID: <5123fe11-2f94-faea-073a-41f93e23b76a@linaro.org>
Date:   Sat, 25 Mar 2023 13:08:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/4] arm64: dts: msm8953: Drop unsupported dwc3 flag
Content-Language: en-US
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230325112852.18841-1-a39.skl@gmail.com>
 <20230325112852.18841-3-a39.skl@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230325112852.18841-3-a39.skl@gmail.com>
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



On 25.03.2023 12:28, Adam Skladowski wrote:
> Property phy_mode according to binding checker does not exist,
> drop it.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---

grepping for it in drivers/ also returns nothing

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/msm8953.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> index 5dd10c35ee0d..0a1bf1058cbf 100644
> --- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> @@ -977,7 +977,6 @@ usb3_dwc3: usb@7000000 {
>  				snps,hird-threshold = /bits/ 8 <0x00>;
>  
>  				maximum-speed = "high-speed";
> -				phy_mode = "utmi";
>  			};
>  		};
>  
