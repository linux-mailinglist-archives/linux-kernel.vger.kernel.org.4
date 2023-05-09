Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAB46FCD32
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 20:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbjEISFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 14:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjEISFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 14:05:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9DF40F6;
        Tue,  9 May 2023 11:05:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C1036362A;
        Tue,  9 May 2023 18:05:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB86C433EF;
        Tue,  9 May 2023 18:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683655521;
        bh=Tdj/22kgA8XkFoA986JPGYnfWwEcnwTjUAalnblqCYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tj8rEfD8bzoP3ENFKkSFpA1LpSIJGrsf+RXdNrYIADnUN+NMZGhCT2IEPRUyBPrja
         eqxRN5d7VgGo0SC5AX6Lk0khulo2GSo8RLS8umt1fKU44FyknV8dUzIsIvx374hh06
         0BMTJAP6QOSzEYMiEEZDLEtgxA1EL3cjqwKRNzxIt6h31s7Xfh2BI1+dVxMDywkLFR
         umJTE/5AVlKQRBYOdSGi6KW4dFZP1YlUFhIpAa3TYIg3iCPFwrO0B+6gKnFS+0rhvv
         hLSgQC1RNqvq5dHpzsKAbFrBarlyE8dY/BM7pQyk2oHXWEc7BuKxyBNOOLIJE0ntEC
         iFd572OME5hsg==
Date:   Tue, 9 May 2023 19:05:16 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 3/3] riscv: dts: starfive: add tdm node and sound card
Message-ID: <20230509-overheat-pliable-00d60523637e@spud>
References: <20230506090116.9206-1-walker.chen@starfivetech.com>
 <20230506090116.9206-4-walker.chen@starfivetech.com>
 <a0932e84-3813-bbbe-762d-948d75fbcd8a@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cgSWW3RzfwlIKhhN"
Content-Disposition: inline
In-Reply-To: <a0932e84-3813-bbbe-762d-948d75fbcd8a@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cgSWW3RzfwlIKhhN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2023 at 08:52:48PM +0800, Walker Chen wrote:
> Hi Conor/Emil,
>=20
> DT overlay is used to describe combinations of VF2 and hat.
> Do you have any comments on this patch ?

Up to Emil :)

I seem to recall that he said at the linux-riscv sync-up call that we
have* that he was not in favour of overlays for hats like this.
I'll let him confirm that though, I might very well be misinterpreting or
misremembering what he said.

Cheers,
Conor.

* https://lore.kernel.org/linux-riscv/mhng-775d4068-6c1e-48a4-a1dc-b4a76ff2=
6bb3@palmer-ri-x1c9a/

--cgSWW3RzfwlIKhhN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFqLXAAKCRB4tDGHoIJi
0qBCAPsE8YwhVOhYQs79hkq8MKo8na1XocNJROiloe+mcYefYQEA354Svch8qplg
cy1NtrkXNW4PClswD2VNVAVe/IphjAc=
=UgFO
-----END PGP SIGNATURE-----

--cgSWW3RzfwlIKhhN--
