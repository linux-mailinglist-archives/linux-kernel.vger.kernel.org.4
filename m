Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31520649C01
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 11:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiLLKYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 05:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbiLLKX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 05:23:56 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0ED763D8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:23:54 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id g7so17771763lfv.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tx/K2nxqJN+6DgdgaOfQVHfNHyjVh8x8nxZ18Z0hLvA=;
        b=j/VaNbe81nj9PboTIIxg/xAkHSvwtGjPPLfF0JuzkYq4G9UBT1VfXVrXzOsDc3cMxC
         SPzz+61jYM/QSkKOFwd8hFDX4qFrPy+C5Y16H8ym61Rzh7TE29U//nTy2Hz1uROZf5LN
         dxk+qcEmolKHx7Ydhs+85VUB8kEk2Ox2zJZyVbuO9QkvFcOSdYzjbrXayjfpDgVL0rvI
         ck7FNeCbddMwIQ6HCaJc02FUZ7whGuqabfkbwsd1YbYjho51Gu3d4XqvJBfHIpcCoifC
         7Z6RDjWLsmfpbYZpoDQ5i1rwsBAt9qMLKRB9uinIiJgs7s7sYBY4BKAxUaUAALAoBuJt
         sHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tx/K2nxqJN+6DgdgaOfQVHfNHyjVh8x8nxZ18Z0hLvA=;
        b=Wu0P5xL4PqEt8eQXQZytcwta4rC/8XCgIq+12xxIFxeXa9yb9JpLdCdMQzKFWAYQMj
         X8tZIcfx5Jt33iLeCLFyzzCrlZcQ8JZDH/V2aj4uPDd23mRhD2sZ1qinZX55M8LiIG6b
         6LbW7qyulxhJN3FQeu+ScVtIC3L0X16/tJJpPQrfThupgplGl7zKcLBlPHWcg8gAOMyw
         v0En5iA29hy5mPuNHRQiztZHN5nS3orIgtLPNSnaYHS51EH1H1VUqF5PZqvZrGApAeiF
         Q0b7YP/ylMYF5L/qs9F/TwTvGZPE09uB7l4En5ePPOomEkcG4eG6/hrVy0bGwKgklrrM
         le3g==
X-Gm-Message-State: ANoB5pmxA9S+GL4fqaEnDt5YyxNFvxBe4D85EvIf9DTYd7pvnQAHpVJj
        xyxMf+MMK7BLya7yDhbsJItzkw==
X-Google-Smtp-Source: AA0mqf7FmyY0UcIoNK7shKkuiKMn1eGM1xDejUPLY6+8jOyWJ7kPNpOuGtSuCDWzN7yFPHyEOYjNrg==
X-Received: by 2002:a05:6512:e9b:b0:4b6:eaa5:4347 with SMTP id bi27-20020a0565120e9b00b004b6eaa54347mr1278992lfb.62.1670840633014;
        Mon, 12 Dec 2022 02:23:53 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id g6-20020a056512118600b004971a83f839sm1587237lfr.39.2022.12.12.02.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 02:23:52 -0800 (PST)
Message-ID: <80168963-0e17-e8aa-6d99-a1c53f63c934@linaro.org>
Date:   Mon, 12 Dec 2022 11:23:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm8150: Add DISPCC node
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221212093315.11390-1-konrad.dybcio@linaro.org>
 <20221212093315.11390-2-konrad.dybcio@linaro.org>
 <FF242AC6-01EC-4C8E-BE49-BB54FC9D2FEE@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <FF242AC6-01EC-4C8E-BE49-BB54FC9D2FEE@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.12.2022 11:18, Dmitry Baryshkov wrote:
> 
> 
> On 12 December 2022 12:33:13 GMT+03:00, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>> Years after the SoC support has been added, it's high time for it to
>> get dispcc going. Add the node to ensure that.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>> arch/arm64/boot/dts/qcom/sm8150.dtsi | 26 ++++++++++++++++++++++++++
>> 1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
>> index a0c57fb798d3..ff04397777f4 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
>> @@ -3579,6 +3579,32 @@ camnoc_virt: interconnect@ac00000 {
>> 			qcom,bcm-voters = <&apps_bcm_voter>;
>> 		};
>>
>> +		dispcc: clock-controller@af00000 {
>> +			compatible = "qcom,sm8150-dispcc";
>> +			reg = <0 0x0af00000 0 0x10000>;
>> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
>> +				 <0>,
>> +				 <0>,
>> +				 <0>,
>> +				 <0>,
>> +				 <0>,
>> +				 <0>;
>> +			clock-names = "bi_tcxo",
>> +				      "dsi0_phy_pll_out_byteclk",
>> +				      "dsi0_phy_pll_out_dsiclk",
>> +				      "dsi1_phy_pll_out_byteclk",
>> +				      "dsi1_phy_pll_out_dsiclk",
>> +				      "dp_phy_pll_link_clk",
>> +				      "dp_phy_pll_vco_div_clk";
>> +			#clock-cells = <1>;
>> +			#reset-cells = <1>;
>> +			#power-domain-cells = <1>;
>> +
>> +			power-domains = <&rpmhpd SM8150_MMCX>;
>> +			/* TODO: Maybe rpmhpd_opp_min_svs could work as well? */
>> +			required-opps = <&rpmhpd_opp_low_svs>;
> 
> Is it required for the dispcc, for the DSI or for the dpu? We have stumbled upon the similar issue when working on the 8350, see the latest Robert's patchset.
While I don't have any hard evidence, it seems like it is required for
any "interesting" multimedia components, AFAIU even including video and
camera clocks..

Seems like it's a deep down dependency for a lot of things on this
particular SoC (and likely also on newer ones, remember the initial
mess with 8250 mmcx?)

Konrad
> 
> 
>> +		};
>> +
>> 		pdc: interrupt-controller@b220000 {
>> 			compatible = "qcom,sm8150-pdc", "qcom,pdc";
>> 			reg = <0 0x0b220000 0 0x400>;
> 
