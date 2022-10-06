Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D935F6D35
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 19:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiJFRpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 13:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiJFRpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 13:45:50 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82685923CB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 10:45:48 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id qw20so5576675ejc.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 10:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ezmq/iaY9rDfnbpCghNhiuX5IKh0tJNMj1kyoFb3wBM=;
        b=g1lsjZQG++PqVBbu8Wen596e/vDbUstqf6bUX84DA+/yiJK/fAzAgNFQemsqSZgsLO
         BC0CDS/K7Bu+6pHs5w4R9XfXovqAmr2ImRJ6Apsv0H+pP4LHM6z84LzpR5HUJ0VAUWid
         mv0gGo7p8GGbKUIzymnuTYZ3KUqCywo/eOoXiuUhNXBlaKC44lN1IQxkQkGwvU7Oy+tT
         DjTFhHlWOqUDG96pMrnfWUh96vIUfAAh1cfSMm3QKIx3OFu1q8jRMvBydrkfg5zILhnf
         H0eXEFeVI++4+yQhSkoQKeNbM8arFOrtJFlYOQjlZmTGFEeqWPN0U76u6wpBt5OSI7Ol
         wyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ezmq/iaY9rDfnbpCghNhiuX5IKh0tJNMj1kyoFb3wBM=;
        b=8LNqYjUuATrkOi1PyOjLP7Jeiv14fn6nih0FECL3CobeiQnqRpjMjBOs4eqAtsxn7y
         oVmTMZsf0q5NMU7CSqdatfyDBf68PWFfLAlQhvM636TXP5+uWqe5vhqDZcBFDkUQe79h
         okrrJmxsCdkiwsxlDzVmf2wIoBe2oPUovs54D/7hyQpDqShf1QG/c5RRwmv2JD/b+Lw7
         2Z3CQFsXvmhyVvKBhodPdAbnLBQ3rERxyM4KKTK5lpEkOEFeAiFODHZPRED6y0ZUC7Yh
         3vjK7UYaJnvAxz0bPVy5cX/Cv/2qGF2zspjV2aJXhiVYpJQQZg+zf5gTRqYfWVKa5TwO
         x2lQ==
X-Gm-Message-State: ACrzQf18+TeJ6KApedbhQJFnjnoRDEWoaK4aqH8acAbjqUGOWEHAp2q0
        IwbKhliRiBln9Hy2kiA8Oo5iFg==
X-Google-Smtp-Source: AMsMyM5jhIiUUmEwIkVxQc1jomKmXt2Fyt8sivIhvinl/NnHvHfZi8dxE6r9gJMEXnQchGEreugbOA==
X-Received: by 2002:a17:907:6e90:b0:782:a5ef:89a8 with SMTP id sh16-20020a1709076e9000b00782a5ef89a8mr799737ejc.639.1665078344359;
        Thu, 06 Oct 2022 10:45:44 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id h19-20020a1709063b5300b0078d4c72e2cesm21813ejf.44.2022.10.06.10.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 10:44:24 -0700 (PDT)
Date:   Thu, 6 Oct 2022 19:44:19 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] riscv: move riscv_noncoherent_supported() out of
 ZICBOM probe
Message-ID: <20221006174419.ey66tfvpynjixmah@kamzik>
References: <20221006070818.3616-1-jszhang@kernel.org>
 <20221006070818.3616-2-jszhang@kernel.org>
 <20221006131033.jfb62me2zxz67gfs@kamzik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006131033.jfb62me2zxz67gfs@kamzik>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 03:10:33PM +0200, Andrew Jones wrote:
> On Thu, Oct 06, 2022 at 03:08:11PM +0800, Jisheng Zhang wrote:
> > It's a bit wired to call riscv_noncoherent_supported() once when
> 
> s/wired/weird/
> 
> s/once/each time/
> 
> > insmod a module. Move the calling out of feature patch func.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  arch/riscv/kernel/cpufeature.c | 7 +------
> >  arch/riscv/kernel/setup.c      | 4 ++++
> >  2 files changed, 5 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index 3b5583db9d80..03611b3ef45e 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -272,12 +272,7 @@ static bool __init_or_module cpufeature_probe_zicbom(unsigned int stage)
> >  	case RISCV_ALTERNATIVES_EARLY_BOOT:
> >  		return false;
> >  	default:
> > -		if (riscv_isa_extension_available(NULL, ZICBOM)) {
> > -			riscv_noncoherent_supported();
> > -			return true;
> > -		} else {
> > -			return false;
> > -		}
> > +		return riscv_isa_extension_available(NULL, ZICBOM);
> >  	}
> >  #endif
> >  
> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > index 2dfc463b86bb..1a055c3f5d9d 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -299,6 +299,10 @@ void __init setup_arch(char **cmdline_p)
> >  	riscv_init_cbom_blocksize();
> 
> I think we can move this riscv_init_cbom_blocksize() down to be above the
> new #ifdef in order to keep like calls grouped. It doesn't matter though.

Please ignore this comment. I see commit 8f7e001e0325 ("RISC-V: Clean up
the Zicbom block size probing") specifically moved riscv_fill_hwcap()
below riscv_init_cbom_blocksize().

Thanks,
drew

> 
> >  	riscv_fill_hwcap();
> >  	apply_boot_alternatives();
> > +#ifdef CONFIG_RISCV_DMA_NONCOHERENT
> > +	if (riscv_isa_extension_available(NULL, ZICBOM))
> > +		riscv_noncoherent_supported();
> > +#endif
> >  }
> >  
> >  static int __init topology_init(void)
> > -- 
> > 2.37.2
> 
> Otherwise,
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
