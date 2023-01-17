Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CFF66E8A1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjAQVlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjAQViX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:38:23 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4222438B7D
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:01:36 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r9so8999505wrw.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4NbgmQ7vwZWISWrpORFndGUj0Z1v8WzwxSlAH052uaI=;
        b=DDkxuKKBdTiKhwMOyfxlHgaEFjJoxSsFSon4tpKtYWiAsylwRuduHnpWAlMh7TIu5d
         JqTK48Ax6peub1bM63LMmpHukChbBB/fEKpUHCI8TQEHitR883aApOvxbn9GcUYY404e
         hxvRfDMj+UEA1qyAmwDlCy3/b4IMHm7izEKK2kWEkxUrYpo5xea4jIWf0uvixsQYFvCJ
         Q1z/tMAHGqN4VbeUl83nZXq/8peD0AQkZEXLLJ/hTLKSl/r7gFTQexzuItqI5ikTa/3P
         S9JOc2oY4pBoatoJHqRi97IZGnSKr5vA1yYZMy6v+avnIRLUx7ORskp0qU+77zkVfIfr
         W4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4NbgmQ7vwZWISWrpORFndGUj0Z1v8WzwxSlAH052uaI=;
        b=mEK7UZL6xVUzqXV3Rc3ZknIQMLgoa1ylySzrhAdZ5L2HcCn3t8sVE/6yJ0Nh0y+GnM
         xfMSJ8JpGc5D45R6PGKhweAxFOq6HZ59YtMsMvZphbiPD+xTypbr7nQCN2F+qTu5eGjF
         9YFgm4f32OEb+jvuCYMqZ6Y/Qbfc2gpbwiKnnWd5y/vf5W9VbUJ+bUpFEoAQ2W9Bq19p
         F1NlJ3bzIY08IDwljcKgfZVh79M0nT9XrmRwv/RrE0zXKfL0xx4VgkNqTXlCx8IW1JPu
         +59FiOC8Yfe9ebrfsoDMV8wxkduhu81VpxcCNHE/L4bc1vkftDJEl7lBBl+Pjxll3atS
         IZDA==
X-Gm-Message-State: AFqh2krcxrlaWg63vdQxu8tnK0Pa5YncAlIgQK7Gf6lbf0ryCIC/N1SG
        x2vkKgNVrp6WRQhqk2oVsqid5w==
X-Google-Smtp-Source: AMrXdXs4vMDYW9Wv8LmQ84pxtZoBKU4CXfy3IowTrSQqP8YN9k1B4gP9qV3XvnQv4pX/+ICuhpLO4Q==
X-Received: by 2002:a5d:50c9:0:b0:2bd:db42:36cd with SMTP id f9-20020a5d50c9000000b002bddb4236cdmr3825481wrt.0.1673985694939;
        Tue, 17 Jan 2023 12:01:34 -0800 (PST)
Received: from [192.168.0.15] (cpc76484-cwma10-2-0-cust274.7-3.cable.virginm.net. [82.31.201.19])
        by smtp.gmail.com with ESMTPSA id i15-20020a05600011cf00b00294176c2c01sm29185345wrx.86.2023.01.17.12.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 12:01:34 -0800 (PST)
Message-ID: <b127bf23-8752-47be-d98e-4a61794a3c48@linaro.org>
Date:   Tue, 17 Jan 2023 20:01:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 4/6] arm64: dts: qcom: sm6125: Add UFS nodes
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lux Aliaga <they@mint.lgbt>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, martin.botka@somainline.org,
        marijn.suijten@somainline.org
References: <20230108195336.388349-1-they@mint.lgbt>
 <20230108195336.388349-5-they@mint.lgbt>
 <475d3f2f-114f-d6d2-89db-465ba7acd0d6@linaro.org>
 <f1f1337a-30cc-df3c-81d5-2daac61e874c@mint.lgbt>
 <PxopLVxLOIJ3_2bHt6pxk7OW4uY69s6KglHqShGI_CuUgDQFA_yn8HwD5gdoQpMpvYYqKXqVNhOQmwBQ6y0REQ==@protonmail.internalid>
 <51a8bb85-8fda-2d79-f753-9461316bae9e@linaro.org>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <51a8bb85-8fda-2d79-f753-9461316bae9e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/01/2023 12:04, Konrad Dybcio wrote:
> 
> 
> On 11.01.2023 03:53, Lux Aliaga wrote:
>>
>> On 09/01/2023 09:18, Konrad Dybcio wrote:
>>>
>>> On 8.01.2023 20:53, Lux Aliaga wrote:
>>>> Adds a UFS host controller node and its corresponding PHY to
>>>> the sm6125 platform.
>>>>
>>>> Signed-off-by: Lux Aliaga <they@mint.lgbt>
>>>> ---
>>>>   arch/arm64/boot/dts/qcom/sm6125.dtsi | 57 ++++++++++++++++++++++++++++
>>>>   1 file changed, 57 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
>>>> index df5453fcf2b9..cec7071d5279 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
>>>> @@ -511,6 +511,63 @@ sdhc_2: mmc@4784000 {
>>>>               status = "disabled";
>>>>           };
>>>>   +        ufs_mem_hc: ufs@4804000 {
>>>> +            compatible = "qcom,sm6125-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
>>>> +            reg = <0x04804000 0x3000>, <0x04810000 0x8000>;
>>> You need reg-names for ICE to probe, otherwise the second reg sits unused.
>>>
>>>> +            interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
>>>> +            phys = <&ufs_mem_phy>;
>>>> +            phy-names = "ufsphy";
>>>> +            lanes-per-direction = <1>;
>>>> +            #reset-cells = <1>;
>>>> +            resets = <&gcc GCC_UFS_PHY_BCR>;
>>>> +            reset-names = "rst";
>>>> +            iommus = <&apps_smmu 0x200 0x0>;
>>>> +
>>>> +            clock-names = "core_clk",
>>>> +                      "bus_aggr_clk",
>>>> +                      "iface_clk",
>>>> +                      "core_clk_unipro",
>>>> +                      "ref_clk",
>>>> +                      "tx_lane0_sync_clk",
>>>> +                      "rx_lane0_sync_clk",
>>>> +                      "ice_core_clk";
>>>> +            clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
>>>> +                 <&gcc GCC_SYS_NOC_UFS_PHY_AXI_CLK>,
>>>> +                 <&gcc GCC_UFS_PHY_AHB_CLK>,
>>>> +                 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
>>>> +                 <&rpmcc RPM_SMD_XO_CLK_SRC>,
>>>> +                 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
>>>> +                 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
>>>> +                 <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
>>>> +            freq-table-hz = <50000000 240000000>,
>>>> +                    <0 0>,
>>>> +                    <0 0>,
>>>> +                    <37500000 150000000>,
>>>> +                    <0 0>,
>>>> +                    <0 0>,
>>>> +                    <0 0>,
>>>> +                    <75000000 300000000>;
>>>> +
>>>> +            status = "disabled";
>>>> +        };
>>>> +
>>>> +        ufs_mem_phy: phy@4807000 {
>>>> +            compatible = "qcom,sm6125-qmp-ufs-phy";
>>>> +            reg = <0x04807000 0x1c4>;
>>> Isn't this too small? Downstream says 0xdb8, but it's probably even bigger..
>> What do you think could help me find the new length of the registers? I tried 0x1000 and it probed just fine, but I'm not really sure until what extent I could push it.
> The "true" values are probably only in documentation, which
> I don't have.

This patch series uses the "new" DT layout, where there isn't a subnode
to define the address ranges of the different components.

The reg size would be correct if it used the "legacy" DT layout.

Confirming in downstream, 0xdb8 is the correct value (it's what DT uses
there and the phy-qcom-ufs-qmp-v3-660 driver confirms the biggest
register offset is PHY_BASE (0xc00) + PHY_SIZE (0x1b4) = 0xdb4 inclusive)

I'd suggest going for that in your next revision Lux.
> 
> Konrad
>>

-- 
Kind Regards,
Caleb (they/them)
