Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF69B7242F6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237404AbjFFMtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbjFFMtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:49:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EB210F1;
        Tue,  6 Jun 2023 05:48:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EA0E62A5D;
        Tue,  6 Jun 2023 12:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7718C433EF;
        Tue,  6 Jun 2023 12:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686055661;
        bh=zHzYsFuRhydM1KHHgL+12941nqdkCp9sMCoUeWC4ZGM=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=uo4GGGjXL0a2Yq3wxZ+Egc9JmtIyWkTxVSH664LwMjomhKR/+2+1iWCYkcv+7Xg1w
         C3wGuDkd1/b+IZPajhiUqtCM4R8Yy95VwuWSOJO1lJ40FmH6Pf/7lqbDWJUi3nujGb
         8aoO0Mu9VBN+uFSn7Fv/N2LG6Fl5HSeiYb4411hdx0EziNzLmKHNvyfjIZYSh7Rzw6
         fMQ0iyLN6WG8pxAC1z2Ytj35suQkSY8X9obIS71dPlMoAbnCTAVj1IooKYloLrWxbW
         FjP/1EUZGj2OfTzHOyliN8WGco658DT22cQMIGYaXc382NS83OzPY/5Acrpy5pDbYh
         HSgMtmMNMKtBQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 06 Jun 2023 15:47:37 +0300
Message-Id: <CT5KUK24BARQ.12FJ90WR1XUAX@suppilovahvero>
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
 <CT5KS2NGSH54.58733YDNW3K0@suppilovahvero>
In-Reply-To: <CT5KS2NGSH54.58733YDNW3K0@suppilovahvero>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Jun 6, 2023 at 3:44 PM EEST, Jarkko Sakkinen wrote:
> On Tue Jun 6, 2023 at 3:38 PM EEST, Jarkko Sakkinen wrote:
> > On Fri Jun 2, 2023 at 11:59 AM EEST, Franziska Naepelt wrote:
> > > The following issues are fixed:
> > > - WARNING: Missing or malformed SPDX-License-Identifier tag
> > > - ERROR: trailing statements should be on next line
> > > - WARNING: braces {} are not necessary for single statement blocks
> > > - ERROR: space required before the open parenthesis '('
> > > - ERROR: code indent should use tabs where possible
> > > - WARNING: please, no spaces at the start of a line
> > > - WARNING: Missing a blank line after declarations
> > >
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202306021040.UTvXfH5J-l=
kp@intel.com/
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202306021102.zQU95cMI-l=
kp@intel.com/
> > >
> >
> > Remove the empty line.
> >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
> >
> > Fixes tag?
> >
> > > ---
> > > v2:
> > >  - revert noreturn changes to fix build issues
> > > ---
> > >  certs/extract-cert.c | 10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/certs/extract-cert.c b/certs/extract-cert.c
> > > index 70e9ec89d87d..96c0728bf4d1 100644
> > > --- a/certs/extract-cert.c
> > > +++ b/certs/extract-cert.c
> > > @@ -1,3 +1,4 @@
> > > +// SPDX-License-Identifier: LGPL-2.1
> > >  /* Extract X.509 certificate in DER form from PKCS#11 or PEM.
> > >   *
> > >   * Copyright =C2=A9 2014-2015 Red Hat, Inc. All Rights Reserved.
> > > @@ -63,7 +64,8 @@ static void drain_openssl_errors(void)
> > >
> > >  	if (ERR_peek_error() =3D=3D 0)
> > >  		return;
> > > -	while (ERR_get_error_line(&file, &line)) {}
> > > +	while (ERR_get_error_line(&file, &line))
> > > +		;
> > >  }
> > >
> > >  #define ERR(cond, fmt, ...)				\
> > > @@ -73,7 +75,7 @@ static void drain_openssl_errors(void)
> > >  		if (__cond) {				\
> > >  			err(1, fmt, ## __VA_ARGS__);	\
> > >  		}					\
> > > -	} while(0)
> > > +	} while (0)
> > >
> > >  static const char *key_pass;
> > >  static BIO *wb;
> > > @@ -107,7 +109,7 @@ int main(int argc, char **argv)
> > >  	if (verbose_env && strchr(verbose_env, '1'))
> > >  		verbose =3D true;
> > >
> > > -        key_pass =3D getenv("KBUILD_SIGN_PIN");
> > > +	key_pass =3D getenv("KBUILD_SIGN_PIN");
> > >
> > >  	if (argc !=3D 3)
> > >  		format();
> > > @@ -118,6 +120,7 @@ int main(int argc, char **argv)
> > >  	if (!cert_src[0]) {
> > >  		/* Invoked with no input; create empty file */
> > >  		FILE *f =3D fopen(cert_dst, "wb");
> > > +
> > >  		ERR(!f, "%s", cert_dst);
> > >  		fclose(f);
> > >  		exit(0);
> > > @@ -155,6 +158,7 @@ int main(int argc, char **argv)
> > >  			x509 =3D PEM_read_bio_X509(b, NULL, NULL, NULL);
> > >  			if (wb && !x509) {
> > >  				unsigned long err =3D ERR_peek_last_error();
> > > +
> > >  				if (ERR_GET_LIB(err) =3D=3D ERR_LIB_PEM &&
> > >  				    ERR_GET_REASON(err) =3D=3D PEM_R_NO_START_LINE) {
> > >  					ERR_clear_error();
> > >
> > > base-commit: 7877cb91f1081754a1487c144d85dc0d2e2e7fc4
> > > --
> > > 2.39.2 (Apple Git-143)
> >
> > IMHO should be split to separate commits with fixes tags for
> > trackability sake.
> >
> > My guess is that fixes tag is missing because this commit is
> > bundling a pile of stuff.
>
> Why? I mean I do get it might sound cutting hairs, so here's a
> big longer explanation.
>
> When you look up for a victim commit for a bug that actually screws up
> run-time behaviour in a way or another, exactly these "random selection
> of fixes" really can make you use an inappropriate vocabulary, and you
> *really* have to meditate not to spill that garbage online :-)
>
> Exactly because of this carefully localized fixes are very important.
> If you don't do it, your fix is counter-productive for the codebase
> IMHO.

... not to mention downstream distribution kernels. We maintain upstream
and do not obviously proactively support downstream *but* at the same
time we probably do not want to make backporting bug fixes more
difficult than it is necessary.

BR, Jarkko
