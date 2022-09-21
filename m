Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59915BFEB9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 15:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiIUNNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 09:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiIUNNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 09:13:10 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5C382752;
        Wed, 21 Sep 2022 06:13:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MXf3k1QZlz4xG9;
        Wed, 21 Sep 2022 23:13:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663765986;
        bh=TeiuUTqhylaxbG26Vkxwskt7S9E7Di1Y1ogWtwqFpLI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WZ6Odkc8579eE9eGk1ygkEhagBvkolmEXkh4yV4z20KWP+FEExfT/X61ZaqgWra6Y
         8Cl0DwzcVgAbbTxWcHCbuONAWzWid+Fw8fR17N9uK9XGO/uSqCELIXr40bHdlCy/3D
         kTJ+/g2xfk4dF49aMtDx7GybVCH5jY1sYJQS9MbxuOnxpI0wisqTX0/bdImOdcKbu6
         GXGMeV+Hf+CzgQ6wE+hWf/FePcA/vnpkGDnxR7SQGKT9KEN8bzsyg4IBHYF90LwmlV
         ZtEhOCkQiIuo3kc5mvK9D3pQxaoSiaOwXmF3gXJFCUzOyf1oD8Ub0nx2zuxH+vd65U
         LtiB/ftAA1CuA==
Date:   Wed, 21 Sep 2022 23:13:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Sep 21
Message-ID: <20220921231304.5a5d0624@canb.auug.org.au>
In-Reply-To: <20220921185740.6e19ee1e@canb.auug.org.au>
References: <20220921185740.6e19ee1e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NPRJe6Mb+a72t65YBDPIDdX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NPRJe6Mb+a72t65YBDPIDdX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 21 Sep 2022 18:57:40 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Changes since 20220920:

I forgot to mention that there will be no linux-next release tomorrow
(while all Aussies remember their Queen) or next week.

--=20
Cheers,
Stephen Rothwell

--Sig_/NPRJe6Mb+a72t65YBDPIDdX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMrDeAACgkQAVBC80lX
0GyG6Qf+NEH4vx7QEhgPxHbWzjaK4uWsV8u9y+Pn/GS6UywukXIxjiFmRUm8cTUS
/MTNz9KH45sMriaAZzU1BnDmdq1nynw0cEW3yBYHQtOWJcQc3A9zz2IOSKVrlMvy
4qL/mNXu8RlVfpj4MVhzocKBCP3qYmgJ7jtauvI1iko1TR7YCsZKWMThwB3ZfWsF
GYWOCcZONFzUqf5L2PhgOL7lRFWPrO4iYJ8uaqJGIV2G3Dv2yVeXLlFepYTQ0Nw4
FY7rsN5HkBn94hn0lXUEN8yYmOZLZVZTfC7FGMsZv5OeOu6Xp7WDz4fi7IA/XtaA
otRoY5oSCmp/8GeBaY3/PEF+4tmQrQ==
=coar
-----END PGP SIGNATURE-----

--Sig_/NPRJe6Mb+a72t65YBDPIDdX--
