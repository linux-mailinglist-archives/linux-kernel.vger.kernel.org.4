Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0546E664ECD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 23:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbjAJW3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 17:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjAJW3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 17:29:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A969660DF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 14:29:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29FE3618DC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 22:29:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBB3C433D2;
        Tue, 10 Jan 2023 22:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673389763;
        bh=cpgoneEESoOwYTW63FIfGWY9WzxbekrB8D55/b/kfIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kd4HGDcs9C0uAx6fe2A493YJOR7w9F4QlCL8Ku4XgZPEZP/jtG3FWIAUBpYqVNZe/
         eDkNZKNR5GxTsZivPORvZadd/r/UKYZjAoQZQLf+UHK8de0WnbOrp8B9zpKiv+7LhS
         BSGQM+SFRsOBxLpbWBpUTqNo9u1aWk2AGqI72jgK/1J5wk0M5nmdItfGgcLBRYk4bO
         7uu8SXKplxwOyDjET47CjR6ni5nonPFDCS65hO1tXZszrU94pXnwy9VmsRgVlgy3iJ
         qt2dKUEXvcwpygvNSTmGdlll+NMUghywsYzYqLNAvrjRYEa+U4zcXuUmIe+9i4Oh3t
         KWpvlT+jL5gJw==
Date:   Tue, 10 Jan 2023 22:29:18 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Vineet Gupta <vineetg@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        palmer@rivosinc.com, Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, Guo Ren <guoren@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>, linux@rivosinc.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] riscv: elf: add .riscv.attributes parsing
Message-ID: <Y73mvsYpEv8FxXPR@spud>
References: <20230110201841.2069353-1-vineetg@rivosinc.com>
 <Y73g/nkDe7Sfp9ps@spud>
 <dfffd3ab-d607-9b1f-92a5-24a798807849@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L63ZHz58XQpsN3NV"
Content-Disposition: inline
In-Reply-To: <dfffd3ab-d607-9b1f-92a5-24a798807849@rivosinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L63ZHz58XQpsN3NV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 10, 2023 at 02:16:58PM -0800, Vineet Gupta wrote:
> On 1/10/23 14:04, Conor Dooley wrote:
> > On Tue, Jan 10, 2023 at 12:18:41PM -0800, Vineet Gupta wrote:
> > > Reported-by: kernel test robot <lkp@intel.com>  # code under CONFIG_C=
OMPAT
> > You can drop this, even if it reported against a private branch AFAIU,
> > just like its complaints about patches. As Greg would say, LKP didn't
> > report a feature!
>=20
> OK. Personally I tend to add Tested-by (vs. Reported-by for the same
> reasons) to still give them the credit for finding some issue.
> I can certainly drop it.

What I've seen Greg say is that you don't add "Reported-by" if someone
tells you your patch doesn't compile, so why would you for the build
robots.

--L63ZHz58XQpsN3NV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY73mvgAKCRB4tDGHoIJi
0tZTAP99tuxoONk5ydeoUofcmIhHXlE5ss8pWF5xhgPOorhkbwD+KJmwouKAHnWD
UpDk8UVqqi884haUuMJ2BoA9BDW86w0=
=+V2V
-----END PGP SIGNATURE-----

--L63ZHz58XQpsN3NV--
