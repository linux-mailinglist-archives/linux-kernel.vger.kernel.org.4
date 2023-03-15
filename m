Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B196BB934
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjCOQL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbjCOQK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:10:56 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A8790B4E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:10:22 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id f16so19979802ljq.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678896620;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+2oNQhuWFl2xmjcGLuuONOAMitOfeFrzp8haVzsoX0w=;
        b=zNSd8aZRnYTp/dVaghTYE52N2Muzd8hzkgV+06GTLjEGcVgjLd5uBDXbgQeQ+QeVpE
         pS3NeYtqM0at4xzl3QmTtzIS+UXr+2K1nlJcGoyGFxr5cHbo75AQ3z+TH9i7RuGykQrZ
         VSI9ZB9quWDTt/viUHMQMNV/2Gf5x5C6idagsfuahdS3SCduO36rx7EcwnElSyjexYKX
         9UgCd/aNZ1u3H191uhXxpebCKOmU8MLgrjfJnuAif/IBFEVnUFrh7ycXD2QgsW2LmSg5
         wyI7gOkCB8FfVqAT1ahGHGb2Ots3MFonYkQr/xOiM/xoqiTk9epnwZvBo12knadZzFYG
         YtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678896620;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+2oNQhuWFl2xmjcGLuuONOAMitOfeFrzp8haVzsoX0w=;
        b=NEsgfjinXqpHvF96XBt6HS+KhWR99qDD9wTYh/nYIMBdQzcxW89fvurYbcmzsp5VLT
         emn+pQyXQfhVY3W3/9sUEwsmvTCX+yJxZckR1/jb4KmqAEKhnn2uslmn0BKkVUfcYwPZ
         USjJzFXUEvm8PxUNjNDgCUCOLWlNziQr+uTqPwkGdYN2FFoUDh9Ks6vL+h1lvJC7mK3B
         Lk+anwQIPKGHEVW8MCGXuo5g+lIOOZtknsokmaHrMbZ9nq8QZ5blSY8kD6k4Jj6LG6e3
         qml65uZRt6CyJ4xbqowlNAXkQQeBNf1Eb3ZhZLubRyf/aaHMycOWR5QuM1nnM+n4EKNt
         Q1qA==
X-Gm-Message-State: AO0yUKXToT6r4wYAoVmmIRhd3WB/o/Lf3+IFz4G8EDgLW5VLz5HDfrHs
        X65NH5CNQvMAH0qAMG7wIECMXw==
X-Google-Smtp-Source: AK7set8/kniOUBzZbXSQt5chSaEyICBH/kU6FZWPXX2Oajg7gqAEIVV0tva8jm0oRmhdgo+BJckQZA==
X-Received: by 2002:a2e:9b11:0:b0:298:b03d:5715 with SMTP id u17-20020a2e9b11000000b00298b03d5715mr786823lji.25.1678896620381;
        Wed, 15 Mar 2023 09:10:20 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id b24-20020a05651c033800b00298593e3a01sm910401ljp.70.2023.03.15.09.10.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 09:10:19 -0700 (PDT)
Message-ID: <684b31d8-8aad-79e1-247f-b7ef60ac5e95@linaro.org>
Date:   Wed, 15 Mar 2023 17:10:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/4] arm64: dts: qcom: sc7180: Drop redundant disable
 in mdp
Content-Language: en-US
To:     Nikita Travkin <nikita@trvn.ru>, agross@kernel.org,
        andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230315154311.37299-1-nikita@trvn.ru>
 <20230315154311.37299-3-nikita@trvn.ru>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230315154311.37299-3-nikita@trvn.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.03.2023 16:43, Nikita Travkin wrote:
> mdss is useless without a display controller which makes explicitly
> enabling mdp redundant. Have it enabled by default to drop the extra
> node for all users.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts      | 4 ----
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 4 ----
>  arch/arm64/boot/dts/qcom/sc7180.dtsi         | 2 --
>  3 files changed, 10 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> index c3bdd3295c02..828c8b55d925 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> @@ -339,10 +339,6 @@ &dsi_phy {
>  	vdds-supply = <&vreg_l4a_0p8>;
>  };
>  
> -&mdp {
> -	status = "okay";
> -};
> -
>  &mdss {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index 26def6e12723..e72d49a3d97d 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -818,10 +818,6 @@ dai-link@5 {
>  	};
>  };
>  
> -&mdp {
> -	status = "okay";
> -};
> -
>  &mdss {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index f0de177981f9..4ee64ee824b3 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -2983,8 +2983,6 @@ mdp: display-controller@ae01000 {
>  				interrupt-parent = <&mdss>;
>  				interrupts = <0>;
>  
> -				status = "disabled";
> -
>  				ports {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
