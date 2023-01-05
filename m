Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2528565E34A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 04:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjAEDNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 22:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjAEDNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 22:13:30 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C1B48596;
        Wed,  4 Jan 2023 19:13:28 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NnWkt6YPyz4xxJ;
        Thu,  5 Jan 2023 14:13:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1672888407;
        bh=cHSTg9Lf9GH2ynCxm+T65kJGJvNtAd60OzH1FTpkzbo=;
        h=Date:From:To:Cc:Subject:From;
        b=pSbD9Zpc/B6fMQg28/nQEXoE37H54SJSROqT6ZOtmXwOWCWMX7FYcer+pn8TYYSpY
         wDA52pZb1Y5xy2DEjPVrjtFcU+LVjVQpqUA/if5lTK7yEW51AmF5CYHR/AK58Q3uZT
         GOKP648I9TUtmXN+vl4tJvXy+trCpFSXJlu2rW87EiLTz9x/+mTL+OOOfSK9rjF2oO
         REMXznomtXDzIXrdkSsX3Xwv53UP9kBLnjPB6h+qzRxieXgAQVR4gPqV2cp1ay52NF
         ZMMmsde2OCTeLgMV5wjsrVpVFjTa9vZaolZFD2dB5gxJ6AErTvliHuOnNc5mF27Kxj
         zQhpVVC5xvTjA==
Date:   Thu, 5 Jan 2023 14:13:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the qcom tree
Message-ID: <20230105141326.5e339f2b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/y+L9tox/4Ba+jpd8AN+viZ8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/y+L9tox/4Ba+jpd8AN+viZ8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the qcom tree, today's linux-next build (htmldocs) produced
these warnings:

Documentation/ABI/testing/debugfs-driver-dcc:34: ERROR: Unexpected indentat=
ion.
Documentation/ABI/testing/debugfs-driver-dcc:34: ERROR: Unexpected indentat=
ion.
Documentation/ABI/testing/debugfs-driver-dcc:34: WARNING: Block quote ends =
without a blank line; unexpected unindent.
Documentation/ABI/testing/debugfs-driver-dcc:34: WARNING: Block quote ends =
without a blank line; unexpected unindent.
Documentation/ABI/testing/debugfs-driver-dcc:34: ERROR: Unexpected indentat=
ion.
Documentation/ABI/testing/debugfs-driver-dcc:34: WARNING: Block quote ends =
without a blank line; unexpected unindent.
Documentation/ABI/testing/debugfs-driver-dcc:34: ERROR: Unexpected indentat=
ion.
Documentation/ABI/testing/debugfs-driver-dcc:34: WARNING: Block quote ends =
without a blank line; unexpected unindent.

Introduced by commit

  4cbe60cf5ad6 ("soc: qcom: dcc: Add driver support for Data Capture and Co=
mpare unit(DCC)")

--=20
Cheers,
Stephen Rothwell

--Sig_/y+L9tox/4Ba+jpd8AN+viZ8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO2QFYACgkQAVBC80lX
0GwAqQf+M1YUN7+aV8FKTFohuMC1s25LLbAABrOKG4s22PdOx8pcQq3ISi38cW1w
WVDblK82WFWb4ysqNum//SQIPhs6JRt+0wBUpRy5ekkqnjs6K5fdEhSnAbcYmY3P
hE2hMDSVPYkOzSVgffu+7iRmS2WCC2tAwxnVSwxpaNKpGKktsyfjs7sqxoKDDttQ
YiQE5SNU3RuiCD7z5BzLPIfGUasag3mjbJc+6g1uaOrICOjq3o6B5CpOQrurrIQB
EuIwfxt/AJPEoZO+Sc3MjagwGPDL7V9ScgIjwS/aa/Q376i+ZWEiv2nGLEgKtv1T
O3icHdSPN8GkJuqKPnBe8BVKn9F48Q==
=A7ek
-----END PGP SIGNATURE-----

--Sig_/y+L9tox/4Ba+jpd8AN+viZ8--
