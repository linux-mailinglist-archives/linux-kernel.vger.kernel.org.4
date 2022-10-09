Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5C85F8BED
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 17:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiJIPR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 11:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiJIPRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 11:17:23 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C432A26A
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 08:17:22 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 2so8482139pgl.7
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 08:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tw9gcqaowP+TMgv0PBW1Mu3ng2vA1GWaG7qFwpGpykQ=;
        b=AU6dM8S8LJprNlJaUChKe1QftOAnSYLh0lARFWLQE3JooNJjTdUnEKR7ICBvzLkiAF
         ZwX+3OR4gIkgCeiBPUZGZef0FLJfYi6rYY15g8NOzhKRzCFntlmfWxuXs5/Yk7DtWNx+
         kxeAvlZWbyd2bO3212Gq87eePxTLXiqUS+DhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tw9gcqaowP+TMgv0PBW1Mu3ng2vA1GWaG7qFwpGpykQ=;
        b=0H313l5LdjzGMIlwjFGjPXnh8sG2b9wSTQH4ydMvbLd2WuVmZk0Ddg88naekKv4S9N
         bUhf3LxlDZ024X17DmrRWCsWFyDAkI4wIwn8S4wy5wZJOOR5/IaBXpW3cSxP0q6Z1D71
         F9KBgKLH/QcEkO31bM8jKVs7fq4denqvAX0SFclWq686+/lpzuUkXWbzFaC5/Ae1lHdM
         aO3BIjLABkMKmZd1SHShQehuxrsH1xVCKBRSWqOrW151IG4HWdqCxYH/rT1qGCldzMeK
         IhJaRQKJFEn/I1UL7i/p8Rq8jQBhHEcYM6iz4MM03z6M4B+vDOsqZ/qp8vuK4fVnUDi7
         VcYA==
X-Gm-Message-State: ACrzQf2kZjvQIBo5g3I6Ix8ZoDN2Pc/Na5XL0VvamCq5nOSRTuU7oC6n
        IEBosais758SAThJo1zJePhhCQ==
X-Google-Smtp-Source: AMsMyM4PsSYVHPiS4hhVGx24VmAVXK3O/DaEUG3mJLjweG47ZL12Dhyt0NjoVUe6x6HwLKShp2pTJA==
X-Received: by 2002:a05:6a00:1907:b0:557:e83b:1671 with SMTP id y7-20020a056a00190700b00557e83b1671mr15260472pfi.65.1665328641487;
        Sun, 09 Oct 2022 08:17:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n14-20020a170902e54e00b001782580ce9csm4847952plf.249.2022.10.09.08.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 08:17:20 -0700 (PDT)
Date:   Sun, 9 Oct 2022 08:17:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Li Zetao <lizetao1@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, akpm@linux-foundation.org,
        michael.roth@amd.com, nathan@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, masahiroy@kernel.org,
        ndesaulniers@google.com, brijesh.singh@amd.com,
        peterz@infradead.org, venu.busireddy@oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: Ping: [PATCH -next v3 0/2] Remove unused variables in x86/boot
Message-ID: <202210090815.526C76396@keescook>
References: <20220927081512.2456624-1-lizetao1@huawei.com>
 <20220930032727.3451619-1-lizetao1@huawei.com>
 <43ebb21e-a445-748f-f78b-51535a8384c1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43ebb21e-a445-748f-f78b-51535a8384c1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 08, 2022 at 09:41:59PM +0800, Li Zetao wrote:
> On 2022/9/30 11:27, Li Zetao wrote:
> > This series removes some unused variables in x86/boot, and add the
> > "-Wall" flag to Makefile, which is the old problem of x86 not sharing
> > makefiles.
> > 
> > Changes since v2:
> > - Add "frame-address" flag and "-std=gnu11" to
> >    x86/boot/compressed/Makefile to fix warnings when "-Wall" flag added.
> > - Declare the variable "i" within the for loop to reslove unused
> >    variable warning.
> > - Delete __efi_get_rsdp_addr function when CONFIG_EFI is disabled to
> >    resolve unused function warning.

Nathan suggested earlier (and I agree): please re-order these patches so
the fixes for the new warnings are first, and then turn on the compiler
flags in a final patch. This will keep the build "warning free" at all
steps.

-- 
Kees Cook
