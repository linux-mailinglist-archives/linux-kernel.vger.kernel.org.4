Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D60659CAA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 23:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbiL3WML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 17:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiL3WMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 17:12:09 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D709019C37
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 14:12:07 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 1so33254704lfz.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 14:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hpuawFo1QryumZl9aqxUrtpkYD+9l4HMQlvhPEkbBZ4=;
        b=QFbwHGTzXUFD6JakV9JZvxSJXCAHYNNMnJFJPUD/Di8lCLRqfZxe3LaRNFtHHhkvyU
         6KjIwxSUHS/JXPfRxMOreMMxRNOl+zE3zBK+V9RKAU4Y9VtDfVIZ0JMxmhR7RRfASQcF
         +faCwgfE1EhEj070V4Maxq0DuyTynB05bzreVW0TDDxNSDzJJ/Q0B/XERv/i/hEmivpe
         0XxZgAPLcnF+Vp+Ly4FofuASkvDEvxvjOEyDO3ZtBBJvOR0TTh/VhxsxkUQEY5izzLtF
         mv4IO383wPoFLOXUzv1cYtFVoPPNWGZlZvA2ecjY3p4k/0Bxt7mpp9AQfdugGKqds5EI
         cQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpuawFo1QryumZl9aqxUrtpkYD+9l4HMQlvhPEkbBZ4=;
        b=BeW6toyGuOoa6P7IqQoFW40mouHy/u1kElK3oUkAH0PzAnOsdKzuOLaEAh2QewJJnA
         wqXs/IcfkTzEASFQfn9ZeQN7hLXikm2Jop50+5pwvsNn1CFVKLw7Ne9LK4wA4Q9r6+YA
         YQ0TYrXrANxkwP6KYK7KkpCxDjas9j7GQ2c3mRNt9P6ehX0xLwzL8aBQPKgp8AR5mWEy
         e8m9QM5iSBjtR3lEuRk0cZC1MHgJRG+P5WwTuqfj7HPmVUc9sJw3ny7d+t7+9B1HFeBh
         Bxncc5CZWnYrWrRguxNwXJNAliZNIaOAuD8TOympggWedGZEebNz2ws9DQevnC/BaowZ
         JmDQ==
X-Gm-Message-State: AFqh2kpXgfMkwuuPaAiAtpUx4giVwR/Ld6n5aQOEqg7qT0AKP2wUAimA
        sGfQsmB2so+S3LzDFoVCTYg=
X-Google-Smtp-Source: AMrXdXtYKIpCc3pFJcBPgY/PHdBRKzVXrrerQEtak+qK6HorvL54qWfN7H8mI7WOXOxmR4ofQebKwg==
X-Received: by 2002:a05:6512:3683:b0:4b5:b46d:e52 with SMTP id d3-20020a056512368300b004b5b46d0e52mr8204019lfs.50.1672438326052;
        Fri, 30 Dec 2022 14:12:06 -0800 (PST)
Received: from curiosity ([5.188.167.245])
        by smtp.gmail.com with ESMTPSA id u1-20020ac243c1000000b004b18163476esm3608728lfl.112.2022.12.30.14.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 14:12:05 -0800 (PST)
Date:   Sat, 31 Dec 2022 01:12:04 +0300
From:   Sergey Matyukevich <geomatsi@gmail.com>
To:     Icenowy Zheng <uwu@icenowy.me>
Cc:     Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: errata: fix T-Head dcache.cva encoding
Message-ID: <Y69iNMQ60gXYkKus@curiosity>
References: <20221227020258.303900-1-uwu@icenowy.me>
 <CAJF2gTSGvEnTqEqR9f+zU8T3VS8FoCtsgSk=9hz6cWxAL630zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTSGvEnTqEqR9f+zU8T3VS8FoCtsgSk=9hz6cWxAL630zQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > The dcache.cva encoding shown in the comments are wrong, it's for
> > dcache.cval1 (which is restricted to L1) instead.
> >
> > Fix this in the comment and in the hardcoded instruction.
> >
> > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > ---
> > The code is tested on a LiteX SoC with OpenC906 core, and it
> > successfully boots to Systemd on a SD card connected to LiteSDCard.
> >
> > This change should be not noticable on C906, but on multi-core C910
> > cluster it should fixes something. Unfortunately TH1520 seems to be not
> > so ready to test mainline patches on.
> >
> >  arch/riscv/include/asm/errata_list.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> > index 4180312d2a70..605800bd390e 100644
> > --- a/arch/riscv/include/asm/errata_list.h
> > +++ b/arch/riscv/include/asm/errata_list.h
> > @@ -102,7 +102,7 @@ asm volatile(ALTERNATIVE(                                           \
> >   * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> >   *   0000001    01001      rs1       000      00000  0001011
> >   * dcache.cva rs1 (clean, virtual address)
> > - *   0000001    00100      rs1       000      00000  0001011
> > + *   0000001    00101      rs1       000      00000  0001011
> >   *
> >   * dcache.cipa rs1 (clean then invalidate, physical address)
> >   * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> > @@ -115,7 +115,7 @@ asm volatile(ALTERNATIVE(                                           \
> >   *   0000000    11001     00000      000      00000  0001011
> >   */
> >  #define THEAD_inval_A0 ".long 0x0265000b"
> > -#define THEAD_clean_A0 ".long 0x0245000b"
> > +#define THEAD_clean_A0 ".long 0x0255000b"
> >  #define THEAD_flush_A0 ".long 0x0275000b"
> >  #define THEAD_SYNC_S   ".long 0x0190000b"

Nice catch ! I experimented with T-Head RVB-ICE board on the up-to-date
upstream kernel, using device tree and some other bits from the vendor
kernel [1]. Without this patch, emmc on this board does not work since
noncoherent dma sync operations use incorrect 'clean' instruction.
Applying this patch fixes emmc operations, so

Tested-by: Sergey Matyukevich <sergey.matyukevich@syntacore.com>

[1] https://github.com/T-head-Semi/linux/tree/linux-5.10.4

Regards,
Sergey
