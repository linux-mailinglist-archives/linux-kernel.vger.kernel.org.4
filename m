Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69656B1486
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCHVyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCHVyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:54:20 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8763AA103B;
        Wed,  8 Mar 2023 13:54:18 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PX5gX4xKrz4xDr;
        Thu,  9 Mar 2023 08:54:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678312456;
        bh=yJm+Ip1EhdItp6u14zwPrUZNA7hnWdOqeBiQzwKd7oc=;
        h=Date:From:To:Cc:Subject:From;
        b=OF9IuN7MWWsu9TJCIc0RSIfVuY2s0UwcqzIRV1SXiE0Czpi8fPE2G7T2okyYCfSzN
         wYV+FiNdkAB122A0ZFZ0TrS3TccPDGSbuLUoLX1YrmuCEWGAVCmsDP0FBgxrqG6rg6
         ZsuvVj/tlI+Xw5EQGG5mUwRoZwIqB5tnAFge4ImNVQkZoGhHXLUOQHTCUFki2UcpwF
         oUq4T6sYvyWKw5Lu8wQ5mSDjnWWKQbaKiYI6QLLnRUBsV/y7AT7gznhxkwTebIymhT
         AKIMZk2tlWAejHXvmAWA0CEVOTAgAbKWKKipaJ353RtaP4I5BIoSLXOmmB+XPc2l19
         TDgcZ6xx9jHoQ==
Date:   Thu, 9 Mar 2023 08:54:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Simon Horman <horms@verge.net.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: error while fetching the ipvs-next tree
Message-ID: <20230309085415.0b738f0a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6LrLnrRKW222J/UTkdhzwyw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6LrLnrRKW222J/UTkdhzwyw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Attempting to fetch the ipvs-next tree
(git://git.kernel.org/pub/scm/linux/kernel/git/horms/ipvs-next.git#master)
today produces this error:

fatal: couldn't find remote ref refs/heads/master

Should I switch to using the "main" branch?

I also notice thet the ipvs tree
(git://git.kernel.org/pub/scm/linux/kernel/git/horms/ipvs.git) has both a
"master" and "main" branch.  Should I be using "main" there as well?

--=20
Cheers,
Stephen Rothwell

--Sig_/6LrLnrRKW222J/UTkdhzwyw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQJBAcACgkQAVBC80lX
0Gxx6Qf/QDSQEldUdrn3BI0f87Vk+Tu+GjdXVyrrelDJoPNWo7DDNXdRjcomJW5V
faw79Ui1NlJsKwJOkRdQ0MkEWL4UBc2Wka6TusllNSlzqWhXEvVwYIYJUDUg6B3D
aw61b/0Wjp/Rm8xInDf2tl/GL0rbDFEQWYm0DtnVXdmIvHausijoDVlHjvPoO29C
UFTG72NC4duBaCVq+YuAe1Ky05N1NnMEkGZ7XEEjCIO/jaQQRxswIJd1Yepfg3ev
Hi3xLZBvM2W74S8Yhw4aPCgiC2DlHure5n7RC+8aOf+uJz/T+jgP9NHV0h5wRuwt
F/3fdkmq3gJAWeghNc1A/R1TU/paMw==
=LcQh
-----END PGP SIGNATURE-----

--Sig_/6LrLnrRKW222J/UTkdhzwyw--
