Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0BA65E305
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 03:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjAECuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 21:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAECuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 21:50:50 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFFB43A22;
        Wed,  4 Jan 2023 18:50:49 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NnWDm36F8z4xyY;
        Thu,  5 Jan 2023 13:50:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1672887048;
        bh=bo8FhcCljF4EXe+kC7VoMTatRXA6FitRhpQlJTwavMI=;
        h=Date:From:To:Cc:Subject:From;
        b=fxDMzkLumhxVvNExwAQnxsnAVJARheJOR0ioyxqkbdwkBB1xtOZ9cys1VNotU0jcI
         FEugp7+Kxg4sJZWFpe0G/q/NuxVOkCTXQs1T4NnmHI/OCfu4U58Idr3Ua1yO3KLz/M
         a7P9u2S6F1UaYaNl44tc6uSE7gKuycFHlCCwKJUxxS6HcSxudueC3Kk90gUhLGgvZG
         Vz2gjRl1sJaVMEckK5NuCcPKZAUD1DEFtwuwhQV2Q8cUgv5j/UmHAP7FAWirIbUa/Z
         Pxf6OVkyDs2uzHm0GHdyI/0p7nWdgng1LZ3ciyz5+XgBnRkntmxuDdRFHbGwjtz4o+
         oJit57Iz4aAxA==
Date:   Thu, 5 Jan 2023 13:50:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Rob Herring <robherring2@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the mm tree
Message-ID: <20230105135047.686a1753@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=/U1wvr6BC+EFU+1aQIduWJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=/U1wvr6BC+EFU+1aQIduWJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  afcd2f4f5629 ("of: overlay: fix trivial typo")

also exists in the devicetree tree as commit

  8e5d0c68f23a ("of: overlay: Fix trivial typo")

--=20
Cheers,
Stephen Rothwell

--Sig_/=/U1wvr6BC+EFU+1aQIduWJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO2OwcACgkQAVBC80lX
0Gxo6Af/TrgMIDdP7PjzqSVBNfYfNetKbzXBDniHQyS9HrUg3BkanTcDf8BZTCBU
zahso9OWtozrelgWoBV09mo6Bh7XF0R9yrs6J2Iro8HpvZoNBiLV14tBikFi8xBE
oyntoYLrBvz53eIBBEGaJQ9VALJP2VEzmcRaIg9xuJGsFKYecbOZAum70A0PVt4m
ILM8GcvAM+DYiDu7IZ531xNT3i9HcUnEGm9I9T3oR3tn/lEJLLpbL8WMQTI8OGi/
a7UtxvR0motsqpr2uYzZhCgS2ZsWhUpzG7WpuGoj+wyrlB2A3oBUSEuIEMW+Ae7f
XDVvdwln9eaN9QouRLdMYdXpAbBmOw==
=ZMxb
-----END PGP SIGNATURE-----

--Sig_/=/U1wvr6BC+EFU+1aQIduWJ--
