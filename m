Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9CA67E91C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbjA0PLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbjA0PLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:11:47 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FD47FA01
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:11:30 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so5619508wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pFGFyIlaUgi5dEdEAInZAffkhm1C7oufG5PHtVZv8k4=;
        b=n+Z7FILuTAIuI8fdgCmqUjlUb9JshrYX66HmRWLHbRPJzI91jR0lFU9qYjA8pVnHMJ
         Vq9r+s++nCsd5q34Qv8B7ScoMEUzjXVteDLzJJ1Df23lJEDXlftru/r7vV22B9WABGhv
         txUox2wazSwJbjubtxB4RD4fjmoZzOiD7Wn0t1mJFk8IQKVG7QDMo0EM5loeJGdX+d/X
         SyUOoOrhMxCPVMbPcZ26NIpIAiHIukooSbmmwzmwRb5icSGU3OCNnL1BaY2bWsz7YpXR
         74El27246kheJaaVmiTYe1b2eboYcww+/jfTtJsjWuLeJWU+ZBWmHJWYDTIN6UUF5NG7
         NpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pFGFyIlaUgi5dEdEAInZAffkhm1C7oufG5PHtVZv8k4=;
        b=sUzLPHTbAw2OcGAxs20FGCH342qkGFru6xUVKdlxX0dVc7NCGlRAz9DkmY7kxpFR6c
         RusNaPLeuV5ahtEgIn2sNi84YMiRyfResJJVAVFF/WsBcSyrf1eG70pY93yTiR0XsQtH
         baMppNGob7rh/1rTnj2HvjEN0irvVPlu+HCpw3OwrjlVsW0gX3VcWwDi2kyN9IKBEK8Z
         oEMMRE6LbNYxWCAHDua7e/iTQjNbT7Lc11iU/soO4vXpT9+KfwWhe5WbzGsPgjt5klRm
         FQvch0Si01bzUfH/F2tpKi59XzPhTEa+GHekL9pMU8YWEpGEtH4AzA3daSEcS/yZetI3
         kJ8w==
X-Gm-Message-State: AFqh2krDcx+Nh5KuSgIipSGHhU7po7IVFu2JRCuafP15lDnd/k26Vtzf
        1e6BK+0t73MSfhtCFH3VwO0TSg==
X-Google-Smtp-Source: AMrXdXskBTvhigu7JjoC9WzKkVc8AO+kZF5hVkJFTRwD5SOusc042fCbF4GvHhgYSIed5eluNp1kKg==
X-Received: by 2002:a05:600c:c0a:b0:3db:2858:db84 with SMTP id fm10-20020a05600c0c0a00b003db2858db84mr30564681wmb.34.1674832288879;
        Fri, 27 Jan 2023 07:11:28 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c26d200b003da28dfdedcsm5390776wmv.5.2023.01.27.07.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 07:11:28 -0800 (PST)
Message-ID: <1eff0411-430d-25d2-f1c6-41b22ff3938f@linaro.org>
Date:   Fri, 27 Jan 2023 16:11:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 07/15] dt-bindings: clock: Add Ambarella clock bindings
Content-Language: en-US
To:     Li Chen <me@linux.beauty>
Cc:     li chen <lchen@ambarella.com>,
        michael turquette <mturquette@baylibre.com>,
        stephen boyd <sboyd@kernel.org>,
        rob herring <robh+dt@kernel.org>,
        krzysztof kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:arm/ambarella soc support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:common clk framework" <linux-clk@vger.kernel.org>,
        "open list:open firmware and flattened device tree bindings" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        arnd bergmann <arnd@arndb.de>
References: <20230123073305.149940-1-lchen@ambarella.com>
 <20230123073305.149940-8-lchen@ambarella.com>
 <0c19efb4-3bca-f500-ca24-14b9d24369ef@linaro.org>
 <87y1prgdyu.wl-me@linux.beauty>
 <b26a52ff-6b8a-8a64-7189-346cd2b0d705@linaro.org>
 <87tu0ehl88.wl-me@linux.beauty>
 <ec9fc589-2612-3315-3550-83b68bead926@linaro.org>
 <87sffyhgvw.wl-me@linux.beauty>
 <f70def8e-b148-616f-a93e-c2a8fb85be03@linaro.org>
 <185f3b3a330.11c135c37327076.6300919877819761183@linux.beauty>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <185f3b3a330.11c135c37327076.6300919877819761183@linux.beauty>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2023 15:48, Li Chen wrote:
>  > This is independent topic. SoC-specific compatibles are a requirement
>  > but it does not affect your device hierarchy.
>  
> Thanks, "requirement" makes things much more clear. So I will always use SoC-specific compatibles even
> if different Amarella SoCs may share the same reg offset and setting.

Just please read before sending any new versions:
https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst

Best regards,
Krzysztof

