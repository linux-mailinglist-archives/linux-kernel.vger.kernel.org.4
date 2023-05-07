Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43E96F9BA2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 22:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjEGUu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 16:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjEGUuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 16:50:55 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E81A5DE
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 13:50:53 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2ac7707e34fso44401901fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 13:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683492651; x=1686084651;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HjBrxK8qc3xLnnr2R60HyqhiwwpGTFeasR6j9aUXl18=;
        b=wIqNDsfN0z6yBX/VVpdrkPMvJGlRY10siClhXAPgQGqvQ5AfmZZ640ida1ZiyToIr+
         NQbDzhWRuOLUOI+XZAC8fCj30+5jVzF3KNzHFUFYkk5XBmiec/f9tau5yajJZ1A9qjX7
         jn+8tN6YJBfy3nE5spTLIKh0fcNma5ArIevbfx+fSTzcV4fGC54WB1hN3yXcLLjJn3+d
         1kwENGSIJa3Ti7/xyjv5Ctv4e4/L1lTaoqvB/d6rYjSy/Nn6Xr2hfIk365QcKd0KEq/i
         ECLmuaI9AQGfROn4zE04bDvKNMp1dPnm64ZajXReLmQfSZ3b0IAPucNwu1v2RM635/ms
         6h/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683492651; x=1686084651;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HjBrxK8qc3xLnnr2R60HyqhiwwpGTFeasR6j9aUXl18=;
        b=hXobQoHNjLXHQoxmeC2IJKavgM4Azp0xDnRlbzj/ipmPzSVSTtYm9w8SM82vh4pgkm
         wbVCteck9z8fCi5+Te6ciCj1W8oR7ybCngUiG0KPKBuDNc9opHmjdr3CQ0db+UE/NcpV
         OL2BJa9vQoDWQvxJqsHMfZuCMtGnMioRU589CLghkb5dh12d+Lu1FmBMqSWkBygtEOEH
         cJKb8FEWjY9pN9iemUNBc8t+Dl7Ti6bM/qEn/Z8XJ2lyD6TMz6bICjWT3dclzVDRwwBf
         HQdMNZQ3EoDjgxeHWyusVCYQBDJflpXm33NVYxZz5N7FVLRJ5CjpwYxSdlaAeOs88yUN
         TOqQ==
X-Gm-Message-State: AC+VfDwv8VjNnM1AHBf47Zsr9lfBYqjyiI4odKD3DCqEsc3WdM8ZYQEo
        WxCGmqey74UTOzs9axEh4IP+EA==
X-Google-Smtp-Source: ACHHUZ6CJi6Oe3pMcbkYpstoXB9PUlE7AlvcRdkEhZs6+g0ljHXjs5PiFlQTNvpZ1wHUwDn4oeg12w==
X-Received: by 2002:a2e:9c99:0:b0:2ac:8db5:a717 with SMTP id x25-20020a2e9c99000000b002ac8db5a717mr1877948lji.1.1683492651260;
        Sun, 07 May 2023 13:50:51 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id f4-20020a2e3804000000b002a634bfa224sm929889lja.40.2023.05.07.13.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 13:50:50 -0700 (PDT)
Message-ID: <45492699-9e1c-2a45-372f-5ce467de8f7a@linaro.org>
Date:   Sun, 7 May 2023 23:50:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4/6] ARM: dts: msm8226: Add qfprom node
Content-Language: en-GB
To:     =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230507201225.89694-1-matti.lehtimaki@gmail.com>
 <20230507201225.89694-5-matti.lehtimaki@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230507201225.89694-5-matti.lehtimaki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2023 23:12, Matti Lehtimäki wrote:
> Add missing QFPROM definition for MSM8226 SoC.
> 
> Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> ---
>   arch/arm/boot/dts/qcom-msm8226.dtsi | 7 +++++++
>   1 file changed, 7 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

