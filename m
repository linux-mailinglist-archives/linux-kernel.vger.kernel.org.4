Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AC26D9F3A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjDFRwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239846AbjDFRwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:52:19 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A9F6589
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 10:52:17 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x17so51915481lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 10:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680803535;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oqh31J+9WnCZQ+VZx21flHudxWSRa9C49U+L9cIzO1Q=;
        b=Xx0nLvpwpJd/sMMLhHll4wxkQTSt6NFYangv9757u6H2SxmyIDjNLRC8rVLENWH0OJ
         0nNuaAQZ6bA3RXuPNBo6xfZtyBP3JBM6YvALYzjEeqL5AWSBeZmoP6wQDw0zC9udnvJo
         1qYKAyCLaPSytfUCYXjym32CSyU/QARkblPpO10hCzNR1xRArY1/NilF3fn/1yqp2+kq
         ea7wMR/3fPW4soTgo1kR5Dxa9gSkDtcHp5gSowEBlj5x9k1zvoNdy8LxuGgUDNMMwr6B
         i0bQ8e8Vd10B0BhuTsbunKOif39RDzMH5Mo/VHIcalJRAGzvkq79xlO7iDtmPfQ8KutZ
         c/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680803535;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oqh31J+9WnCZQ+VZx21flHudxWSRa9C49U+L9cIzO1Q=;
        b=aBEMCHIOABd5xJcNEo5HM272rS0K0334kieuZSfzp3SsQ//dHNIbDqfmpptOVrNAMb
         x5DGHseyyYEca7zmO63Son8Y9lOFEfsTIU/vo8TFVvDZaGq9IHOJPK4234hk86+w7J7J
         jv4flZVEkXFH5MXvxzF3N4INa5QdrH5Cjkhr84NLfIcBlKokLeLMQDUTq8Y0kyEVF/T/
         4qqZf18tswgGsg8eoRZC8IoMZapthgA6FjcUoNkFD36Z+4H53pNEl85403pVW/m/nBs1
         J3XBdrRA9QPzYRBx5BMB9mQaShHatEizZ9SFRNHJyCzc/e2FC0d4q8HY1IzZvUWDvHCH
         QaAA==
X-Gm-Message-State: AAQBX9faee0A+kAvzDW3vmVp7mMwurbLD7yB+xJs8tT0wZrkwjmjUZxa
        5qKCezzBO5ADTbfQc+GC3QtHbw==
X-Google-Smtp-Source: AKy350aLEqlbMg1zjr2Iszui+7uEs7GNXcNS3DH8MVJGY6resuvtAQm9HtTXhcCL2oIw5pjyLZaYIg==
X-Received: by 2002:a05:6512:985:b0:4ea:fc73:7c59 with SMTP id w5-20020a056512098500b004eafc737c59mr32499lft.10.1680803535690;
        Thu, 06 Apr 2023 10:52:15 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id e25-20020ac25479000000b004eb2643a473sm355351lfn.161.2023.04.06.10.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 10:52:15 -0700 (PDT)
Message-ID: <ba6677de-b95a-1d4c-4185-762ed46bdb4c@linaro.org>
Date:   Thu, 6 Apr 2023 20:52:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sm6115: Add RMTFS
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230406-topic-lenovo_features-v1-0-c73a5180e48e@linaro.org>
 <20230406-topic-lenovo_features-v1-2-c73a5180e48e@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230406-topic-lenovo_features-v1-2-c73a5180e48e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 18:25, Konrad Dybcio wrote:
> Add a node for RMTFS and associate it with MSA and NAV IDs to enable
> modem functionality on SM6115.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm6115.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

