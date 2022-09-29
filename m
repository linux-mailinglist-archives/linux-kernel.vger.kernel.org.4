Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7705EEFA4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbiI2Hs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbiI2Hsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:48:41 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEACC139420
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:48:39 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a2so1019290lfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Tid/nAhFERXLfYgWORgIvhzA6ivC3KOuDpJP97O0ll0=;
        b=wigLur9gEbEr0wd44D9cpg/Ai6w1oJAU3sb2MgRTDV0zFs+G/4xkWVf40hkE9sDP6F
         NTH55wFMkb7l9lkHkfPp/wDhcp6Abp5zGLrGiPOOHw+lsbvUbimjZQdCmuvtmDjMJmTB
         l3PqFo2xwZ6Okcd20GaG2Ez3FSN2/qA9cuWtJBojPvSm0VPvZzXFYWAP/+fK2af5vejf
         LPUGZ6ciQgwbSv3zRxAXxSjncRUbX90PS1FVVmBYw/MDGsIf5mpIbcNNNYlouj+ungdG
         YDpxeme/NiPNzyPyD77UTn+1otYwmPHHe2p1iSUeFp2esPordv0Mfub90Wha4HbjRzNz
         qS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Tid/nAhFERXLfYgWORgIvhzA6ivC3KOuDpJP97O0ll0=;
        b=pFLngvNFwXS4DmIpaPb0mW741QEoy8nUQBV+NX/kNOtdrybMPzuF7LzCmKanKEG2gX
         EgrX8+r+fLmTrfRJt4bzDU06X6HQQSDZKxoGJ9KrZjCf61oyZ1yhhBfnGPLlRaS+rWX/
         +uLfAUO7vnL6ptMGdavbYMx2/sWSv3ylr6V0MnY0PfHga4byQIpDGZtMnPc5+bDtw7Dl
         FYMqOUoBJvQ+w6jEg3rsWjpx5/vRqoxL2zxV6ftlt2xp6hFnjCH8rX/38v52DF4Y3uYj
         +LF3dYSc4C6H+Avvpv+d8n7xuNqIixHCrEUuIIgttglrNz1bVypwPvtEN9XIJGSZepG3
         8iCQ==
X-Gm-Message-State: ACrzQf1qPojQOhiHu8kG0dPE4abgScQtNz98NqVx+vvZ5zQltT2Bd2Eh
        ZhnKclLw/ZyD+Ru38+iPAl+ryw==
X-Google-Smtp-Source: AMsMyM7l6fn8/Gi16rRe0GWEMt+pHsumnQ2yl2vPgSexaYofuA0kIqGglb/cacoUDi3RaHE4qLeovg==
X-Received: by 2002:a05:6512:228b:b0:49e:f3d0:4ced with SMTP id f11-20020a056512228b00b0049ef3d04cedmr764655lfu.625.1664437717665;
        Thu, 29 Sep 2022 00:48:37 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id x4-20020ac25dc4000000b00494618889c0sm711460lfq.42.2022.09.29.00.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 00:48:36 -0700 (PDT)
Message-ID: <839afeb4-a5c2-2129-53c2-602d55a5ced2@linaro.org>
Date:   Thu, 29 Sep 2022 09:48:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v6 2/3] dt-bindings: thermal: add loongson2k thermal
 binding
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhanghongchen <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>
References: <20220929071312.29536-1-zhuyinbo@loongson.cn>
 <20220929071312.29536-2-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220929071312.29536-2-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 09:13, Yinbo Zhu wrote:
> Add the loongson2k thermal binding with DT schema format using
> json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
> Change in v6:
> 		1. Fix the warning "reg: [[0, 534779136], [0, 48]] is too long"
> 		   when compile the yaml.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I assume you dropped my tag on purpose, right?

Best regards,
Krzysztof

