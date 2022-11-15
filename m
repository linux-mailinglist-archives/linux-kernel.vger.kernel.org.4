Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB430628E78
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 01:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiKOAfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 19:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiKOAfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 19:35:14 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9534E10068
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 16:35:13 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id f5so32421648ejc.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 16:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGk2wPhs4slpmIs2T/eEbmhJ9ilny1GSUlC3zed5xiw=;
        b=Z3jJvxeYRd4c0jHP+1+QDjte8JAOp+spYi5rntloiM7sZDttF2eoJHrKt6l0FP5I9T
         jrhpajrWrAZYoXBU1h+TRwV2Nj0Lh43+Ovim3FJTWamcxUrcZW/puSbwXjpRmLAbE89A
         H8ROt8gU2TRQAw+6rtiSD+MXn9gIgWbfCnsTphWIXWXijJUzGyLiAJRJwscvP0WvteL2
         AP1Xg/jOkjAdGR4e73pLS85mEr1rLpkozhuFBhIgbgkBP/e/c+ga1YcLdqBOmPZhMhf6
         MBJ8L19sMYR1U0FuRPN8d+qJDD94wUU1ndktcqPA7FOWw2jlzGLpG3zvqVsK6o38yLxy
         C/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NGk2wPhs4slpmIs2T/eEbmhJ9ilny1GSUlC3zed5xiw=;
        b=EuJy6OlmjnvM5ICyeYffKL9uHYiFKaM7mDOiWlCBLPUvyqqk56rO8VGbmQB906Kta+
         zFeqaF1laApqdC1IHXHfJi+ssf2fxR6hnbkmbpsAFAPQIqdyGqkYShQBAMar2KAFlUXR
         Eds4At+YA3pi0QJ/7Nl1STtWnIG8nAJMYsCpvQdeOPvsBvjQakvkEgcVoOaA/EBH1CsN
         vspfZO/k8j7bSeKIqTLTU8rrbH0Pyzg/3gSp2zstuaZ8e/m0y3vdf0a3ZsMr/kaE+aMV
         Wnhse8pgATYiReAWtaYs2799FvOgX4sIQOnHFYx6iw5ispdza8MMl2j0UYpHZITj5lqH
         LvtA==
X-Gm-Message-State: ANoB5pmdsUfGRt8qx8ntXGSWaZR/jub8gftyROZwtIJKYsbyHPY8qXeV
        mZV87ofGUyd+zHbmZ7BtffQdGA==
X-Google-Smtp-Source: AA0mqf518cSWdLBM0HNyX7S9x0osj7z+VM1L2SvKr2vazdoHWfnwwnhkyLhPgRNiDXXMfDeUBF9UDA==
X-Received: by 2002:a17:906:cb85:b0:7ad:beb3:91b6 with SMTP id mf5-20020a170906cb8500b007adbeb391b6mr11928100ejb.159.1668472512122;
        Mon, 14 Nov 2022 16:35:12 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id r18-20020a17090609d200b0077f324979absm4789795eje.67.2022.11.14.16.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 16:35:11 -0800 (PST)
Message-ID: <a724efdc-f35a-8320-f2e1-0078198408d4@linaro.org>
Date:   Tue, 15 Nov 2022 01:35:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Make herobrine-audio-rt5682 mic
 dtsi's match more
To:     Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     mka@chromium.org, swboyd@chromium.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        judyhsiao@chromium.org, Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221114162807.1.I0900b97128f9bb03e5f96fcb3068c227a33f143a@changeid>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221114162807.1.I0900b97128f9bb03e5f96fcb3068c227a33f143a@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15/11/2022 01:28, Douglas Anderson wrote:
> The 1-mic and 3-mic dtsi still had two minor cosmetic differences
> after commit 3d11e7e120ee ("arm64: dts: qcom: sc7280: sort out the
> "Status" to last property with
> sc7280-herobrine-audio-rt5682.dtsi"). Let's fix them so the two files
> diff better. This is expected to have no effect though it will
> slightly change the generated dtb by removing an unnecessary 'status =
> "okay"' from the sound node.

Also known as "no functional change"!


Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>


Konrad

>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>   arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi
> index fc7a659dfe4a..af685bc35e10 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi
> @@ -19,8 +19,6 @@ sound: sound {
>   		#address-cells = <1>;
>   		#size-cells = <0>;
>   
> -		status = "okay";
> -
>   		dai-link@0 {
>   			link-name = "MAX98360";
>   			reg = <0>;
> @@ -96,6 +94,8 @@ dai-link@1 {
>   	};
>   };
>   
> +/* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */
> +
>   &mi2s0_data0 {
>   	drive-strength = <6>;
>   	bias-disable;
