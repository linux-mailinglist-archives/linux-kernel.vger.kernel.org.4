Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C807225EB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 14:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjFEMdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 08:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjFEMcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:32:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B3C1BC9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 05:31:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CB7F62365
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC430C433D2;
        Mon,  5 Jun 2023 12:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685968283;
        bh=6isVfj5HPelAM2be2XHB5El5FupDQSIzr5YS5JDTgZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l97kzALj15ApSmL//qWGveFbey5uNPPQnpCQo1PtBg5U47wX7+l7iiKvXecb+9fE0
         iXoNZQURJiAam/Qjrq+iW9XRGcP/QbKiIF8gD+RX4TSqDGtYrcWv00TuM1/wKDdsWu
         dHO6gfecoZGTncCzpNzh7S+AHBgdZzKpE/J1e0iAIacJYXQgO7DBJdEOXwirnOcjaN
         BtZWdqPlj09OCKErTTpLVjSLdVPtaEvgLUqu2OmUxCwnUZFpcOJxBttlLupXvPqPcG
         QcQQejaHz361G/uxwkA5hkc/76cYItMqWO+dDuKKnIhl1DCTZxynRMifHF7szzOMvL
         HH3+IHywIVnmw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q69N6-0007jv-BS; Mon, 05 Jun 2023 14:31:40 +0200
Date:   Mon, 5 Jun 2023 14:31:40 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/2] ASoC: codecs: wsa883x: do not set can_multi_write
 flag
Message-ID: <ZH3VrC0v4orFUEby@hovoldconsulting.com>
References: <20230523154605.4284-1-srinivas.kandagatla@linaro.org>
 <168492769030.49784.4719862081052299023.b4-ty@kernel.org>
 <ZH2YAmBY-GNKABSB@hovoldconsulting.com>
 <b3bc0a07-4dcb-4f50-a7b3-91a4a62fac56@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ho5/CO/HymAIgj7f"
Content-Disposition: inline
In-Reply-To: <b3bc0a07-4dcb-4f50-a7b3-91a4a62fac56@sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ho5/CO/HymAIgj7f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 05, 2023 at 01:24:04PM +0100, Mark Brown wrote:
> On Mon, Jun 05, 2023 at 10:08:34AM +0200, Johan Hovold wrote:
>=20
> > Is it possible to get also these fixes into 6.4 final?
>=20
> They're already queued for 6.4.

Indeed they are. Your patch-applied message said "Applied to ...
for-next" and I didn't check your repo before reporting.

Sorry about the noise.

Johan

--ho5/CO/HymAIgj7f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCZH3VqAAKCRALxc3C7H1l
CAGbAP4hE7Bw9ePN2pwJDEBzc+z2IL9HkzZkjz/LXt1LBxrD7wEAsVd+92arnoDs
ofsZ43NQKmj9G9qjzSpQs8GUWjbEZAg=
=80cZ
-----END PGP SIGNATURE-----

--ho5/CO/HymAIgj7f--
