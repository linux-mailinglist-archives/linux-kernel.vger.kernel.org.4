Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0806A7110CC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239473AbjEYQUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjEYQUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:20:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5B3139
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:20:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 035006197F
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 16:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79546C433D2;
        Thu, 25 May 2023 16:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685031635;
        bh=2w4rrL1C0Qs+cOYNmYdTfanv48y+sYseid/+Gt86h+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ENpQJdkhDadGeh44/mMedQmcN0d2v/1DuMF6FEWsgIbsf/1n1/rL8xcmayICi+mJM
         3ShJR9wCpUSb+F+ws7FExcr/9SZzUoTjy67ILLTuN3MxNJDyV4dk9v+BDptw6F1zaB
         siSMjnNL/gmfXf0+H5jB23OAIwEG60NyYJUK5NNll3faSNq6H7V9NzZixX6fVvMKMD
         y5XXjg01HU9fCubc6J9irBFlUHHLZsasCpyIbiDkpA/PuJz1HgxNJcZ2CykTLM9N96
         xJ7SdBnYpRZ3svKWz2iZ16tE+Ws8rV3Zvsr5mQlpfeKp47QAtgOgf1j2f8XFxS1gZR
         VGEO2Zo5EqVHg==
Date:   Thu, 25 May 2023 17:20:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Deepak Gupta <debug@rivosinc.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [GIT PULL] x86/shstk for 6.4
Message-ID: <b402b80b-a7c6-4ef0-b977-c0f5f582b78a@sirena.org.uk>
References: <20230424212130.590684-1-dave.hansen@linux.intel.com>
 <CAHk-=whn3F1k263SZNUVQK195tcCMAo5E_WbmjUE0qFC5rWg=w@mail.gmail.com>
 <4433c3595db23f7c779b69b222958151b69ddd70.camel@intel.com>
 <148b3edb-b056-11a0-1684-6273a4a2d39a@intel.com>
 <CAHk-=wiuVXTfgapmjYQvrEDzn3naF2oYnHuky+feEJSj_G_yFQ@mail.gmail.com>
 <ad5b44e17c1c17ebdc581169fec7e80f7ef2a4d4.camel@intel.com>
 <CAHk-=wiZjSu7c9sFYZb3q04108stgHff2wfbokGCCgW7riz+8Q@mail.gmail.com>
 <bd7c4f53cd27224308bff305513978dced1495ad.camel@intel.com>
 <20230515212255.GA562920@debug.ba.rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4xDnJ/JT4ZY6//sb"
Content-Disposition: inline
In-Reply-To: <20230515212255.GA562920@debug.ba.rivosinc.com>
X-Cookie: volcano, n.:
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4xDnJ/JT4ZY6//sb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 15, 2023 at 02:22:55PM -0700, Deepak Gupta wrote:
> On Sun, May 07, 2023 at 04:24:24PM +0000, Edgecombe, Rick P wrote:

> > BTW, I forgot to mention that there is another architecture (maybe 2)
> > that is expected to use this refactor for implementing their shadow
> > stacks. So FWIW, this churn is not just for x86.

> That's right, one of them is RISC-V.

Also arm64.

> RISC-V control-flow integrity: https://github.com/riscv/riscv-cfi

> Since RISC-V PTE have 3 separate bits for read, write and execute. Write
> only (R=0, W=1, X=0) encodings had been reserved and thus cpu supporting
> this extension will treat this reserved encoding as shadow stack.

> It doesn't get messy as in case of x86 (due to overloading of dirty bit),
> but it still will need pte helper which marks a page "shadow stack
> writeable" or "regular writeable" depending on vma.

For arm64 GCS (our shadow stack equivalent) is built on top of another
extension that allows us to assign arbitrary meanings to four of the
bits (they become an index into an array of actual permissions) so we
might be able to avoid having to look at the VMA, though we might want
to in future in order to make better use of the other features of the
indirection extension.

--4xDnJ/JT4ZY6//sb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRvis0ACgkQJNaLcl1U
h9BKswf/WpINbiUBFLGfCXGwM0YsASUPoJoK1V7g+saDH9q66NEq4yB1t/UFPSPY
bylxlSVk97TTHlTDR5Z6twr/YdVX5hqcszBMOhUBqgImKGBHvc10+mBj3dIUeUCR
/zexGgbk/vZw9zmzBdRwK4bZESO44DZC+lYpKjxoXct2wYrZuzLz+dlE/fvYTa93
1mq6fU6tel2Rnxk5EUoE1PC4wYIGsMEzDcHccfl2O/xwcvwDgIR6xQ7hHSRqyzDC
JoH0C4PklIJFs1151uCvO8m2qIM3gJqJGGXHrYi3qs1gAdebWbQywdx59hFHNAnG
+JONah/5gMlQ6ER7q29Cd0o21gzNag==
=46DT
-----END PGP SIGNATURE-----

--4xDnJ/JT4ZY6//sb--
