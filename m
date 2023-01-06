Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBB96600D0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 13:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbjAFM7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 07:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbjAFM6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 07:58:50 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B96E6B59C
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 04:58:49 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r2so1192474wrv.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 04:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CSdruF5WslPDBt2aMUvunziwZFAXmjY40b4SkwxJcEw=;
        b=aD59vwgKsFK5Xl0LWbV8422liKKQ99+pRFNofzudeZ9TLvhjfvA5aWZK1AtjtIB4ie
         H5m80vusHk+kxg7O4svqepqssqYLcP7ErdQOZn9nSr1QbdQyFu3xGeutdMHrzvyJEa2G
         oLEr9wzeG8mkI0sRfB2pbgQzTxLGwWUffA0quc7sr7kCMIfrfkoplJVi2nf/VN2fJ3fo
         JKjGxFiuruHSXs0fdyPpyVCrR045fqrK4s9AvURQSsvTZbE8f5HFiG/TVSQJKwUg8vxW
         WbjJS605eYf2qmwqFNsLzD3wFF9rKLNXYFD7zCDgBpi68MelwjmvnjNAG7Q/JyV6wRRh
         iMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CSdruF5WslPDBt2aMUvunziwZFAXmjY40b4SkwxJcEw=;
        b=u8k3kC1nXo7J174p1B7zLxPT4ONfEQ8+yrjQbaf5D09QSqERbDJuHauXm91nh4HP4s
         8SfPM9nfX9Qh8CFzocggLg+IAhlgWiH94Nv5kYuiF7AOnEiDnsoD6QCI2KpNYFgHfb+R
         zKeOyqyDvJSt0HCSGVl4220OkOrbyJYgMJitwdT7Wycsl6jHHc4cjFFhoF2FnNAGsW6M
         H4nMdPItJoN8ZTLejhuLf47BeY2PXzQdVW6kfPU6bCq0p9S1KEHQT22yVb73Oh30C9tn
         8A3GanJEcEIxg1+wB5RXm8Os2GTgFq32NsFmFL4piyx9c+tCPFdziQJ1bqMC8o5hApj9
         AYYA==
X-Gm-Message-State: AFqh2ko54aGkSsPmgQR21hx5+rV0R5TtGK6nhLh/uHOmmnbm90zK66+E
        4X1LoUirll1Ti7WFOCgj2N6M2Q==
X-Google-Smtp-Source: AMrXdXs5rezawuzK2oCvI7diB1SxdYe301BsOGfKql0K71pMTyK/4QZ4An47IHTwgS80S0N9CWfmag==
X-Received: by 2002:adf:f4c5:0:b0:291:3f93:b7d1 with SMTP id h5-20020adff4c5000000b002913f93b7d1mr16091637wrp.64.1673009927832;
        Fri, 06 Jan 2023 04:58:47 -0800 (PST)
Received: from [192.168.1.102] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l13-20020adfe58d000000b00296730b5c3esm1111034wrm.102.2023.01.06.04.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 04:58:47 -0800 (PST)
Message-ID: <ebb0a452-9ae6-780a-a6ca-d34d0ebbc520@linaro.org>
Date:   Fri, 6 Jan 2023 13:58:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V4 1/3] dt-bindings: arm: ti: Add binding for AM68 SK
Content-Language: en-US
To:     Sinthu Raja M <sinthu.raja@mistralsolutions.com>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
References: <20230105151740.29436-1-sinthu.raja@ti.com>
 <20230105151740.29436-2-sinthu.raja@ti.com>
 <977b5cce-2501-4d7a-fe24-437df88aee8f@linaro.org>
 <CAEd-yTR=zdg_pt=MzkzceGTY2SkV=16dyhXCtd4EU-KGzP_mAQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAEd-yTR=zdg_pt=MzkzceGTY2SkV=16dyhXCtd4EU-KGzP_mAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2023 13:53, Sinthu Raja M wrote:
> On Fri, Jan 6, 2023 at 6:19 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 05/01/2023 16:17, Sinthu Raja wrote:
>>> From: Sinthu Raja <sinthu.raja@ti.com>
>>>
>>> AM68 Starter Kit is a low cost, small form factor board designed for
>>> TI's AM68 SoC which is optimized to provide best in class performance
>>> for industrial applications and add binding for the same.
>>>
>>> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
>>
>> What happened here?,
> Krzysztof
> Missed the merge window, so rebased to 6.2rc1 and reposted again.

And what was here in v3?

Best regards,
Krzysztof

