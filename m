Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F05D5FCF0E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 01:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiJLXvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 19:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJLXvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 19:51:46 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A3165E6;
        Wed, 12 Oct 2022 16:51:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MnqDt5cqQz4xFy;
        Thu, 13 Oct 2022 10:51:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665618703;
        bh=dA8N37bFNWFPlabux+qKnWL1WSocYHM/0YwOZ0ddJnE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FoCqE5d/57cyWyKoKo9g9WKZ1J2Te/XhM3+6ZNND/H5+4V9JBTiswdbAL1UFFNpn7
         0NIFPsp8X/EZ4CYyzQdCs2e3LfoVdEQpkJxfDiqEwLF3Z/68Eo0/mQX+Rz4230PHA5
         JZnaiiyK/oO+nORxTDRbxeYM3OyhGWwS3DKqwnZi7F4vgbt7MekraFBVZ2SQMqapr8
         GBSvpg/l+oMKIpyaU0YUvm5gysJIopy+gqHp5aJYqBHJvRPTiF7hNZKHWPz2WJmwv4
         XscHo+LddSOV3yqnUxLZ+RgfKeR7vtZgatk5nnJv1remZUv3IjMq8y1pEOdiC2B/d9
         7gotSnaR2gMqw==
Date:   Thu, 13 Oct 2022 10:51:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Jun Lei <Jun.Lei@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Zeng Heng <zengheng4@huawei.com>,
        Wenjing Liu <Wenjing.Liu@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kbuild tree
Message-ID: <20221013105140.338004f3@canb.auug.org.au>
In-Reply-To: <CAK7LNASCFVxGV0e1DbnJzrtRJs_iuMsL6Q-2oxpoRMaSK5U1ZA@mail.gmail.com>
References: <20221013091722.72263dca@canb.auug.org.au>
        <CAK7LNASCFVxGV0e1DbnJzrtRJs_iuMsL6Q-2oxpoRMaSK5U1ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/84WFYVdkPpKiE+9b8Iu1766";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/84WFYVdkPpKiE+9b8Iu1766
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

On Thu, 13 Oct 2022 07:34:21 +0900 Masahiro Yamada <masahiroy@kernel.org> w=
rote:
>
> Or, if it is not too late,
> can you revert only commit 61168a974a16?

Sorry, too late.

--=20
Cheers,
Stephen Rothwell

--Sig_/84WFYVdkPpKiE+9b8Iu1766
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNHUw0ACgkQAVBC80lX
0Gxegwf9Ebw/0CUy91lzkdngxdYHOoo9j/LvTZiQwNAN2yKhD/MrPg9j4EoRfBjg
wIL1w/Nqhmk1IzamH5WtkPedBKfSmxB2hbJdRIw3d0J0ZbpI3iaTaECTjfza1SXX
AV7oApluGksD2HKdmjEurzmNd5NOpecKtqOMPG/MwnGEGYi1M5Tkqm6QiDFaeMZk
ynvezRchoCxCw7UGlVo+Yy63BWIeTTldiZLPh9YrZJKwsvsz3R7qGyBuDk/12i4B
4UJdV1KKT/dg2HWKYorzCe6OKOUB9SU3w4g2YHXhM5W3FPT1fHjX/wz4RvgtsA71
bjuZEdfDDggkz/Ii85CWr/1ZT7Z+SA==
=IV05
-----END PGP SIGNATURE-----

--Sig_/84WFYVdkPpKiE+9b8Iu1766--
