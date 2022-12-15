Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC48564DC19
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 14:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiLONRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 08:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiLONRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 08:17:35 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FC42C130
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 05:17:32 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id z26so15604972lfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 05:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sg/7PKZ2PpLj44QUzjyo60iofeYQC0nT1+8EbxEYeYk=;
        b=paqjLWLQjV3QM7o0g45iNNwnnTCrY5fNU98IFbOl88i8N05oz/7pwz8U4konc2LKBI
         4im+yTolmz5RvPwIXBBUAW69FKxIc9OOOjJtXmEHrf/WorTXyD6pQItLL9R1llswJIIJ
         3TN68XWRZQ1cYIxLWbygHK9yuR1hPGe3XyTaV59MCbZJXTPJ2HVCbLMnOee/0KYhenAV
         sREeEt+/+7zk3hgKUtaTsTOMs291dD1X1zcivWER55m+BRaEQ+HSuEeE1A1s0kI4i/Hy
         AGldpgU9DwGbNITetJbtATshSvEbWobZWYd4M+5KsBU2ThZ3zLb5YRcyXcyUrN0ywf5d
         nzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sg/7PKZ2PpLj44QUzjyo60iofeYQC0nT1+8EbxEYeYk=;
        b=qCjDWz9etTPc/uKT0/PgM0YtZzWBMGxIt/5Gw4SdOmPq8aK+fmc4U8I9Mt/Z0m80ur
         /dmCETIG+LnuW4YjzDVNTFKBDkSAMuHvVnLK+kwI8BJPO5N6DXPeI0XIbKKhlzc6epmQ
         /RxKMiMMv7/kvdBMhH/A02bQdXuqEHsy92uVhyHaBQyAaZijoDsGyrImrb6sl7Ojg/4j
         a5V+X3on/AO/qo7PbGkWBMf+K8UFKICH1vbL2239AFhwFFrzHFIjSMrCktK73n0mBydz
         d82FOzGNLvmPPTObVb2PSpXypMXK0YnTfVKKknmR32ku3zfppj498DU61vzsSuG9sVEA
         /w1w==
X-Gm-Message-State: ANoB5pm3AUldCr3xfVSNsKPzTkSUdARp3HmykhvR71BS4TZVto1cJt//
        3Rwi8ex7NTk1iEIXeVwV1DyXZcy8dRsJ44HG
X-Google-Smtp-Source: AA0mqf6adzOmCFsfsG4Pco2bqy42zVq9ZhzDRHVcRCAsSdpPIgPtuFiVQeUoqpWpdoJCmTZoxIVM0w==
X-Received: by 2002:a05:6512:1690:b0:4b6:eca8:f6ca with SMTP id bu16-20020a056512169000b004b6eca8f6camr6144996lfb.67.1671110251085;
        Thu, 15 Dec 2022 05:17:31 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id o9-20020a05651205c900b0049478cc4eb9sm1156938lfo.230.2022.12.15.05.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 05:17:29 -0800 (PST)
Message-ID: <57e7f32b-86d6-81b4-1501-d732deee6c48@linaro.org>
Date:   Thu, 15 Dec 2022 14:17:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/6] arm64: dts: qcom: msm8956-loire: Add usb vbus and id
 extcons to ci-hdrc
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Adam Skladowski <a39.skl@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221214232049.703484-1-marijn.suijten@somainline.org>
 <20221214232049.703484-3-marijn.suijten@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221214232049.703484-3-marijn.suijten@somainline.org>
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



On 15.12.2022 00:20, Marijn Suijten wrote:
> ci-hdrc does not have the ability to detect voltage presence (5V vbus)
> on the USB connector nor the role (via an ID sensing pin), and relies on
> the PMIC-side charger to provide such information through an extcon
> driver.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi b/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
> index 67baced639c9..700583a56a0e 100644
> --- a/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
> @@ -77,6 +77,8 @@ &gcc {
>  
>  &otg {
>  	status = "okay";
> +
> +	extcon = <&pmi8950_usb_vbus>, <&pmi8950_usb_id>;
Please add it above to keep status as the last property.

Konrad
>  };
>  
>  &pm8004_spmi_regulators {
