Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA3770E373
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238211AbjEWRjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238022AbjEWRjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:39:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A223FB5;
        Tue, 23 May 2023 10:39:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2717761D92;
        Tue, 23 May 2023 17:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E02C433EF;
        Tue, 23 May 2023 17:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684863544;
        bh=vDGswodSlrzYhuB+jhwOgA8e4UY+ICmFArxjHAa0lQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cmb+eJFLMLRCNos+XdtkEaiFGCeaU44cLSIk5Rf4y1wm+t0VUptmbLHY77jOzC+Il
         VeEilcHZvfBC3BB9Kl2IjxuacFnQt61SWpCmEIhVaJOK2eUAVxEbLhRDv4EKML9E10
         JdaYnosTUuxBCcfJWlnfJyMdGEOaijz0BEl18CBXI1s+bs2WDX8QxcaUt4swgmUn/1
         Zf92mTTUJiERQ1KRrWPW98LbSXU6Y/DjQvlNk/N1cwdVB25eQsU7NsHbXjcNBsxxHQ
         EOGYNRvBzOtmOw37wH1t7lMKdyxzIxNKL5jJ8dJ6/dqUXmt4BIFTsiVSWJuuRM/ZJF
         nMScmsVvuY5Eg==
Date:   Tue, 23 May 2023 18:38:59 +0100
From:   Conor Dooley <conor@kernel.org>
To:     David Rau <David.Rau.opensource@dm.renesas.com>
Cc:     conor+dt@kernel.org, broonie@kernel.org,
        support.opensource@diasemi.com, lgirdwood@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: dialog,da7219: convert to dtschema
Message-ID: <20230523-rush-impurity-0d3cfe7f166b@spud>
References: <20230523161821.4260-1-David.Rau.opensource@dm.renesas.com>
 <20230523161821.4260-2-David.Rau.opensource@dm.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CepHPvTd7JkTVbr9"
Content-Disposition: inline
In-Reply-To: <20230523161821.4260-2-David.Rau.opensource@dm.renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CepHPvTd7JkTVbr9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2023 at 04:18:19PM +0000, David Rau wrote:
> - Convert Dialog DA7219 bindings to DT schema format.
> - Remove unused `dlg,ldo-lvl` property.
>=20
> Signed-off-by: David Rau <David.Rau.opensource@dm.renesas.com>

The conversion seems fair enough to me. Apologies for the messing around
on V(N-1).
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--CepHPvTd7JkTVbr9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGz6MwAKCRB4tDGHoIJi
0oMQAQCy3qP/6zmjCiNVVw646qB02mnLHzktE//bUWaF1ktUBQEAuTGeu/BKC/89
cKwAnnEUJBVgTBYf2szP0dezn1R78gs=
=riwd
-----END PGP SIGNATURE-----

--CepHPvTd7JkTVbr9--
