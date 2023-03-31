Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21B76D1553
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 03:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjCaBsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 21:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjCaBsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 21:48:30 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F665768C;
        Thu, 30 Mar 2023 18:48:02 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pnjq34l0hz4x4r;
        Fri, 31 Mar 2023 12:47:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680227280;
        bh=U8nCrbVruhyvA7LfoiI3ZeZd7L605M5xPTJX1LcWDvg=;
        h=Date:From:To:Cc:Subject:From;
        b=DSGAMbkU2eoyVlZFdFJxBqvwjiazQmM2NlAN+vxgsL3uKdYsz72TGoX3nC7NQJTTw
         tZw3G0RFl8mlRTRB0Ts5zxNFqMId7hBG9MnGydGaccORoT5EeUmnSXWXDZln4ftBab
         Te7SuNKzdJSw3eWXUMhra31fs1CMcc1F/r0YhK0yEWkVkfBeKEGvK+E0lZrEJMykpc
         5CGHTxmFFsvaptxYyAP0w+clrj9DX2KMBgptQShJ118y8ZypkfNky2vqLvCGqjBXoM
         zKWnM1nl15GZqT5mEQ77kSmiyxIz6LG50/K1lC31hWJGF4b3L9YP1nJ0uxT6a6d+Pa
         QbtPi7gYYWc9Q==
Date:   Fri, 31 Mar 2023 12:47:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: linux-next: manual merge of the devicetree tree with the sound-asoc
 tree
Message-ID: <20230331124758.501257d7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WLD4kryHRjB6dvur894ssH9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WLD4kryHRjB6dvur894ssH9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the devicetree tree got a conflict in:

  Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml

between commit:

  cfad817095e1 ("ASoC: dt-bindings: qcom,lpass-va-macro: Add missing NPL cl=
ock")

from the sound-asoc tree and commit:

  d0dcd0ce8437 ("dt-bindings: yamllint: Require a space after a comment '#'=
")

from the devicetree tree.

I fixed it up (the former removed the text updated by the latter) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/WLD4kryHRjB6dvur894ssH9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQmO84ACgkQAVBC80lX
0GyfkAgAi7KhLv8weXSBkpBmVzrxyT6MIri4YbLfUstlypFfa9oD92yiAfxhgDMJ
CD3zyv31ymKEz2rictxQZmno5NGApP39qogH9B2ZXhGIPzQycaxSnVLIQSbzjmKB
3i0Csfj8hW9n8sDtnXrwR8H2hjRnQRvWoVXauS1diuKSYQ+sW+qfAv4BVYfpxc45
npU7ThifMM0LOg+zD8+zQViEOGyFvvYJji7GOXHGEw2oGMNEcisSw6Kib1LvHVdC
PHhOG56sbjOQq/+Etfm8iv9bOlgt+Phwzkv2jgCTImro5+ff9BVmlOcpuEdLulzX
7a9UxK/cmCdoCAP0nNGbVo6/L9/h5A==
=HFmQ
-----END PGP SIGNATURE-----

--Sig_/WLD4kryHRjB6dvur894ssH9--
