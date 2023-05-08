Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F43A6FA525
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 12:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbjEHKGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 06:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbjEHKGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 06:06:20 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155333045F;
        Mon,  8 May 2023 03:06:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QFH4M0Z2Bz4xFl;
        Mon,  8 May 2023 20:06:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1683540371;
        bh=iG4/ggrGUZ33mm9T7YnbjdIvs0uUU/Bf2drpkukMexk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QmdgbtMevYUUuJYndcVPHsU3t5jwiZ0+0FJdYsmIHXQsPd5E+mGsuaW6l3vFw1MJn
         4ZkuSDy7cNVCXFrZI7sNBI6Sd3Vj6Uo5PN0yz4T5W3FysbMvkgYL0W+R7Mo6oBLRlH
         3WMgyHAGDpu5zYuBUAqdxkq3KyKbm2VwBCtucqmOP/4DlLHEoLHEjY/lnTg2+fCk+D
         4ZYT/hFAS0PwWzbTqi1pFUfxowZTwXfWOeNVlaCJgUbfLvrJKifPCYnKgEDpiJTel5
         JD+Iy2u+STU8ykzfSnx5SYmtyajFvYKbpdjfBUVPfIZdwl2246CmNdwjtjzwjCLaNQ
         Cg8gEdXXSMx4w==
Date:   Mon, 8 May 2023 20:06:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: linux-next: Tree for May 8
Message-ID: <20230508200609.5b970ba8@canb.auug.org.au>
In-Reply-To: <20230508142728.1aeecbd3@canb.auug.org.au>
References: <20230508142728.1aeecbd3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LYJW2Pd5ubzsQUFi00YpRO+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LYJW2Pd5ubzsQUFi00YpRO+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

A big thank you to Mark Brown for once again shouldering the burden
while I was off having a good time.

--=20
Cheers,
Stephen Rothwell

--Sig_/LYJW2Pd5ubzsQUFi00YpRO+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRYyZEACgkQAVBC80lX
0GwChwf+KTIJAzYhdYMQIQwt15Dyk198MIia9iC8lHiUAwTh6taGj9kcgv7hBL2w
NKnVC5FhWGTXaRdPbc6Oir9WeqG0bzOWjeg2UbQlI1keTO+OKKMrD2fWHNdjcjs8
+ZLIjiUL80hfn61BOSeNMINsk2/jWlhNegjJ1JaNRqalvSLSHBkGezxTosJbwpzl
4B40a54m8kf1oGOY6TG080KQTdD+oEEn9EO8fIK2qRtK4ZhsJH+P9/7FMpFEb3+b
z15yPYNr653RBWA6Pg4eOB7K9UfyUb5EoQtzR9VbtRINxbG8bimA0IB9AiA87hxO
53AUDigQt8YezjzxHmCSzk3J9kiiRg==
=KMVy
-----END PGP SIGNATURE-----

--Sig_/LYJW2Pd5ubzsQUFi00YpRO+--
