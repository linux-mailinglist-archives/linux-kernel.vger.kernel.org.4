Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0FB703644
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243580AbjEORI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243674AbjEORIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:08:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC408A46;
        Mon, 15 May 2023 10:06:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC83A62B03;
        Mon, 15 May 2023 17:06:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D5EC4339C;
        Mon, 15 May 2023 17:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684170396;
        bh=iEG55+eMRMDRtNqfDsjn9pvk5SCvqsO11Osuy3nfDHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rk8ZEfmtTh0LDp7vJ2orZEeJWmHHQ6YVhdmzT8GUuBIxYaITJ6ru9ZbvEcGExN1iw
         ohv55hHHeBYWi4sVQUOi2oLgjoA5CkzKn1mfrgRYY8LlYez4L+OecyeqDRlLePVW38
         cyV8N5+p8DiFBmLzUSfpaMZAQ0AvOOJhe7ip6jvb0BnGAI/ZAvT+Yrl45XOF3tTF9I
         MvuTWfqkzZmpoaARLezsB3bRYLXfS4b8i1wAx5wH6+6Wb4llknPr+tY+8T5/eZ/DOd
         ngNQMsijhmeBjfc2dl390pL91xRh9Rhb176evuyO5TrAuz42nWRVsVxt0MqiuKXL1D
         70xjROOV/w8Tg==
Date:   Mon, 15 May 2023 18:06:31 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        alison@she-devel.com
Cc:     alison@she-devel.com, johan@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        achaiken@aurora.tech, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: gnss: Add U-Blox Zed-F9
Message-ID: <20230515-relation-sandal-32e4e580daba@spud>
References: <20230515004025.1133572-1-alison@she-devel.com>
 <20230515004025.1133572-3-alison@she-devel.com>
 <5530a1f3-ae89-29e9-dab5-c93f617edbff@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4k/pillGtsSsyiz/"
Content-Disposition: inline
In-Reply-To: <5530a1f3-ae89-29e9-dab5-c93f617edbff@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4k/pillGtsSsyiz/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2023 at 08:30:03AM +0200, Krzysztof Kozlowski wrote:
> On 15/05/2023 02:40, alison@she-devel.com wrote:
> > From: Alison Chaiken <achaiken@aurora.tech>
> >=20
> > Add support for the U-Blox Zed-F9P GNSS device.
> >=20
> > Signed-off-by: Alison Chaiken <achaiken@aurora.tech>
> > ---
> > Acked-by: Rob Herring <robh@kernel.org>
>=20
> Not a correct placement. Apply the patch yourself and you will see.
>=20
> Also, this is not v1, but v6.

Aye, something is going quite badly wrong in terms of versioning :/
Got a v6 cover letter, v5 patch 1 and an unversioned patch 2.

FWIW, the --reroll flag to git format-patch should handle that for you:
https://git-scm.com/docs/git-format-patch#Documentation/git-format-patch.tx=
t---reroll-countltngt


--4k/pillGtsSsyiz/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGJmlwAKCRB4tDGHoIJi
0negAQDdInT74CYcLWVtT92O9oOolh/+swmpaCn0Zm0y0qmyJwEAxGRdtwYQLOs/
V3zWdkgM+n2zcXA4v7CeAj4uQFBSQA4=
=fSZk
-----END PGP SIGNATURE-----

--4k/pillGtsSsyiz/--
