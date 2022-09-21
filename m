Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD3A5BF5D9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 07:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiIUFUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 01:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiIUFUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 01:20:17 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A561DA63;
        Tue, 20 Sep 2022 22:20:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MXRZ71Fdxz4xGG;
        Wed, 21 Sep 2022 15:20:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663737615;
        bh=5ykawb32eUwAkasQdnjCXd2Izlanf6Q57xiRbwT8oD0=;
        h=Date:From:To:Cc:Subject:From;
        b=QXYhmJcTXmUBRq7Jvqi0ISp1xDhCD+qB4mMmj+epT56jm8kT3OJioSuI9wmbHR5G/
         9liFNFV6SSSdH8PuOe31CL9Yj/Rzuif84ABDfOipQyzclQpllh1d9P5iDpxF4AL6or
         M9siWXDoXYKuNjifzERPGf8a4n+mFgGh5H7LnSIDZqUt7fCuCbpQhTRIpijMpPJFrj
         Qc+U50jsCZD+QuD1XDM2FMRugoD+CFWJvdIWCtuU0UzmK3FZWpqDrTzUPo6Q3dvCV6
         kOFZI2N5xCVB5847U2UBxbP3Nwi+fB7zGUJTdWJTIp2Wvq7B+B8cjnNhOrdgk4LswC
         nBGpUmwNp/PHQ==
Date:   Wed, 21 Sep 2022 15:20:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: linux-next: manual merge of the soundwire tree with Linus' tree
Message-ID: <20220921152013.2cffcf42@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NvcAsUE2FnweYF6OhaOesF=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NvcAsUE2FnweYF6OhaOesF=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the soundwire tree got a conflict in:

  drivers/soundwire/qcom.c

between commit:

  4ef3f2aff126 ("soundwire: qcom: fix device status array range")

from Linus' tree and commits:

  8039b6f3e5c7 ("soundwire: qcom: update status from device id 1")
  ed8d07acec73 ("soundwire: qcom: do not send status of device 0 during ale=
rt")

from the soundwire tree.

I fixed it up (I used the latter) and can carry the fix as necessary.
This is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/NvcAsUE2FnweYF6OhaOesF=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMqnw0ACgkQAVBC80lX
0GznvQf/fGiI++ydJ4a1cmdSzCBYlI0yMpIZILMCu1mEPdQPt7DIYBGBqhLNt405
1k+nyFJYV9D8uzjXmVqvcJ8HEjhMK6LmYCsUYNsShrt2x0wPg/FycLXGsIrOjXx9
NNDxcjxhnMci6TcNPeJwJRKg07N294ZOLQbeR+2Ms2zNH5QYG8e24dS6S1rzBLBA
wWm28MyuCIKPWV4SO+tNKEWePWSbSq6fJ49G7AaB2XE7j1S0otV6eMmdEGJrL77J
raypvng1UZucP/W7AGJFSWhsuFaqkeUEpHteHEc06zl4Az7o+ekukAwffEHW1zpL
I5q6Mb1fhoWKsN2SyMtY0u+K7nNsxA==
=lML6
-----END PGP SIGNATURE-----

--Sig_/NvcAsUE2FnweYF6OhaOesF=--
