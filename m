Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A415F8B54
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 14:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiJIMuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 08:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiJIMt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 08:49:57 -0400
Received: from mail.galaxycrow.de (mail.galaxycrow.de [162.55.242.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1F0F588
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 05:49:54 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 90A8D620F9;
        Sun,  9 Oct 2022 14:49:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=galaxycrow.de;
        s=dkim; t=1665319791;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:
         in-reply-to:references; bh=g/8euF14dUerCEvnwg7lRGoe8cSv4brGLbH1WKfEZUQ=;
        b=YyL1S3v9UPX9sTsy0IpwqWdW58b5Z2W/EA98dHHq3zIO6bC1CepBEFAqR/W/0DWtizYmXh
        aY8zBfM9vaOSXrr0QAKt1VNpVrwVF9omF5UPuEi/sXPYUQ6OTtMRQAXket6ft6HI2JiedJ
        XzS/Hz5aZeE/5TTTyaxQ8OwxO5PetRU/OBiHgjbsXz/Wgr8F+NGMn4UKuSD6kDiY7O4aVP
        LUPCG+wchfPNdw3webS4qYYe2K7Wmz+CFNnExfAes7TXQbtM7RkdIaGRXBmwymYOS0/pBO
        BZwbcB+bTWRDN9EdVXQ9NNYtwoqppt2oBvLGweHXm0m1nQSifqdJnArhwDJ9yA==
From:   Cleo John <waterdev@galaxycrow.de>
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixed styling in riscv ucontext header
Date:   Sun, 09 Oct 2022 14:49:40 +0200
Message-ID: <3473110.iIbC2pHGDl@watet-ms7b87>
In-Reply-To: <Y0LB1oLuVIytgKI/@spud>
References: <20221009120340.GA41243@watet-ms7b87> <1923489.PYKUYFuaPT@watet-ms7b87> <Y0LB1oLuVIytgKI/@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9019818.CDJkKcVGEf"; micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart9019818.CDJkKcVGEf
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Cleo John <waterdev@galaxycrow.de>
To: Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH] Fixed styling in riscv ucontext header
Date: Sun, 09 Oct 2022 14:49:40 +0200
Message-ID: <3473110.iIbC2pHGDl@watet-ms7b87>
In-Reply-To: <Y0LB1oLuVIytgKI/@spud>
MIME-Version: 1.0

On Sun, 9. October 2022, 14:43:02 CEST, Conor Dooley wrote:
> On Sun, Oct 09, 2022 at 02:38:43PM +0200, Cleo John wrote:
> > Hey Connor,
> > 
> > On Sun, 9. October 2022, 14:14:52 CEST, Conor Dooley wrote:
> > > Hey Cleo,
> > > 
> > > On Sun, Oct 09, 2022 at 02:03:40PM +0200, Cleo John wrote:
> > > > Fixed styling in riscv ucontext header
> > > 
> > > This should probably be "riscv: fix styling..."
> > 
> > okay yea, I will change this in a second patch.
> > 
> > > > This patch changes the two comments in ucontext.h by getting them up
> > > > to
> > > > the cody style proposed by torwalds.
> > > 
> > > s/This patch changes/Change
> > > 
> > > Looks like some typos here too & your lines need to be wrapped at 72
> > > characters for commit messages. git usually enforces that automatically
> > > when you do a `git commit`.
> > 
> > I will wrap the lines, but where are the typos if I may ask?
> 
> "cody style" & s/w/v/ in Linus' name.
> 

okay, this is.. embarrassing.

> > > > In my opinion this also improves the readability so I think this is a
> > > > useful change to do. Please also tell me if you have a different
> > > > opinion.
> > > 
> > > FYI commentary on the patch should go below the ---.
> > 
> > will note
> > 
> > > > Signed-off-by: Cleo John <waterdev@galaxycrow.de>
> > > > ---
> > > > 
> > > >  arch/riscv/include/uapi/asm/ucontext.h | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/arch/riscv/include/uapi/asm/ucontext.h
> > > > b/arch/riscv/include/uapi/asm/ucontext.h index
> > > > 44eb993950e5..0cd6f8616985
> > > > 100644
> > > > --- a/arch/riscv/include/uapi/asm/ucontext.h
> > > > +++ b/arch/riscv/include/uapi/asm/ucontext.h
> > > > @@ -18,7 +18,8 @@ struct ucontext {
> > > > 
> > > >  	/* There's some padding here to allow sigset_t to be expanded in the
> > 
> > > Why fix the closing comment but leave the opening ones incorrect?
> > > 
> > > Thanks,
> > > Conor.
> > 
> > I mixed the code style up with the one in net/ -will fix
> > 
> > Thanks,
> > Cleo.
> > 
> > > >  	 * future.  Though this is unlikely, other architectures put uc_sigmask 
> > > >  	 * at the end of this structure and explicitly state it can be
> > > > 
> > > > -	 * expanded, so we didn't want to box ourselves in here. */
> > > > +	 * expanded, so we didn't want to box ourselves in here.
> > > > +	 */
> > > > 
> > > >  	__u8		  __unused[1024 / 8 - sizeof(sigset_t)];
> > > >  	/* We can't put uc_sigmask at the end of this structure because we need
> > > >  	 * to be able to expand sigcontext in the future.  For example, the
> > > > @@ -27,7 +28,8 @@ struct ucontext {
> > > > 
> > > >  	 * ucontext, so we're putting this at the end in order to allowb for
> > > >  	 * infinite extensibility.  Since we know this will be extended and we
> > > >  	 * assume sigset_t won't be extended an extreme amount, we're
> > > > 
> > > > -	 * prioritizing this. */
> > > > +	 * prioritizing this.
> > > > +	 */
> > > > 
> > > >  	struct sigcontext uc_mcontext;
> > > >  
> > > >  };


--nextPart9019818.CDJkKcVGEf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE2nzORJA3JEiNR015AnApHozuxisFAmNCw2QACgkQAnApHozu
xivgeA/8CEbHVKvn7Ale6zxrrgmkXPz+lpaN2tndBSoaje/hzS2U3JMQdZXbwv3h
40CmbX0lLslwCZVl0wysDMkdEnjZSdqiIOaFJOrkrvp1YnVU9G7WkdnIqgxJr8Qu
KuJXgBGp2XvorE3bbP03idG2UYfpMJnHbN1kJ8/fOkEc3Q6b0BCEHpHKGLZYV7fO
Me6ipbi4oHtLBK91MKzp+LC71EON0+Ih50P+EPcLlO31wWeck8lh8ICXkd5dFWPQ
GC7Jf5VkkbV1CgjkOFqitsLYcUzdc+02WypHZ5+TjioEux/263V/25pJs+zhg1pS
KhFfXDrPOEdOHgVIkG1S358M4tOCWj/QZOZ5lFleDkuhrGpXAY2j1LZMbOE0zcVn
fmAWbg1POSO9/ISiBr7diuPk9Vg+GvoARUR8GTiTDFGXGaJ0YV7Y7T/eQJdtaqff
FODFSjMkzLMZEnog574ZgY7BxP4RELElU1fKp+b2c2Qom0w2eU9j12pplxcELq+3
4jGe6R1L5If8EFuvMUJdDo8YjpBc7sU6YCoojf70SGMudJEtrI8RwGti+RzpIYMd
76IXpjqNpWwMVikpGYfusT9fI3XLm7THh2KSlyl1LYhB07mY7AsGjsp1bUMs6FqH
yM9IxaqIlyZR4vHaz7rE0+TiO66IWGSbYtOq0w+/AlmMPHy70s0=
=HuMm
-----END PGP SIGNATURE-----

--nextPart9019818.CDJkKcVGEf--



