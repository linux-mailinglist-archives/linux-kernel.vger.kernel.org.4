Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCE66AC0A1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjCFNT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjCFNTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:19:23 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE16B298E1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 05:19:21 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id t25-20020a1c7719000000b003eb052cc5ccso8153666wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 05:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678108760;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vrJgxYarH7I6tNp9lZXR/Ac4rjm0j3spQFQq/MBh93Y=;
        b=jHFLuIxja1G7FgaKieMDho79j97bJcJzl5r6JSUNDsV4mA/2T7Rt4dEtFe+mJ68fX4
         BeL12/7YXldN+W+jMsW2lzMpm7r3Yib7HB15R0q1heNbBxPxEhqAIyFb3CQ8yqwvxO6o
         BJurB4kLXa0lNndbLzZFaNMuolqgLqLKrQAR20V3xF0z74ogRkWYyf9Fn6yc2fhFf5Yt
         FkCUzXT6yQqa29dR6x7uYhnNqncplW9W2fbLvSLNfHc7S5X+e6Ao0YebH65T7dKnNa3q
         Jy+sBKs6+/mTsBRIAlMv1Y4l4Lt9r2RJbnY6D7RgudRSTAB6XHrXBh5KlORUW46XFdOz
         u/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678108760;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vrJgxYarH7I6tNp9lZXR/Ac4rjm0j3spQFQq/MBh93Y=;
        b=ooh42Gf7f/C8aq2xWjdtGK3EQqKaByehuGmCSlZEyGWG0vj1jIDA1mKAizX+mlKgP0
         tk3sA4F6Qelogrlu6zI/aJX7xRg2RVtLLgSioeYDT2a6w4LU2+SIu1r1v2PTzVf6ffOt
         8WNz6VifLkhvaQzF7L1pUEqCYfCXoKstVdEnX9Od9SiLIFpysEtTl46K53+GWgqeB7BZ
         0O8uD5AnTbTwEYHFUsqHEPGb9d/8lty4x0QDlEasu91U8B9xT2+GEHE+RHIQ0OzpqAoZ
         9Ipl12uh6k1uOTr+EEiYdGY1hqUJ/q1jqj5V9Jyr2y3G+mHDE35y1SpTpQDZKJ5yaNfX
         XOvg==
X-Gm-Message-State: AO0yUKWmdEEDZbkW52ZJZN4T2UBjk1rNal9Wl+G1AkLFTX8+4Be7CD+8
        EIA1AX8vqqmG+nrwHyq+wouIwQ==
X-Google-Smtp-Source: AK7set/GCxEC4IkWKnP9EDEQUMxesVbqKr+YvF+/CM/XdLiZbcIHy+xB1RCNFt5QnRqORoMSq/nNOw==
X-Received: by 2002:a05:600c:1548:b0:3e2:1f00:bff7 with SMTP id f8-20020a05600c154800b003e21f00bff7mr7424203wmg.12.1678108760216;
        Mon, 06 Mar 2023 05:19:20 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id f21-20020a1c6a15000000b003e733a973d2sm13613044wmc.39.2023.03.06.05.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 05:19:19 -0800 (PST)
Message-ID: <e1fa23ff-951e-176b-1a84-cbaab34ed44d@linaro.org>
Date:   Mon, 6 Mar 2023 14:19:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v5 00/26] Remove COMMAND_LINE_SIZE from uapi
Content-Language: en-US
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org
References: <20230306100508.1171812-1-alexghiti@rivosinc.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230306100508.1171812-1-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/23 11:04, Alexandre Ghiti wrote:
> This all came up in the context of increasing COMMAND_LINE_SIZE in the
> RISC-V port.  In theory that's a UABI break, as COMMAND_LINE_SIZE is the
> maximum length of /proc/cmdline and userspace could staticly rely on
> that to be correct.
> 
> Usually I wouldn't mess around with changing this sort of thing, but
> PowerPC increased it with a5980d064fe2 ("powerpc: Bump COMMAND_LINE_SIZE
> to 2048").  There are also a handful of examples of COMMAND_LINE_SIZE
> increasing, but they're from before the UAPI split so I'm not quite sure
> what that means: e5a6a1c90948 ("powerpc: derive COMMAND_LINE_SIZE from
> asm-generic"), 684d2fd48e71 ("[S390] kernel: Append scpdata to kernel
> boot command line"), 22242681cff5 ("MIPS: Extend COMMAND_LINE_SIZE"),
> and 2b74b85693c7 ("sh: Derive COMMAND_LINE_SIZE from
> asm-generic/setup.h.").
> 
> It seems to me like COMMAND_LINE_SIZE really just shouldn't have been
> part of the uapi to begin with, and userspace should be able to handle
> /proc/cmdline of whatever length it turns out to be.  I don't see any
> references to COMMAND_LINE_SIZE anywhere but Linux via a quick Google
> search, but that's not really enough to consider it unused on my end.
> 
> This issue was already considered in s390 and they reached the same
> conclusion in commit 622021cd6c56 ("s390: make command line
> configurable").
> 
> The feedback on the v1 seemed to indicate that COMMAND_LINE_SIZE really
> shouldn't be part of uapi, so this now touches all the ports.  I've
> tried to split this all out and leave it bisectable, but I haven't
> tested it all that aggressively.

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

