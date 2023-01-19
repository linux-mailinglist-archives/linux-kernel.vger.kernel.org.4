Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B21673182
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 07:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjASGEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 01:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjASGEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 01:04:15 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766D4654CB;
        Wed, 18 Jan 2023 22:04:11 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NyBsQ0wTpz4xFv;
        Thu, 19 Jan 2023 17:04:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674108250;
        bh=1dc5tTe/jqT/F5J+vlqFhjhos0sTYbJuV9GDAGKXGtY=;
        h=Date:From:To:Cc:Subject:From;
        b=sLm4IARmErbxEGmVrkF18oSLJVu24gzubpyMG2NNNwbt327xdFOwIv+2cemDoN++U
         OidNnBLFN4DfSJexJAl5a5yvooVHzA1L4nYlLFGVW+Wg5yHsgMTRj2Cyjt0rVhl/Y6
         LdDJ/vGRv3irQlL06NQ5ZAgHU5+Pf+4P4HcIVT8fBHA+LLQ7uU4S0BscDM8VYCtVsS
         HeUXkdpw5fqBLb2iriGVAvQ4HybHSv7oWDimhdTaI0J6gYQS7TrD6Cb2dOdvQNxQbL
         B9xbY7kPAekk+pwXbpLLbVx0HBP1J17EXptC9OBrxEfG5wmiWvbdNkj9yQBOlzJvWg
         0aArTfcDfwzuw==
Date:   Thu, 19 Jan 2023 17:04:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Gross <agross@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the qcom tree
Message-ID: <20230119170408.39061d06@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/S6G9Np6_4C/nG1dlC9CcXwc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/S6G9Np6_4C/nG1dlC9CcXwc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  0da2eff44e78 ("arm64: dts: qcom: sm8450: Allow both GIC-ITS and internal =
MSI controller")

Fixes tag

  Fixes: a11bbf6adef4 ("arm64: dts: qcom: sm8450: Use GIC-ITS for PCIe0 and=
 PCIe1")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: ff384ab56f16 ("arm64: dts: qcom: sm8450: Use GIC-ITS for PCIe0 and P=
CIe1")

--=20
Cheers,
Stephen Rothwell

--Sig_/S6G9Np6_4C/nG1dlC9CcXwc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPI3VgACgkQAVBC80lX
0GwFugf/WlFcKKaNnTA2rHCgb38kmZXtjxRcBOPSaM813VRIBdO5PGsgKybzok/O
yWyFoVnZOSOg1EeeP8jyUnXO9k2JddEKqpeYqe1ut+eQLL/I/JnZLkzY9mG6TVt9
YWGc4faY2aWUm9QelPAm3n6KXwFpTaiVMfQTCOFXndDdUwMoBRnc97ZWvHsOaWwh
bCFkAxDGNAY7Z6xGym8jfAi/9S0QRQYOKtPCA82m4DABsYkw1sj7mI0KGdGlqDc4
8OXV6sFDCUDBFnQjf6aV52/pUO/lVNwt97+Zc8Br5JH3g6ha+DZiXUhRnH+DvszU
22E40KNNgG8fPRmvFUyhVZkqhzd4tw==
=X/tF
-----END PGP SIGNATURE-----

--Sig_/S6G9Np6_4C/nG1dlC9CcXwc--
