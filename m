Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DA46AFD68
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 04:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjCHDaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 22:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjCHDa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 22:30:26 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A272858B54
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 19:30:25 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id d6so8896359pgu.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 19:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678246225;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IrGumBD3CuL7JhmpbkRoYLuQ9iRztdyj8h7PwNT0G+k=;
        b=nMEKpiB7FONecJfzkjebJwCPpi28Dj2XGpP4GXKQ26ESvbaACwC342Din9Ax1xxY5L
         wbOddRCSnmwOYMksQw3Qdu5mRfQureAx5/i/16NCIUODZpYPqRkiko+kmKKPlNGUXiEA
         aXYE5iDy1t1/dC5gzdd2qFFMC2Lsk2FIHb4DgjPfQlZUyXgTvmE5yxVkScVuFdMXQ8N/
         9PY7FQJCGGsTo0VGTQrba5VHI8TNPXOxIBhzPzY2mCeDhoalLaOSxSq41Fd1BV+9Keyz
         gR3qvdUJN5o2gNrh+SlnHyTyO3n8fbOGKSIRdfzol8xhkDct4RQZ0bUznxP61irRCIEl
         RvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678246225;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrGumBD3CuL7JhmpbkRoYLuQ9iRztdyj8h7PwNT0G+k=;
        b=Zm9OlD3O9UAFcdv5UEvo5ewzVyzRP6JMjuRtjStykRt0EfCHFdORrvrjVS8B5/DADv
         nmvDVU+suLfX3kpakdqXIQifpxbsulTQ38x+eOP34qJaJa85KDOnInjOqSkU7ktvdJWb
         S0IPdeiq4k4k2JRCmHRfYO7nGAMWnlcCOdFB7AKpgP8WVHoRPBdv6AkYTJISI8vyicTY
         iNNeLUCiYiGrbyaDnYxaL37NalwxKJx2jAHAlbujZfNeMetZPoJkr91LsY3QwHt424Nh
         AhzcJFJwvnpTvQqb2aO/KeZKU/3ARor1TF8T3i7V5Dq3bXa/bEpFL4W64lDoFI6f2EfO
         SqCg==
X-Gm-Message-State: AO0yUKU/iiDuYkpAw49pYPas96xi3yz0SJ18THVxm0hTTjG1Hw7RP2CV
        oiOKNKA4CqszqZJuAhcXSkqqLg==
X-Google-Smtp-Source: AK7set8hzVBuskesB4GYntZLwYi23Uwo1MfEphVfa6NFwFtmeKv9GeZ8e6GgiHrVvGj/l+Hl+mwyWQ==
X-Received: by 2002:a62:1758:0:b0:593:d2ab:fdfb with SMTP id 85-20020a621758000000b00593d2abfdfbmr13432662pfx.13.1678246225092;
        Tue, 07 Mar 2023 19:30:25 -0800 (PST)
Received: from localhost ([135.180.224.71])
        by smtp.gmail.com with ESMTPSA id n13-20020aa7904d000000b0058b927b9653sm8771578pfo.92.2023.03.07.19.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 19:30:24 -0800 (PST)
In-Reply-To: <20230203075232.274282-1-alexghiti@rivosinc.com>
References: <20230203075232.274282-1-alexghiti@rivosinc.com>
Subject: Re: [PATCH v4 0/6] RISC-V kasan rework
Message-Id: <167824615129.30763.10646446884793553712.b4-ty@rivosinc.com>
Date:   Tue, 07 Mar 2023 19:29:11 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-efi@vger.kernel.org, kasan-dev@googlegroups.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        linux-riscv@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Conor Dooley <conor@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 3 Feb 2023 08:52:26 +0100, Alexandre Ghiti wrote:
> As described in patch 2, our current kasan implementation is intricate,
> so I tried to simplify the implementation and mimic what arm64/x86 are
> doing.
> 
> In addition it fixes UEFI bootflow with a kasan kernel and kasan inline
> instrumentation: all kasan configurations were tested on a large ubuntu
> kernel with success with KASAN_KUNIT_TEST and KASAN_MODULE_TEST.
> 
> [...]

Applied, thanks!

[1/6] riscv: Split early and final KASAN population functions
      https://git.kernel.org/palmer/c/70a3bb1e1fd9
[2/6] riscv: Rework kasan population functions
      https://git.kernel.org/palmer/c/fec8e4f66e4d
[3/6] riscv: Move DTB_EARLY_BASE_VA to the kernel address space
      https://git.kernel.org/palmer/c/1cdf594686a3
[4/6] riscv: Fix EFI stub usage of KASAN instrumented strcmp function
      https://git.kernel.org/palmer/c/415e9a115124
[5/6] riscv: Fix ptdump when KASAN is enabled
      https://git.kernel.org/palmer/c/fe0c8624d20d
[6/6] riscv: Unconditionnally select KASAN_VMALLOC if KASAN
      https://git.kernel.org/palmer/c/4cdc06c5c741

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

