Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A6A6F3B2B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 02:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjEBADY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 20:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjEBADX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 20:03:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FD310DC;
        Mon,  1 May 2023 17:03:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EC8961A41;
        Tue,  2 May 2023 00:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51826C4339B;
        Tue,  2 May 2023 00:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682985798;
        bh=QdYH6yIwZfoQtaUWs7MtYiqjg+6MKHcLUlPFwj1Siv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LNIPH8AfrY/ocfOdCc+f5fpO3T4YPJlBMvafDl8nz8m/qzaIu7XwQK9fPV+6uFUdc
         ryJg8cu5/R0jaldHmbdYXfhN1c8lLxAfKT8f25bg/79u1Sq5DPuX7+0UC0eAwAyhGC
         uwPQdLcU+whb26yWcxV8qDzAG92MAte6IsAqV5NmNVBBfKOzklUTLNYqqGQIk0nNSJ
         5k/GjXi9bZm0mnrBS3sF+FdDkgvn6yAh5jXP1IsJmPYmiq7X15YuZjOeriVxcpqwqx
         Jcf08KaieJydz5K/kxDoJvWYqmp03kli5QKI8pQgm0yJyTDuflPh5EdYBDlco7c2/L
         3vEu7ltL1W9SA==
Date:   Tue, 2 May 2023 09:03:15 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: Missing signoffs in the hte tree
Message-ID: <ZFBTQ+dAHp3g7FXN@finisterre.sirena.org.uk>
References: <143a3e5b-ddc9-4ce1-88ea-9e4d80761cc1@sirena.org.uk>
 <14a6bbb9-aca7-750c-e004-2b11abf05926@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2O/ays0to2035xr5"
Content-Disposition: inline
In-Reply-To: <14a6bbb9-aca7-750c-e004-2b11abf05926@nvidia.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2O/ays0to2035xr5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 01, 2023 at 12:40:16PM -0700, Dipen Patel wrote:
> On 4/24/23 5:07 AM, Mark Brown wrote:

> >   1af0f6b5060cf ("hte: tegra-194: Use proper includes")
> >   3798a6e3b6a89 ("hte: Use device_match_of_node()")
> >   981501927e482 ("hte: tegra-194: Fix off by one in tegra_hte_map_to_line_id()")
> >   58e1189d075a4 ("hte: tegra: fix 'struct of_device_id' build error")
> >   499c35fe9bf2e ("hte: Use of_property_present() for testing DT property presence")

> > in the hte tree for today are missing a Signed-off-by from their
> > committers.

> Shouldn't Acked-by tag from me (maintainer of the HTE tree) enough? I mean it does imply signed-off-by, right?

No, not at all - the signoff has specific meaning with regard to the
developer certificate of origin [1] - whoever applies the commit needs
to supply a signoff to say that they're asserting that the DCO is being
followed.  This is separate to review (though if a maintainer is
applying a patch that's generally at least as good as an ack so no need
for anything else).

[1] https://developercertificate.org/

--2O/ays0to2035xr5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRQU0IACgkQJNaLcl1U
h9DJFwf/eiCZqXA0qN4BDRtDbWnsHBjf5bOhyi1aBQTWrIcpwWtzC8/n4WIbZFMB
cK3oGILyIRcwT9yXD2FtSGVo+W5hd+X23yDxmF3QPO70SUpP0Ao26wE/GOIy9DpS
hrSEqPsCm1KvjvPOwuNKJVJeL6vBSV2OePGp22sNW28Auk5xMflz7Ssr6LZJOV31
pMkkjXS9pmeC35KKvtV7k6upywuNCCAMlGEGTvDL7BQF/23lHSY6n2A/L4jiRuEu
iVA9frLCxraTRcFRhmOYTJ8wDhDS/2hi5DtPzKJ2HlKHaqgA5rThS6msWuUZuxTQ
YZeTeuzCaQUPSzt8opeRigwIsfMvcw==
=9fkH
-----END PGP SIGNATURE-----

--2O/ays0to2035xr5--
