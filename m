Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F7F63B176
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbiK1Sgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbiK1SgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:36:11 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB8BD88
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:36:02 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id n3so18375017wrp.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1nOZjMbMo96D7jK6HEe/+t9X8Bowh9uZiGdvN65gOws=;
        b=oEkLoWQGxOS1awqe7QmwayKLBEaAdW0933WHxdwnPkSG0HKhBsfcntFGwd0XZUGLOx
         WJzZtRhTclTxy/5XZvA2ptFPUJgGpzQjczqw4lzYHxaqlab2vdVBY33ydlUErInP0B2K
         5BW+NOvGtyLB5LbGfk5mALU8/Br4SH+r/B1x8A42nj2VYteNmgPmxWW1Au+SH1jQsjVG
         dhZZmSbmzE+KADACkDLyRT0uplk9eM3dqGL6y0Kez2HXrgzX5QFQl/QE51nOljeyJisc
         Hjhfa4QDLTWEQhzbJKG8NrB4vBrvlWrc/k5i+3eREwAjeEZw6zk0MO4NLzd0iWpi8NIL
         yowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nOZjMbMo96D7jK6HEe/+t9X8Bowh9uZiGdvN65gOws=;
        b=l1GDEt9ieeih7+qAGFdcp/yNRwnyOLu0YXdBGDZphtxRcf7kp0jfgwKvl9OHocBFce
         D/nCvoAOqYgmHYA2SDjtVYrB8K9NXVcfkZMflyIQm2/ciQcjHmvZRNFMAM9G/rsaeymK
         Fol/bQVYxk7lEaQytVucCoJDbGtjjySrqFrxBTezpbbT6YpcEF0SS7mjaKp+gxlm8BxR
         k99PhZ1eGe1O9E0ARmRh2vFZ7llkURuZm7N+joUf62W8FjLwzY55AI1vgAOWGRMcUPSG
         4iAZBh7yr+vA1R9WKkHGLnSioUY/IBP6vzd80HGTO9QWhZjurUCwH98qeTu9Iy4DQkZV
         1w1g==
X-Gm-Message-State: ANoB5plUKxkBj0S92DfkC4QthZq5j756U/TBYEnNoWUcctiXNNgRUT+G
        XjL7dbAKJWAJvx8ZpZumCwiS3A==
X-Google-Smtp-Source: AA0mqf7olKVFDTdYeQAjldLUgW4jENbq321Qdm1A37f0wZK0gRbWnumHsAsDgtBg3pXJdela/gsJJg==
X-Received: by 2002:a5d:5948:0:b0:241:ea80:878 with SMTP id e8-20020a5d5948000000b00241ea800878mr17223417wri.124.1669660561353;
        Mon, 28 Nov 2022 10:36:01 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id u2-20020a056000038200b00241cfe6e286sm11391928wrf.98.2022.11.28.10.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 10:36:01 -0800 (PST)
Date:   Mon, 28 Nov 2022 19:35:59 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] riscv: Fix NR_CPUS range conditions
Message-ID: <20221128183559.5ei5fx4cl4mo3ioj@kamzik>
References: <20221126061557.3541-1-samuel@sholland.org>
 <Y4IxdOPWhLLg5rwd@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4IxdOPWhLLg5rwd@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2022 at 03:32:04PM +0000, Conor Dooley wrote:
> On Sat, Nov 26, 2022 at 12:15:56AM -0600, Samuel Holland wrote:
> > The conditions reference the symbol SBI_V01, which does not exist. The
> > correct symbol is RISCV_SBI_V01.
> 
> Huh, good spot.
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Yeah, huh. It never occurred to me that we don't have some sort of symbol
referencing checking in kconfig. Or maybe we do and I just don't know how
to enable it? Anyway, this issue made me wonder how many more dangling
references we may have. I wrote a script to look for them and found 29,
including this one. I'm not exactly sure how to report them since they
touch so many different places. For now, I've opened this kernel BZ

https://bugzilla.kernel.org/show_bug.cgi?id=216748

> 
> > 
> > Fixes: e623715f3d67 ("RISC-V: Increase range and default value of NR_CPUS")
> > Signed-off-by: Samuel Holland <samuel@sholland.org>
> > ---
> > 
> >  arch/riscv/Kconfig | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index fec54872ab45..acbfe34c6a00 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -319,9 +319,9 @@ config SMP
> >  config NR_CPUS
> >  	int "Maximum number of CPUs (2-512)"
> >  	depends on SMP
> > -	range 2 512 if !SBI_V01
> > -	range 2 32 if SBI_V01 && 32BIT
> > -	range 2 64 if SBI_V01 && 64BIT
> > +	range 2 512 if !RISCV_SBI_V01
> > +	range 2 32 if RISCV_SBI_V01 && 32BIT
> > +	range 2 64 if RISCV_SBI_V01 && 64BIT

And for this patch,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
