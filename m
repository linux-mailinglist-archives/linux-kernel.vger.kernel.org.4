Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B285BA2E5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 00:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiIOWlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 18:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiIOWlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:41:11 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB5E915FA
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 15:40:48 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id c11so33115504wrp.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 15:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=PVkvDcs5B55lPsyOSCnEvKpynvpMcBlSH4X5N0oNFYw=;
        b=gRt1AkHz797KUWc/T/+UBcNeA1d+rSFR0fBJW9HeAr/jWJf6nqlR5TdJ+mIZeuX8UI
         yJgVN4dflkmmgB2YMdBZLCn7grder4SPehiVTE4btXlWsIIkpeopEa4dpiG2mZrlm0l0
         0w6VUpfTRpozUh0xAXVW+7vmdEIFTVdFhK+m5JCy+b3Y4PMWavijSoSFENWJ4B3jfMjX
         /085Ceh+Pf28BCHvuApHW1KzNop4Cv9fAUQeIjMEz+whZj5zJE9Jjjm7IGatgWSWuqFd
         43N4YNgTI0Wq/37whV86XVx6esV/L7jA9A1tnEvQe73qLKa1qwpNlikpgQ+hA/XD+gKI
         2hAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=PVkvDcs5B55lPsyOSCnEvKpynvpMcBlSH4X5N0oNFYw=;
        b=sDJq3qf1OqBWHAAiqLDO2tApQTfuyiuNQoVga3Lx+MtLMwg5+F0eU5bjuy3w2l62hw
         b6VX7vj/U2HMDYNdX/3+v/awqvSoJKLnAGQGG8NMCpBYaunQ6L80SN2UgGZO/xAKAUUJ
         5K9WHvABq2E7+UaOkTvgMJYjl+dv4JuHJQGF/Ob2Abqe8/aHy6kX2G3wBUyfXVXuLxlA
         raV6uqMgxg/DjF+RV35bf+EGigax5kSMUmcdtKGgxvAOR2Sg5F3IXYYSbLjWq5CgFx/0
         Qw6itijwjoip63HJNxyye0OlyXWuMTKkc0w4Gdn8J8+R1IyXAC6P6O0ArSsh+V6s4jvs
         P9Iw==
X-Gm-Message-State: ACrzQf1PX8qZvAeD++LhZGsdzC99l6lIBfJ5S2XQK9WkSC22zYCmMO0f
        FruP5jk3wL4klK8TsBPIncGtq6kr/J9wEXKY
X-Google-Smtp-Source: AMsMyM6/ENjFaotvxFYS+1ydpbwHLtW1hKAX0fr6Of+2WoS911b5ZDjhHxgEBnOwssRrZthyt817LA==
X-Received: by 2002:a5d:58d6:0:b0:22a:c38c:d2c8 with SMTP id o22-20020a5d58d6000000b0022ac38cd2c8mr1084920wrf.604.1663281636090;
        Thu, 15 Sep 2022 15:40:36 -0700 (PDT)
Received: from [192.168.2.222] ([109.76.158.112])
        by smtp.gmail.com with ESMTPSA id i17-20020a1c5411000000b003a63a3b55c3sm356513wmb.14.2022.09.15.15.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 15:40:35 -0700 (PDT)
Message-ID: <e15f3e2a-2761-84d9-c5c9-118717e0bb83@conchuod.ie>
Date:   Thu, 15 Sep 2022 23:40:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 07/10] riscv: boot: dts: r9a07g043: Add placeholder
 nodes
Content-Language: en-US
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Conor.Dooley@microchip.com
Cc:     geert+renesas@glider.be, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, heiko@sntech.de,
        atishp@rivosinc.com, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com
References: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220915181558.354737-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <3693a3a1-5a2a-4cc5-fb55-f6ad9a4b3f72@microchip.com>
 <CA+V-a8u87tqhC69qGD2zq_gT9jc_cSWd+NRn_u0bPTdmmk+j4A@mail.gmail.com>
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <CA+V-a8u87tqhC69qGD2zq_gT9jc_cSWd+NRn_u0bPTdmmk+j4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2022 23:26, Lad, Prabhakar wrote:
> Hi Conor,
> 
> Thank you for the review.
> 
> On Thu, Sep 15, 2022 at 10:36 PM <Conor.Dooley@microchip.com> wrote:
>>
>> On 15/09/2022 19:15, Prabhakar wrote:
>>> riscv: boot: dts: r9a07g043: Add placeholder nodes
>>
>> nit: s/boot//
>>
> Will fix that.
> 
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>
>>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>>
>>> Add empty placeholder nodes to RZ/Five (R9A07G043) SoC DTSI.
>>
>> Can you explain why do you need placeholder nodes for this and
>> cannot just directly include the other dtsis?
>>
> Since the RZ/G2UL SoC is ARM64 where it has a GIC and on RZ/Five SoC
> we have PLIC for interrupts. Also the interrupt numbering for RZ/Five
> SoC differs from RZ/G2UL SoC hence we are not directly using the
> RZ/G2UL SoC DTSI [0].
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/renesas/r9a07g043.dtsi?h=v6.0-rc5
> 
> For the RZ/Five SMARC EVK I am re-using the below files [1] (SoM) and
> [2] (Carrier board) as the RZ/Five SMARC EVK is pin compatible.  Since
> I am re-using these when trying to compile the RZ/Five DTB I get
> compilation errors since the nodes dont exist (and there is no way
> currently we can delete the node reference when the actual node itself
> isn't present) hence these place holders.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi?h=v6.0-rc5
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi?h=v6.0-rc5


If this method is acceptable to Geert, this explanation 100% needs to
go into the commit message.

Thanks,
Conor.

