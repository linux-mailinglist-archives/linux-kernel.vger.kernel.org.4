Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10591664003
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjAJMM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjAJMMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:12:16 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC963BE92
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:10:16 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id u9so28104112ejo.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gVc5jfW0tU6LKMV6osTzqESg4stytCoAR83GJOQq+e8=;
        b=Gf6xT4PsNimHFHc17k9pYQ9JLDCvvipCGT4JcmraLHJBhVI3LD0g+YtogCmv1JA+B5
         UlneEdMm2q1LvwxlVwwN6qDtmiwczuSsxADrTDVlCVyOcZ5Tcpqkqa7ItZgTus0yGzNI
         4Aa80m0vGAqdCPcZI/J3E2+2BUwPrqrG/4QLyUEJk6ajXs7sGjEiCQ/oyoDxHN+F1CIt
         tY2o+FDdrlp8jsBl2Vj0vdEpOI8LnDLDZ4IxiaDWqNWQZYuSTtKDeypAltrHmzY69ZDX
         PQOYvBTJmx2f0nBTnukf8K6eBlCdVMpttgwUARII35JuMV88czEI6WD9u2yZGKnMwENF
         UC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gVc5jfW0tU6LKMV6osTzqESg4stytCoAR83GJOQq+e8=;
        b=Ebs1VjrJYTcJCrAsIFhk6Szjnr90dYSrYHy30i8DfxPi7+BnluSsmdS1fLDLCsz7oe
         +LwU+tZBCOXp2MuXTXf65aHJzeScDhxnChU79xfvlQXoe8nR6JyFS2I0O19qswOR7u0e
         yRL3jICDvh8sVQ4hW3KvBf1FEsmZZ4hl54cDIg4oIT6PUIApHt8Axh6pBaZFyGveJd3V
         KL6jcCWd7iL9Fp8wlY5dhUjPrMVOG/bDB6lEXXcOjWnzOTRs3CLdPlf/x5WjHORvwei5
         3zwGRyZ3ifZbF8p2D0vVmCw3kvz9dlbvJAObGdbSI+FjbPTZ1JvwoDyHdt+AXBrBr7Eh
         G+og==
X-Gm-Message-State: AFqh2kqkBzgCX/7PXSndDwmeXpLkVyDZJI2dvqRc/QRKMCWaEKjCS/vi
        Fhp0penB+pXyBHZfM8PhJBsp0A==
X-Google-Smtp-Source: AMrXdXuKKVnZN4iZ2Sse+Ujg+xmzXmEVaV6M+UuE8weh75aeAVNhwBfU5ToZD9KtRV10VJgBtATUjg==
X-Received: by 2002:a17:907:20d6:b0:844:5d1f:95cc with SMTP id qq22-20020a17090720d600b008445d1f95ccmr54373072ejb.15.1673352615477;
        Tue, 10 Jan 2023 04:10:15 -0800 (PST)
Received: from ?IPV6:2003:f6:af07:6c00:a421:1191:7df8:7628? (p200300f6af076c00a42111917df87628.dip0.t-ipconnect.de. [2003:f6:af07:6c00:a421:1191:7df8:7628])
        by smtp.gmail.com with ESMTPSA id f6-20020a056402150600b0049622a61f8fsm4890435edw.30.2023.01.10.04.10.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 04:10:15 -0800 (PST)
Message-ID: <ee8ff694-4a6b-b4da-9a80-c456fda9c99d@grsecurity.net>
Date:   Tue, 10 Jan 2023 13:10:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH qemu v3] x86: don't let decompressed kernel image clobber
 setup_data
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <Y69fUstLKNv/RLd7@zx2c4.com>
 <20221230220725.618763-1-Jason@zx2c4.com>
Cc:     qemu-devel@nongnu.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        ebiggers@kernel.org, ardb@kernel.org, kraxel@redhat.com,
        hpa@zytor.com, bp@alien8.de, philmd@linaro.org
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <20221230220725.618763-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason!

Am 30.12.22 um 23:07 schrieb Jason A. Donenfeld:
> The setup_data links are appended to the compressed kernel image. Since
> the kernel image is typically loaded at 0x100000, setup_data lives at
> `0x100000 + compressed_size`, which does not get relocated during the
> kernel's boot process.
> 
> The kernel typically decompresses the image starting at address
> 0x1000000 (note: there's one more zero there than the compressed image
> above). This usually is fine for most kernels.
> 
> However, if the compressed image is actually quite large, then
> setup_data will live at a `0x100000 + compressed_size` that extends into
> the decompressed zone at 0x1000000. In other words, if compressed_size
> is larger than `0x1000000 - 0x100000`, then the decompression step will
> clobber setup_data, resulting in crashes.
> 
> Visually, what happens now is that QEMU appends setup_data to the kernel
> image:
> 
>           kernel image            setup_data
>    |--------------------------||----------------|
> 0x100000                  0x100000+l1     0x100000+l1+l2
> 
> The problem is that this decompresses to 0x1000000 (one more zero). So
> if l1 is > (0x1000000-0x100000), then this winds up looking like:
> 
>           kernel image            setup_data
>    |--------------------------||----------------|
> 0x100000                  0x100000+l1     0x100000+l1+l2
> 
>                                  d e c o m p r e s s e d   k e r n e l
>                      |-------------------------------------------------------------|
>                 0x1000000                                                     0x1000000+l3
> 
> The decompressed kernel seemingly overwriting the compressed kernel
> image isn't a problem, because that gets relocated to a higher address
> early on in the boot process, at the end of startup_64. setup_data,
> however, stays in the same place, since those links are self referential
> and nothing fixes them up.  So the decompressed kernel clobbers it.

I just ran into this very issue yesterday when trying to boot a 6.1
kernel. pipacs pointed me to some changes of yours[1] which confirmed,
the issue is related to the additional setup_data entries, as adding,
e.g., '-M pc-i440fx-7.0' to the QEMU command line made the bug vanish
(as QEMU then omits adding the random seed setup_data entries) .

[1] https://github.com/qemu/qemu/commit/67f7e426e538

After digging a while I found this thread and it fixes the issue for me,
thereby:

Tested-by: Mathias Krause <minipli@grsecurity.net>

Thanks,
Mathias

> [snip]
