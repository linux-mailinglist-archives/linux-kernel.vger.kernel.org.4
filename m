Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E7E740184
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjF0QlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjF0QlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:41:20 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F812700;
        Tue, 27 Jun 2023 09:41:06 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-313e68e99c7so4403257f8f.1;
        Tue, 27 Jun 2023 09:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687884065; x=1690476065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tPqwuMIYF4VZddyTRxVW9wCbFz3nD1brpxZ4QBpbzrc=;
        b=inHfmnWw4N5iMaE9pnKNs1SF/HQUZ4fMgt1Q0BJ4t2tE5ZNuRArKjepLCFgCDY0msK
         sUE5w/K5mwMRxDZimmJfnAg4gu5Uiv5ao5xkbgiT+ZOE2p+sn6KqvU7oWm/PfYExTRZA
         Kx5LPGjb5OorMDQE3n41+aRrVUbflFRdBjNvAkmTSIgOyosN5j3kU815skkp/4AQYjDA
         yHJrpLkEVTPmFxeYZsSmNKXDmSac8dShO/zmhT/iyHiVG5U1ssIWxoAXhReYJAZe32wb
         IJnupcTmGVo86npaNAlgfdOuhW5pyVlBgPb38MS1YETO34Pr+Nk6aBh1Rw8PFzmhutj5
         h4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687884065; x=1690476065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPqwuMIYF4VZddyTRxVW9wCbFz3nD1brpxZ4QBpbzrc=;
        b=dxaYUqTOo55ttfqWIuhIu8P7yYh9A0ATxqivCVEQ18UjxpD0mBT5xUWtOjFo5oEHVj
         kqbZpSsF5psNen5cP49OWR9iyDE+zf2JstfzjhsO5D4auu7Vo9leY9bBPvQ3qYYMuUWV
         an2il6owp3q0Jus8sI7ecERML8tOX6QTP8fOEzPXmj70wvyEKdXsjRQWzcQScSITPvMD
         O5MEuEWkHj0Z7wVNnlnRfl2YQnSBeCbP7cpwSbTPxB8SXhvLCq56kISZRz5jkKpAjjsf
         4CKIDuqvd9JYUL6iOYmmxF+xGhh2OF8cTAvGO/v6wOPDp+8e5WE1CSEU2/whVWWaP1+g
         DeSA==
X-Gm-Message-State: AC+VfDyaF91jaDUlO/SCEbgv2jvIo82vH85AsQikymNZRTI6GKTwTqDY
        +Y4xj+gS1E0fVcIJXyXNBX0=
X-Google-Smtp-Source: ACHHUZ6TUmmGbdfad1tP5CR0ZLqVj9ctsqGWz0wY0SC29ZsDHa930uyPrMN7LDJw0IVHNzz8FmHKvg==
X-Received: by 2002:adf:fe09:0:b0:313:e6f3:d05a with SMTP id n9-20020adffe09000000b00313e6f3d05amr7993378wrr.16.1687884064353;
        Tue, 27 Jun 2023 09:41:04 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id f18-20020adff452000000b003113b3bc9d7sm10876009wrp.32.2023.06.27.09.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 09:41:03 -0700 (PDT)
Date:   Tue, 27 Jun 2023 17:41:03 +0100
From:   Stafford Horne <shorne@gmail.com>
To:     Szabolcs Nagy <nsz@port70.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-mm@kvack.org
Subject: Re: [PATCH 3/4] openrisc: Support floating point user api
Message-ID: <ZJsRHzDbuTlXKNCG@antec>
References: <20230418165813.1900991-1-shorne@gmail.com>
 <20230418165813.1900991-4-shorne@gmail.com>
 <20230626213840.GA1236108@port70.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626213840.GA1236108@port70.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 11:38:40PM +0200, Szabolcs Nagy wrote:
> * Stafford Horne <shorne@gmail.com> [2023-04-18 17:58:12 +0100]:
> > Add support for handling floating point exceptions and forwarding the
> > SIGFPE signal to processes.  Also, add fpu state to sigcontext.
> > 
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> ...
> > --- a/arch/openrisc/include/uapi/asm/sigcontext.h
> > +++ b/arch/openrisc/include/uapi/asm/sigcontext.h
> > @@ -28,6 +28,7 @@
> >  
> >  struct sigcontext {
> >  	struct user_regs_struct regs;  /* needs to be first */
> > +	struct __or1k_fpu_state fpu;
> >  	unsigned long oldmask;
> >  };
> 
> this seems to break userspace abi.
> glibc and musl have or1k abi without this field.
> 
> either this is a new abi where binaries opt-in with some marking
> and then the base sigcontext should be unmodified,
> 
> or the fp state needs to be added to the signal frame in a way that
> does not break existing abi (e.g. end of the struct ?) and also
> advertise the new thing via a hwcap, otherwise userspace cannot
> make use of it.
> 
> unless i'm missing something.

I think you are right, I meant to look into this but it must have slipped
though.  Is this something causing you issues or did you just notice it?

I didn't run into issues when running the glibc test suite, but I may have
missed it.

Just moving this to the end of the sigcontext may be all that is needed.

-Stafford
