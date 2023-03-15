Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847506BB554
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjCON4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjCON4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:56:44 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FAC3B207
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:56:35 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x3so75822386edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678888593;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nWcxS/EnvsLY1IslnqQwR8YGTUM/z30Xu2wGXtyYax8=;
        b=UvpjdUcRE2QxWAoApUwwUh5gucn4fOVtUOW/gD+1R0tIX1iVPEDXA1p/t+o0x7boAi
         rNaGgfKhEI1Sx7IpDHI/RVyvwKnxQKdcQ28W27a92enqWIuJHMEparZ7M0WD5bIGMGUH
         GtRjQMO2SHrWkNfQwljwyOQVUv6GLTCkQoz4QBjG8pCc8m0WNvnRME31LDiMvOjmZ06t
         Vad4Ge8UKoRaV0ZuYv3uPeu4K3vChLrR7MscDNtdiIb8U+Q5Ugryd6wk7XUHvCZCCUsL
         lrV10LhfPaeFQ+jYmb2XvIZhicO6SgaLbTSod0AH0TbZ1MDw209dv8MhAEnbXCJulPlw
         GhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678888593;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWcxS/EnvsLY1IslnqQwR8YGTUM/z30Xu2wGXtyYax8=;
        b=GHY16R8NZXTPei+4kEiUMsLynv2U9h3sqQQu4VNBr/T+BTRkwPX86HhBBlbAfzbnkJ
         u8fpbizNCFdBPtz4RNk87q+nXwiPpQXJTEkKrQDZb3+cVNVA7IN/iEE1JeVS+bjoT+5y
         6D/MYABdUk0bCWlfM/pRHG/L6KabEwVXZlzqQ9oKiEuIC+q1QlF3i3v0Oro0S/UEoDv9
         4vm/SXXFhavE7HVdTNaAbwBc1pogg0sn9YfF1m0krPXbnDxxm09m9I12HoykDOL4DeaC
         7VBv/eGkR4WhYotJMZrBrGgB0LQOaPaMETBnvO6CcmEHI9LAJB65IonYjrvqC/tWIRI8
         jBCg==
X-Gm-Message-State: AO0yUKXyWLtLcgg3wTLYF+/hNerjkbbgXRlt0MWQ7Ey7lif4MyRh6uwX
        9wHo/V7MQcxe/OsrCgv/PAV+YpK0vB0EqPvC
X-Google-Smtp-Source: AK7set8AMAin/XSiz2ZLaC/2ZSZc9C6cMoFNsm2CXzTzcjxidKYEqxUGCJTl0V4o0p8UfFOk45u8fw==
X-Received: by 2002:a17:906:6782:b0:928:d4f6:6f77 with SMTP id q2-20020a170906678200b00928d4f66f77mr6917677ejp.29.1678888593534;
        Wed, 15 Mar 2023 06:56:33 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.209.88])
        by smtp.gmail.com with ESMTPSA id h11-20020a17090619cb00b008b30e2a450csm2568698ejd.144.2023.03.15.06.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:56:33 -0700 (PDT)
Date:   Wed, 15 Mar 2023 18:56:27 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] staging: axis-fifo: initialize timeouts in probe only
Message-ID: <ZBHOi8vA/LpCyLTJ@khadija-virtual-machine>
References: <ZA9mThZ7NyRrQAMX@khadija-virtual-machine>
 <ZBEJ+8DbhADSBTLr@aschofie-mobl2>
 <ZBG699SriXWy1I2K@khadija-virtual-machine>
 <2168386.Az4OtozEo7@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2168386.Az4OtozEo7@suse>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 02:13:51PM +0100, Fabio M. De Francesco wrote:
> On mercoledì 15 marzo 2023 13:32:55 CET Khadija Kamran wrote:
> > On Tue, Mar 14, 2023 at 04:57:47PM -0700, Alison Schofield wrote:
> > > My guess is that this patch gets ignored because it has a lower version
> > > number than a previous patch.
> > > 
> > > Take the feedback given here, and rev to
> > > [PATCH v5] staging: axis-fifo: initialize timeouts in probe only
> > > 
> > > Be sure the Changelog, below the --- explains the journey.
> > > 
> > > Changes in v5:
> > > 
> > > Changes in v4:
> > > 
> > > Changes in v3:
> > 
> > > Changes in v2:
> > Hey Alison!
> 
> Hi Khadija,
> 
> Please put one or two blank lines between the last message you are replying 
> and the new you are writing (exactly as I'm doing here between "Hey Alison!" 
> and "Hi Khadija").
>

Hey Fabio!

Sorry about that. This was pointed by Alison before and I have been
adding spaces since then. Hopefully I am doing it right this time.

> > Based on Nathan's feedback I am trying to recompile and send a patch
> > without any warnings.
> 
> Great!
> 
> > As suggested by Fabio, I am running "make w=1 -jX" command to see if I
> > get any warnings.
> 
> I suppose that "w=1" is a typo. The option is enabled with "W=1" (capital 
> case, Linux and all UNIX-like are case-sensitive). 
>

Okay. I should re-run it with "W=1".

> > But it is taking a lot of time, is there any way of
> > speeding it up?
> 
> What is you choice for 'X' in "-jX"?

I used "-j4".

> Did you try with the exact number of logical cores?
> Are you building into a VM with enough logical cores? 
> If you are building into a VM, did you reserve enough RAM?

I am using Ubuntu 22.04.01 with the help of VM on VMware.
My machine has 13GB RAM and 2 processors(4 cores each).


> Please read carefully my questions above and try to understand your 
> environment and reply, so that I can help you more effectively.
> 
> > If this doesn't work then I have to follow the steps to reproduce in lkp
> > mail as you said before.
> 
> The steps to reproduce will take your precious time and use more resources. 
> Again, try to respond my questions.
> 
> > After dealing with these warnings I will send a [PATCH v5], following
> > your instructions above.
> 
> Sorry for inadvertently overlooking to warn you about to send a message to 
> Greg and ask him to drop your first 3 + 1 patches. Now you are doing good by 
> following what Alison suggested: send v5 and write the log of revisions under 
> the three dashes (exactly how Alison explained).
> 
> > Kindly, let me know if I am on the wrong track.
> > Thank you!
> > 
> 
> I think you are in the right track.
> Let's try to speed up your builds because you'll need to build again your 
> kernel many, many times for future works.  
>

Okay great! Thank you.

Regards,
Khadija

> Thanks,
> 
> Fabio
> 
> 
