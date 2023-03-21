Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FCF6C30F5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjCULyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjCULyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:54:15 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BE61BE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:53:45 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id t14so15200133ljd.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679399623;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PHYicZCpX9e/ECtMpq+W+0vzy+duTC7O8lXBsVndLUw=;
        b=tIbCAi3++wdGvgilnSs/W2RaKDtbmB1bkE2JN4k4nUD9diudsq0XhOFrM1/wzjoQ6s
         HXpRpc/MGxO8eZF4oPuYoAhoDhyRY20NFe/xtt21zORiVScFZdluRKBemi8nJzq2LS/G
         D4pDWFDHv4y9GgHXGzdjP4m1jfJKHSWre78eQ9I/zDsoejLf5NB3rlPomePj6JWdsMsu
         wx+epJ9SbGBbaXYSnzp51/yMPoXCXl1HsWJT95Kd5P+q5r8sHkBR/uJ9UypLGVsvRoRD
         3yBTbT6Y8DTi8JgFZ7mmkLH2cCVn6tPgE7LWufhrZk0C/Xr+lHElJMWStUADhsFXxKGr
         juGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679399623;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PHYicZCpX9e/ECtMpq+W+0vzy+duTC7O8lXBsVndLUw=;
        b=qfwqmE5AeWpaC3dXmApL9oJFy45IKThlJITdufT9qChGjI9MZbeI21qv01Hs9CgBUg
         17Ko+QHuHwuDyweE8Bn8KOyp/vkodiusC1EaFRqo1kONWDQLFB9UtjgsyW9RWFmO/u43
         PdgzeutGgPnlnLgUoopJg0pwZtVRejxkXJbUhOG5WfXb+9vQG94eRosZkfb3qkpz9XOf
         Df5MN8CW70G7bEDABfUNCMeMNqJJbZCCxD/zJSB392uAhR1aZiB79VuBsz2nwk+RxJoS
         EO8qoBeuFrzWRxwGXgkKz50jx854AlF+hfqR4mc8pPko/zGytRMKFXh6phbuIXo63Vbx
         N/mw==
X-Gm-Message-State: AO0yUKUkzoTNFqdIQA28Ky+/w9hOw2o0Wmh2/+gv6kBPOq3xI6jqCGmE
        BPK7B2/Y8R6zlQB8rGXrTcNApQ==
X-Google-Smtp-Source: AK7set8H8ztkokOQKVh1LA5viyxH684OEh2WsxmA1W5HeX5LBIFmqiZHmb3kb3SJZ2Jqe2771pVwJw==
X-Received: by 2002:a2e:8699:0:b0:29b:7c49:a512 with SMTP id l25-20020a2e8699000000b0029b7c49a512mr811204lji.21.1679399623692;
        Tue, 21 Mar 2023 04:53:43 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id l22-20020a2e8356000000b0029e967c1dfesm634385ljh.8.2023.03.21.04.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 04:53:43 -0700 (PDT)
Message-ID: <1cb44e37-9881-3c71-816f-a492c917c494@linaro.org>
Date:   Tue, 21 Mar 2023 12:53:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 0/8] Enable IPQ9754 USB
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        gregkh@linuxfoundation.org, mturquette@baylibre.com,
        sboyd@kernel.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1677749625.git.quic_varada@quicinc.com>
 <cover.1679388632.git.quic_varada@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <cover.1679388632.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.03.2023 09:54, Varadarajan Narayanan wrote:
> This patch series adds the relevant phy and controller
> configurations for enabling USB on IPQ9754
I got this as a reply to the v1 thread. Please don't do that
and send it as a new mail thread the next time around.

Konrad
> 
> Depends on:
> https://lore.kernel.org/all/20230217142030.16012-1-quic_devipriy@quicinc.com/
> 
> [v2]:
>         - Incorporated review comments regarding coding styler,
>           maintaining sorted order of entries and unused phy register
>           offsets
>         - Removed NOC clock entries from DT node (will be implemented
>           later with interconnect support)
>         - Fixed 'make dtbs_check' errors/warnings
> 
> [v1]:
>         https://lore.kernel.org/linux-arm-msm/5dac3aa4-8dc7-f9eb-5cf3-b361efdc9494@linaro.org/T/
> 
> Varadarajan Narayanan (8):
>   dt-bindings: phy: qcom,qusb2: Document IPQ9574 compatible
>   dt-bindings: phy: qcom,qmp-usb: Add IPQ9574 USB3 PHY
>   dt-bindings: usb: dwc3: Add IPQ9574 compatible
>   clk: qcom: gcc-ipq9574: Add USB related clocks
>   phy: qcom-qusb2: add QUSB2 support for IPQ9574
>   phy: qcom: qmp: Update IPQ9574 USB Phy initialization Sequence
>   arm64: dts: qcom: ipq9574: Add USB related nodes
>   arm64: dts: qcom: ipq9574: Enable USB
> 
>  .../bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml    |  22 ++++
>  .../devicetree/bindings/phy/qcom,qusb2-phy.yaml    |   3 +-
>  .../devicetree/bindings/usb/qcom,dwc3.yaml         |   1 +
>  arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts       |  12 +++
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi              |  86 +++++++++++++++
>  drivers/clk/qcom/gcc-ipq9574.c                     |  37 +++++++
>  drivers/phy/qualcomm/phy-qcom-qmp-usb.c            | 119 +++++++++++++++++++++
>  drivers/phy/qualcomm/phy-qcom-qusb2.c              |   3 +
>  include/dt-bindings/clock/qcom,ipq9574-gcc.h       |   2 +
>  9 files changed, 284 insertions(+), 1 deletion(-)
> 
