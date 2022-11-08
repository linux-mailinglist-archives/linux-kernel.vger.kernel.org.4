Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276AA621E56
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 22:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiKHVNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 16:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiKHVNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 16:13:01 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2483C6EE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 13:12:58 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id u11so22970564ljk.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 13:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wIdfbTng+tTAaILuDn9NZccChxnc1mAMEr243g5AE5Q=;
        b=iTjLTbcG99SbapGUPOpT8KcxRneAH8zYd4dQyMRXYtlti+glhDtRyLgvP5+CzzyfRv
         Fih/uqwNJ1eDGMVCFWx2tx9LCobMHtTd94MqkpcvGko+pS70kYfkZ5uLWF3idV8s7PRG
         8ArTY6mX7/cnjb50OcQITOrV5KZSXqA8SJW5meeudaev/T54y3GQSjc26MAdnhMxr6go
         lV4Bltmxy9zViJM0YWctiK9UUHGgSxycoWy2hNdiOVj/qUBqzTIEm0AqWF2J6eRao15n
         PmieweREvx7OVbDwwuRX6ynqXrpdbyr7uIlGVBQPlL1B+lItiFP1rblnW3Dv1aNKfFyt
         2qkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wIdfbTng+tTAaILuDn9NZccChxnc1mAMEr243g5AE5Q=;
        b=ejETEZR/Y+P92I5zx6Brgg1zH3slQTGE4OkV7f9o0BGMXY7OeidX40d6c2m6dZPxsx
         MP28GFrlcfKNr3MBZEVLRti8slT9smq+s40g1KgX2OWQ2HzK5suzPceWcTBQ1RgC/A+y
         ykQ6wqlLh7etGIlbjTat3yQoH1uWFAUxlm9xSQ5CwWXXqtE/RGeMAoT+O7LW1fQ/XKMr
         kRmNcloBuRRUDwxV3xFo0+AeCy0yMf7vd89kjWIkYow0S1iUpUGzhKRwuJ6Dcrk10jcx
         UGmK844MRBJEPMZCSQc5KfqUKWrNZRufHl1uK2mpY7eWzl4MOAXGs4MSbGdNKVqP0Onu
         Nfzw==
X-Gm-Message-State: ACrzQf1o+GH/8nEM0EO6yZcq9ljqBtSP6MOWUMMy657ZCNCenmgKdnLY
        om4F8XLo3YIkU3QO54vxnsXz6Q==
X-Google-Smtp-Source: AMsMyM6SgLmkxRFWJTxBTWSWRlGO/aMwDi/n44UGoH2/Rnkq8C6kWntqL+Y/9AfeOxEM2rY1scJwOA==
X-Received: by 2002:a2e:b94a:0:b0:277:91a:737 with SMTP id 10-20020a2eb94a000000b00277091a0737mr18825127ljs.25.1667941977231;
        Tue, 08 Nov 2022 13:12:57 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id c16-20020ac25f70000000b00492dba3c85asm1935745lfc.220.2022.11.08.13.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 13:12:56 -0800 (PST)
Message-ID: <6d671b6f-517d-54b5-23ac-49ba62c64701@linaro.org>
Date:   Tue, 8 Nov 2022 22:12:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 05/18] dt-bindings: msm: dsi-controller-main: Fix
 description of core clock
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        quic_mkrishn@quicinc.com, linux-arm-msm@vger.kernel.org
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221107235654.1769462-1-bryan.odonoghue@linaro.org>
 <20221107235654.1769462-6-bryan.odonoghue@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221107235654.1769462-6-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2022 00:56, Bryan O'Donoghue wrote:
> There's a typo in describing the core clock as an 'escape' clock. The
> accurate description is 'core'.
> 
> Fixes: 4dbe55c97741 ("dt-bindings: msm: dsi: add yaml schemas for DSI bindings")
> Cc: Rob Clark <robdclark@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

