Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070836AFD93
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 04:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjCHDpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 22:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjCHDpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 22:45:36 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E59E136DA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 19:45:29 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id p20so16434547plw.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 19:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112; t=1678247128;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4ZCOc3mfCj0AC3biqgCZENtlzkJ+33Pb7B/SIsDo+k=;
        b=0u+x9DsomFyjMNGcbtzfyoTHwt8qOxy9beSxjhMmj8zh+5aCKJ9DVMCQ9okbiC8o5E
         /EWcvzRVoDt1knCL3ZNYRHvGRMrdMOc4qvbO2TaP3ZtVyEQjHSFhvYnkZKsoMgukdm6X
         Y44TMP0zQzcxNdBmJgFa58tSjRmPy7P5mWEJyeUA6G9pT4ak9ORl+iwRKJs7lNqxLb/b
         YMActfD5KxmxmHn0Bq3/0lOq6tcWrp4lOq53JMlxR/0CRFIiiatHVczfNzlhhc38kjWr
         kQ/L7SKY8VUONFkeifPsWzliVHJhpa9NNax0yjUt2rRPlI4Sczua7LAdZPJWQBHz5lgK
         +Vkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678247128;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4ZCOc3mfCj0AC3biqgCZENtlzkJ+33Pb7B/SIsDo+k=;
        b=7r5SluKYfLGPGyikqh3zLomtyNbnQek/pCUWpEPclCs3LWVHVK6HnIqi1xPOJwb2DN
         fsMQuZkKVgYReKdRx/SP4Sr1NsVrp5e4Uyz9WgvfK1ryykcCgkDBpZWLF4+HZal5D46S
         AG50YClr/HCMpkR8UnA6GsmS4nKHKlXPGf9WtHCtuNF7CQmzXjSgPdSwcAtAmZvx3CbH
         y7Lp2tItf/oNWuLDKYO/y78GciNI28HO48MFrFmn7JOrFTSjjIyQKB0n4wL7BbvjA0tO
         KfufTFjzfaRzXO8/kyWYUuoQ36AqlPMTGWd+b2ig0AUnLilxGVVMINQnWU1gaRqn4leg
         yBdg==
X-Gm-Message-State: AO0yUKWu25fLFAhaUi66ra5pRdV+K+JEywDb+vH8elELm0N2o3bNsqZe
        tD4n5e+Ae7HG8CPKDOqtpxgAFg==
X-Google-Smtp-Source: AK7set+KZksDT7X01j+FCtcezLtBZ3kJ3ekK4zHcOoOG+0PqmHkRbQb66FGlMa23SEDhQpnyPDwbqw==
X-Received: by 2002:a17:902:ea0c:b0:19a:727e:d4f3 with SMTP id s12-20020a170902ea0c00b0019a727ed4f3mr23665335plg.5.1678247128449;
        Tue, 07 Mar 2023 19:45:28 -0800 (PST)
Received: from localhost ([135.180.224.71])
        by smtp.gmail.com with ESMTPSA id ko16-20020a17090307d000b0019472226769sm9069473plb.251.2023.03.07.19.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 19:45:27 -0800 (PST)
Date:   Tue, 07 Mar 2023 19:45:27 -0800 (PST)
X-Google-Original-Date: Tue, 07 Mar 2023 19:44:57 PST (-0800)
Subject:     Re: [PATCH v4 0/6] RISC-V kasan rework
In-Reply-To: <167824615129.30763.10646446884793553712.b4-ty@rivosinc.com>
Message-ID: <mhng-0481a843-8d7f-4f2d-b110-f357324c7c73@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
CC:     aou@eecs.berkeley.edu, andreyknvl@gmail.com,
        vincenzo.frascino@arm.com, linux-efi@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Paul Walmsley <paul.walmsley@sifive.com>, glider@google.com,
        ryabinin.a.a@gmail.com, linux-riscv@lists.infradead.org,
        ardb@kernel.org, linux-kernel@vger.kernel.org, dvyukov@google.com,
        Conor Dooley <conor@kernel.org>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alexghiti@rivosinc.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Mar 2023 19:29:11 PST (-0800), Palmer Dabbelt wrote:
>
> On Fri, 3 Feb 2023 08:52:26 +0100, Alexandre Ghiti wrote:
>> As described in patch 2, our current kasan implementation is intricate,
>> so I tried to simplify the implementation and mimic what arm64/x86 are
>> doing.
>>
>> In addition it fixes UEFI bootflow with a kasan kernel and kasan inline
>> instrumentation: all kasan configurations were tested on a large ubuntu
>> kernel with success with KASAN_KUNIT_TEST and KASAN_MODULE_TEST.
>>
>> [...]
>
> Applied, thanks!
>
> [1/6] riscv: Split early and final KASAN population functions
>       https://git.kernel.org/palmer/c/70a3bb1e1fd9
> [2/6] riscv: Rework kasan population functions
>       https://git.kernel.org/palmer/c/fec8e4f66e4d
> [3/6] riscv: Move DTB_EARLY_BASE_VA to the kernel address space
>       https://git.kernel.org/palmer/c/1cdf594686a3
> [4/6] riscv: Fix EFI stub usage of KASAN instrumented strcmp function
>       https://git.kernel.org/palmer/c/415e9a115124
> [5/6] riscv: Fix ptdump when KASAN is enabled
>       https://git.kernel.org/palmer/c/fe0c8624d20d
> [6/6] riscv: Unconditionnally select KASAN_VMALLOC if KASAN
>       https://git.kernel.org/palmer/c/4cdc06c5c741
>
> Best regards,

Sorry, this one didn't actually get tested -- I'd thought it was in the 
queue before I kicked off the run, but it wasn't.  It's testing now, 
I've dropped it from for-next for a bit as I don't remember if this is 
one of the patch sets that had a bulid/test failure.
