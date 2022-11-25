Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F13638DE9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 16:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiKYPzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 10:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiKYPz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:55:28 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA1A40456
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:55:15 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id z4so5635065ljq.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N75qs6mFE+82rJ2tMLVbCwIvCda7QU+ZxRGf1iXfJdE=;
        b=vy7Yttm0R2M2h+VkrKBw2oXKSpzAnkKl1SJuZhacqQO+f4BEi4LeNpl+MGuBisVBAC
         ai/3rRBKIzJBuEhWFHHM6hJiJcug3rN0vvbQTNam/ZOcP8cIZoh1D8CaXhm/dzbJUM1n
         Z6Z+8hgJv2ZSKuqmk518M5Pv/G2kgjN0q8iRxPFM+LtmtlxvGtE6geKLI2HRWR6Um7O+
         aobhGGDuZM7gE/6bZNR1V1MJqWM9hvvjTdvEFzZBnWvOlPnL/Z64aKh5KnWxSCqK8EZr
         mWG+XWyZXXleWjRIJqR8RN2ZhSu1tfB7JsNVlbVq/Ajg/D2tWEm6NVSIXmPwsqVN/Dmx
         5pcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N75qs6mFE+82rJ2tMLVbCwIvCda7QU+ZxRGf1iXfJdE=;
        b=XJWTtLH1A5aFzT63duu3X1DCXHNOARH2x/f5dYEw3ppykyO52Jwr3naRS9/AY1vlUc
         zIjKbJGvEn7vAxQRLqt8wqvuisNSILsh58O97rxl+qRBUzA6EboR+QYuBA14BN89Zg6P
         zVEOuzq+pJoQm7UZnyI2mg/GVJiRcrQZlQ4trjS6cVJEWhIv770+YNxRbiJx0eEWEviq
         GNA7Tpl0JpvldSCYwwBUyZJqwDNP8jA75Bhegg/juPqi/cWAoLfKK4xDcGHIZNuKXJMl
         Rqii6SbeWLgwFuPu8D3t6QbJrqjxgHcrL2eGqQ3tQxuK7rXX1WWQdPfXu0N9apxTxRlV
         3KoA==
X-Gm-Message-State: ANoB5pk6tYfDIR9k1eQk3LB4pcIhdN1HdMXsNTQ/q4KxtNsnrzl85u+V
        OlU/wn3VwDPdMHxGLa1nTvxAtg==
X-Google-Smtp-Source: AA0mqf42151/tVAc9fD5z3KO3qH9yTDBjI5DNvMIYHqsvGQQgYJaTtByflQpt5PYo8sRqWP1eP7w9g==
X-Received: by 2002:a2e:93d7:0:b0:279:7294:5e42 with SMTP id p23-20020a2e93d7000000b0027972945e42mr5917318ljh.81.1669391713514;
        Fri, 25 Nov 2022 07:55:13 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z25-20020a195e59000000b004aa14caf6e9sm577178lfi.58.2022.11.25.07.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 07:55:13 -0800 (PST)
Message-ID: <ab0e55a2-d99a-328e-4f54-6a75936a1c81@linaro.org>
Date:   Fri, 25 Nov 2022 16:55:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 6/7] dt-bindings: cache: r9a07g043f-l2-cache: Add DT
 binding documentation for L2 cache controller
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221124172207.153718-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <70d1bfde-f57f-1741-08d3-23e362793595@linaro.org>
 <CA+V-a8s2awLp=YvbhA1Ohe500Oh1easLUcG9V4_FWov7Pf2i6g@mail.gmail.com>
 <9b0f8312-2caa-b9f3-edf3-1b720532f559@linaro.org> <Y4C0Jn1hl81ZCxOt@wendy>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y4C0Jn1hl81ZCxOt@wendy>
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

On 25/11/2022 13:25, Conor Dooley wrote:
> On Fri, Nov 25, 2022 at 01:12:18PM +0100, Krzysztof Kozlowski wrote:
>> On 25/11/2022 11:34, Lad, Prabhakar wrote:
>>>>> +/* Device, Non-bufferable */
>>>>> +#define AX45MP_PMACFG_MTYP_DEV_NON_BUF                       (0 << 2)
>>>>> +/* Device, bufferable */
>>>>> +#define AX45MP_PMACFG_MTYP_DEV_BUF                   (1 << 2)
>>>>> +/* Memory, Non-cacheable, Non-bufferable */
>>>>> +#define AX45MP_PMACFG_MTYP_MEM_NON_CACHE_NON_BUF     (2 << 2)
>>>>> +/* Memory, Non-cacheable, Bufferable */
>>>>> +#define AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF         (3 << 2)
>>>>
>>>> What are all these? They don't look like flags, because 3 = 1 | 2...
>>>> they don't look like constants, because we do not use shifts in
>>>> constants. Are these some register values? I also do not see the header
>>>> being used in the code, so why having a bindings header if it is not
>>>> used (DTS is not usage...)?
>>>>
>>> These are register bit values for the MTYP[5:2] field. The DTS example
>>> in the binding doc (above) uses these macros. I haven't included the
>>> DTS/I patches with this patchset yet do think I should?
>>
>> Then why storing it as bindings? Bindings headers describe the interface
>> implemented by drivers and used by DTS, but this is not implemented by
>> drivers.
> 
> IIUC, some of these properties are non-discoverable attributes of the
> cache controller. I see two things that could be done here that are
> "better" than #defining bits:

I did not comment about properties. I comment about constants. Why
register values/offsets/addresses are in this particular case suitable
for binding headers?

> - add an RZ/Five specific compatible and use match data to set the
>   attributes which is only possible if the pma-regions are set on a
>   per SoC basis
> - make pma-regions into a child node, in which andestech,non-cacheable
>   andestech,non-bufferable etc are properties of the child node
> 
> Prabhakar, does that make sense or am I off with my understanding of the
> attributes?


Best regards,
Krzysztof

