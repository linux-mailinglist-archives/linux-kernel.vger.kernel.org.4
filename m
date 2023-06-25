Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907A773D46C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 23:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjFYVZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 17:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjFYVZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 17:25:07 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6831D184
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 14:25:05 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3113da5260dso2101667f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 14:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687728304; x=1690320304;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vpEvNkmFhBPV/sgQmjmG/u9Az5tks6N1ix3FgBzMzh4=;
        b=XPi3AIP3sHw/BiO9+D1QLKVd26npdK3hmROeMnfMD+84Rh7ecz07cFV1swOBqXg2Jp
         0fYlEdumqqAmZnsD4c0N4E+xYKJGzbqinIAzjIRtEMYWWX8mGRqfd8h4ESKBkfPGFdq8
         YNwatYm5vad4u0IcrGPsfChk+hpNKBJX76sCWZaJEc4+kJuWrzixgLlp5Svn3tE4QbpK
         fXM+FXw1wkuFTFMHVyVo8pTDCh50D0x7kVjvYj6JmD68K8XJJPrAs39LDdbjhhokqL9d
         Rc2iUKAA9C58yEN2oWVJHYJnyuzWkmGbL5KMMDSfIEll9802O22bE8Tz3ElK+l0KZcPI
         247A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687728304; x=1690320304;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vpEvNkmFhBPV/sgQmjmG/u9Az5tks6N1ix3FgBzMzh4=;
        b=dbQCyDW9D1YKb9lYOzPQvC1sW4CWKoE6E8J8ntq3EohfjMQ3Q44uwwLI5i4h0+282M
         XEM8PwqNtWRV8WXDncHbyIwVlj5ReiVGjwltL1va9wmRV/T5nnzQNQR6oXuZnKuzwggV
         UZIFF9+9US1bqazXvrcqah+gV+D+GvEeB/MmP0wbzz6jZz7Rr8oBbek5Hmp+mjKN2XrU
         EQ8ibdaPsNt3DsFOzX1DcAWaSlAt7LgrjnAHDvPL2zILjo0mjRNUKgAcHejbeyBd5Imb
         Do6xLJx7tRaiLOT75K8bXEYp3bFBeeFOh9TZg9Bua5C3p/4clEKN6Pr+eBHVS9HBHKnX
         O+eA==
X-Gm-Message-State: AC+VfDzQf83t2rhbPm1KuF4WITZo+pEF3Ia4zeDv53dNM3Dt3QzseAuC
        O3gJLUhxTUr2kV5xb9CCNrmrxw==
X-Google-Smtp-Source: ACHHUZ6w/KTem4en6DpoUOTRJpkCeba0iSA1Pbh0dhzDh23gdYN0n6DSJL7HItwPFWno5XUjveDcqg==
X-Received: by 2002:a05:6000:1962:b0:311:9a5:2d63 with SMTP id da2-20020a056000196200b0031109a52d63mr7485836wrb.42.1687728303983;
        Sun, 25 Jun 2023 14:25:03 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.212.184])
        by smtp.gmail.com with ESMTPSA id s25-20020a7bc399000000b003fa96fe2bebsm788890wmj.41.2023.06.25.14.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 14:25:03 -0700 (PDT)
Message-ID: <e8d8ee2b-1faa-1d60-d230-cbef8aecacef@linaro.org>
Date:   Sun, 25 Jun 2023 23:24:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [patch 05/17] loongarch/cpu: Switch to arch_cpu_finalize_init()
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org,
        Richard Henderson <richard.henderson@linaro.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20230613223827.532680283@linutronix.de>
 <20230613224545.195288218@linutronix.de>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230613224545.195288218@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/6/23 01:39, Thomas Gleixner wrote:
> check_bugs() is about to be phased out. Switch over to the new
> arch_cpu_finalize_init() implementation.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: loongarch@lists.linux.dev
> ---
>   arch/loongarch/Kconfig            |    1 +
>   arch/loongarch/include/asm/bugs.h |   15 ---------------
>   arch/loongarch/kernel/setup.c     |    4 ++--
>   3 files changed, 3 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

