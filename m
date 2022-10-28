Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0997B610FF1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 13:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJ1LnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 07:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiJ1LnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 07:43:08 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317411D2B42
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 04:43:07 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id w10so3862726qvr.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 04:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pa4o10V2uYugUVoKqq6yjjDg+mNOr/BQAbRwWBsPRtM=;
        b=JX5M/+/2HWQ10e3W0WLl6CWzXoXlie2tjB4pKMvJdcii+roJFGtinwIaklhaF6DUKG
         OtSpXZg6xjI5Hpvsu3ORDq4Zetq4sDRcnd3G4GMJY0Y7YH1MCPx6YRwYrg4f6k4NejnF
         FJRWrWznSuAuIbRVkpImnS2kfGrAoLFtFeZonvM0hrOGVGQNcmb8+N2p+Uhfq9cP0VeC
         23his/m8b4sUZUqewSRIGGC3/A0+ixueVylCLnWZvFQb4rvpKLC6J3OrC7okwU/IIfxY
         cE48yUVCtlF0HhCUeuiiN4YP87VEqgKai3EO3eU9Lw3YiaZH4/v+hrc8M8yHTVYxsRxT
         Xwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pa4o10V2uYugUVoKqq6yjjDg+mNOr/BQAbRwWBsPRtM=;
        b=C19EvtiHibZN8BrVoKmCiN8vmx+1tsksaLtSZRAUUqXoOqv1Oq2a//QIT+XyeLAE4u
         O67IMS77JFE+6wpEdTJcHh9YpUUdN6Fk8L7A8+NqoHJpHy9IYWeEo7Z7hjFhQ3GbUDag
         g1ZweA1G8sZTzXKwxqu5CASPcZ5fUKgRkUQfa9sLxJQJZ/CWknnSKRxXk1yk07hMTFmH
         N9682YyvM/1oKTe+6tOfX66z2AcAlCzx/C1bWZgO7Rw17t3ntZ9rjx1BD6pNepz23HXx
         +ggNrYdH76kAZ9U6fu58BccLoOJ0YtoNzfEv5sYt/hV4x8UROf2EalbYkv3mkooZNqth
         EXSg==
X-Gm-Message-State: ACrzQf29L7eLGqOC+SNRmyo0g558OF2HdJR6GLqoglrgNgKtrjmuVuaS
        1/8cB4hIzP3O4aW/PTCa4AclGw==
X-Google-Smtp-Source: AMsMyM7bghuS9h/0jCAZoW8otuRB7+u3RvPRMdDpIVdgW6VfT6Pm7FaGmGBHKMiy1B/XHwmLyL6kHA==
X-Received: by 2002:ad4:4ea2:0:b0:4b7:e8a3:e043 with SMTP id ed2-20020ad44ea2000000b004b7e8a3e043mr36526888qvb.34.1666957386382;
        Fri, 28 Oct 2022 04:43:06 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id q11-20020a05620a0d8b00b006ee9d734479sm2776093qkl.33.2022.10.28.04.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 04:43:05 -0700 (PDT)
Message-ID: <01a38c4c-b42a-c170-3c3d-0b7e087bfaa4@linaro.org>
Date:   Fri, 28 Oct 2022 07:43:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5 1/3] dt-bindings: clock: add loongson-2 clock include
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
References: <20221028025504.13247-1-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221028025504.13247-1-zhuyinbo@loongson.cn>
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

On 27/10/2022 22:55, Yinbo Zhu wrote:
> This file defines all Loongson-2 SoC clock indexes, it should be
> included in the device tree in which there's device using the
> clocks.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Change in v5:
> 		1. Replace loongson2/Loongson2 with loongson-2/Loongson-2.
> 		2. Replace soc with SoC.
> 

Where is the rest of the changelog?

Best regards,
Krzysztof

