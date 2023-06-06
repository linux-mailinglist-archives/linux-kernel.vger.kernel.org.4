Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CCB72425E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237592AbjFFMjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236424AbjFFMjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:39:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED4910C7;
        Tue,  6 Jun 2023 05:38:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F956631F3;
        Tue,  6 Jun 2023 12:38:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282FEC433D2;
        Tue,  6 Jun 2023 12:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686055134;
        bh=GoKJVxcYM3YHiySYtc2j/jW2j5w+mMQPpCOboxsRxPU=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=lGSHh/YDw8plsHo5wOZlj1EQxELfL3PTQh/WV07BbL0uFWdlM0JEF46/CcGnwVQ/K
         LqYJt6fZrlaXq7IH+yBgXQ7rtwgN5KISl+/h+Fb26wxGcc2CmF9oxWQNVOVTrBElf3
         RU6Run6x5zS9vvMTkbM6oBaNGSl8Ssm/HUiDQAa9SjhnBJRWyo9oCSJKHAH/P4Jlh9
         kaBLG/8GZiVyzzo4/q7QaBXiIuv2BABcu42KuLVmbg7knjYQQpr6HGJOIUlAXouNyD
         E+xVSuCF4hCrZD/oHpfKU47NhWwRZoMie/6uiozSzsALHCfNOCtx92aEqRbd79IcQM
         rpQ/HisXAdQ7A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 06 Jun 2023 15:38:50 +0300
Message-Id: <CT5KNU3BZ71L.2S88IEDDT5AD9@suppilovahvero>
Cc:     <dhowells@redhat.com>, <dwmw2@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Franziska Naepelt" <franziska.naepelt@gmail.com>,
        "kernel test robot" <lkp@intel.com>
Subject: Re: [PATCH v2] certs/extract-cert: Fix checkpatch issues
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Franziska Naepelt" <franziska.naepelt@googlemail.com>,
        <keyrings@vger.kernel.org>
X-Mailer: aerc 0.15.2-33-gedd4752268b2
References: <20230601190508.56610-1-franziska.naepelt@gmail.com>
 <20230602085902.59006-1-franziska.naepelt@gmail.com>
In-Reply-To: <20230602085902.59006-1-franziska.naepelt@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Jun 2, 2023 at 11:59 AM EEST, Franziska Naepelt wrote:
> The following issues are fixed:
> - WARNING: Missing or malformed SPDX-License-Identifier tag
> - ERROR: trailing statements should be on next line
> - WARNING: braces {} are not necessary for single statement blocks
> - ERROR: space required before the open parenthesis '('
> - ERROR: code indent should use tabs where possible
> - WARNING: please, no spaces at the start of a line
> - WARNING: Missing a blank line after declarations
>
> Closes: https://lore.kernel.org/oe-kbuild-all/202306021040.UTvXfH5J-lkp@i=
ntel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202306021102.zQU95cMI-lkp@i=
ntel.com/
>

Remove the empty line.

> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>

Fixes tag?

> ---
> v2:
>  - revert noreturn changes to fix build issues
> ---
>  certs/extract-cert.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/certs/extract-cert.c b/certs/extract-cert.c
> index 70e9ec89d87d..96c0728bf4d1 100644
> --- a/certs/extract-cert.c
> +++ b/certs/extract-cert.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: LGPL-2.1
>  /* Extract X.509 certificate in DER form from PKCS#11 or PEM.
>   *
>   * Copyright =C2=A9 2014-2015 Red Hat, Inc. All Rights Reserved.
> @@ -63,7 +64,8 @@ static void drain_openssl_errors(void)
>
>  	if (ERR_peek_error() =3D=3D 0)
>  		return;
> -	while (ERR_get_error_line(&file, &line)) {}
> +	while (ERR_get_error_line(&file, &line))
> +		;
>  }
>
>  #define ERR(cond, fmt, ...)				\
> @@ -73,7 +75,7 @@ static void drain_openssl_errors(void)
>  		if (__cond) {				\
>  			err(1, fmt, ## __VA_ARGS__);	\
>  		}					\
> -	} while(0)
> +	} while (0)
>
>  static const char *key_pass;
>  static BIO *wb;
> @@ -107,7 +109,7 @@ int main(int argc, char **argv)
>  	if (verbose_env && strchr(verbose_env, '1'))
>  		verbose =3D true;
>
> -        key_pass =3D getenv("KBUILD_SIGN_PIN");
> +	key_pass =3D getenv("KBUILD_SIGN_PIN");
>
>  	if (argc !=3D 3)
>  		format();
> @@ -118,6 +120,7 @@ int main(int argc, char **argv)
>  	if (!cert_src[0]) {
>  		/* Invoked with no input; create empty file */
>  		FILE *f =3D fopen(cert_dst, "wb");
> +
>  		ERR(!f, "%s", cert_dst);
>  		fclose(f);
>  		exit(0);
> @@ -155,6 +158,7 @@ int main(int argc, char **argv)
>  			x509 =3D PEM_read_bio_X509(b, NULL, NULL, NULL);
>  			if (wb && !x509) {
>  				unsigned long err =3D ERR_peek_last_error();
> +
>  				if (ERR_GET_LIB(err) =3D=3D ERR_LIB_PEM &&
>  				    ERR_GET_REASON(err) =3D=3D PEM_R_NO_START_LINE) {
>  					ERR_clear_error();
>
> base-commit: 7877cb91f1081754a1487c144d85dc0d2e2e7fc4
> --
> 2.39.2 (Apple Git-143)

IMHO should be split to separate commits with fixes tags for
trackability sake.

My guess is that fixes tag is missing because this commit is
bundling a pile of stuff.

BR, Jarkko
