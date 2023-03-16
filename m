Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FC36BCCEE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjCPKg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCPKgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:36:24 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52A4136F8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:36:19 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id cy23so5501772edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678962978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eFQrmV4Y6J/VlzENEy2pmuoKXBnBpTNDb984EiuL890=;
        b=AA/xhG0NRLbbLdSMIcjR7BdfDSN4fuPjAarYvTwOk58HgGM9yDysXTs1XL6ckaucth
         oRp/aoL5BUsyORQRCnariIR/DOAE8RrqAqSPCioU5ETOdJshKW+yJ0flqRogZiD6Y0+l
         Y6uL/NDjXd1dWCpDa30LzWO8zMozPFtyhL+noOAQaMC+Ve3vEtNHmD8whcHfB5uP9zI4
         NvxgA8eHotrpLlAKcnC6x8lLnGEuXBx8BTHlYx3F1Yw/QeJVFntEMnHuW6Y8p4JAe/A6
         B5Wdvw8m9QozqGTIO4YBeEdcTYKSRjxIes8VphiVzB5jE/9+3rShdsTKdFfJ0s6jFn7x
         eeSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678962978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFQrmV4Y6J/VlzENEy2pmuoKXBnBpTNDb984EiuL890=;
        b=jcsPMfvFz3xPnLYo+scdCLFrfSPek79E4v8bcjIR4UoiEaII+DNHwtAs/+B2Sp8rVq
         k2+oWlLZaiyGJXRlXUJ4esP3r/kaDnjJ6W5p/gVrW/zRW3TJTu7Qyro4gCxhmz48S7+b
         JduKyzVFVezgwFUFD/RmhTdX5NupiSPbJY0akGR/0AMfhEZ3ptbIXBBZ+hKl2D0YAC/W
         51m73SYEsIaK7sQwfRMicjIYURGqGIghgl/5B9jW0Uo511hdu3HCQ9YxOel8J7wiq9jJ
         ZTYGX83ycUSbM3Dq5pEo9rVYLZh15AUv2PdRJndlW0JY2n+fmM/CqZmk5GtMNzIj/2o/
         9qtg==
X-Gm-Message-State: AO0yUKU58u7R1+nbG5G578q0ZM8rzJFMZgFxwzPMEvX54f03XVDwHzZN
        XG3Z6yAjUjddrkkY53XCiJM=
X-Google-Smtp-Source: AK7set9zhsWR7GgDboUAXUp1Ouiw7kPQSz0uEe5q9H+w1GWGdTHxiCPrDzg+y8cn6Jl286Xcdwer+Q==
X-Received: by 2002:aa7:d943:0:b0:4ac:b687:f57e with SMTP id l3-20020aa7d943000000b004acb687f57emr5799234eds.1.1678962978008;
        Thu, 16 Mar 2023 03:36:18 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.209.88])
        by smtp.gmail.com with ESMTPSA id q11-20020a5085cb000000b004bd6e3ed196sm3590299edh.86.2023.03.16.03.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 03:36:17 -0700 (PDT)
Date:   Thu, 16 Mar 2023 15:36:15 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] staging: axis-fifo: initialize timeouts in probe only
Message-ID: <ZBLxHyiFnOwEdPYf@khadija-virtual-machine>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
>

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
> Thanks,
> Alison

Sorry, I made a mistake here.

I did not change the driver 'Xilinx AXI-Stream FIFO IP core driver' to
being compiled as a module by typing 'm'.
Is that the problem here?

Also, now when I try to change it by pressing 'm', it is not working.
And I have tried many times but I cannot change the driver from '*' to
'm'.

Kindly help me with this.

Regards,
Khadija


