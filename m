Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF962669B64
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjAMPGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjAMPFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:05:41 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E3F8D3A5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:57:05 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id o20so1534802lfk.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Na3ZrE6A9rh81pSsXiZxGcF9IK4nLW3nyLKYL0aIcJk=;
        b=jxuFWlPtwQ9F568YD6d7nIFz8eLjcs0j6kLwHG29Ujh36BK6Us5Gs+I+TQ/BD0dEXl
         Vw+WzawLuT/IjVpiybsa+PeKnqFKEEre++X0MiSNNoNAUEpZrOoifKCAU3uHgHprg29v
         bTB+RmgdNBJMTyz/mqCQCACxdjVTybgSP9fcZ72i/M09OGBAWDQ/2SOV8iQQhEsSdMCH
         GOm92NsH7S4h0K+5Smgzr8+IFa9qf3MQeUjSpkltR5akxfyvz+G+/rmyU+oVLHxE1n4k
         ihEy+h4XJQRkPFVfcnsej/1i2bHhY63EkW9Ybesg6fgAEzRhzPkOUi7CjLNfHgCzRQqa
         xRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Na3ZrE6A9rh81pSsXiZxGcF9IK4nLW3nyLKYL0aIcJk=;
        b=CnuchFUOcRQ4UM6WqFUUNj/aAVxSIxNAdaOi1Ha/F0JaCvYyPvgy4jIXY9PNjVDRNT
         B1K0lNZg0VFboK2biYevMQjF0WHtbaKtJG4vvljKU9h+jNe94Q4qFJTkCUdt2Cr1AGb0
         7koOBM218vcBp99Oqm6QJeCNqgImUkx0dK67srMnYrpzmuB7l7aK1DV2er3ZamQaatkM
         +Ubni3/10H1xWKw9Ese9VX7Nch8wSHuyuZvbswhHN0MosTWArNmxrS8ijYhvKPrlH7HM
         RIjtE8z/P8bwh9Gnr/YTWqgz/XwVTOA5Smvxt1v7lLKQy3aOH0Sr3fms+sY9vC0rytUF
         DE1g==
X-Gm-Message-State: AFqh2ko1ozQmGy1hFgnW1bejAf6tW+rFsK2TOrxcVr6721MBv4NBKuYy
        fJm1mJl7Tik9ozZo6fYNoAjURA==
X-Google-Smtp-Source: AMrXdXtK78wDBBNrYu++ZFjm6b/nQ++mI9J8yJs6bL3QmgppxUrMuOTd40O6gvn68/5psniZuS03EQ==
X-Received: by 2002:ac2:4ad1:0:b0:4d2:bb83:e7e6 with SMTP id m17-20020ac24ad1000000b004d2bb83e7e6mr221744lfp.59.1673621823553;
        Fri, 13 Jan 2023 06:57:03 -0800 (PST)
Received: from [192.168.1.101] (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id e19-20020a05651236d300b00499b1873d6dsm3851569lfs.269.2023.01.13.06.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 06:57:02 -0800 (PST)
Message-ID: <bcf497a7-66bb-9cd9-bada-4081000747a6@linaro.org>
Date:   Fri, 13 Jan 2023 15:56:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 0/4] soc: qcom: Introduce PMIC GLINK
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20230113041132.4189268-1-quic_bjorande@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230113041132.4189268-1-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.01.2023 05:11, Bjorn Andersson wrote:
> This implements the base PMIC GLINK driver, a power_supply driver and a
> driver for the USB Type-C altmode protocol. This has been tested and
> shown to provide battery information, USB Type-C switch and mux requests
> and DisplayPort notifications on SC8180X, SC8280XP and SM8350.
> 
For the series:

Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org> # SM8350 PDX215

Thanks a lot for working on this!

One thing, /sys/class/power_supply/qcom-battmgr-usb/input_current_limit
is stuck at zero and so is the current_now as a result (the voltage
readout is 5V + some noise, so that looks good), but I don't see any
SET paths for it in the driver, so I suppose that's what the firmware
default is?

Konrad

> Bjorn Andersson (4):
>   dt-bindings: soc: qcom: Introduce PMIC GLINK binding
>   soc: qcom: pmic_glink: Introduce base PMIC GLINK driver
>   soc: qcom: pmic_glink: Introduce altmode support
>   power: supply: Introduce Qualcomm PMIC GLINK power supply
> 
>  .../bindings/soc/qcom/qcom,pmic-glink.yaml    |  102 ++
>  drivers/power/supply/Kconfig                  |    9 +
>  drivers/power/supply/Makefile                 |    1 +
>  drivers/power/supply/qcom_battmgr.c           | 1421 +++++++++++++++++
>  drivers/soc/qcom/Kconfig                      |   15 +
>  drivers/soc/qcom/Makefile                     |    2 +
>  drivers/soc/qcom/pmic_glink.c                 |  336 ++++
>  drivers/soc/qcom/pmic_glink_altmode.c         |  477 ++++++
>  include/linux/soc/qcom/pmic_glink.h           |   32 +
>  9 files changed, 2395 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
>  create mode 100644 drivers/power/supply/qcom_battmgr.c
>  create mode 100644 drivers/soc/qcom/pmic_glink.c
>  create mode 100644 drivers/soc/qcom/pmic_glink_altmode.c
>  create mode 100644 include/linux/soc/qcom/pmic_glink.h
> 
