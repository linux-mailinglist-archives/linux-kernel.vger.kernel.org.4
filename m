Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CAA616C3C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiKBSdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiKBSda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:33:30 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015AC2A941
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:33:29 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id fz10so6196030qtb.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 11:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7jsBbxM68g4hu49oQPI04Z6ZuqRO93ekJAZVTY7G7PE=;
        b=XlNJsDQtwzg6thDxRfW7oyVabaE2Dtnv/wbgUbwPgBy0+XqBFYVwi6qmv4HscjWEhM
         VWhx/y99ZMsZUYDtYCoc6a1jm+hVyYv2ejTZz+QNyQyGu3suM0zFQ9GKJwgi74JdnRkx
         sNqwWk8UtdsMQgiEO5V/DSnwsTwFP7i/NkY7FNDPoku9AtLwgZETxiAi+4d6VmpAH9MW
         EFCN0NRMtXbQ5Crk+lHl0Gv0AjPMFmDmxpbOHNnbStfBxmwaUgFXqA7wbC5aJJiaGpzj
         zny1gvUh/5vZgBheuq20VWSeVuegfW2/ZcASG0Bf+9W0I0c2vCnRSAxGlWXJheqybn2/
         5wCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7jsBbxM68g4hu49oQPI04Z6ZuqRO93ekJAZVTY7G7PE=;
        b=jFlAMfU51BfLipgJ6jxGLCy9a8toaCNOzuTZO+sApNcFGHihjMS+aleofqPYgDiJcb
         zeu9Pt/Ppu81+RusHyrew5QVgXUyw0tOIIJakn5BeuEVBGeyCdt54yR7w1d47KsZeRib
         dRM0lu/z6mEpNnQC/lCHQkCUL3yy1q1ilpl2OSYL1L2hImolYMtZ0ReHzrlLfDHdMQSx
         12A7Y6De6/l2gCkLEobO/r6XvOu95wxFWSe6nOe20gg0q4ZrJ/Xk9GGH2TcI9/OUjwZA
         iBo/m0+QmRR6z0x3iqAEvfi+tiAPxogHNYwNFKgGRKKaXGgZ5Vf2HEcnF81FxPYzsoxe
         Q6/A==
X-Gm-Message-State: ACrzQf367HG6dM0tddc5jQQmggoiyONUxjEwDb8Z4Dvqkk/mDlbdZeiX
        7tRvplMV9cRSukQkU8zJy6ZeRA==
X-Google-Smtp-Source: AMsMyM72M7UDRorVLYAV/MhAIyKp6TXC/eN/z5Cvcc/FAEYGFSLv+6M0ttEcE0C6XUuL3Ts2Z+wFVg==
X-Received: by 2002:a05:622a:1014:b0:39c:c5ef:c768 with SMTP id d20-20020a05622a101400b0039cc5efc768mr20344412qte.525.1667414008128;
        Wed, 02 Nov 2022 11:33:28 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:28d9:4790:bc16:cc93? ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id u12-20020a05620a454c00b006ea7f9d8644sm9125353qkp.96.2022.11.02.11.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 11:33:27 -0700 (PDT)
Message-ID: <1c057273-2651-dafc-0b13-e3b958ac1d2f@linaro.org>
Date:   Wed, 2 Nov 2022 14:33:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 2/2] ARM: dts: qcom: pm8941: fix iadc node
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afd@ti.com, Konrad Dybcio <konrad.dybcio@somainline.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221031182456.952648-1-luca@z3ntu.xyz>
 <20221031182456.952648-2-luca@z3ntu.xyz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221031182456.952648-2-luca@z3ntu.xyz>
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

On 31/10/2022 14:24, Luca Weiss wrote:
> The spmi-pmic bindings require the iadc node to be named just 'adc'.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Changes in v2:
> * Drop changing double compatible, now bindings are adjusted
> * Pick up tags
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

