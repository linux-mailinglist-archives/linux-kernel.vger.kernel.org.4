Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915AC6527EE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 21:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbiLTUde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 15:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbiLTUdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 15:33:01 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A111CB3A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 12:32:57 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id y25so20343836lfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 12:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i1rCPEjDDB4aTaz1z66evVwngn0CcNCDZ7iQ3I9uTtA=;
        b=SiZ7G0lOmd3LM+BkyU6zFbx1cmhPFz8r9B84QnM/EyJC3pRZnnAH1gEmvr5RW9JLnl
         jLVKPWgCYnVq0xVbJgVMW4MnubN2URImjjHEGICs+ANuk3eAIkqHD91B7wCaSV1nmGWY
         ehs1+81om8j98YzZFB7Dg8v+TxXw93b0/Le0PHYvnZPzuk68bxY78y8bTlNotVzLgPEw
         uIDaXrgqEGHZu2IhNQ82FbHGB1S1dDN3ZPuNm4E7VSkRSaVx3uyNG8AF+QHVwH8WVOdx
         7JJzsJCE5gQP7YrnevEGf0igMPGjGvN6I7rOuHqjA2p5LHx0kmOB/1xZkSlMQv4zocDQ
         pH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1rCPEjDDB4aTaz1z66evVwngn0CcNCDZ7iQ3I9uTtA=;
        b=AYdwi/H+C7eOvaib7gxPdum+duprUV4161Gp60bnu8I54DQ60+YG3bYhLA+JGvpmWF
         KHy8TuspJTg53C+pW+QJwFhhi5Q8963EIBTrZbumqtJkLsif4XLJvrtG53LfCfrChEI1
         MOxf0Y3cTONTcPZJYprGKOlPI84T26GD3zSqARg7uk06YoXdJ3H8XDANpPrCQOnvDxcl
         q2srd1CR+Vn5sJZN6C7OAbHIkH9N0hkf0qEKyCZyikwee8PhmE8g/jYKmYuQQb3xydO1
         j6FJaSseVzhReoLklumi9jvdO//Lr5GIq1PnvWaUq0PnHVesqSORDBNqTMeHn4QAg4kC
         HNTg==
X-Gm-Message-State: AFqh2kpDOnmYSHOAs6o2T80mnwt/L7Irwr3CfXzqtCqTnAX1JFEsagZa
        V4+2J+5gnglBmB8M3SKExf96h+ObkNS3NYdmhbg=
X-Google-Smtp-Source: AMrXdXvVICNdQgl7zMMbAM9Ga7nB0iu59zrYProEc4CLdp+1dPMe4Je+hA8dnAdXT8DrmDazBtR5Ww==
X-Received: by 2002:a19:e01b:0:b0:4a6:7271:e314 with SMTP id x27-20020a19e01b000000b004a67271e314mr1034718lfg.62.1671568376163;
        Tue, 20 Dec 2022 12:32:56 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id v21-20020a056512349500b004a44ffb1050sm1568398lfr.171.2022.12.20.12.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 12:32:55 -0800 (PST)
Message-ID: <d6fe27d0-729a-1730-9b57-6bdb2a76e6d0@linaro.org>
Date:   Tue, 20 Dec 2022 22:32:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 2/4] arm64: dts: qcom: sm6125: Add UFS nodes
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Lux Aliaga <they@mint.lgbt>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221215190404.398788-1-they@mint.lgbt>
 <20221215190404.398788-2-they@mint.lgbt>
 <e474f99d-2375-c8db-203c-632c918d8e4d@linaro.org>
 <9c185e36-4342-0f8e-1816-494303ebd072@mint.lgbt>
 <66140726-0771-a28b-4916-cc3aef569cab@linaro.org>
 <CAA8EJprw+314QagdqmvZ7_6SR-TH5NSmndL66DQqc2=zeaT6AA@mail.gmail.com>
In-Reply-To: <CAA8EJprw+314QagdqmvZ7_6SR-TH5NSmndL66DQqc2=zeaT6AA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2022 22:30, Dmitry Baryshkov wrote:
> On Tue, 20 Dec 2022 at 21:33, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>>
>> On 20.12.2022 19:57, Lux Aliaga wrote:
>>> On 16/12/2022 08:24, Konrad Dybcio wrote:
>>>
>>>>
>>>> On 15.12.2022 20:04, Lux Aliaga wrote:
>>>>> Adds a UFS host controller node and its corresponding PHY to
>>>>> the sm6125 platform.
>>>>>
>>>>> Signed-off-by: Lux Aliaga <they@mint.lgbt>
>>>>> ---
>>>> Please include a changelog, I don't know what you changed and
>>>> what you didn't. Also, you sent 4 revisions in one day, not
>>>> letting others review it.
>>>>
>>>>
>>>>>    arch/arm64/boot/dts/qcom/sm6125.dtsi | 67 ++++++++++++++++++++++++++++
>>>>>    1 file changed, 67 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
>>>>> index 7e25a4f85594..b64c5bc1452f 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
>>>>> @@ -508,6 +508,73 @@ sdhc_2: mmc@4784000 {
>>>>>                status = "disabled";
>>>>>            };
>>>>>    +        ufs_mem_hc: ufs@4804000 {
>>>>> +            compatible = "qcom,sm6125-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
>>>>> +            reg = <0x04804000 0x3000>, <0x04810000 0x8000>;
>>>>> +            reg-names = "std", "ice";
>>>>> +            interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
>>>>> +            phys = <&ufs_mem_phy_lanes>;
>>>>> +            phy-names = "ufsphy";
>>>>> +            lanes-per-direction = <1>;
>>>>> +            #reset-cells = <1>;
>>>>> +            resets = <&gcc GCC_UFS_PHY_BCR>;
>>>>> +            reset-names = "rst";
>>>>> +
>>>>> +            clock-names = "core_clk",
>>>>> +                      "bus_aggr_clk",
>>>>> +                      "iface_clk",
>>>>> +                      "core_clk_unipro",
>>>>> +                      "ref_clk",
>>>>> +                      "tx_lane0_sync_clk",
>>>>> +                      "rx_lane0_sync_clk",
>>>>> +                      "ice_core_clk";
>>>>> +            clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
>>>>> +                 <&gcc GCC_SYS_NOC_UFS_PHY_AXI_CLK>,
>>>>> +                 <&gcc GCC_UFS_PHY_AHB_CLK>,
>>>>> +                 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
>>>>> +                 <&rpmcc RPM_SMD_XO_CLK_SRC>,
>>>>> +                 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
>>>>> +                 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
>>>>> +                 <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
>>>>> +            freq-table-hz = <50000000 240000000>,
>>>>> +                    <0 0>,
>>>>> +                    <0 0>,
>>>>> +                    <37500000 150000000>,
>>>>> +                    <0 0>,
>>>>> +                    <0 0>,
>>>>> +                    <0 0>,
>>>>> +                    <75000000 300000000>;
>>>>> +
>>>>> +            non-removable;
>>>>> +            status = "disabled";
>>>>> +        };
>>>>> +
>>>>> +        ufs_mem_phy: phy@4807000 {
>>>>> +            compatible = "qcom,sm6115-qmp-ufs-phy";
>>>> Krzysztof asked you to add a SoC-specific compatible in v1.
>>> I'm working on adding a new compatible for sm6125's UFS PHY. Should I copy sm6115's tables or just reference them in the sm6125's config in drivers/phy/qualcomm/phy-qcom-qmp-ufs.c?
>> If they're identical, you can just do something like this:
>>
>> compatible = "qcom,sm6125-qmp-ufs-phy", "qcom,sm6115-qmp-ufs-phy";
> 
> Ugh. I'd prefer to see either of the compatible strings here, but not
> both of them.

I hit send too quick, so the justification didn't get in.

Currently we list a single compatibility string for all QMP PHYs. Having 
just a single exception stands out, so I'd advise against doing that 
(despite Konrad's suggestion being technically correct).

> 
>>
>> And ensure your newly added compatible is documented in bindings.
>> This way, the driver will fall back to the 6115 compatible that's
>> defined in .c, but if we ever need to adjust something specific
>> for 6125, we will just use the define that we added here. That's
>> important, as we're supposed to stay backwards-compatible with
>> old device trees.
>>
>> Also, wrap your emails at around 80 chars or so, some people
>> are grumpy about that :P
>>
>> Konrad
>>>
> 
> 
> 

-- 
With best wishes
Dmitry

