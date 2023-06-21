Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFD073905F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjFUTqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjFUTqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:46:24 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A101735
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 12:46:23 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-543ae674f37so3510536a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 12:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1687376782; x=1689968782;
        h=message-id:to:from:cc:in-reply-to:subject:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yAEYX8p4xEPzztgSX6jBgXp6p/Xb2RUIX5fAtspxlsk=;
        b=O+py1+Rpcwp6w+AR4wey7NcLDxvddKtqNBonT+E2kowjbpXM93WK2d43d5Lo5eadvb
         i1DD8KpxveaNKlUarBlGyvv63EeTdAtgxwo23u1pgyTF7sMO2mlwVF04KbyxzEbx2IBq
         SVO7gg7973NHQ5PTrGDCCXBdnKUOJiIhuf0NTRX3jPr5EEE369JzQbXVvqwODDHVK80h
         H5vDaJf2v9Gcr8imIk5JdCHcKtI0UlFmWGXHvOMXroAd/7QvwD7ulLCMX3q7tP2dskCM
         GDPPpffLk6SXcGT+pZT3hWOQu6LHlBrT6Gd4QG7Dye4iUkxqC2t1+iztrMudIflP44WK
         oUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687376782; x=1689968782;
        h=message-id:to:from:cc:in-reply-to:subject:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yAEYX8p4xEPzztgSX6jBgXp6p/Xb2RUIX5fAtspxlsk=;
        b=haXFytCBMR7UZq5Y1G0L1o5NG9oFg1vfEPZeI+cZMTwGqet1q5nzUwVDWq1saP5eAy
         52usdG49eIdZX2CfHqSvEQhLaCl+QkTRUB7PxCbgEDUi+uKUtG1zQpQp83tEI+vvgOju
         h2jlQ4ADYf3CIBAzwlYZJF1UOLLSONkGNhGpJqa89/QnplZIQ8klkk076AnRFRIRkivq
         EQhFOFYZZoj6UVxfcjy6HQ9ME7NLEF4lfquW7k9d8c3W7vRm80m9XPtUjRXefStS7ECq
         8uHrAsAm+QYVOuFXiPYlTK29t7KdBNHubfMkKjuwLz0qFHbdo9qBTuoX8qZ0ukhpMsNn
         c2aA==
X-Gm-Message-State: AC+VfDw/Ai9kI5mbaBtNZFuC8cAn+MN5pYjmikzuXBpUB8TPrPOMoC3d
        TZNWrQsI3xPbtc31m0EjFt5t0A==
X-Google-Smtp-Source: ACHHUZ7++iionK3i1+rBjCBOM2BOzaovcT/5zgI9IHyrmKGBJktrKL9rdXh969Ib7fB+ucArnYBWvQ==
X-Received: by 2002:a05:6a20:13d9:b0:123:89f0:ec6b with SMTP id ho25-20020a056a2013d900b0012389f0ec6bmr1062014pzc.47.1687376782376;
        Wed, 21 Jun 2023 12:46:22 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id fe15-20020a056a002f0f00b006687f6727e1sm3222011pfb.206.2023.06.21.12.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:46:21 -0700 (PDT)
Date:   Wed, 21 Jun 2023 12:46:21 -0700 (PDT)
X-Google-Original-Date: Wed, 21 Jun 2023 12:45:41 PDT (-0700)
Subject:     Re: [PATCH v2 0/4] riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
In-Reply-To: <mhng-1d790a82-44ad-4b9c-bfe4-6303f09b0705@palmer-ri-x1c9a>
CC:     bjorn@kernel.org, Conor Dooley <conor@kernel.org>,
        jszhang@kernel.org, llvm@lists.linux.dev,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     ndesaulniers@google.com, nathan@kernel.org
Message-ID: <mhng-ad2d02fa-2d4d-4bf1-ab2a-fd84fa4bcb40@palmer-ri-x1c9a>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 11:19:31 PDT (-0700), Palmer Dabbelt wrote:
> On Wed, 21 Jun 2023 10:51:15 PDT (-0700), bjorn@kernel.org wrote:
>> Conor Dooley <conor@kernel.org> writes:
>>
>> [...]
>>
>>>> So I'm no longer actually sure there's a hang, just something slow.
>>>> That's even more of a grey area, but I think it's sane to call a 1-hour
>>>> link time a regression -- unless it's expected that this is just very
>>>> slow to link?
>>>
>>> I dunno, if it was only a thing for allyesconfig, then whatever - but
>>> it's gonna significantly increase build times for any large kernels if LLD
>>> is this much slower than LD. Regression in my book.
>>>
>>> I'm gonna go and experiment with mixed toolchain builds, I'll report
>>> back..
>>
>> I took palmer/for-next (1bd2963b2175 ("Merge patch series "riscv: enable
>> HAVE_LD_DEAD_CODE_DATA_ELIMINATION"")) for a tuxmake build with llvm-16:
>>
>>   | ~/src/tuxmake/run -v --wrapper ccache --target-arch riscv \
>>   |     --toolchain=llvm-16 --runtime docker --directory . -k \
>>   |     allyesconfig
>>
>> Took forever, but passed after 2.5h.
>
> Thanks.  I just re-ran mine 17/trunk LLD under time (rather that just
> checking top sometimes), it's at 1.5h but even that seems quite long.
>
> I guess this is sort of up to the LLVM folks: if it's expected that DCE
> takes a very long time to link then I'm not opposed to allowing it, but
> if this is probably a bug in LLD then it seems best to turn it off until
> we sort things out over there.
>
> I think maybe Nick or Nathan is the best bet to know?

Looks like it's about 2h for me.  I'm going to drop these from my 
staging tree in the interest of making progress on other stuff, but if 
this is just expected behavior them I'm OK taking them (though that's 
too much compute for me to test regularly):

$ time ../../../../llvm/install/bin/ld.lld -melf64lriscv -z noexecstack -r -o vmlinux.o --whole-archive vmlinux.a --no-whole-archive --start-group ./drivers/firmware/efi/libstub/lib.a --end-group                                                                                                                                    

real    111m50.678s
user    111m18.739s
sys     1m13.147s

>> CONFIG_CC_VERSION_TEXT="Debian clang version 16.0.6 (++20230610113307+7cbf1a259152-1~exp1~20230610233402.106)"
>>
>>
>> Björn
