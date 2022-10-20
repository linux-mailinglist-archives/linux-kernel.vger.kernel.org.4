Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C0F6058CB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiJTHj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiJTHjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:39:08 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B947D175341
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:39:07 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id g1so32071564lfu.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WXSAoATQCgV1tkrtFlfAwHc5TCrnlZk59AbU4gXCz/M=;
        b=IQfGk/QydWspEikjitqgDAHA8Z7JztQjBAYZGBr5InCIRR+Vu2vkQ17YbWK5o0slwI
         siwCWxTauWfOZqnJV6vguVBXJtdXU5ztDjEJFaJUGHIzWKa8B/sVSlrfkxV0lXa0uMKl
         6LO6jj/easqGTbyTkqFUKFRRqybL3jPvYHm3Mfm8wG9SQZe3K1MdJCjdwlNKhqWdFDrq
         zDiVYpViBJ8Po8lHQ6LPiGiIN1VFFl6Z8iAZ5JLjLyWY6iiCwL7M3/+5lJZvGa0rEwID
         eWUyLNce+YmQ20G+1Y6pZiHwPk6vEnPlZjw5szzgrySZrVn+JM+F34UKijg6Fiw4hyUx
         bm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXSAoATQCgV1tkrtFlfAwHc5TCrnlZk59AbU4gXCz/M=;
        b=Pmo76uz7U/Xy5W2W+KszteLpXy/v4+GHW3te7tqYUF2Z9hWrW4V+gEEebE2DotPONu
         XZhshsgtl1rP4lUr3O0AMxl6CekJ4sS0xkZOuwtPhTNGiK20mbWg0EHy0HfHhFu/hgTI
         JmRqHqGcwhncjX9xmRoUfCV7ZjKGYUCeNyIEaXZhdNfoGx4z8NJAvLUsm7le0D351B3l
         +wcnXlm4a6xHfYybQ8tbg+aqku0nwUgSd38R7/L0kvwC/W2sOIbciSH7/ml4d13uH+vZ
         LwR7EVRUXDXbFE+RtWAmqbM49N9jG4ra/iwjDzyvws+jqvLSkm64y5IjlMc6sz3MmFT7
         evOg==
X-Gm-Message-State: ACrzQf2/FW8xZa8OfxypzJ/7EPogy3fesc+GichWjtShvycXZiWBd+PZ
        Lei2cjQHF8Ix3YHiDAUPwYhlsZhZjW4JXslZwSw/jA==
X-Google-Smtp-Source: AMsMyM6SDl9FiSkW9loqo2yrBaOay/BZwucTn9j+98fVGc6fP1g+2B8E0KPcVC1zc+vUaBrhB0PVltQtdWOm31s1yaQ=
X-Received: by 2002:ac2:5616:0:b0:4a2:61f6:85e9 with SMTP id
 v22-20020ac25616000000b004a261f685e9mr4072003lfd.419.1666251545918; Thu, 20
 Oct 2022 00:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221019131128.237026-1-apatel@ventanamicro.com>
 <20221019131128.237026-3-apatel@ventanamicro.com> <13122510.uLZWGnKmhe@phil>
 <CAK9=C2WaoqAaVa2fo9E7cGXMy-MKpj-xLN6LoMHyq_g1psGLUQ@mail.gmail.com> <20bfd8a3-3836-46b8-9fdd-a407973224ba@app.fastmail.com>
In-Reply-To: <20bfd8a3-3836-46b8-9fdd-a407973224ba@app.fastmail.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 20 Oct 2022 13:08:54 +0530
Message-ID: <CAK9=C2V4EUm_ff4+LidHyO86gBJ4ys=Gh+4jzZAD35+dz037Tw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] RISC-V: Fix ioremap_cache() and ioremap_wc() for
 systems with Svpbmt
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 2:20 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Oct 19, 2022, at 18:10, Anup Patel wrote:
> > On Wed, Oct 19, 2022 at 7:49 PM Heiko Stuebner <heiko@sntech.de> wrote:
> >>
> >> Am Mittwoch, 19. Oktober 2022, 15:11:26 CEST schrieb Anup Patel:
> >> > Currently, all flavors of ioremap_xyz() function maps to the generic
> >> > ioremap() which means any ioremap_xyz() call will always map the
> >> > target memory as IO using _PAGE_IOREMAP page attributes. This breaks
> >> > ioremap_cache() and ioremap_wc() on systems with Svpbmt because memory
> >> > remapped using ioremap_cache() and ioremap_wc() will use _PAGE_IOREMAP
> >> > page attributes.
> >> >
> >> > To address above (just like other architectures), we implement RISC-V
> >> > specific ioremap_cache() and ioremap_wc() which maps memory using page
> >> > attributes as defined by the Svpbmt specification.
> >> >
> >> > Fixes: ff689fd21cb1 ("riscv: add RISC-V Svpbmt extension support")
> >> > Co-developed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> >> > Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> >> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> >>
> >> Wasn't there discussion around those functions in general in v2?
> >
> > Yes, there was discussion about a few drivers using ioremap_xyz()
> > which is discouraged and drivers should use memremap().
> >
> > We still need the arch specific ioremap_xyz() functions/macros
> > added by this patch because these are required by the generic
> > kernel memremap() implementation (refer, kernel/iomem.c).
>
> There is a difference between the strongly discouraged
> ioremap_cache() that pretty much has no valid users, and
> the ioremap_wt/ioremap_wc functions that are sometimes used
> for mapping video framebuffer or similar.
>
> It should be sufficient to provide a arch_memremap_wb()
> and no ioremap_cache() to make memremap() work correctly.
>

Okay, I will simplify this patch to only implement arch_memremap_wb().

This will make the MEMREMAP_WB flag to work correctly but other
MEMREMAP_xyz flags will always use non-cacheable IO mappings.

Regards,
Anup
