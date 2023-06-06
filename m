Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C94B7242E4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237852AbjFFMqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237816AbjFFMpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:45:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA9E173C;
        Tue,  6 Jun 2023 05:44:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2278963207;
        Tue,  6 Jun 2023 12:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F368C4339B;
        Tue,  6 Jun 2023 12:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686055467;
        bh=GEm+xf3ce2OKj8R7S/U1053Z3tc2TuVZlMfIaUVKtlg=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=SaMeeBiQDG9oRGq7FnaRswrYuH/4QgKPfeXXRastnUyhUVNsM3uB+TBhxalNEWFWw
         DXmJT1w1cxFXRclVI75ePZ6369Q+s6XZIWmefbmjE76kvHpL55ItIistaKTHa9rDg8
         D4Ix294DmiBz+lTFPNsXcVbb7iKeNZvQN+2afoy4ix/I1bN09eYqmWA7XQiF74WmZ1
         GYVg0W6yzLAmVPW87GpFlj63VZBcU+NQDBAuyxtyyA1dyXQU4p3RrS0eJFmYDYEopc
         Gpd+wRbQBySAZqVflmc9LRglK4ubpqQNHeN/Jfy9onCeClQVLXXQN3KAiY7k4Nz1Ke
         f7Noe+5V0tt2Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 06 Jun 2023 15:44:22 +0300
Message-Id: <CT5KS2NGSH54.58733YDNW3K0@suppilovahvero>
Cc:     <dhowells@redhat.com>, <dwmw2@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Franziska Naepelt" <franziska.naepelt@gmail.com>,
        "kernel test robot" <lkp@intel.com>
Subject: Re: [PATCH v2] certs/extract-cert: Fix checkpatch issues
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jarkko Sakkinen" <jarkko@kernel.org>,
        "Franziska Naepelt" <franziska.naepelt@googlemail.com>,
        <keyrings@vger.kernel.org>
X-Mailer: aerc 0.15.2-33-gedd4752268b2
References: <20230601190508.56610-1-franziska.naepelt@gmail.com>
 <20230602085902.59006-1-franziska.naepelt@gmail.com>
 <CT5KNU3BZ71L.2S88IEDDT5AD9@suppilovahvero>
In-Reply-To: <CT5KNU3BZ71L.2S88IEDDT5AD9@suppilovahvero>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Jun 6, 2023 at 3:38 PM EEST, Jarkko Sakkinen wrote:
> On Fri Jun 2, 2023 at 11:59 AM EEST, Franziska Naepelt wrote:
> > The following issues are fixed:
> > - WARNING: Missing or malformed SPDX-License-Identifier tag
> > - ERROR: trailing statements should be on next line
> > - WARNING: braces {} are not necessary for single statement blocks
> > - ERROR: space required before the open parenthesis '('
> > - ERROR: code indent should use tabs where possible
> > - WARNING: please, no spaces at the start of a line
> > - WARNING: Missing a blank line after declarations
> >
> > Closes: https://lore.kernel.org/oe-kbuild-all/202306021040.UTvXfH5J-lkp=
@intel.com/
> > Closes: https://lore.kernel.org/oe-kbuild-all/202306021102.zQU95cMI-lkp=
@intel.com/
> >
>
> Remove the empty line.
>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
>
> Fixes tag?
>
> > ---
> > v2:
> >  - revert noreturn changes to fix build issues
> > ---
> >  certs/extract-cert.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/certs/extract-cert.c b/certs/extract-cert.c
> > index 70e9ec89d87d..96c0728bf4d1 100644
> > --- a/certs/extract-cert.c
> > +++ b/certs/extract-cert.c
> > @@ -1,3 +1,4 @@
> > +// SPDX-License-Identifier: LGPL-2.1
> >  /* Extract X.509 certificate in DER form from PKCS#11 or PEM.
> >   *
> >   * Copyright =C2=A9 2014-2015 Red Hat, Inc. All Rights Reserved.
> > @@ -63,7 +64,8 @@ static void drain_openssl_errors(void)
> >
> >  	if (ERR_peek_error() =3D=3D 0)
> >  		return;
> > -	while (ERR_get_error_line(&file, &line)) {}
> > +	while (ERR_get_error_line(&file, &line))
> > +		;
> >  }
> >
> >  #define ERR(cond, fmt, ...)				\
> > @@ -73,7 +75,7 @@ static void drain_openssl_errors(void)
> >  		if (__cond) {				\
> >  			err(1, fmt, ## __VA_ARGS__);	\
> >  		}					\
> > -	} while(0)
> > +	} while (0)
> >
> >  static const char *key_pass;
> >  static BIO *wb;
> > @@ -107,7 +109,7 @@ int main(int argc, char **argv)
> >  	if (verbose_env && strchr(verbose_env, '1'))
> >  		verbose =3D true;
> >
> > -        key_pass =3D getenv("KBUILD_SIGN_PIN");
> > +	key_pass =3D getenv("KBUILD_SIGN_PIN");
> >
> >  	if (argc !=3D 3)
> >  		format();
> > @@ -118,6 +120,7 @@ int main(int argc, char **argv)
> >  	if (!cert_src[0]) {
> >  		/* Invoked with no input; create empty file */
> >  		FILE *f =3D fopen(cert_dst, "wb");
> > +
> >  		ERR(!f, "%s", cert_dst);
> >  		fclose(f);
> >  		exit(0);
> > @@ -155,6 +158,7 @@ int main(int argc, char **argv)
> >  			x509 =3D PEM_read_bio_X509(b, NULL, NULL, NULL);
> >  			if (wb && !x509) {
> >  				unsigned long err =3D ERR_peek_last_error();
> > +
> >  				if (ERR_GET_LIB(err) =3D=3D ERR_LIB_PEM &&
> >  				    ERR_GET_REASON(err) =3D=3D PEM_R_NO_START_LINE) {
> >  					ERR_clear_error();
> >
> > base-commit: 7877cb91f1081754a1487c144d85dc0d2e2e7fc4
> > --
> > 2.39.2 (Apple Git-143)
>
> IMHO should be split to separate commits with fixes tags for
> trackability sake.
>
> My guess is that fixes tag is missing because this commit is
> bundling a pile of stuff.

Why? I mean I do get it might sound cutting hairs, so here's a
big longer explanation.

When you look up for a victim commit for a bug that actually screws up
run-time behaviour in a way or another, exactly these "random selection
of fixes" really can make you use an inappropriate vocabulary, and you
*really* have to meditate not to spill that garbage online :-)

Exactly because of this carefully localized fixes are very important.
If you don't do it, your fix is counter-productive for the codebase
IMHO.

BR, Jarkko
