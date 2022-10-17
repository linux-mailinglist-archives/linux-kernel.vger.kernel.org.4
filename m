Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F23760134C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 18:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiJQQSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 12:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiJQQSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:18:44 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAC66DF8A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:18:43 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id s30so16817449eds.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EvKXXBfjBxozfV6WFzYGdtAGU5x1cXP77F9OEOiHjRA=;
        b=hF2zG+QODFU7vhHtcL27fRDayxvbsN8P6jQWLQnMg+jXt4yc3MymyuXu/gGux8kTI1
         0Zrhj4OCrvC5HA1Gaq4zgv3DgVeyC/S34yGYcYwTmo8ouI/Ail+VUQRwFI2mV2DZoZUv
         H31iS/2OgtsBzHK76ThDDMx8h/4R68ZyRWspWPIM2swVIa6g0ufgzXGJQW8v7T/y1bZj
         a6xjYRGYmtQndob/ZtBcIQHfjrZNScOcPt3bhi+HYh/OCqvt384HKOr1X8WSaCt5qwxv
         2W7+mnYglhCAcBlzDfqgTybNZa61lWisHM7zcf+PDYKhaa0Ga8bQAkwlgbcgMb8Wm8K+
         wc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvKXXBfjBxozfV6WFzYGdtAGU5x1cXP77F9OEOiHjRA=;
        b=gw1+cXkcSIPXd7M4kYCIIr5SdtrJE9HN3QNjjF0C2GG8EZqP3yt2EFT8BgqVzcIT0r
         eB9iFc6FLm86GNgeUKz5KloZEriFabtb1QYkswukJ9/V7a1D7ix0kn+iHbB6cXfJiviG
         pcI8oYC3nuTQoKWgNDczlvm65RBCwonoHYqEMGe6WQ2x+Fi9B/pBsroKdWc0W16LFVB1
         d5/Bv9wgAJE2PW49aSHAkJSc42tE04eMeTevD6A8PgIpepHMSC93af4GbuKkuGECWPjl
         c3cT4o6bPjkIfz0krZOCOMGA7j1NGCMXwBfBLTPhAWqvjFxg/X2pdRNW5WJG8r5q2HHY
         wgNA==
X-Gm-Message-State: ACrzQf3IJDOrDO3580QEOmiWT76FKXZOPLCdTcigTnTTacijGgLWmr8z
        trzQlUY0ExPqw//AqJG0OFti/w==
X-Google-Smtp-Source: AMsMyM6ARby/6+Um7l8K2gj3ebnctRHo0Xc/NKdIW4tMZZYU4QtVwZMcJLLaa41J8jCUicQYTvhBHg==
X-Received: by 2002:a05:6402:42d0:b0:457:d16e:283d with SMTP id i16-20020a05640242d000b00457d16e283dmr11053428edc.395.1666023521673;
        Mon, 17 Oct 2022 09:18:41 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id et11-20020a056402378b00b0045c47b2a800sm7483488edb.67.2022.10.17.09.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 09:18:41 -0700 (PDT)
Date:   Mon, 17 Oct 2022 18:18:40 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Dao Lu <daolu@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>,
        Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 0/2] (attempt to) Fix RISC-V toolchain extension support
 detection
Message-ID: <20221017161840.7o5tpsjox7klyvvs@kamzik>
References: <20221006173520.1785507-1-conor@kernel.org>
 <20221017155103.4dt5uzmnlbtibqcn@kamzik>
 <Y0185O1zjyfv7WjN@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0185O1zjyfv7WjN@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 05:03:48PM +0100, Conor Dooley wrote:
> On Mon, Oct 17, 2022 at 05:51:03PM +0200, Andrew Jones wrote:
> > On Thu, Oct 06, 2022 at 06:35:19PM +0100, Conor Dooley wrote:
> > 
> > However, we could also drop the compiler and linker checking if we
> > converted our use of cbo.* to the insn-def.h framework (I think Heiko once
> > mentioned looking at doing that, but I'm not sure.) I'm looking at adding
> > Zicboz support right now and for starters I've duplicated and modified
> > these checks. But, I think I'll look into defining the instruction type
> > needed for cbo.* and using insn-def instead.
> 
> What is the ETA of your zicboz support? Do you think these patches
> should be applied to v6.1 & backported before being replaced by insn-def
> when your zicboz support arrives? Or just wait for your zicboz series?

I hope to have something posted by the end of this week, so if all things
go well, it could land in 6.1. I think it's reasonable to merge your
patches anyway, though, as they fix the current code and we don't know
what rabbit holes I may fall in with my series yet.

Thanks,
drew

> 
> Trying to decide what status I should set for this in patchwork.
> 
> Thanks,
> Conor.
> 
