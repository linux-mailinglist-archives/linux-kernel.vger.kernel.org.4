Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE2D65371A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 20:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbiLUTmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 14:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiLUTl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 14:41:57 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD65F26102
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 11:41:55 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id m6-20020a9d7e86000000b0066ec505ae93so9648815otp.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 11:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M77+zkSrNLPknPTLa1QipDCIHqQpe+PgczwgzLamsAQ=;
        b=V3ap7UEAvze92oEmjHSpPU+W/Mq3T/ZoTGcN1x4Imhxw+3JdxoAUq42/164zPEQKnR
         wK+Xi7s8lio6LtL38ODgbknXRgpVh1cDvkllAK46rfCgsbIMQzm5xHoiq5oFs2u0dT1X
         RmaAnRCooC5KgOTvn9n208tf9mtk0HpdJ5REtp4gatMRGPFAtaQrlUMCPn6+Fch/FuCd
         2VFHo85jJyAGzOEIOzSopVkVYql+PW7UNAMJijxIP36Q79hZD+eCWFX75OJste7IYkfE
         ZQFzRHArJC3CsX4eCFswOQCm0RNYhJwGXxHyPnZ1mz2jJHkcclb/989bHw2B7YiBwrFO
         eeTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M77+zkSrNLPknPTLa1QipDCIHqQpe+PgczwgzLamsAQ=;
        b=azvC7duxnyC9ZH2lt+9IPB2TvxA6Q7YXKkNmzlVHh6d5Q2faV7UDR0b81wiI4IDVOk
         XosGXqUc5vpal+XCyJid01gvTMcXfmnul9tOtbusQpQIpcou2C635BJ8xuE9ZQy0GFEf
         oWZbNyE1B429MOEsNg1tNn+fDrNeNEb8A2Tq7NasXL04rQDe4RtdOu1vJFwYwIL+qIPd
         19RDovWiiUCxDPJuSNJusvFP9RgZ8n6Ld657WZ4l8/gg5oRGI0TlbA9k+DD2vhMxw0hl
         nd2swxiTXg/23qfwSa1oV66VrCI4pEWZCtnvuaqddiM9t5oGV//u9onKF5/JeU+ZJold
         8k8Q==
X-Gm-Message-State: AFqh2koyvHIHBlBMQVmXOWZNqt85lRl2tFJW/ePfRx6REiRsy9GMCGKg
        Hb2de5LFiRpzFOEvS46qZf2aQg==
X-Google-Smtp-Source: AMrXdXsNphmP7S1148UfbgYRWOShpLe/8D/x7R63IpeDLafvHZ6lrfJ8iA8shAxwkx95cBEJXRvZkQ==
X-Received: by 2002:a05:6830:26e5:b0:670:8d2e:649e with SMTP id m37-20020a05683026e500b006708d2e649emr1150551otu.17.1671651713994;
        Wed, 21 Dec 2022 11:41:53 -0800 (PST)
Received: from [192.168.11.20] (23-118-233-243.lightspeed.snantx.sbcglobal.net. [23.118.233.243])
        by smtp.gmail.com with ESMTPSA id g17-20020a9d6b11000000b00660e833baddsm7325994otp.29.2022.12.21.11.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 11:41:53 -0800 (PST)
Message-ID: <4d434dd7-cd3c-ed53-c337-4cf1ba018aef@kali.org>
Date:   Wed, 21 Dec 2022 13:41:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH v3 0/7] dts: qcom: sc8280xp: add i2c, spi, and rng nodes
To:     Brian Masney <bmasney@redhat.com>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     quic_shazhuss@quicinc.com, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com
References: <20221220192854.521647-1-bmasney@redhat.com>
Content-Language: en-US
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <20221220192854.521647-1-bmasney@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/20/22 1:28 PM, Brian Masney wrote:
> This patch series adds the i2c and spi nodes that are missing on the
> sc8280xp platform. Since I am already making changes to sc8280xp.dtsi
> in this series, I also included a change to enable the rng node for this
> platform as well.
>
> The first three patches in this series are new in v2 and rename one node
> at a time to try to make the review easier. Each patch has a changelog.
>
> Note that this series needs to be applied on top of:
> [PATCH v5] arm64: dts: qcom: sa8540p-ride: enable pcie2a node
> https://lore.kernel.org/lkml/20221213095922.11649-1-quic_shazhuss@quicinc.com/
>
> Changes from v2 to v3:
> - Reordered rng node in patch 7 so that it's sorted correctly by address
> - Since I respun the series, I made Konrad's sort order suggestion to
>    the state nodes since I'm making changes here.
> - Collected R-b and T-b tags.
>
> Brian Masney (7):
>    arm64: dts: qcom: sc8280xp: rename qup2_uart17 to uart17
>    arm64: dts: qcom: sc8280xp: rename qup2_i2c5 to i2c21
>    arm64: dts: qcom: sc8280xp: rename qup0_i2c4 to i2c4
>    arm64: dts: qcom: sc8280xp: add missing i2c nodes
>    arm64: dts: qcom: sc8280xp: add missing spi nodes
>    arm64: dts: qcom: sa8540p-ride: add i2c nodes
>    arm64: dts: qcom: sc8280xp: add rng device tree node
>
>   arch/arm64/boot/dts/qcom/sa8295p-adp.dts      |  12 +-
>   arch/arm64/boot/dts/qcom/sa8540p-ride.dts     |  91 ++-
>   arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     | 160 ++--
>   .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 178 ++---
>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 725 +++++++++++++++++-
>   5 files changed, 983 insertions(+), 183 deletions(-)


One note, and this isn't due to your patches at all, but the touchscreen 
on the Thinkpad X13s needs to be manually bound in order to work via 
echo 1-0010 | sudo tee /sys/bus/i2c/drivers/i2c_hid_of/bind - this patch 
does not affect that, though I had hoped maybe it would.

Tested on the Lenovo Thinkpad X13s

Tested-by: Steev Klimaszewski <steev@kali.org>

