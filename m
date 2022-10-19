Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1F56042F9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbiJSLM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJSLM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:12:29 -0400
Received: from mail.galaxycrow.de (mail.galaxycrow.de [162.55.242.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAA9108244
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 03:39:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 369A060842;
        Wed, 19 Oct 2022 12:08:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=galaxycrow.de;
        s=dkim; t=1666174111;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:
         in-reply-to:references; bh=blnn0G2Cx37+alWbaZeVkXAz2TsiK7y6SUZFku7+j4c=;
        b=eeJqCDM9BjAlTDZnKUkEEje1BHk15WYclfhI6BnmOpw2LfbT1OYmNGFnWnNs1GECAq7adb
        F1fjSLNSM7yGfpWzJilumKYvjs9rpXTx4BDa+H4Qdk6cDtgQ5ZBmCqEnrDFKfbgExJBaY/
        FyFqhsuhPfVsH9GNWJLU7MV6W+g0iOV4fCJMwucg/za8rpYy2GF1alDr1b25QEVR9CEBPt
        ia94MT69a8JUAK8x1T1HzPlk7seCQ6BymA5xICQxyoSGEK9oJ067iT6SS0FUsqvIuBGIz1
        IU2B1nYRjXxNbz7VzCJdWVm+VmYYbZLDKAoL8HosZcokEGuxdhS7d4BYzHqCaA==
From:   Cleo John <waterdev@galaxycrow.de>
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: fix styling in ucontext header
Date:   Wed, 19 Oct 2022 12:07:58 +0200
Message-ID: <4763163.GXAFRqVoOG@watet-ms7b87>
In-Reply-To: <Y0SDZEXQ5kXGJZLh@spud>
References: <20221010182848.GA28029@watet-ms7b87> <5631093.DvuYhMxLoT@watet-ms7b87> <Y0SDZEXQ5kXGJZLh@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1845179.tdWV9SEqCh"; micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1845179.tdWV9SEqCh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Cleo John <waterdev@galaxycrow.de>
To: Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v2] riscv: fix styling in ucontext header
Date: Wed, 19 Oct 2022 12:07:58 +0200
Message-ID: <4763163.GXAFRqVoOG@watet-ms7b87>
In-Reply-To: <Y0SDZEXQ5kXGJZLh@spud>
MIME-Version: 1.0

On Mon, Oct 10, 2022 at 22:41:08 CEST, Conor Dooley wrote:
> On Mon, Oct 10, 2022 at 09:55:17PM +0200, Cleo John wrote:
> > Am Montag, 10. Oktober 2022, 20:50:56 CEST schrieb Conor Dooley:
> > > On Mon, Oct 10, 2022 at 08:28:48PM +0200, Cleo John wrote:
> > > > Change the two comments in ucontext.h by getting them up to
> > > > the coding style proposed by torvalds.
> > > > 
> > > > Signed-off-by: Cleo John <waterdev@galaxycrow.de>
> > > > ---
> > > > In my opinion this also improves the readability so I think this is a useful change to do.
> > > > Please also tell me if you have a different opinion.
> > > 
> > > I don't think it is all that /important/ of a change, but it does make
> > > things match between this file and the other headers.
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > 
> > > Thanks.
> > > 
> > 
> > Yes, its not that important. Thats why I chose it. :D
> 
> :)
> 
> > To be honest this is my first commit to the kernel so 
> > I wanted to do something simple to start things of
> > easy and to get more familiar with the procedure,
> > before getting my feet wet into some real kernel
> > additions.
> 
> Cool, nice to have you & good luck!
> 
> > Thanks for helping!
> 
> nw, hopefully I wasn't too direct/negative.
> 
> Conor.
> 
> > 
> > > > 
> > > > Changes in v2:
> > > >  - change the styling of the top comments too
> > > > 
> > > >  arch/riscv/include/uapi/asm/ucontext.h | 12 ++++++++----
> > > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/arch/riscv/include/uapi/asm/ucontext.h b/arch/riscv/include/uapi/asm/ucontext.h
> > > > index 44eb993950e5..516bd0bb0da5 100644
> > > > --- a/arch/riscv/include/uapi/asm/ucontext.h
> > > > +++ b/arch/riscv/include/uapi/asm/ucontext.h
> > > > @@ -15,19 +15,23 @@ struct ucontext {
> > > >  	struct ucontext	 *uc_link;
> > > >  	stack_t		  uc_stack;
> > > >  	sigset_t	  uc_sigmask;
> > > > -	/* There's some padding here to allow sigset_t to be expanded in the
> > > > +	/*
> > > > +	 * There's some padding here to allow sigset_t to be expanded in the
> > > >  	 * future.  Though this is unlikely, other architectures put uc_sigmask
> > > >  	 * at the end of this structure and explicitly state it can be
> > > > -	 * expanded, so we didn't want to box ourselves in here. */
> > > > +	 * expanded, so we didn't want to box ourselves in here.
> > > > +	 */
> > > >  	__u8		  __unused[1024 / 8 - sizeof(sigset_t)];
> > > > -	/* We can't put uc_sigmask at the end of this structure because we need
> > > > +	/*
> > > > +	 * We can't put uc_sigmask at the end of this structure because we need
> > > >  	 * to be able to expand sigcontext in the future.  For example, the
> > > >  	 * vector ISA extension will almost certainly add ISA state.  We want
> > > >  	 * to ensure all user-visible ISA state can be saved and restored via a
> > > >  	 * ucontext, so we're putting this at the end in order to allow for
> > > >  	 * infinite extensibility.  Since we know this will be extended and we
> > > >  	 * assume sigset_t won't be extended an extreme amount, we're
> > > > -	 * prioritizing this. */
> > > > +	 * prioritizing this.
> > > > +	 */
> > > >  	struct sigcontext uc_mcontext;
> > > >  };
> > > >  
> > > 
> > 
> 
> 
> 

Hey, because I am new to Kernel submissions I wanted to ask if there is a way for me to see / track how far this commit has gone in the pipeline of commits?

Thanks,
Cleo
--nextPart1845179.tdWV9SEqCh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE2nzORJA3JEiNR015AnApHozuxisFAmNPzH4ACgkQAnApHozu
xisJEQ//VwUTcssY2/bbX8TuDCQ3OyPaxkD70GaPagHsIs+ZwcGKPDqYmeKIEyUq
sCj1ul3WfeoCi8/TiSaruGDvq0Gw7A+LFgnUZUR96uVnF2rb0IFOi9DOvVTWgNX7
GXpzeAEU/japPXutthcGaf12ZZprMi8mh7UULSA3WnsOjOTvfST0tpEQkPGIACh8
1tu5cXIVQG703tuttA0Y6Y3mFekFns1GWFfEpHqJQtOH61BW9JbNvjH7SWmxvI//
pExCNGbLFbMQH2jfD3S1irHLX1QGLEJzztP6jQOEAP8+ov3ToaOU1kpieKdbaG3a
CMSojxyVTglf99HiqJW8xqeEUm721hLC6dycf8GoLbsJwwX1yo5eiWF3XsVrI2IH
xmenUzUcjAb0LUkg2ooF6CjnhHkmdd/3phJTR5d4V4PdHxr4UyWwIElbJStxpeQu
Hflf9n6BV4eZptTMhXsRJ/8C2A5urDtt5ShoDWTuJ5515SDfTxcE41AYGrGj3IHe
kvK4e0lt7HNt06DjVtV572oCI1ChR2FUW4koNZY59YI/f4ppF+sKJ0eAG8xNf+wY
6K/UuWxmMoy1TiGoXb3mNhwv4Mw7IdVAm49qvpBGbFvmGLbZCNfXBSgsme+u/xxD
jc8TUGzWalaIhxqy/RcADomYXmk+SjxvJQGa1LgLyQ7IsmNj0pQ=
=I2Se
-----END PGP SIGNATURE-----

--nextPart1845179.tdWV9SEqCh--



