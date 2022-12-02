Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E83640FB7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 22:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbiLBVDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 16:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLBVD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 16:03:29 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C762CBA4F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 13:03:27 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id a9so5712000pld.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 13:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NKNPL0gFXJWzgjoUQUUlKaMR1OadcdNig+zrCqluUos=;
        b=KYJAgnLoMBpwFobGI4tq+NzE5ExvyBMduQqBVu/Lb98EtbdGuHmyCO8NQXu3CZHW0R
         0V6DueE2dXyQtt8hm+mEiouw0qItMJ7nj9s+QUM75fk8gk2jcOf3VUOHz7jSrEAq1jp5
         ez5m02ladx1OxheZEOznd79clQks4O/+SK28vMorHyg6G9aKNIuJORxZeGkr0qTbp5b/
         3G0jL+qZ5pr5o4VEcvIQfPzTV4x1ebR2nfay15mMG6fA5CXsLp3S5ffKDzaKTd7pyTNA
         3Lh7ITyGI4ulywkcfvVwsNNa7AfGRwlpj8oxnnhvcfnpHD+nelMv0jG4timCLDBeWbQr
         /tew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NKNPL0gFXJWzgjoUQUUlKaMR1OadcdNig+zrCqluUos=;
        b=Tdtm+HiCsaapQw/j+zV3MvU53KBGuwBfWNyoibY2f5wZB7dP6chCOUxlw02S5HxhYs
         i80fdK/2ThFEU2rTFZ/ZdoLqmCIeDrxG1KAm2hnnupHBXj6nQ5n3f/Hgq2lTBKtQLczX
         YmmRIIxz7dGfJGjcyshVgZ4bGAKhtSYvI3REyM6lZ1+YRU7m+PtolisluTfrQ5PfHgnR
         Cu1HdtyotkIJeJMO6ZR/M7UJP6AbOrsa10iT4LQfwmG1pVoaRNI05GPHc2hudAsQ8+PB
         42Q9upAfn4JxK77256ZXVOEGjA2O2APCZMy1R/F5KDYLWkhCPbF8bunvn7gzfnhRNjul
         WJlg==
X-Gm-Message-State: ANoB5pn4aLZvlYkeFImOOmg+9rcFCodCIHc5DBvrS0z2vkigwieQI91u
        J8+7f0alGs7SocHGrQJ8rhGI1rigaqk06heS
X-Google-Smtp-Source: AA0mqf5dA+RuYdi4h3k9FHaZsXm3v3kMmx7jTBqXxze55tfyneQvhH6wbRdXpIyFAOlEfATCfwR7eA==
X-Received: by 2002:a17:903:2290:b0:189:93bf:b5d5 with SMTP id b16-20020a170903229000b0018993bfb5d5mr23593776plh.145.1670015007023;
        Fri, 02 Dec 2022 13:03:27 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id k60-20020a17090a14c200b00219220edf0dsm5102107pja.48.2022.12.02.13.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 13:03:26 -0800 (PST)
In-Reply-To: <20221024094725.3054311-1-tongtiangen@huawei.com>
References: <20221024094725.3054311-1-tongtiangen@huawei.com>
Subject: Re: [PATCH -next 0/2]riscv/mm: two modifications on hugepage
Message-Id: <167001498712.10811.4574922810264344403.b4-ty@rivosinc.com>
Date:   Fri, 02 Dec 2022 13:03:07 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-e660e
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        wangkefeng.wang@huawei.com, Guohanjun <guohanjun@huawei.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2022 09:47:23 +0000, Tong Tiangen wrote:
> Tong Tiangen (2):
>   riscv/mm: hugepage's PG_dcache_clean flag is only set in head page
>   riscv/mm: add arch hook arch_clear_hugepage_flags
> 
> arch/riscv/include/asm/cacheflush.h | 7 +++++++
>  arch/riscv/include/asm/hugetlb.h    | 6 ++++++
>  arch/riscv/mm/cacheflush.c          | 7 +++++++
>  3 files changed, 20 insertions(+)
> 
> [...]

Applied, thanks!

[1/2] riscv/mm: hugepage's PG_dcache_clean flag is only set in head page
      https://git.kernel.org/palmer/c/d33deda095d3
[2/2] riscv/mm: add arch hook arch_clear_hugepage_flags
      https://git.kernel.org/palmer/c/d8bf77a1dc30

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
