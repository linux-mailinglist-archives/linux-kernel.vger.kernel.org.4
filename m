Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D5266D482
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbjAQCoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235778AbjAQCni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:43:38 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA162F7AE
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:38:33 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id b5so7990568wrn.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NN7ra9RM5RwWoUr/tsRU6zWH7d53cck2M9uCu21ulu0=;
        b=Oab9zK27rpgas0uCStmMiykRixxSbqgEkfw41hgaNMTL3tWA/9pi5puiL/ERXYkLpY
         47CVxZnDTCYkPZYPSRRJtwc2YEPI2H8WG04kN/t0Yj7L8Y9VCdPsL0JbZgU4Y61r5BP7
         aI2tvd6ObvUqLjXmHJrdE6l49kAt4Q9e4kyb2C7DgrtVXS8lZfhzp/PW/bK1eUHcMxKh
         X0b15FwntkLtmhjqK5URNhh/7EG/7EJfWfVq2reEB+dc65bjju+Ns4noGV1tO/jClh/p
         tuHzdKSruPdk1ivcgcMG6kVLQSGD4bxz/xcpDV89E7ryXofXsqkiV2n5G/F/L55GAkC9
         EaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NN7ra9RM5RwWoUr/tsRU6zWH7d53cck2M9uCu21ulu0=;
        b=2U/RGLgImXXdEZ69V4fSEP0BJq9T9ooGQCOlOhBLGbdig8uTy4J2rWelI7IOEFlV1j
         mV+ym9BiJdf5gKFtZ7vJmglpN6nl+jhRUcMuOGkAkkM9wpNxk+6BY++TbAs2hdAH+2Fn
         bUfDWIVsse7XTeWunyBrJ2YwHeMI48XHpOhnq9Ok5XskffBvt37OoCXkS0KXRKpR/eCb
         WksOCZSkInzZcdmZfreyLVXuOgVng6HpbqbtU9Zu8fRKBTspelwz8+DwSjDnT9QXkXeI
         19tcFrUOEvDrSFAMcMDKw+orfe44suqLIlYP7Nba+nDKTKKk3LD+8dW+8Vfzh3hwwyy8
         WvGg==
X-Gm-Message-State: AFqh2koxJRDXhWqel7SQ6R539XUEnzZWmx+12Pk20Y/OJmBt1O0gOz9X
        8Lt7AkSX99QeQFXRcEq9totzu6S3bG6yalXn
X-Google-Smtp-Source: AMrXdXt/uADrirudTtbLAThIF7D33RBC/uAACiFdsfTZOuuirWxs/Jfbl29q/QJSTS1dIZHczsAv2g==
X-Received: by 2002:a5d:4e51:0:b0:2bd:f5df:2696 with SMTP id r17-20020a5d4e51000000b002bdf5df2696mr1122371wrt.67.1673923049035;
        Mon, 16 Jan 2023 18:37:29 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id f2-20020adff982000000b002bde537721dsm9634581wrr.20.2023.01.16.18.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 18:37:28 -0800 (PST)
Message-ID: <c1e3db0d-7593-b0fc-043b-60538faf9ba2@linaro.org>
Date:   Tue, 17 Jan 2023 02:37:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 0/4] soc: qcom: Introduce PMIC GLINK
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
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
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230117023238.GB2350793@hu-bjorande-lv.qualcomm.com>
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

On 17/01/2023 02:32, Bjorn Andersson wrote:
> On Fri, Jan 13, 2023 at 05:10:17PM +0000, Bryan O'Donoghue wrote:
>> On 13/01/2023 04:11, Bjorn Andersson wrote:
>>> This implements the base PMIC GLINK driver, a power_supply driver and a
>>> driver for the USB Type-C altmode protocol. This has been tested and
>>> shown to provide battery information, USB Type-C switch and mux requests
>>> and DisplayPort notifications on SC8180X, SC8280XP and SM8350.
>>>
>>> Bjorn Andersson (4):
>>>     dt-bindings: soc: qcom: Introduce PMIC GLINK binding
>>>     soc: qcom: pmic_glink: Introduce base PMIC GLINK driver
>>>     soc: qcom: pmic_glink: Introduce altmode support
>>>     power: supply: Introduce Qualcomm PMIC GLINK power supply
>>>
>>>    .../bindings/soc/qcom/qcom,pmic-glink.yaml    |  102 ++
>>>    drivers/power/supply/Kconfig                  |    9 +
>>>    drivers/power/supply/Makefile                 |    1 +
>>>    drivers/power/supply/qcom_battmgr.c           | 1421 +++++++++++++++++
>>>    drivers/soc/qcom/Kconfig                      |   15 +
>>>    drivers/soc/qcom/Makefile                     |    2 +
>>>    drivers/soc/qcom/pmic_glink.c                 |  336 ++++
>>>    drivers/soc/qcom/pmic_glink_altmode.c         |  477 ++++++
>>>    include/linux/soc/qcom/pmic_glink.h           |   32 +
>>>    9 files changed, 2395 insertions(+)
>>>    create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
>>>    create mode 100644 drivers/power/supply/qcom_battmgr.c
>>>    create mode 100644 drivers/soc/qcom/pmic_glink.c
>>>    create mode 100644 drivers/soc/qcom/pmic_glink_altmode.c
>>>    create mode 100644 include/linux/soc/qcom/pmic_glink.h
>>>
>>
>> How does the USB PHY and a USB redriver fit into this ?
>>
>> Is the host supposed to manage both/neither ? Is the DSP responsible for
>> configuring the PHY lanes and the turnaround on orientation switch ?
>>
> 
> As indicated above, the firmware deals with battery management and USB
> Type-C handling.
> 
> The battery/power management is handled by the battmgr implementation,
> exposing the various properties through a set of power_supply objects.
> 
> The USB Type-C handling comes in two forms. The "altmode" protocol
> handles DisplayPort notifications - plug detect, orientation and mode
> switches. The other part of the USB implementation exposes UCSI.
> 
> The altmode implementation provides two things:
> - A drm_bridge, per connector, which can be tied (of_graph) to a
>    DisplayPort instance, and will invoke HPD notifications on the
>    drm_bridge, based on notification messages thereof.
> 
> - Acquire typec_switch and typec_mux handles through the of_graph and
>    signal the remotes when notifications of state changes occur. Linking
>    this to the FSA4480, is sufficient to get USB/DP combo (2+2 lanes)
>    working on e.g. SM8350 HDK.
>    Work in progress patches also exists for teaching QMP about
>    orientation switching of the SS lines, but it seems this needs to be
>    rebased onto the refactored QMP driver.
>    I also have patches for QMP to make it switch USB/DP combo -> 4-lane
>    DP, which allow 4k support without DSC, unfortunately switch back to
>    USB has not been fully reliable, so this requires some more work
>    (downstream involves DWC3 here as well, to reprogram the PHY).

Oki doki that makes sense and is pretty much in-line with what I thought.

We still have a bunch of typec-mux and phy work to do even with 
adsp/glink doing the TCPM.

Thanks for the explanation.

---
bod

