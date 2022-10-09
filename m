Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BF95F8B47
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 14:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiJIMjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 08:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJIMjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 08:39:05 -0400
Received: from mail.galaxycrow.de (mail.galaxycrow.de [162.55.242.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A772CDC3
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 05:39:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 82B9061866;
        Sun,  9 Oct 2022 14:38:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=galaxycrow.de;
        s=dkim; t=1665319139;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:
         in-reply-to:references; bh=d6mUxv+4rMdxCUE/xftUBw4Q6gPkeYMBuZIYtE6ZrQM=;
        b=I0qo+O3ZbG2GxEku3vz8bKwzhJBKe3TUINC6fOuGkNvsBdQj0pRUFHsAyeWM4R/guYBOiK
        26KHFAHAjbo/SVkgRSnJjr2ToIsy2t9q7YeGzV/rYTKGkE5G9K0xC+BC29rEjyrOj/ULSJ
        zy2DMoAcC3TApHrE8WvX+sHOiDafLB8rZigeoBknPFFW/m0msKInkCo2SjPJsj+NXYfry2
        f25KmTFKjQ2qc3XUwNGrL3RHhR6KmV+W56hCuzjZlwAPaRk1j8gdVLlYEEgGZ+PBLMF/0n
        8L+KIoZo5qTGKHGknvkAN8NLR/mF3yEzhtX6YdCZs7rfiJpuu35xWXtA6U5IQA==
From:   Cleo John <waterdev@galaxycrow.de>
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixed styling in riscv ucontext header
Date:   Sun, 09 Oct 2022 14:38:43 +0200
Message-ID: <1923489.PYKUYFuaPT@watet-ms7b87>
In-Reply-To: <Y0K7PDzwuOPweYSm@spud>
References: <20221009120340.GA41243@watet-ms7b87> <Y0K7PDzwuOPweYSm@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart21645611.EfDdHjke4D"; micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart21645611.EfDdHjke4D
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Cleo John <waterdev@galaxycrow.de>
To: Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH] Fixed styling in riscv ucontext header
Date: Sun, 09 Oct 2022 14:38:43 +0200
Message-ID: <1923489.PYKUYFuaPT@watet-ms7b87>
In-Reply-To: <Y0K7PDzwuOPweYSm@spud>
MIME-Version: 1.0

Hey Connor,

On Sun, 9. October 2022, 14:14:52 CEST, Conor Dooley wrote:
> Hey Cleo,
> 
> On Sun, Oct 09, 2022 at 02:03:40PM +0200, Cleo John wrote:
> > Fixed styling in riscv ucontext header
> 
> This should probably be "riscv: fix styling..."

okay yea, I will change this in a second patch.

> > This patch changes the two comments in ucontext.h by getting them up to
> > the cody style proposed by torwalds.
> s/This patch changes/Change
> 
> Looks like some typos here too & your lines need to be wrapped at 72
> characters for commit messages. git usually enforces that automatically
> when you do a `git commit`.
I will wrap the lines, but where are the typos if I may ask?

> > In my opinion this also improves the readability so I think this is a
> > useful change to do. Please also tell me if you have a different opinion.
> 
> FYI commentary on the patch should go below the ---.
will note

> > Signed-off-by: Cleo John <waterdev@galaxycrow.de>
> > ---
> > 
> >  arch/riscv/include/uapi/asm/ucontext.h | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/riscv/include/uapi/asm/ucontext.h
> > b/arch/riscv/include/uapi/asm/ucontext.h index 44eb993950e5..0cd6f8616985
> > 100644
> > --- a/arch/riscv/include/uapi/asm/ucontext.h
> > +++ b/arch/riscv/include/uapi/asm/ucontext.h
> > @@ -18,7 +18,8 @@ struct ucontext {
> > 
> >  	/* There's some padding here to allow sigset_t to be expanded in 
the
> 
> Why fix the closing comment but leave the opening ones incorrect?
> 
> Thanks,
> Conor.

I mixed the code style up with the one in net/ -will fix

Thanks,
Cleo.

> >  	 * future.  Though this is unlikely, other architectures put 
uc_sigmask
> >  	 * at the end of this structure and explicitly state it can be
> > 
> > -	 * expanded, so we didn't want to box ourselves in here. */
> > +	 * expanded, so we didn't want to box ourselves in here.
> > +	 */
> > 
> >  	__u8		  __unused[1024 / 8 - sizeof(sigset_t)];
> >  	/* We can't put uc_sigmask at the end of this structure because we 
need
> >  	
> >  	 * to be able to expand sigcontext in the future.  For example, 
the
> > 
> > @@ -27,7 +28,8 @@ struct ucontext {
> > 
> >  	 * ucontext, so we're putting this at the end in order to allow 
for
> >  	 * infinite extensibility.  Since we know this will be extended and 
we
> >  	 * assume sigset_t won't be extended an extreme amount, we're
> > 
> > -	 * prioritizing this. */
> > +	 * prioritizing this.
> > +	 */
> > 
> >  	struct sigcontext uc_mcontext;
> >  
> >  };


--nextPart21645611.EfDdHjke4D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE2nzORJA3JEiNR015AnApHozuxisFAmNCwNMACgkQAnApHozu
xisufhAAlvSM5MWGEbowao+ZV4f6Xi+XnTXSAgkDnZmMi9bjvBL0AaaS8u9eq9bt
EgWaVVkHbjw/zdwOERwUL51UNMy+NxN03whjKZ4JsL0Ei+1JtVtLfJNWY0DVouw5
zpj7Bd6s2CTOogDPLlVp443D5Hjf8+MGftk/7sn/fjonFOIwDlMWwlT6iaC1lEGp
KNinD2NNJU16hws0H21GJpkGfuUcHk1S4nAdM4gacTuAS0L30fTH2qAPTK3rrzsx
jhb7XIDFiTPaUCNtzu8MFb9hrzK8yiuet3tTY7sPomHrfcyMZGdGPZbHUe6/j2Yz
EmjrDtwcXkWczHcDL8PzyH22beA8uF0aq5gDnO3DNjblKwxBPwLH9Q9dGMqdjzzn
flOxHoRdvBh7yrbRcANZZqsH2S8vfEKr3E0VlAzHwHqrh+jhWK6vgNTeQ/AeVq9C
+xf7x40NrOT1JyI7Znp407jWJnbtholyVUhwDOsan4avV8UNuB0NJYz9gFE3fkON
t0PS3FIUUVgHf16bTR/2Kdpj5hAZpYPkyGWtKR3bOdzhCaZoA26HWOd9FMFok0fP
oldCGGh+LQuUrplrlDDD32xSREIO4vMbXpqsFFHppesr2BUv9njs4gamd0xT7KYD
OUJTFiAsaYzMEjaaM3wFYgu9YIlc4K7uckVARKY/Vsmg0U+kpEY=
=eD/M
-----END PGP SIGNATURE-----

--nextPart21645611.EfDdHjke4D--



