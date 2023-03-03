Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A09A6A8E5A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 01:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjCCAw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 19:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjCCAw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 19:52:27 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B8047403
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 16:52:26 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id t11so1622244lfr.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 16:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677804745;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rZoQPzOS2F9b1yxfwL5mradqTzXKrqqaGNTBFehgjNs=;
        b=hOYY7G3r3eoFxOayDXp1ljtkIDBo2YAQlVKR+ey3Bwx0FLxageIxe2To/6W6wTJafq
         fXGd9NLdbPdwNg2k+hzFGwytVz0RD/5czqZkX41usbaCWvH6vVRnV8l4DyYRZHYHB47Z
         95ronfSfXdKqG4DUnYCsc8hNzSVU4fhNN+iqQ7tLEilJqsRMw/wuNp+smbQ/2uulaJLu
         NC/lvAq213/U70QfI4umXOlA7q6RAA1ROkwz4XCXGEhL5ouZQ7A8H6OpMG0IzkzQr2z6
         QVcEkPdMlITsEerSCPuPhXrECn48FklyFW+Rod2Gc25zssSdYaGkyYT8HMzcS2iYtfse
         CR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677804745;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZoQPzOS2F9b1yxfwL5mradqTzXKrqqaGNTBFehgjNs=;
        b=m+NNy5GETlBKxEYnocV+GZrY5T/qdHxL6GT2rm9FYZt3KYc0kSRkAPimqI/kM4U5xw
         X5Osu83yZy55fNyK4e10LVnAwzjcUi9Pcdl8BN+kPt8QKAtjzEnIWbr+lRqaTucuefd4
         sOOozVYNRVfv3P4iOPhP58SS0hdwFqnavX+CFHie1rBlk4pgW0aCvcgpRpNDFIVywfpA
         nfRGXYzUi4wrSrGMrxS01YkQMxTN2+deU6BOBKaMf6oZD9unRVTE+EVhRMkO8oIZepDy
         IptoQ4Iz6NHBjYSy1eFyTnmAWv2NwdQy8xBq3NRZuGpW85NGets6ComjPQWhuuHXqby8
         7KdQ==
X-Gm-Message-State: AO0yUKUKLrG3Ru8AbwirfQpXUKpF5R+m7n54egtPYWVwnNzQqs2cc9DO
        ZeI3Lfbe2IrYHv3Y+YAR4Ijs6A==
X-Google-Smtp-Source: AK7set+sCyp6NFtgrZvO+Sb5lPOEZUsTYXsadh7hvF1COMV0pmgSyFkHfMdk2RsGzw8bTDixtgXhDw==
X-Received: by 2002:ac2:5a06:0:b0:4dc:260e:6b59 with SMTP id q6-20020ac25a06000000b004dc260e6b59mr45267lfn.40.1677804744648;
        Thu, 02 Mar 2023 16:52:24 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id f14-20020ac2532e000000b004ab52b0bcf9sm149765lfh.207.2023.03.02.16.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 16:52:24 -0800 (PST)
Message-ID: <94587945-eff6-8912-f08b-cac2453a1035@linaro.org>
Date:   Fri, 3 Mar 2023 01:52:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] arm64: dts: qcom: msm8976: Add and provide xo clk to
 rpmcc
Content-Language: en-US
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230302123051.12440-1-a39.skl@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230302123051.12440-1-a39.skl@gmail.com>
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



On 2.03.2023 13:30, Adam Skladowski wrote:
> In order for consumers of RPMCC XO clock to probe successfully
> their parent needs to be feed with reference clock to obtain proper rate,
> add fixed xo-board clock and supply it to rpmcc to make consumers happy.
> Frequency setting is left per board basis just like on other recent trees.
> 
> Fixes: 0484d3ce0902 ("arm64: dts: qcom: Add DTS for MSM8976 and MSM8956 SoCs")
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
So your commit message suggests that this commit does not
actually fix the problem, but lays the groundwork for it..

I'd say squashing these two into a single one would make more sense,
as if somebody was bisecting something and landed on this one, there
would be little hope in getting a boot if what you said holds.

Konrad
>  arch/arm64/boot/dts/qcom/msm8976.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
> index 2d360d05aa5e..e55baafd9efd 100644
> --- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
> @@ -20,6 +20,13 @@ / {
>  
>  	chosen { };
>  
> +	clocks {
> +		xo_board: xo-board {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +		};
> +	};
> +
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> @@ -351,6 +358,8 @@ rpm_requests: rpm-requests {
>  
>  				rpmcc: clock-controller {
>  					compatible = "qcom,rpmcc-msm8976", "qcom,rpmcc";
> +					clocks = <&xo_board>;
> +					clock-names = "xo";
>  					#clock-cells = <1>;
>  				};
>  
