Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BB4602CE4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiJRN0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiJRNZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:25:53 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DC5C90D5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:25:13 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id s17so7385134qkj.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rLekKpBYGH8ndeJEM8TUXAibtMNpseYq89qr23kvcRg=;
        b=nvlt78pAFMY6sl9vdsBMkAaOROLjx8h2KNVZgLalVtUam0JVzz6yVruzLOdDb88KjA
         bxTlhpSl08Nyl2i2cSXTTRN4VeLZQ4AvVKBQ9ZlT3GK9J7a+zrJtd/DdZClAESfub3x0
         36cglufyWktnD761LvSVyVWhRVyFCa3JhW0Tqkz8wvQ8sU9AT/w/ycUBzQgcT+w7lJ+e
         Rkmbrln9N8Tvzs8NLkIA/LYk2VuzxAvLnXfz+FsiNlnALFS5xCR7LVVie9wUxtoSm8KF
         5x7WYXAC7Zx9VfTUzUTuSBmLrPtbHZeMJznUScgRaU8V0Wiwqxu7Ya6ZAJnolEp0U8eI
         Y90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rLekKpBYGH8ndeJEM8TUXAibtMNpseYq89qr23kvcRg=;
        b=HWR/8DHcH96QR/32LMH2kjW1Rfy66parWRq6NR9t0DQZm3NZwhq30WWKi/BgzOVqtU
         F23sQ0jqJPeVYwZ7G3AjEsF1RPsXOQ5uNEqCWcZ69GA577Ybz95KgU2N6f5q6UkYi030
         aeQRm6HtOUPnqQyHT5XIu/a2OIqD1LXWba/kCUP/Y7TWXM4h6wJXjECYwv5JqDeQhBZD
         e3s63RIM6G1av/93MFinOi03dddJHI25V/n6Aq67gJIR2uV4K/pK2ZseDMpLVZsK/6PQ
         ktrbiruC1toZhj+uUrPjdMbacZAw6OgjknGuFa+7UKCXVVS93LmjFQLo5sqvDssXsF3V
         GS4g==
X-Gm-Message-State: ACrzQf1KgxHAOSpWgmrljDfgm2ZrqynDTN2RJ9tIBIrM+64n2aYxE53h
        WQmK/5NoTkT+0FpYps/EE8vjig==
X-Google-Smtp-Source: AMsMyM7/FLeJ8jSuI5g0egAb58PR1xxeRZOb17GOpDIpA8y1m1u9lLMJRq80gc01kGOTu/6UmMKxxw==
X-Received: by 2002:a05:620a:d8c:b0:6a7:91a2:c827 with SMTP id q12-20020a05620a0d8c00b006a791a2c827mr1714546qkl.407.1666099509047;
        Tue, 18 Oct 2022 06:25:09 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id dt5-20020a05620a478500b006ee94c5bf26sm2430593qkb.91.2022.10.18.06.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 06:25:08 -0700 (PDT)
Message-ID: <81220c13-56e3-eda5-8b60-68b0f7a1feee@linaro.org>
Date:   Tue, 18 Oct 2022 09:25:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 0/4] arm64: dts: fix drive strength macros and values
 for FSD Platform
Content-Language: en-US
To:     chanho61.park@samsung.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, linus.walleij@linaro.org,
        robh+dt@kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CGME20221013110708epcas5p3c54c22bbc77175eb2a26dc9fd43814d5@epcas5p3.samsung.com>
 <20221013104024.50179-1-p.rajanbabu@samsung.com>
 <166609930553.9199.13331632528050957780.b4-ty@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <166609930553.9199.13331632528050957780.b4-ty@linaro.org>
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

On 18/10/2022 09:21, Krzysztof Kozlowski wrote:
> On Thu, 13 Oct 2022 16:10:20 +0530, Padmanabhan Rajanbabu wrote:
>> With reference to FSD SoC HW UM, there are some deviations in the
>> drive strength macros names and macro values. Also the IPs are not
>> using the default drive strength values as recommended by HW UM.
>>
>> FSD SoC pinctrl has following four levels of drive-strength and their
>> corresponding values:
>> Level-1 <-> 0
>> Level-2 <-> 1
>> Level-4 <-> 2
>> Level-6 <-> 3
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/4] arm64: dts: fix drive strength macros as per FSD HW UM
>       https://git.kernel.org/krzk/linux/c/3a27bce7e13e3b5368377c9a518927e197a4afb1
> [2/4] arm64: dts: fix HSI2C drive strength values as per FSD HW UM
>       https://git.kernel.org/krzk/linux/c/bb997d949e5a835f626facfd67b1768fd4492398

Fixed subject and squashed last two commits into this one.

Best regards,
Krzysztof

