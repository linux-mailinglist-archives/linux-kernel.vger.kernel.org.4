Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9205F6226D4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiKIJYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiKIJYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:24:12 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E750B1AD8A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:24:10 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id k19so24842831lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 01:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0gm5yfU9YziCMwLNsyVuPxY75pXMz7VSRfqIfnoUFvE=;
        b=eAz2QvzAzn/m+Dfbq4RDigAZs9DY3fb/ppo0otCSBB0rL6JKxIhyMVX5z5qBd3TWR/
         esfHXVQT5OwDFrlQbFBn5UWr2a6+Rfd+IxmecJWkbEJBIUvMivnslwveb9VDfXILW4xa
         gY7l0U4qXQgwg0jG1+gtHBqYyce5aPFtHuwpGAxdPTs+n7j8fLlf+X8FRQfAtSxn8eGl
         mCCYbC8giysrnBFstKTI+K/cdUyReS/wTi3X/bTofv+jc2IyXO92OFHqd4Fob3YEW4h8
         5Z4EYgQs5XZ+KtqQwPwsX7otQWYOwDIF17QTI2Gkap78a2tTMVZwp906nXUjxpbCqf57
         vYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0gm5yfU9YziCMwLNsyVuPxY75pXMz7VSRfqIfnoUFvE=;
        b=B1XbCori7kdSjbJff6qXz4szq05pUm1Uw1K6B2qSAGrbRsDDI+7FDE7bINpVZa/ZRg
         242MGlFG2yqTxq14UtR7WBvcZ2JUMtRlqZlVB5KtYXYjP/v95h18kBZZIr4xs2l02GN1
         ll2wLzaTPKeZnSQ+oBCK1lV+AF37XRYM+zhNCWQG72BpGrhW73Qb4iMX+2ObdYiqKCcF
         DQqeGWK4BV92qZQRVPhQku+FS94W/YKs53nRsnEX86WKoXoV+H0R/b4i6raT85RGVRCt
         QEJjweEcJTYaXgdVPiol8Mid5194Ck7gGrF5FLNVWKKh6LGRXxk3Nta8t8Fqgj1HexRc
         2rkw==
X-Gm-Message-State: ACrzQf02gm5uzCIrPvMTsEQ96RJovQOFLYcumOTsrOqX1bvLCZS+rsOT
        98FrgHB/nq2dYHQRq9Zz17hKs+1C52vqhg==
X-Google-Smtp-Source: AMsMyM5UI1gFIlHma+VcJxWK8k5Kni7jsznGK0vbSHYejZElBiiGKVZcM7EDMrppBCrBZxji9Hvu6g==
X-Received: by 2002:a2e:350d:0:b0:26d:e73c:e018 with SMTP id z13-20020a2e350d000000b0026de73ce018mr8186724ljz.391.1667985849333;
        Wed, 09 Nov 2022 01:24:09 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id g19-20020a2ea4b3000000b0026de1bf528esm2084311ljm.119.2022.11.09.01.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 01:24:08 -0800 (PST)
Message-ID: <a588a90e-a8ab-7b43-a14b-101bb9f590db@linaro.org>
Date:   Wed, 9 Nov 2022 10:24:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v8 2/2] dt-bindings: hpet: add loongson-2 hpet
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yun Liu <liuyun@loongson.cn>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        loongarch@lists.linux.dev
References: <20221103065351.32603-1-zhuyinbo@loongson.cn>
 <20221103065351.32603-2-zhuyinbo@loongson.cn>
 <b0aed9f8-f82e-3d74-4299-4d77445c2170@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b0aed9f8-f82e-3d74-4299-4d77445c2170@loongson.cn>
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

On 09/11/2022 10:19, Yinbo Zhu wrote:
> Hi maintainer,
> 
> please help me merge it to upstream.
> in addition, this patch need rely on 
> "https://patchwork.kernel.org/project/linux-clk/list/?series=691497"

Why pinging for v8? Didn't you have v9 and v10?

Several of your Loongson patches had many build errors, pointed out by
lkp. Therefore I have doubts that you test these extensively. This might
be the reason why your patches float around...

Best regards,
Krzysztof

