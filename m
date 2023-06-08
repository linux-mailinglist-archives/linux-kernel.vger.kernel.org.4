Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D037275E0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 05:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbjFHDq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 23:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbjFHDq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 23:46:27 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E12E26A2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 20:46:25 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-53fa457686eso803479a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 20:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686195985; x=1688787985;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zPf6EVQH09A92WbqJ3iwYGcgI/uGh046z4DNzjj1omg=;
        b=x6pUm2+fmGAXqIGZ3GWmw8MJN6FQFDPN/jxNnk1a4d+x4XtXRgh6sZxLAVEkTnJjPZ
         N50wRXzKdcFpb1ZTqQZytoJOYf/pWF8dL6UIEz9eKFFiaOY4qYogsxhLA9wTMDPz39aR
         O4Z6T7eB/IP+BIptCY2mLHU5QzM3nTttzRVOhLSJxg63envUrv5PoPSijEF+odKdqijg
         UggMv+QhzDLKINQc7fh9nHKfbKFeGikaIGn/sXx+9063qj7OEW46PHGRbF0NBCAwUSS1
         e4rq0ylJdM/bFSfrwVi4Tfv86r0Rb108sq8rbwdhkAZovvcS/z4fBk1Vwyhxz71qwlF3
         qeeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686195985; x=1688787985;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zPf6EVQH09A92WbqJ3iwYGcgI/uGh046z4DNzjj1omg=;
        b=WIkEkVZ5asPdR1u9JvebYJUZhomxpKRShfSKKqJNrRiEv7j+I7xoidxBD/O2AGt9NJ
         Xaaw5hpZ6qM7tAMmSzn8B4mV5GfmbZlebTW13FmL4Uzr3ZXqilhx6IXWCzstWZmZfuGo
         s3O1nORvzoO0n2HRJIYLkkMRSFBzaHA6B5U7W/gcwVO0SnteAMMHabDHhAu63a5dOLWm
         +sVhi98R5v2ecb51KSgtvREgcYnGWYJFgXC98s8gqng9eya7ffRaqfcIxRp5/lNPygKz
         a0rJkWzJ+oCp7ds4KwVOImp6AQns049349wNWusjXXbflh4zxMSNByIvoYsUKQl9rn2u
         WZ3A==
X-Gm-Message-State: AC+VfDz5Z2CkyK1Ormoqj1gBcDZUfLV7uctdoKJgqqz2yFJHGy1ezFkS
        c9UBxc5+pF67juUbgDa8NOyWwuX3f3U=
X-Google-Smtp-Source: ACHHUZ5ERc0sQl+8hDoScAwGkH1OHFU8LnUFX+cZnrw2XC2h/eSo1wMN1HZaQKy57pvWLRPHzlIuFu5cJYw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:42c4:b0:1a6:8a07:960a with SMTP id
 jy4-20020a17090342c400b001a68a07960amr199948plb.0.1686195984350; Wed, 07 Jun
 2023 20:46:24 -0700 (PDT)
Date:   Wed, 7 Jun 2023 20:46:22 -0700
In-Reply-To: <ZIECZMHxtEYnuBAJ@araj-dh-work>
Mime-Version: 1.0
References: <20230603193439.502645149@linutronix.de> <ZH4eNL4Bf7yPItee@google.com>
 <87pm694jmg.ffs@tglx> <ZICuhZHCqSYvR4IO@araj-dh-work> <ZIC/b+AwvH2wIz/o@google.com>
 <ZIECZMHxtEYnuBAJ@araj-dh-work>
Message-ID: <ZIFPDvsKGZ7MVSMt@google.com>
Subject: Re: [patch 0/6] Cure kexec() vs. mwait_play_dead() troubles
From:   Sean Christopherson <seanjc@google.com>
To:     Ashok Raj <ashok_raj@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Ashok Raj <ashok.raj@intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023, Ashok Raj wrote:
> On Wed, Jun 07, 2023 at 10:33:35AM -0700, Sean Christopherson wrote:
> > On Wed, Jun 07, 2023, Ashok Raj wrote:
> > > On Tue, Jun 06, 2023 at 12:41:43AM +0200, Thomas Gleixner wrote:
> > > > >> So parking them via INIT is not completely solving the problem, but it
> > > > >> takes at least NMI and SMI out of the picture.
> > > > >
> > > > > Don't most SMM handlers rendezvous all CPUs?  I.e. won't blocking SMIs indefinitely
> > > > > potentially cause problems too?
> > > > 
> > > > Not that I'm aware of. If so then this would be a hideous firmware bug
> > > > as firmware must be aware of CPUs which hang around in INIT independent
> > > > of this.
> > > 
> > > SMM does do the rendezvous of all CPUs, but also has a way to detect the
> > > blocked ones, in WFS via some package scoped ubox register. So it knows to
> > > skip those. I can find this in internal sources, but they aren't available
> > > in the edk2 open reference code. They happen to be documented only in the
> > > BWG, which isn't available freely.
> > 
> > Ah, so putting CPUs into WFS shouldn't result in odd delays.  At least not on
> > bare metal.  Hmm, and AFAIK the primary use case for SMM in VMs is for secure
> 
> Never knew SMM had any role in VM's.. I thought SMM was always native. 
> 
> Who owns this SMM for VM's.. from the VirtualBIOS?

Yes?

> > boot, so taking SMIs after booting and putting CPUs back into WFS should be ok-ish.
> > 
> > Finding a victim to test this in a QEMU VM w/ Secure Boot would be nice to have.
> 
> I always seem to turn off secureboot installing Ubuntu :-)

Yeah, I don't utilize it in any of my VMs either.

> I'll try to find someone who might know especially doing SMM In VM. 
> 
> Can you tell what needs to be validated in the guest?  Would doing kexec
> inside the guest with the new patch set be sufficient? 
> 
> Or you mean in guest, do a kexec and launch secure boot of new kernel?

Yes?  I don't actually have hands on experience with such a setup, I'm familiar
with it purely through bug reports, e.g. this one

https://lore.kernel.org/all/BYAPR12MB301441A16CE6CFFE17147888A0A09@BYAPR12MB3014.namprd12.prod.outlook.com

> If there is a specific test you want done, let me know.

Smoke testing is all I was thinking.  I wouldn't put too much effort into trying
to make sure this all works.  Like I said earlier, nice to have, but certainly not
necessary.
