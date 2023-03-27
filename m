Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F3E6CA0F9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbjC0KMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbjC0KMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:12:33 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82895524E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:12:31 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id c9so236151lfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679911950;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/C2K7AVqHJsIM3703QBvpePPFt/BDGgGCogbo4S2LZk=;
        b=WxthYPz1xddExSJCFGmMBWlKOVi7fQatkdUFNt+PD2NkE+/kLZjyCLxDkGJJ2kDHUx
         20Nqjf2ZyjFHwiQPq0x+/W9S0PwYZL0C9hX5eE+A/snI5hmIICi/n+nslh/IkA4JJXsh
         7GJ+k+QYGbesXFGy+avXrQ4cRA/mL5hJ45Iv5MkbHLKpo4KFPSeV9c5gGHMkuHxSr3N5
         D+7GltAEGNSbjJvbY2CsEPfCHlyI30Dd8V6pPT9Gs/vkYac06p5BbqBSS4rogKd4JK7k
         6V6VLyyTH7jD/YYuizij9tV1VmQdZceJjgkAjMC2BWIR8xkja0nvEkWkjJZx20d1E8zX
         9mjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679911950;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/C2K7AVqHJsIM3703QBvpePPFt/BDGgGCogbo4S2LZk=;
        b=dxqmcnZGk1xBWHcYuSvcZBaImYJlJKnyBSgedaVT/rbguR5Yh9NE/JmfRZCx4N+0X/
         G0JVdbwQhjziy5QCOR99rCLm4gZY7cMWPonE0jzxRCfhX8jiZERu3VwHoNby+/veaPmV
         tQ873e3g04gh89kjaOnU4+IS/575Zwbs9F6so4/O1RyH9NbCIZXqzdogJhkCoH3islFv
         tsFATlsKdnNk4LddoizI1v2zQ1YBa6/oM/H9hplV2W0RXmCqcJAuVzAiqW8DezTMsyja
         gxdpIFWWNaWqmCx1CsayiSZvivaYrFBwFn7ihuftScaJvFfFeCw/78dWij948Neb2Ai8
         qQdA==
X-Gm-Message-State: AAQBX9eoOMXuKljkZ8tAVNhOKp72+fXz8gjzQ4/1Xv2QEPZj4IG4CVWN
        xMVJ7gGGCz1sILr9OUXRJuUQjg==
X-Google-Smtp-Source: AKy350aoI3P2M/ZfMH5ucUYBuToxtgKf7V/XGxgJNrkdlksvqd3WgQLgAo/x7NDfMCfDmNlDw5zvMQ==
X-Received: by 2002:ac2:546a:0:b0:4dd:a57e:9960 with SMTP id e10-20020ac2546a000000b004dda57e9960mr3418274lfn.5.1679911949786;
        Mon, 27 Mar 2023 03:12:29 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id u2-20020a056512040200b004dc807b904bsm4632413lfk.120.2023.03.27.03.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 03:12:29 -0700 (PDT)
Message-ID: <e580d40e-c248-40f7-54cd-693d75c613fb@linaro.org>
Date:   Mon, 27 Mar 2023 13:12:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/4] arm64: dts: msm8953: Provide dsi_phy clocks to gcc
Content-Language: en-GB
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230325112852.18841-1-a39.skl@gmail.com>
 <20230325112852.18841-2-a39.skl@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230325112852.18841-2-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2023 13:28, Adam Skladowski wrote:
> Provide clocks from dsi_phy to gcc, this will make
> sure we don't fallback to global name lookup.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>   arch/arm64/boot/dts/qcom/msm8953.dtsi | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

