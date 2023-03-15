Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D68A6BACE8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjCOKBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjCOKBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:01:19 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE8F5CC3A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 03:00:07 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id x11so19404635pln.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 03:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678874407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nfMWt4ixugNsc9AOhW4zh3Qlkp0wA/BUmvjbUtzpDgw=;
        b=KwquW/B+JdxTYUB3gevchOoNy7S5NSEVjtk2Vw9uyUiuw2KbOX884786SNjAYg2Xwh
         NthtUeL3MfbALd33VrWYKb2gazlKkCdtOXIJS40/7Ye0emaUHLAMInd1DRjgJRI7mpNn
         uSQJIdv+VwdpGiTpTdlqrAP145F5m2y/U4sUbB7s67ONPURmLEojAJTkk8BkaMTqSuf/
         GIIQI+laaERgNWpPSMchyvaqEf0JkludmLgDpfjP40eC14QCgrUQEBkifhtRMk22a7uh
         2Tt37u0nez39KO9ExcBZoM61U9fQL4KnvSvis8nFHz7QCtLBisrF/8Dha3naiusoqOit
         0+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678874407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nfMWt4ixugNsc9AOhW4zh3Qlkp0wA/BUmvjbUtzpDgw=;
        b=i0/peCVgEUM31CE0Ed96tmtMnQjF9pbwqLtXqrpvpmR3CSwyplzhyDhdW6VK5F9WZh
         f4655Jiw6rEzHW9G1XodApINNfwIKL7rb3RgeYQqml6n1YBSPLaOIsDjpeJ+8QG1aT6m
         Gnd0omTv++dSTnAa96K2FGKplAdwQfZ98rwAVK1OLE4Fr2ivXHPs35gRTyK0hL2iVKzx
         BmJlHMhwJM1RtEMFBzjhgHjl1paSHPDgKLPvruWmrKYvGL7mMsX5dyi7WhxtsF/xEL/V
         XKyLDB0aBKXJIM/9DQUkGPHACDsexv+tzYTrT4ZYNNyxQQz0Iklihft/q73ZoZtVHPku
         Znog==
X-Gm-Message-State: AO0yUKUSrx/qh1/m0TJt2PRuoSv+jA+R7kMqoyMMOHhv/Kz4g878N1V6
        Vbeef0DT5krhmmaZT+4MnFXqVg==
X-Google-Smtp-Source: AK7set/A2w5RNkUesxs8MRcKHqtR8roh32s/RLeEjhIrH3APMn4IA1gF0sdSaEuCZQhNN7WbTExdtA==
X-Received: by 2002:a17:902:e844:b0:1a1:7b89:3860 with SMTP id t4-20020a170902e84400b001a17b893860mr1194410plg.6.1678874407080;
        Wed, 15 Mar 2023 03:00:07 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c61:1acb:9af6:bd7f:78e7:7ae6? ([2401:4900:1c61:1acb:9af6:bd7f:78e7:7ae6])
        by smtp.gmail.com with ESMTPSA id x1-20020a1709028ec100b0019aa4c00ff4sm3227744plo.206.2023.03.15.03.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 03:00:06 -0700 (PDT)
Message-ID: <3cdf5826-ef8d-2c4f-e7e3-c9ddef68043c@linaro.org>
Date:   Wed, 15 Mar 2023 15:29:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Add base qrb4210-rb2 board dts
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org
References: <20230314210828.2049720-1-bhupesh.sharma@linaro.org>
 <20230314210828.2049720-3-bhupesh.sharma@linaro.org>
 <09b49716-fa77-710c-92ec-3c0d7c154bc3@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <09b49716-fa77-710c-92ec-3c0d7c154bc3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/23 2:55 AM, Konrad Dybcio wrote:
> 
> 
> On 14.03.2023 22:08, Bhupesh Sharma wrote:
>> Add DTS for Qualcomm qrb4210-rb2 board which uses SM4250 SoC.
>>
>> This adds debug uart, emmc, uSD and tlmm support along with
>> regulators found on this board.
>>
>> Also defines the 'xo_board' and 'sleep_clk' frequencies for
>> this board.
>>
>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>> ---
> [...]
> 
>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> This SoC does not feature RPMh, drop.

Ok.

>> +#include "sm4250.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. QRB4210 RB2";
>> +	compatible = "qcom,qrb4210-rb2", "qcom,sm4250";
> Please add a qcom,qrb4210 between the board-specific and the common SoC
> compatibles so that we can address QRB-specific quirks if such ever arise.

As per the available documentation there are no qrb specific quirks as 
of now, but let me add a qcom,qrb4210 for future compatibility.

>> +
>> +	aliases {
>> +		serial0 = &uart4;
>> +	};
>> +
> [...]
> 
>> +&xo_board {
>> +	clock-frequency = <19200000>;
>> +};
>> +
>> +&sleep_clk {
>> +	clock-frequency = <32000>;
>> +};
> Out of alphanumerical order

Ok.

>> +
>> +&qupv3_id_0 {
>> +	status = "okay";
>> +};
>> +
>> +&uart4 {
>> +	status = "okay";
>> +};
>> +
>> +&rpm_requests {
> Out of alphanumerical order

Ok.

>> +	regulators-0 {
> Will there be more PMICs under this node? If not, drop the -0.

Ok.

> [...]
> 
>> +&tlmm {
>> +	gpio-reserved-ranges = <37 5>, <43 2>, <47 1>,
>> +			       <49 1>, <52 1>, <54 1>,
>> +			       <56 3>, <61 2>, <64 1>,
>> +			       <68 1>, <72 8>, <96 1>;
>> +};
> Are there *really* so many? Does the board refuse to boot if
> you knock off any of these entries? If so, they probably
> don't belong here.

Yes, these are reserved / not-connected gpios as per latest version of 
the board schematics.

>> +
>> +&sdhc_1 {
>> +	status = "okay";
> Status should go last
>> +
>> +	vmmc-supply = <&vreg_l24a_2p96>; /* emmc power line */
>> +	vqmmc-supply = <&vreg_l11a_1p8>; /* emmc vddq */
> The comments are not very useful, drop please.
> 
>> +	bus-width = <8>;
> This is defined in the SoC dtsi already

Ok.

>> +	no-sdio;
>> +	non-removable;
>> +};
>> +
>> +&sdhc_2 {
>> +	status = "okay";
>> +
>> +	cd-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>; /* card detect gpio */
>> +	vmmc-supply = <&vreg_l22a_2p96>; /* Card power line */
>> +	vqmmc-supply = <&vreg_l5a_2p96>; /* IO line power */
>> +	bus-width = <4>;
>> +	no-sdio;
>> +	no-emmc;
> Ditto

Ok. Will send updated v2 soon.

Thanks.
