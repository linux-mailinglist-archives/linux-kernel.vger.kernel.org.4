Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAA46045E8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiJSMvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbiJSMuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:50:54 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE111285C9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:32:54 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id df9so11223850qvb.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TsgvCsDrG0L5go1M7pNQAYTvwXsvN/vC+2+5gNeL11E=;
        b=Pwht4Y+YQT/Q+akb1YflgdfeRaQJuvKGI6p12b2VMApcNLE+XKb1VRzgzTpED0nkNt
         4f2KSAw6YjmsVm8Kt69rdjuO/3eGmIhPPBjoFnKwC5zHYkZ2Fbmu0SPZjSkUzBKnP5T+
         pv1c1OBsXnOCeRoLlWX0VJHUbBHciC17XRfwu1Lmw2ea0IZlXdCMK8+7aCfFMUGqeXDF
         jer9TP3K+xipbqsEHsFe1GShMYQ1zYLob1JTLk4flJZ3IxU8P3PRvKwb9JLyPRru9Jl5
         dPQBpZ0irN/tU/QIOTmQQNV6Mxc7D3gIV5HDt/zoERdAxrI06T7LMvXVFzBlSyh0zbqH
         ihhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TsgvCsDrG0L5go1M7pNQAYTvwXsvN/vC+2+5gNeL11E=;
        b=2OQhQ24UXVzksoP/H5TMms+IZENBS5kR/YKWuFEti4H3Av3HkYu9999C8px/sbztD7
         I3jM17mh1M0TwNjilsQ0rnoXs2gGIui17rgvm7giN6+rpvHdnFR0WmWlGZx7rzglYR4z
         qTmFACLkD5TfDOju6Ivt3H/QQOITWUs+k6SBQZ9woKRLamFMTbX5VJGAuwevnhhei09f
         sZrVRFHoSjC7W3DuP5mLspDrEs7GqKOkDhflMkylcEjGmV+ARKf7JZN3qiSdYg1zgCFb
         10QZUI2ICwcGiqTjJq6GWYMVFG8JMXgVdB3uW6R75vzJzFvNT2rQmTmt1aPOA9m6mcKO
         28QA==
X-Gm-Message-State: ACrzQf2vyB/Glbr/VEDLhY3rbBXUV++lvSk0ti26qr+jDuXxfJ6c+Zi4
        1F4V7Y2+oprmunWp95pTeV94hg==
X-Google-Smtp-Source: AMsMyM7ajU52RN5MSL5JJQ1VgEbJtgiUHm5DykSRp3Iw07X0DoKYmRCW+TIJPHzBUa6tueBS9s6jsQ==
X-Received: by 2002:a05:6214:519c:b0:4b1:8eaf:a21f with SMTP id kl28-20020a056214519c00b004b18eafa21fmr6147405qvb.97.1666182715482;
        Wed, 19 Oct 2022 05:31:55 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id hf8-20020a05622a608800b0039cbbcc7da8sm3871762qtb.7.2022.10.19.05.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 05:31:54 -0700 (PDT)
Message-ID: <05305f6e-8ba5-9145-7835-db60a8a560bf@linaro.org>
Date:   Wed, 19 Oct 2022 08:31:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: add loongson2 clock include
 file
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
References: <20221019062912.3463-1-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221019062912.3463-1-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2022 02:29, Yinbo Zhu wrote:
> This file defines all loongson2 soc clock indexes, it should be
> included in the device tree in which there's device using the
> clocks.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


