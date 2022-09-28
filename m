Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE3D5ED635
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbiI1Hfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbiI1HfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:35:19 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E22F3123
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:35:07 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id d42so19184371lfv.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=n4jnpdb4dLSy7UExnnmpIHxtyt/nMjkUaIB/M2U4YT4=;
        b=k+Hmzx18WjUq3RZttCHCeIfDQ2BwCdr1TaGaGSjYIQhQ5DW0bD2jX+0khiBVTAOnM4
         XwHYXHZlFIe4U8FYbsyO5dcG7S+FuTkKPPJxHhUxlb2CQDDZzRRv+HmKUCALLmUW69eq
         FaxNNqP3dzaQs9THyzznnOUo/Cyo21e+RKKGrEo6zpDCDlPnPt9/NG9SdgiQ6CoweFmv
         aYUHnxCIF/oWPOxqdRdrGX0PKRD8tDDi+vm9zc3XaRy2ze+Y7sZ9Lo3AUZf7dLI9nfm4
         wY22pCkWyn96i7ze0AXj11oclQABXIk8nAfMev7AtitKAtAFMZ6VdLnXXp8kP62QP8kb
         fjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=n4jnpdb4dLSy7UExnnmpIHxtyt/nMjkUaIB/M2U4YT4=;
        b=AUmeO2poAKIzIXaUy4+XybDrHFywFhTH5XauELenuqlSsOuBHSK/prgGmxm0W2YLU4
         1MiCetOtNOqCcZjRElQq4CjiJ1urvNilzKO9EhzRGBmn1ok0FcYd0+zYy2dVBPj6pHtc
         d50u6/YfMQjUJ+rGEFFog4AjF75NkgB8sEhw87oot6UYp/eEoYKcK4dzM8VtrB+diOSM
         kjpf7ImT9gEVe7UMrfKWI+0RB3ozJZH79VnfQkY7Zb4dUMeYsF9/eGVI1eJiBcJFE53W
         A1V6uA02wrw99Fk7KUZ8jUi2qO8vI3rvN4JlGUacnwBrN5SXMh0VHvxMzt1UfsXfXYA+
         hOvQ==
X-Gm-Message-State: ACrzQf2t7Rwms3X982mBcyrF1yEPzIQZcNghcCPbtnbT1wbQQBEIqWJq
        Xr3i56V47NnwaMCzAWukV1KPKA==
X-Google-Smtp-Source: AMsMyM4vZBm/NzbFStl4PS4xXjJmr9t7TU1u2VA3RwodqI1RQNR6U5ltgGVh11/d5SXQ82dldG6kwQ==
X-Received: by 2002:a05:6512:22d2:b0:498:f68b:6cab with SMTP id g18-20020a05651222d200b00498f68b6cabmr12619861lfu.548.1664350464533;
        Wed, 28 Sep 2022 00:34:24 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q16-20020a194310000000b004946bb30469sm396465lfa.82.2022.09.28.00.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 00:34:23 -0700 (PDT)
Message-ID: <1e2df247-c0ce-ab7e-3017-fadd963e1a8d@linaro.org>
Date:   Wed, 28 Sep 2022 09:34:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 01/13] dt-bindings: rockchip: Add Hardkernel ODROID-M1
 board
Content-Language: en-US
To:     Aurelien Jarno <aurelien@aurel32.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Dongjin Kim <tobetter@gmail.com>, Rob Herring <robh@kernel.org>
References: <20220926183727.1893566-1-aurelien@aurel32.net>
 <20220926183727.1893566-2-aurelien@aurel32.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220926183727.1893566-2-aurelien@aurel32.net>
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

On 26/09/2022 20:37, Aurelien Jarno wrote:
> From: Dongjin Kim <tobetter@gmail.com>
> 
> Add device tree binding for Hardkernel ODROID-M1 board based on RK3568
> SoC.
> 
> Signed-off-by: Dongjin Kim <tobetter@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>

And second issue - your SoB is missing here.

Best regards,
Krzysztof

