Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8125FA45F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 21:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJJTzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 15:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiJJTzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 15:55:40 -0400
Received: from mail.galaxycrow.de (mail.galaxycrow.de [162.55.242.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38F6578AF
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:55:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0FD17617FB;
        Mon, 10 Oct 2022 21:55:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=galaxycrow.de;
        s=dkim; t=1665431734;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:
         in-reply-to:references; bh=dCrp5kDtpKtiEQs2m0iGGoNE6y+hz0Z4JZZ8eurS4Q4=;
        b=orYa2PxPN3P6rN0Mu7mVnezkFOtsWTLxlPhZcXOLwBZNAGF/QEM2m5Al/5thcqb+rFUpNF
        I+evJXYQlLS0yCap4faTh3cDHzkfPSeUPkgKPlJSdFV0Bz0UfjiZhykNuN7l64CRkyb54t
        2Lr0IjlSDUIrCRnjeXWr7m16QsFLgYWU0xKw0ya6pF2byhNPJZW2NNHjw28Jc2iqfVndSO
        bZi/tu8zPeT0xCa1KXQUxUL1zFjrhDRnNnL9odu1Rvj9GipRoYGzOsL1DDLFDpFR40rEN6
        jXvQA0KmGgB5HhAyLSEWK7cIcZFPFSd1LCaSF0KiRhYKOd9gJvOOlz3+GgB/Bw==
From:   Cleo John <waterdev@galaxycrow.de>
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: fix styling in ucontext header
Date:   Mon, 10 Oct 2022 21:55:17 +0200
Message-ID: <5631093.DvuYhMxLoT@watet-ms7b87>
In-Reply-To: <Y0RpkI66dwEKD9Kw@spud>
References: <20221010182848.GA28029@watet-ms7b87> <Y0RpkI66dwEKD9Kw@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5887775.lOV4Wx5bFT"; micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5887775.lOV4Wx5bFT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Cleo John <waterdev@galaxycrow.de>
To: Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v2] riscv: fix styling in ucontext header
Date: Mon, 10 Oct 2022 21:55:17 +0200
Message-ID: <5631093.DvuYhMxLoT@watet-ms7b87>
In-Reply-To: <Y0RpkI66dwEKD9Kw@spud>
MIME-Version: 1.0

Am Montag, 10. Oktober 2022, 20:50:56 CEST schrieb Conor Dooley:
> On Mon, Oct 10, 2022 at 08:28:48PM +0200, Cleo John wrote:
> > Change the two comments in ucontext.h by getting them up to
> > the coding style proposed by torvalds.
> > 
> > Signed-off-by: Cleo John <waterdev@galaxycrow.de>
> > ---
> > In my opinion this also improves the readability so I think this is a useful change to do.
> > Please also tell me if you have a different opinion.
> 
> I don't think it is all that /important/ of a change, but it does make
> things match between this file and the other headers.
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Thanks.
> 

Yes, its not that important. Thats why I chose it. :D
To be honest this is my first commit to the kernel so 
I wanted to do something simple to start things of
easy and to get more familiar with the procedure,
before getting my feet wet into some real kernel
additions. 

Thanks for helping!

> > 
> > Changes in v2:
> >  - change the styling of the top comments too
> > 
> >  arch/riscv/include/uapi/asm/ucontext.h | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/riscv/include/uapi/asm/ucontext.h b/arch/riscv/include/uapi/asm/ucontext.h
> > index 44eb993950e5..516bd0bb0da5 100644
> > --- a/arch/riscv/include/uapi/asm/ucontext.h
> > +++ b/arch/riscv/include/uapi/asm/ucontext.h
> > @@ -15,19 +15,23 @@ struct ucontext {
> >  	struct ucontext	 *uc_link;
> >  	stack_t		  uc_stack;
> >  	sigset_t	  uc_sigmask;
> > -	/* There's some padding here to allow sigset_t to be expanded in the
> > +	/*
> > +	 * There's some padding here to allow sigset_t to be expanded in the
> >  	 * future.  Though this is unlikely, other architectures put uc_sigmask
> >  	 * at the end of this structure and explicitly state it can be
> > -	 * expanded, so we didn't want to box ourselves in here. */
> > +	 * expanded, so we didn't want to box ourselves in here.
> > +	 */
> >  	__u8		  __unused[1024 / 8 - sizeof(sigset_t)];
> > -	/* We can't put uc_sigmask at the end of this structure because we need
> > +	/*
> > +	 * We can't put uc_sigmask at the end of this structure because we need
> >  	 * to be able to expand sigcontext in the future.  For example, the
> >  	 * vector ISA extension will almost certainly add ISA state.  We want
> >  	 * to ensure all user-visible ISA state can be saved and restored via a
> >  	 * ucontext, so we're putting this at the end in order to allow for
> >  	 * infinite extensibility.  Since we know this will be extended and we
> >  	 * assume sigset_t won't be extended an extreme amount, we're
> > -	 * prioritizing this. */
> > +	 * prioritizing this.
> > +	 */
> >  	struct sigcontext uc_mcontext;
> >  };
> >  
> 


--nextPart5887775.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE2nzORJA3JEiNR015AnApHozuxisFAmNEeKUACgkQAnApHozu
xivxvA//U3QEUlFlK5+I8/0MnH2zb1SVlPf72FQWtze8TKNY7smuRA3crxMDNP6z
f+h37HWsSMHBxFBuH4e+YJ6Gz/mDsmgNHiZLT2mgOGPzYZ4EQ4ivu/nwdSAPz4jl
wniCTPYLSlK2O+yQyDH26h74xvQRDIyN5LrkXac3YAbmjuPF/UZ0Cqak0wCiT3mc
NT1xLTjIkubnGdr1M1/yLeLbMh4Idr6JbiAx8EIHA5a/t55MYJ7vtdPiaTSs4QsX
eduVq4MIpoc0UMUC2ejGNPIENzIs3g5/hvP8LREOyPllS/cItv3oJcAauxieBpin
54UBumQuUiSU/dp3XHSB0J4ZCMbYwT/ycxxRHR5FWwY/DbblBW/QzAYcjVDyR0k9
8RrItc9oMVjzcy28L6DnH6IcDA/2JK5F1HbSBr76cNfT7f4CLwHOG20DdQYm+SXr
CT/yPsDUvCdtStMydoP333yLoZ2COsLXAw/lxJuH5lkaTgL2+yUlgFjvV9jsx7Lb
TaGTKSxxAsdJo6FyhqHX7Vl80SdFcVTuOKPjzqNo2lfHBxSdI8MK1IQhj/7HHkWG
93MoolaYFnQr9DYsBYrm9m19rythHsjrcwjuCfsoo6S6ksIScfSxGPm4Htk6IYZR
OFnMguev+vrkLHpCPb9nrSKCNbMZ2f3uX0uUYQr2Buax5HChLJI=
=h60/
-----END PGP SIGNATURE-----

--nextPart5887775.lOV4Wx5bFT--



