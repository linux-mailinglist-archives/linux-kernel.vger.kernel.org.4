Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C8164E5C2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 02:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiLPBqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 20:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiLPBqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 20:46:34 -0500
Received: from gimli.rothwell.id.au (unknown [IPv6:2404:9400:2:0:216:3eff:fee1:997a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C952A426;
        Thu, 15 Dec 2022 17:46:32 -0800 (PST)
Received: from authenticated.rothwell.id.au (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.rothwell.id.au (Postfix) with ESMTPSA id 4NYBll2R82z10HZ;
        Fri, 16 Dec 2022 12:46:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rothwell.id.au;
        s=201702; t=1671155187;
        bh=9/aAi7fDVvA/r5A4As2SXirPHvy9OT15x/T7Wq5p0Rg=;
        h=Date:From:To:Cc:Subject:From;
        b=X0+vDVXQZl5FkuCjLJlbR95OrqWgJjUguzGfpF+g8b0PaMA5hFMhYzy80+rRKWFW/
         RbFpUtbOaefs7P9B1qL3llKXEj3w2/HtiV+ZTfOs68HdY5Vtf4OQjr963YIKEsKxGo
         hoWf9yWDIiFefmEX9y/zhoFNoqZvSHg7R5UikcWw2klJDam3IeNP27+252Bsyj3V/5
         cZW7pDumKfksnmVQraRmXitYJDIXWnFcsSKrPDh73wqxbDPQZLwGd9wSrnaOZKl1m+
         aiO/qOt99vbon0p5WsG8wf21UZmpUXKRpwWIqa+nX8UbjfdLt3Kme3UKsw54dNSbJO
         aWp76bHdol2nQ==
Date:   Fri, 16 Dec 2022 12:46:26 +1100
From:   Stephen Rothwell <sfr@rothwell.id.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: linux-next: taking a break
Message-ID: <20221216124626.0dd8cb83@oak.ozlabs.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/M=kVcXxnFpw4p_SioxmHYWg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOCALPART_IN_SUBJECT,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/M=kVcXxnFpw4p_SioxmHYWg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

There will be no linux-next releases between Dec 21 and Jan 4, inclusive.

Mark: Thanks you for your help during the year, but I don't think you
need to bother this time - I assume you would like a break as well :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/M=kVcXxnFpw4p_SioxmHYWg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmObzfIACgkQAVBC80lX
0Gwcegf+Pkei/s/4owrtlhm4RnSof8NQc2k/afl89uynj6LZchzOvm6USRBfJVfU
mghfI+B+61sAZ3ys1oUuBf9WSg8YXMCq2IawJ90INANLoEVToNUtlWfRKkn8IqD9
kfrtLPup56T2WDrfhR1/u/CEwkkd+EZF5dIMZDeFqeEOE0GqDENShokHxapGlWCA
SSrHcFN797hMv0lVU0xXqazBKZcJdKcFu0GI3tKtw7BB1KVEiQ3fgf6iisDjKsS1
BdtIc40xVKEGaK6gDMHQewjIVXILLfx7VhsZqymMtNe8B55k/wBfT5AkWUujI8xS
n5FXaGWWOizCJkb2KQfr/P8FwzxNGg==
=asax
-----END PGP SIGNATURE-----

--Sig_/M=kVcXxnFpw4p_SioxmHYWg--
