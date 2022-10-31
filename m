Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C18B61414D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJaXDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJaXDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:03:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1422E13D0E;
        Mon, 31 Oct 2022 16:03:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DFDE614E0;
        Mon, 31 Oct 2022 23:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FD8C433C1;
        Mon, 31 Oct 2022 23:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667257420;
        bh=vhAIFwd6AVcg9TvJkSBVEzUDWyNe6/dFjwB4YX0P1HA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ufLAtrQ8r2IQjgzoMHeW4VigYVfb/D/Y3zkKD0Q26Z7d4muDn7ykBk0TyJtp4Bfk8
         GZDLmb0a21FUSQi7ixzNiFSyTotz4ldFPutgBGXBsistLp7PedPbXyhpRWBiBO53f4
         PXyti+EJ3nEGT7vBLc1lU58u/+P1mmMQVOy9XifrvK2PgIctUaeYzdy0ewu8jo8A5h
         wS/0V8vNUv9uwnJS3rEX6dlGPC11xyInNLbVSCV1vf0WTgNv3hqL+MkRFOVKA2bItx
         3Gj83ZA3V3ayhR2x+Im4SzJIrcIZkpMMEJhhGsLZgQYhYjNpGHONaUcLOdBVr1R3hV
         LEZ0WlevymIPA==
Date:   Mon, 31 Oct 2022 23:03:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: spi: nuvoton,npcm-fiu: Change spi-nor@0
 name to flash@0
Message-ID: <Y2BURsf5xKyfMn4+@sirena.org.uk>
References: <20221031222559.199509-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZcKXsyfc17hrmMdl"
Content-Disposition: inline
In-Reply-To: <20221031222559.199509-1-j.neuschaefer@gmx.net>
X-Cookie: Are you still an ALCOHOLIC?
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZcKXsyfc17hrmMdl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 31, 2022 at 11:25:59PM +0100, Jonathan Neusch=E4fer wrote:
> The node name for flash memories has been standardized to "flash@...".
> Fix the example in nuvoton,npcm-fiu.txt accordingly.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--ZcKXsyfc17hrmMdl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNgVEUACgkQJNaLcl1U
h9Csegf7BWykpbvVVPf8R0bt4VAWNjgzLV3ymlMsBbbtxT6WQCa+AcQN0HCosnYZ
+rZPW1v4IHCCcWm+waqSW9Tcwbis0pxKBVgAjl7wk3oKsWVR5n294pdLO0X0Bl7O
CSxpakEZwLgrgNeNhPKZ5Y2xHs3gTMmWkyAOY+iS7jANW7z7Agiw0ybRUpVrEv0f
C9CMWE3Hzds5kObCvFSvXpPKk5C5IIYxoNGb3S0RZ5413UApL91f2N5bT1sUoOEc
a+fpK0pr5Kvsy7IgcWo0ZCOHn4uCjLujCff86WvO7AUGUPT4XpKjkcmOwh0g63iC
r7eToayU+xomSUMTZQOj6TqBsHygWQ==
=F6c0
-----END PGP SIGNATURE-----

--ZcKXsyfc17hrmMdl--
