Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC9B66D9ED
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbjAQJ3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236669AbjAQJ2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:28:33 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE1014E9C
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 01:27:01 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id bk15so16380384ejb.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 01:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aG/8wcVo3iRFKTM15eP07bvogfZDNrsKDxEfzDzAxqQ=;
        b=I0xtpXyMLKdw4YC1KQ+i/CO9seD/pJWEEKfI4ib77wLtEsrjFfaYTeXcnp4hnHrjA1
         m8S5X9QeXhhav0yuntaQ7x2KuQqNzfK8YPV4nXEaBlL13kg35pHmSY7Dltq3VnWAdeKk
         XAia9YcWJLOdosghZQn3U77KI60Ryy6jz4pK/TeEWA65+vdd8dwQxAcwmYWXRSUNa83t
         2TEF87WC10QFXfWyW7RwEK8PoCTFXn5lT1m5HQrEi+P5RyY/Jr7WMnja41VsATUH2+Lt
         IuUzpnlsFspRKgwmSuDxBIYPVh/VYnbvCzydKX7GgIcKh2xSos5mlvWiS1celQVLkr22
         IfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aG/8wcVo3iRFKTM15eP07bvogfZDNrsKDxEfzDzAxqQ=;
        b=U7YcuCuhVJUoiue7vRWh9AXNMyux8TOgLycA8/khCJsL+0MgIDPgBpEkSKJYTFxoVZ
         pYcBMxIxVRvpCWLFJ53+warLxVTfbetM/dYfiZD1130iXRaYSh9CkGDn+2ops7F/tni2
         pSsIXGTVDWQe/gXICQAbxGOS3mC7zd7U4pKnZjqZ5f0v82moJLrfybLXXP/Wo70xm3eh
         xYjHr9qHXS6tH1lETll1EqySsmNjaXEzJDScJegInnkq5AYXfOqh0eujWE5em8Pc3F59
         Bxa5InDPudVuPrUzovTx11EWl53+h4+YWMXKqfnJsHQbgqtkC41201dzAs7hsejT3vMt
         EG9w==
X-Gm-Message-State: AFqh2koqmRtX6Q/5DyfQS+qELK0entUZRrl6A7jyiyRsjOVN1lK9AdBS
        0PUkEuuqMD0QNVTKwjf9g5zssA==
X-Google-Smtp-Source: AMrXdXu2si9HzTcy4nOGsEf7y8i21dY9vxEP7F2SyxnNBkvx0AeN1qN1paxsr2aPYTdtxPI9Z81GaQ==
X-Received: by 2002:a17:907:2a56:b0:84d:35e1:2781 with SMTP id fe22-20020a1709072a5600b0084d35e12781mr14583345ejc.46.1673947620250;
        Tue, 17 Jan 2023 01:27:00 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id et21-20020a170907295500b00871f66bf354sm1254923ejc.204.2023.01.17.01.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 01:26:59 -0800 (PST)
Message-ID: <ed32ade2-41b1-5aa0-cc1f-0f40f1d9f099@linaro.org>
Date:   Tue, 17 Jan 2023 11:26:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 0/4] soc: qcom: Introduce PMIC GLINK
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20230113041132.4189268-1-quic_bjorande@quicinc.com>
 <9e831252-7198-7983-8a52-0e745688452d@linaro.org>
 <20230117023238.GB2350793@hu-bjorande-lv.qualcomm.com>
 <c1e3db0d-7593-b0fc-043b-60538faf9ba2@linaro.org>
 <20230117025818.GC2350793@hu-bjorande-lv.qualcomm.com>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230117025818.GC2350793@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2023 04:58, Bjorn Andersson wrote:
> On Tue, Jan 17, 2023 at 02:37:27AM +0000, Bryan O'Donoghue wrote:
>> On 17/01/2023 02:32, Bjorn Andersson wrote:
>>> On Fri, Jan 13, 2023 at 05:10:17PM +0000, Bryan O'Donoghue wrote:
>>>> On 13/01/2023 04:11, Bjorn Andersson wrote:
>>>>> This implements the base PMIC GLINK driver, a power_supply driver and a
>>>>> driver for the USB Type-C altmode protocol. This has been tested and
>>>>> shown to provide battery information, USB Type-C switch and mux requests
>>>>> and DisplayPort notifications on SC8180X, SC8280XP and SM8350.
>>>>>
>>>>> Bjorn Andersson (4):
>>>>>      dt-bindings: soc: qcom: Introduce PMIC GLINK binding
>>>>>      soc: qcom: pmic_glink: Introduce base PMIC GLINK driver
>>>>>      soc: qcom: pmic_glink: Introduce altmode support
>>>>>      power: supply: Introduce Qualcomm PMIC GLINK power supply
>>>>>
>>>>>     .../bindings/soc/qcom/qcom,pmic-glink.yaml    |  102 ++
>>>>>     drivers/power/supply/Kconfig                  |    9 +
>>>>>     drivers/power/supply/Makefile                 |    1 +
>>>>>     drivers/power/supply/qcom_battmgr.c           | 1421 +++++++++++++++++
>>>>>     drivers/soc/qcom/Kconfig                      |   15 +
>>>>>     drivers/soc/qcom/Makefile                     |    2 +
>>>>>     drivers/soc/qcom/pmic_glink.c                 |  336 ++++
>>>>>     drivers/soc/qcom/pmic_glink_altmode.c         |  477 ++++++
>>>>>     include/linux/soc/qcom/pmic_glink.h           |   32 +
>>>>>     9 files changed, 2395 insertions(+)
>>>>>     create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
>>>>>     create mode 100644 drivers/power/supply/qcom_battmgr.c
>>>>>     create mode 100644 drivers/soc/qcom/pmic_glink.c
>>>>>     create mode 100644 drivers/soc/qcom/pmic_glink_altmode.c
>>>>>     create mode 100644 include/linux/soc/qcom/pmic_glink.h
>>>>>
>>>>
>>>> How does the USB PHY and a USB redriver fit into this ?
>>>>
>>>> Is the host supposed to manage both/neither ? Is the DSP responsible for
>>>> configuring the PHY lanes and the turnaround on orientation switch ?
>>>>
>>>
>>> As indicated above, the firmware deals with battery management and USB
>>> Type-C handling.
>>>
>>> The battery/power management is handled by the battmgr implementation,
>>> exposing the various properties through a set of power_supply objects.
>>>
>>> The USB Type-C handling comes in two forms. The "altmode" protocol
>>> handles DisplayPort notifications - plug detect, orientation and mode
>>> switches. The other part of the USB implementation exposes UCSI.
>>>
>>> The altmode implementation provides two things:
>>> - A drm_bridge, per connector, which can be tied (of_graph) to a
>>>     DisplayPort instance, and will invoke HPD notifications on the
>>>     drm_bridge, based on notification messages thereof.
>>>
>>> - Acquire typec_switch and typec_mux handles through the of_graph and
>>>     signal the remotes when notifications of state changes occur. Linking
>>>     this to the FSA4480, is sufficient to get USB/DP combo (2+2 lanes)
>>>     working on e.g. SM8350 HDK.
>>>     Work in progress patches also exists for teaching QMP about
>>>     orientation switching of the SS lines, but it seems this needs to be
>>>     rebased onto the refactored QMP driver.
>>>     I also have patches for QMP to make it switch USB/DP combo -> 4-lane
>>>     DP, which allow 4k support without DSC, unfortunately switch back to
>>>     USB has not been fully reliable, so this requires some more work
>>>     (downstream involves DWC3 here as well, to reprogram the PHY).
>>
>> Oki doki that makes sense and is pretty much in-line with what I thought.
>>
>> We still have a bunch of typec-mux and phy work to do even with adsp/glink
>> doing the TCPM.
>>
> 
> Correct, the registration of QMP as a typec_switch and typec_mux and
> handling of respective notification remains open and should (by design)
> be independent of the TCPM implementation.
> 
> In particular the orientation switching is an itch worth scratching at
> this time. But when the DPU becomes capable of producing 4k@60 output it
> would obviously be nice to have the whole shebang :)

Did you try it with the wide planes patchset at [1]? I was able to get 
stable 4k@30 on RB3 (being limited only by the DSI-HDMI bridge).

[1] 
https://lore.kernel.org/linux-arm-msm/20221229191856.3508092-1-dmitry.baryshkov@linaro.org/

-- 
With best wishes
Dmitry

