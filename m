Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5C175084A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbjGLM2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjGLM2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:28:47 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C75DE77
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:28:46 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b73564e98dso16933731fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689164924; x=1691756924;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8tVaSPQ+w2G/CXnJTkiMl+cJCOUy3bqRCsdNi00/JW8=;
        b=Pi/qBYjAwd4/ZfVUGFBdzDeaZwn0K0YWplH7i42dsFzyhqD20c17n8dWPBGUfptqnR
         WtMDMj4me9MbQ2JKu/0gc3Bdd5vBnFnaOKeWIt1qfbmZ8zmLZmLOkh/f2CTvIk3GGWte
         GtNtUxBvKALaXfZEY/d+7VtlvduQEonkAnvXZ46fHz1r9F0GB7AGRd/JmIjmh0vkQPt0
         pvJM9wrXiYfzWDzsJY7v4ixYBEpbSWTYMQ+MnBh/Q62EtwgmhB+dna8T8ZIOukOPRQp0
         VOVuWZIDAOD0ooouLsS5Zd/z7wQMdRlmCj0OmICRld73YIY11ZeLlIQzw/3kG4LJuvio
         cT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689164924; x=1691756924;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tVaSPQ+w2G/CXnJTkiMl+cJCOUy3bqRCsdNi00/JW8=;
        b=NlJVu/DX03kn0GCINghzNu6vFm3MPEyrmcSLTJ+xR4Qq5IjoHieRQkk/PZbDcs8ffx
         UQdXPXDffxbaW1ymBv3qH7j3YSWkEVnwHqcQQCsioOz7uPb01LH6pon8rVHOFd5DYrsm
         rd5fooE/P/oJk9RWkD2rPj+/68gmh115vc6cnZLgZkCeuHUnA7H6sJ6fAMHS5JHONko4
         +JiTouJdDyWN/AlPIcVNQxnl2xMQWtLB1Ero8zbn0p5zTACxt576C2yXgBj5+6iFsiTL
         3fq+dIAK5lMQaQhNfwP8oh38Tf+vu5wV7rlEwFCnN9BQsp5t0T2V4NR+37ulm0l0NXuw
         Wy3Q==
X-Gm-Message-State: ABy/qLZE09ux/xqx5qzUwzX2ogpOJtXnKiotELnB2k3qcZoi0SXZ97Fj
        XTkkw54qdl5PkgFDQB2sGoMWOw==
X-Google-Smtp-Source: APBJJlG/LDGQeyoCiWq5ImaEz8bka+7iaet3wkQhYdvn6WDMMMOihWIpsZjkOjKq2phaTxUkfWPX/g==
X-Received: by 2002:a2e:b04a:0:b0:2b6:d0fc:ee18 with SMTP id d10-20020a2eb04a000000b002b6d0fcee18mr13742589ljl.19.1689164924397;
        Wed, 12 Jul 2023 05:28:44 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id r7-20020a2e94c7000000b002b6fe751b6esm948263ljh.124.2023.07.12.05.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 05:28:44 -0700 (PDT)
Message-ID: <0f98360a-6d88-9a8b-5d60-3d6120e0640f@linaro.org>
Date:   Wed, 12 Jul 2023 15:28:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 4/6] arm64: dts: qcom: ipq5332: Add USB related nodes
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, p.zabel@pengutronix.de, arnd@arndb.de,
        geert+renesas@glider.be, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        quic_srichara@quicinc.com, quic_varada@quicinc.org,
        quic_wcheng@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1689160067.git.quic_varada@quicinc.com>
 <1f99805b6437aa8d6eaa4663e8d27b98ee595f00.1689160067.git.quic_varada@quicinc.com>
 <13555184-1708-befd-1f2c-5e6f7e04a6ce@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <13555184-1708-befd-1f2c-5e6f7e04a6ce@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 15:04, Krzysztof Kozlowski wrote:
> On 12/07/2023 13:38, Varadarajan Narayanan wrote:
>> Add USB phy and controller nodes.
>>
>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> ---
>> v4:
>> 	Change node name
>> 	Remove blank line
>> 	'make CHECK_DTBS=y DT_SCHEMA_FILES=qcom qcom/ipq5332-rdp441.dtb' passed
>> v1:
>> 	Rename phy node
>> 	Change compatible from m31,ipq5332-usb-hsphy -> qcom,ipq5332-usb-hsphy
>> 	Remove 'qscratch' from phy node
>> 	Fix alignment and upper-case hex no.s
>> 	Add clock definition for the phy
>> 	Remove snps,ref-clock-period-ns as it is not used. dwc3_ref_clk_period()
>> 	in dwc3/core.c takes the frequency from ref clock and calculates fladj
>> 	as appropriate.
>> ---
>>   arch/arm64/boot/dts/qcom/ipq5332.dtsi | 53 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 53 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> index 8bfc2db..8118356 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> @@ -405,6 +405,59 @@
>>   				status = "disabled";
>>   			};
>>   		};
>> +
>> +		usbphy0: usb-phy@7b000 {
>> +			compatible = "qcom,ipq5332-usb-hsphy";
>> +			reg = <0x0007b000 0x12c>;
>> +
>> +			clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>;
>> +			clock-names = "cfg_ahb";
>> +
>> +			resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
>> +
>> +			status = "disabled";
>> +		};
>> +
>> +		usb2: usb2@8a00000 {
> 
> So you responded to my comments, wait ten minutes and send v2? No need
> to wait for my feedback, right?
> 
> No, it's not ok. This is "usb", not "usb2". Are you saying you have
> second device with the same address?

Just to emphasise, it's the node name `usb2', which is not fine. DT 
label `usb2' is (hopefully) fine.

-- 
With best wishes
Dmitry

