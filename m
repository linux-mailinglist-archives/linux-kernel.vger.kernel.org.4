Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41F364EF2C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiLPQcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbiLPQcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:32:08 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6305C1017
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:32:06 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id q71so2107235pgq.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lHeZEl4urkRUVM2RdVBA/kn/ywb3AI+XBKELaiBu0qc=;
        b=NCsfCJsxNnxBuuq0Z9i2gnSCgatr455aBSI9i8tkoK19Ms86AoCXDQoalTrDt3hwXY
         edQKOS0BX+FQhPJ+mBklzXsWQm1/jb3cxaXxKxFB6OZ3kMbizjfTY7t08YialN7iWaZB
         spDcvXPqt6N8s9z8yj/qzCnNOVS/y+JMBWYA2+XoGWAFxacEcJFazUZloDyR9yq5/GoA
         49f2IkGjvpwJogwF3lkFyaCCryEl1W+3MMdc1LYeEJS9UySIVc/n8YwgmI1BzXIndBGw
         d4OFHxtUKjNa8kE1pqBsMBc2jfWbPCaNyt9dCrrIbRnRps5hGgrGhn1GA64w1NuYL/vY
         ZS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHeZEl4urkRUVM2RdVBA/kn/ywb3AI+XBKELaiBu0qc=;
        b=AwLRn89NpGeo3ERJBtWPT9LHBOblIdN61TAKoOePQbV2d0Warm9PtwshrBGRcmbDCF
         hLjL1CLre4htE7MqFBxapTcInqbnvUlnPLk+oQSkiuNRyVr+eMhCXxnYIAexQQlb0pWa
         NWn/ZeHa5QOgeQ5ft0bISG+0a9ol7WAsBMeVsbDCYThERilHhivsFRhxCw8koAbdyJgz
         99YDdrHj/dY9TSlJHa6CeSnT+ku6wtb+WccoNy7YRDBH1zokHrjOsH19gtlntsR2bVBE
         kxuxX8U30CLFatPCvSXaEqggLUgv9O04X3RQZdDBK+E4RLDC5vEDXCUmIjda8PwMZKoJ
         7g5Q==
X-Gm-Message-State: ANoB5pnzPigE0QdJGyQ9e69cYbr8slU6ZDvnzDrXiapAgXAEfsmdzIyH
        hodoUHROYshP2E9qeHKTf9o/5w==
X-Google-Smtp-Source: AA0mqf4izKqYro6PFUpm34vh03n5EOn7EYe4G+r+5xdAGgx0ZYapdWHCjn9GLpaZ5ybuKQdkcdMwuQ==
X-Received: by 2002:a05:6a00:1409:b0:56c:cea7:88ef with SMTP id l9-20020a056a00140900b0056ccea788efmr39605813pfu.18.1671208325653;
        Fri, 16 Dec 2022 08:32:05 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id l187-20020a6225c4000000b0057621a437d7sm1699327pfl.116.2022.12.16.08.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 08:32:05 -0800 (PST)
Date:   Fri, 16 Dec 2022 08:32:05 -0800 (PST)
X-Google-Original-Date: Fri, 16 Dec 2022 08:31:46 PST (-0800)
Subject:     Re: [PATCH v5 6/6] soc: renesas: Add L2 cache management for RZ/Five SoC
In-Reply-To: <Y5wYIrMZIqu5f+WM@infradead.org>
CC:     geert@linux-m68k.org, Christoph Hellwig <hch@infradead.org>,
        soc@kernel.org, Conor Dooley <conor@kernel.org>,
        prabhakar.csengg@gmail.com, Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, magnus.damm@gmail.com, heiko@sntech.de,
        Conor Dooley <conor.dooley@microchip.com>, samuel@sholland.org,
        guoren@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jszhang@kernel.org,
        Atish Patra <atishp@rivosinc.com>, apatel@ventanamicro.com,
        ajones@ventanamicro.com, nathan@kernel.org,
        philipp.tomsich@vrull.eu, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Christoph Hellwig <hch@infradead.org>
Message-ID: <mhng-8b05b6cd-d8a1-4302-af24-2f64a4bf7c32@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Dec 2022 23:02:58 PST (-0800), Christoph Hellwig wrote:
> On Thu, Dec 15, 2022 at 01:40:30PM -0800, Palmer Dabbelt wrote:
>> Given that we already moved the SiFive one out it seems sane to just start
>> with the rest in drivers/soc/$VENDOR.  Looks like it was Christoph's idea to
>> do the move, so I'm adding him in case he's got an opinion (and also the SOC
>> alias, as that seems generally relevant).
>
> Well, it isn't an integral architecture feature, so it doesn't really
> beloing into arch.  Even the irqchip and timer drivers that are more
> less architectural are in drivers/ as they aren't really core
> architecture code.

That makes sense to me, it just looks like the SiFive ccache is the only 
one that's in drivers/soc/$VENDOR, the rest are in arch.  It looks like 
mostly older ports that have vendor-specific cache files in arch (ie, 
arm has it but arm64 doesn't).  Maybe that's just because the newer 
architectures sorted out standard ISA interfaces for these and thus 
don't need the vendor-specific bits?  I think we're likely to end up 
with quite a few of these vendor-specific cache management schemes on 
RISC-V.

I'm always happy to keep stuff out of arch/riscv, though.  So maybe we 
just buck the trend here and stick to drivers/soc/$VENDOR like we did 
for the first one?
