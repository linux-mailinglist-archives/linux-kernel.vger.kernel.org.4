Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D645695E73
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjBNJKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjBNJKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:10:01 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EDD24CBE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:08:55 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso10989317wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BgI+MitPy4LpPY/kxOD/cgobRuJLYDph5veEhGksnEA=;
        b=lB62HMad+osyFa/YRShwy2xvQQhT9yfoc9RwDPDM2XUSGGo5hotMUJADGxDiQ5/oie
         0UWu3aWkXWJPzO2vTsakK1Ei6DOuBI3AmUwSmqLUQ8ZTe80+NCQDOZ6/jIcjNALXtEWB
         myMm5/pYMGpx0868z9pwpjeJrpOhJ3ovmzXzQhl2yeLNk8GtyTunjqqhJ50Jqwbk2KBA
         nUku1vRER3frC96KkvlnDaokGHBYVCdqUaGsTL3zenSy+/9/+IU0+RrXFmVs8uRAFld4
         BkpKIHPTos+3uB9tCP+/qrZBOcLM/octf0KKmtrOqlUnOOZdPlOJ+FnLVLjXXtr1QHtR
         lZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BgI+MitPy4LpPY/kxOD/cgobRuJLYDph5veEhGksnEA=;
        b=sOZ+0VcRMpTJdwvkM0pQxLM6yGOKcbr0yIqdMSNIetfQ95LpjVl4Rip1VpREkki6Yp
         Gip7o5d6wMoCUE83J0Ig3Hnkh9I/z8N6W/ByPJ0rk3HVBkA101fKLMCYe0Grei5/2ErZ
         5wAXmqaKXIvQgLErQCL/qoEj/M4JFlu9WkdpxKxxZ6QCFxDt/68CPjD6vmzSfpVMUoSw
         ICFBKBYCxS9Ux3EB7/9bYtL0xoy78A7WfFLdasxB9hwYsZKFcLlEfxcV8LhYf/0POq1+
         QUI+zsjQk4PzcWkhHIptRFRUpHAOTX31c3SVcPGDd+3FQ7EHPTGQ6tOelxQHFbxgD8ny
         9lzA==
X-Gm-Message-State: AO0yUKWlMQ0nU5uwdzrddqS36N/9yN/xve2J3tBFxtMVMgOynh9oOv7g
        0aLS5QUWV1mgAmsjMTrC7a4cPA==
X-Google-Smtp-Source: AK7set8HRSS8W1/cKITusqPpdx9jDHZBvQKOiM1WFF89CfxkBUxGtw8QxLzPMCmfytpLrqWBoPZ9zg==
X-Received: by 2002:a05:600c:3423:b0:3df:e4b4:de69 with SMTP id y35-20020a05600c342300b003dfe4b4de69mr1515046wmp.27.1676365733617;
        Tue, 14 Feb 2023 01:08:53 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id az7-20020a05600c600700b003dfe659f9b1sm1519398wmb.3.2023.02.14.01.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 01:08:53 -0800 (PST)
Message-ID: <6f9c7a6b-4f6b-dead-2d9b-14b405f18397@linaro.org>
Date:   Tue, 14 Feb 2023 10:08:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v3 19/24] parisc: Remove empty <uapi/asm/setup.h>
Content-Language: en-US
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
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
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
References: <20230214074925.228106-1-alexghiti@rivosinc.com>
 <20230214074925.228106-20-alexghiti@rivosinc.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230214074925.228106-20-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/2/23 08:49, Alexandre Ghiti wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>   arch/parisc/include/uapi/asm/setup.h | 5 -----
>   1 file changed, 5 deletions(-)
>   delete mode 100644 arch/parisc/include/uapi/asm/setup.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

