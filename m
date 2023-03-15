Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1370D6BBA18
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjCOQoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjCOQnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:43:33 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407EF15557
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:42:33 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ek18so46816591edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678898549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s2zZ+qS7JXhqAHFfOrjSrvxFCZYvAc/AtrFDzlHxzgQ=;
        b=C44ZNFkrw/cC3QvoPM0ptdhPv3/AF19dgxA5CtW9UEaV/5gWUX1XMUBbehM9EX551W
         3kc5mSzwiO1sOohsBT9mrzjJ+Y7jYAwDmb1ApDvraDeLapzmAtoRAaJerDCVak0bf2rl
         VOANyjsyE+mno6joaHywe+TiGkLvlQUPHX211Hiyjes1b19Y8m70XGwrdbg8B6eJkVoU
         gE2vq/wDKDLHXKyJEZG9O2whHKqJGUrUJ6+r3Xd4hkxi6PhNA8aGuYt8kqFysO4Ij0I+
         xF/o8S2LCUdGbvkrK5XrFxZF9FTLN24LHNYY5eSFgwWPp4me/Mgv74rAWUTu8rXhekGu
         /1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678898549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2zZ+qS7JXhqAHFfOrjSrvxFCZYvAc/AtrFDzlHxzgQ=;
        b=wNPaUwbziPd5aBgXiSZUOmFLWD219iAgEZphYLRMzG93+Ls8JsysHhUnLgi7MnBegL
         iVIrYUcPOel3xhu7Eem4sFWg0u+UQKzKENFycW82gYu2diY/CX8zArO8DoAXxnaTtvhv
         ZIuEsSob09wc//CUf+CzDUXOXCXb3GwStTjCOlEtTuZJ2qD2tSe6o2jXdjPFhGDorJGH
         BdAEpGLCmL3d+JCVMohwTRvGSSU3ZGQ9CIea5MrppXkbpHcjFLjHySLLmGtd9Wa3puje
         1+so9atVqe37Oyl3xNyh7xELJboBJXxkQb93lP6/uW2CNGoVWIubd76+wW2BHk6nVwXq
         ooNA==
X-Gm-Message-State: AO0yUKXqBI1FHaYKYbLsVJYDOXdBet/uSl/KzlcaZqHyc4RDKooV6Nwa
        zziatK/7nhZznm02mLsna7E=
X-Google-Smtp-Source: AK7set+KiEq4DeAanZxaTVwhRvEVxe+7sEdv+cArt2WJQ7Eon9DS2b90wTpN13CsYuiJEl0ERadPWw==
X-Received: by 2002:a17:906:e206:b0:8b1:bab0:aa3d with SMTP id gf6-20020a170906e20600b008b1bab0aa3dmr7170114ejb.8.1678898548907;
        Wed, 15 Mar 2023 09:42:28 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.209.88])
        by smtp.gmail.com with ESMTPSA id z19-20020a170906271300b008cda6560404sm2729912ejc.193.2023.03.15.09.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 09:42:28 -0700 (PDT)
Date:   Wed, 15 Mar 2023 21:42:26 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] staging: axis-fifo: initialize timeouts in probe only
Message-ID: <ZBH1cmB2dVAi42Gs@khadija-virtual-machine>
References: <ZA9mThZ7NyRrQAMX@khadija-virtual-machine>
 <ZBEJ+8DbhADSBTLr@aschofie-mobl2>
 <ZBG699SriXWy1I2K@khadija-virtual-machine>
 <16148020.1MiD057Pog@suse>
 <ZBHUr7bANuhnOnIV@khadija-virtual-machine>
 <ZBHtrGjgKOiVwjSF@aschofie-mobl2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBHtrGjgKOiVwjSF@aschofie-mobl2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 09:09:16AM -0700, Alison Schofield wrote:
> On Wed, Mar 15, 2023 at 07:22:39PM +0500, Khadija Kamran wrote:
> > On Wed, Mar 15, 2023 at 02:34:31PM +0100, Fabio M. De Francesco wrote:
> > > Aside from what I said and asked for with the other message of this same 
> > > thread, please take note that you can build a specific module if you prefer 
> > > not to re-build the whole kernel and other modules at the same time. 
> > > 
> > > I'm pretty sure that the instructions to do so are in the OutreachyFirstPatch 
> > > tutorial.
> > > 
> > > If they are not there, please let us know.
> > > 
> > > Fabio
> > 
> > Hey Fabio!
> > 
> > In the Outreachy FirstPatchTutorial under the 'Compiling only part of
> > the kernel' section there are ways to compile only some part of the
> > kernel.
> > 
> > I have tried using "make W=1 drivers/staging/axis-fifo/" and it says
> > 'nothing to be done for'. 
> > 
> > Should I start with the steps to reproduce? :'(
> 
> Khadija,
> 
> I've applied your patch and it fails to compile with the warnings
> that LKP reports.
> 
> If you are doing: $ make drivers/staging/axis-fifo/
> 
> and it is saying 'nothing to be done...'
> 
> You either have not changed anything since the last compile, or you
> do not have the module configured.


Hey Alison!
I might've written the statement wrong. Actually, here is the output of
make drivers/staging/axis-fifo

YACC    scripts/genksyms/parse.tab.[ch]
  HOSTCC  scripts/genksyms/parse.tab.o
  HOSTCC  scripts/genksyms/lex.lex.o
  HOSTLD  scripts/genksyms/genksyms
  CC      scripts/mod/empty.o
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/modpost.o
  CC      scripts/mod/devicetable-offsets.s
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  CC      kernel/bounds.s
  CC      arch/x86/kernel/asm-offsets.s
  CALL    scripts/checksyscalls.sh
  DESCEND objtool
  INSTALL libsubcmd_headers
  DESCEND bpf/resolve_btfids
  INSTALL libsubcmd_headers
make[3]: Nothing to be done for 'drivers/staging/axis-fifo/'.


> 
> I suspect it has never compiled for you and you need to look at
> the direction in the tutorial for 'Recompiling the driver' section
> and learn how to use make menuconfig.
>
> This driver has a couple of dependencies described in the Kconfig
> file. You will not even see the 'XIL_AXIS_FIFO' option until you
> turn on 'OF' and HAS_'IOMEM'.
> 
> See the drivers/staging/axis-fifo/Kconfig
> 
> Please confirm that you have compiled the driver before chasing
> after the build env that lkp reports.
>

Sorry, I made a mistake here.

I did not change the driver 'Xilinx AXI-Stream FIFO IP core driver' to
being compiled as a module by typing 'm'. 
Is that the problem here?

Also, now when I try to change it by pressing 'm', it is not working.
And I have tried many times but I cannot change the driver from '*' to
'm'.

Thank you!
Regards,
Khadija


> Thanks,
> Alison
> 
> 
> > 
> > Thank you!
> > 
> > Regards,
> > Khadija
> > 
> > 
> > > 
> > > 
> > > 
