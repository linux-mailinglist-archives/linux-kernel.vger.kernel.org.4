Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC7A7404DD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 22:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjF0UU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 16:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjF0UUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:20:51 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C562296E;
        Tue, 27 Jun 2023 13:20:36 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-312826ffedbso5487985f8f.0;
        Tue, 27 Jun 2023 13:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687897235; x=1690489235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+F+0Zbk3efX4mLn8Qobc5lNIjXu3jsPFwNKngSk7DrU=;
        b=ZodJlmnuDlfsPE6ZRGdn/jwnBd8a8Sv6S9nFI5LaSmWXkRCOoM0C/YG9EtNqjlJ6VA
         RV/LNPMEId8ppmVuMGm43TUo3bSoxVToJdrHVR4QljduBlKmbcfOOCvt+5rGWFQEyJMF
         6bJsiTp8ztIQcF0BEfRJ9jCia9nu7Q/Lhm3ZdIp8PhjuDkrjRTFae1cshOrRv4oen2zS
         Qn/W7uCRXVJrCscABbuBLGgerdssSk3I4MAeaIguIaa7tZJfKevOAbtyRE/5I5tXfcsl
         sXIhzq43o2vLCeNpP+9/p9aIPzECX/Rx7crUytb6yE871BcaGdPHXC5AbJ7D4H2YCAgE
         0neg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687897235; x=1690489235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+F+0Zbk3efX4mLn8Qobc5lNIjXu3jsPFwNKngSk7DrU=;
        b=T4ykMzucrF1x0EmDjfmiE+ZyA/belQBD/LOh/Fz5fXpXHkKFZ8rvQAfCGZ72b+WZG3
         I2ytuZ5HndpGqBBiOAgj5W2RIgiMvxnicaOPzfBHvPsSFr5pwT2t0OtkvDVck4UL/osN
         9mILhFWayJApQX/+ctMgRDFntMgOAArk/5SDW0DI3CARmPbYwoO+fTLh9RIAZKEkhzrs
         FFchTmAMrDH+OcuclOIgbK+rqJQVcA2pHDHN7yIgc2i9sexGcnMaVQP+wDUjslkfgb62
         yLyIo+CdeX3FMGiuI9mJGY9vB1/M3oNGsjTkPJvHmFLAGrx2ucODb9GV8M4e4CkV2e4O
         0Btg==
X-Gm-Message-State: AC+VfDwi8zNhaJIs+p4krUXLLOcVdcjekv528WY9+/Os1fTgefOUI/mr
        ou8ExLfhNDvW9PoAfAkJ69w=
X-Google-Smtp-Source: ACHHUZ6F7WJzRmHL9mdLvQRGMe1DgzoJOPiuuU5ZXKNgvDHEjkRd7iUd+k9rc4UojLUrQzYRzTpC7w==
X-Received: by 2002:a05:6000:11cd:b0:313:eaac:f337 with SMTP id i13-20020a05600011cd00b00313eaacf337mr6965044wrx.53.1687897234376;
        Tue, 27 Jun 2023 13:20:34 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id b3-20020a05600010c300b00313f9367844sm3938220wrx.88.2023.06.27.13.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 13:20:33 -0700 (PDT)
Date:   Tue, 27 Jun 2023 21:20:33 +0100
From:   Stafford Horne <shorne@gmail.com>
To:     Rich Felker <dalias@libc.org>
Cc:     Szabolcs Nagy <nsz@port70.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-mm@kvack.org
Subject: Re: [PATCH 3/4] openrisc: Support floating point user api
Message-ID: <ZJtEkdiWVYJ4Nvo3@antec>
References: <20230418165813.1900991-1-shorne@gmail.com>
 <20230418165813.1900991-4-shorne@gmail.com>
 <20230626213840.GA1236108@port70.net>
 <ZJsRHzDbuTlXKNCG@antec>
 <20230627175638.GD3630668@port70.net>
 <20230627192719.GR20050@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627192719.GR20050@brightrain.aerifal.cx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 03:27:19PM -0400, Rich Felker wrote:
> On Tue, Jun 27, 2023 at 07:56:38PM +0200, Szabolcs Nagy wrote:
> > * Stafford Horne <shorne@gmail.com> [2023-06-27 17:41:03 +0100]:
> > > On Mon, Jun 26, 2023 at 11:38:40PM +0200, Szabolcs Nagy wrote:
> > > > * Stafford Horne <shorne@gmail.com> [2023-04-18 17:58:12 +0100]:
> > > > > Add support for handling floating point exceptions and forwarding the
> > > > > SIGFPE signal to processes.  Also, add fpu state to sigcontext.
> > > > > 
> > > > > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > > > > ---
> > > > ...
> > > > > --- a/arch/openrisc/include/uapi/asm/sigcontext.h
> > > > > +++ b/arch/openrisc/include/uapi/asm/sigcontext.h
> > > > > @@ -28,6 +28,7 @@
> > > > >  
> > > > >  struct sigcontext {
> > > > >  	struct user_regs_struct regs;  /* needs to be first */
> > > > > +	struct __or1k_fpu_state fpu;
> > > > >  	unsigned long oldmask;
> > > > >  };
> > > > 
> > > > this seems to break userspace abi.
> > > > glibc and musl have or1k abi without this field.
> > > > 
> > > > either this is a new abi where binaries opt-in with some marking
> > > > and then the base sigcontext should be unmodified,
> > > > 
> > > > or the fp state needs to be added to the signal frame in a way that
> > > > does not break existing abi (e.g. end of the struct ?) and also
> > > > advertise the new thing via a hwcap, otherwise userspace cannot
> > > > make use of it.
> > > > 
> > > > unless i'm missing something.
> > > 
> > > I think you are right, I meant to look into this but it must have slipped
> > > though.  Is this something causing you issues or did you just notice it?
> > 
> > i noticed it while trying to update musl headers to linux 6.4 uapi.
> > 
> > > I didn't run into issues when running the glibc test suite, but I may have
> > > missed it.
> > 
> > i would only expect issues when accessing ucontext entries
> > after uc_mcontext.regs in a signal handler registered with
> > SA_SIGINFO.
> > 
> > in particular uc_sigmask is after uc_mcontext on or1k and e.g.
> > musl thread cancellation uses this entry to affect the mask on
> > signal return which will not work on a 6.4 kernel (not tested).
> > 
> > i don't think glibc has tests for the ucontext signal abi.
> > 
> > > Just moving this to the end of the sigcontext may be all that is needed.
> > 
> > that won't help since uc_sigmask comes after sigcontext in ucontext.
> > it has to go to the end of ucontext or outside of ucontext then.
> > 
> > one way to have fpu in sigcontext is
> > 
> > struct sigcontext {
> > 	struct user_regs_struct regs;
> > 	unsigned long oldmask;
> > 	char padding[sizeof(__userspace_sigset_t)];
> > 	struct __or1k_fpu_state fpu;
> > };
> > 
> > but the kernel still has to interpret the padding in a bwcompat
> > way. (and if libc wants to expose fpu in its ucontext then it
> > needs a flag day abi break as the ucontext size is abi.)
> > 
> > (part of the userspace uc_sigmask is unused because sigset_t is
> > larger than necessary so may be that can be reused but this is
> > a hack as that's libc owned.)
> > 
> > not sure how important this fpu field is, arm does not seem to
> > have fpu state in ucontext and armhf works.
> > 
> > there may be other ways, i'm adding Rich (musl maintainer) on cc
> > in case he has an opinion.
> 
> Indeed, mcontext_t cannot be modified because uc_sigmask follows it in
> ucontext_t. The only clean solution here is probably to store the
> additional data at offsets past
> 
> 	sizeof(struct sigcontext) + sizeof(sigset_t)
> 
> and not expose this at all in the uapi types. Some hwcap flag can
> inform userspace that this additional space is present and accessible
> if that's needed.
> 
> Optionally you could consider exposing this in the uapi headers'
> ucontext_t structure; whether it's an API breakage depends on whether
> userspace is relying on being able to allocate its own ucontext_t etc.
> This would leave the actual userspace headers (provided by libc) free
> to decide whether to modify their type or not according to an
> assessment of whether it's a breaking change to application linkage.
> 
> What's not workable though is the ABI break that shipped in 6.4. It's
> a serious violation of "don't break userspace" and makes existing
> application binaries just *not work* (cancellation breaks and possibly
> corrupts program state). This needs to be reverted.

Hi Szabolcs, Rich,

Let me work on reverting the bits that try to expose fpcsr in sigcontext.  I am
very aware of rules about not breaking userspace, but for some reason this was
completely missed.

I don't think we do have any need to expose this to userspace at the moment so I
prefer to just leave the fpu state out of sigcontext if that is usable.

The fix will take me about a day or two to get tested and sent.

-Stafford
