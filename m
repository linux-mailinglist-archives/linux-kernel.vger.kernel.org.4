Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9F5742B69
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 19:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjF2RjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 13:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjF2RjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 13:39:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F963AB4;
        Thu, 29 Jun 2023 10:38:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F17196152D;
        Thu, 29 Jun 2023 17:38:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9529BC433C0;
        Thu, 29 Jun 2023 17:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688060324;
        bh=6sXzGhC7vIMzYyxfx+TpK69VIpMiNe5l+HsKkIs0gCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cM2+mp45AR6aLokpbM9NA93Ddoj8EACrDPwr0dt5EHPVKl9+mwOSPLUVsqxuRQGHB
         FKc3YZhyXlxUggE4WwhxHCRoAstKkiHANYoE/fUoeg+Qh0rmaXMawT2JjuIV3fqR3Z
         H9jXHec2IpBiQ05+8K0uQuNZ71gDfJZ/AwYTyWWCSQsFQZUurj39QYgojaNOUcGoad
         GrqEyPmWzMNkq1IWZ3N8vD6KJl3IsYKzIgiXaxmou8XrYVFICHOwYa5HW2evtzWxkD
         HUat2RWeaZpycw5GDw0ZnHCUNqmWO1g1ILHuF3ZrbY1f1r4cYhHmLN0ksatk/Ivqgk
         pzDUHr/mwd/Jw==
Date:   Thu, 29 Jun 2023 18:38:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Greg KH <greg@kroah.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        johan+linaro@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        Stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: qdsp6: q6apm: use dai link pcm id as pcm device
 number
Message-ID: <1c1dd19e-cbc4-41fe-9e97-a07cfebdaa4b@sirena.org.uk>
References: <20230628092404.13927-1-srinivas.kandagatla@linaro.org>
 <c22fcc94-aa41-4ffd-bfe8-f0b9f15a76c0@sirena.org.uk>
 <2023062940-snore-brick-419b@gregkh>
 <9699a960-74b0-4064-b264-6cde06cd16fc@sirena.org.uk>
 <2023062958-thumping-ambulance-7a2f@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kJyOuHiyyBo6gZpK"
Content-Disposition: inline
In-Reply-To: <2023062958-thumping-ambulance-7a2f@gregkh>
X-Cookie: Surprise due today.  Also the rent.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kJyOuHiyyBo6gZpK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 29, 2023 at 07:22:51PM +0200, Greg KH wrote:

> It shouldn't matter for stable or not, if the change is acceptable in
> Linus's tree, with the userspace visable change, then it should be
> acceptable in any active stable branch as well.  There is no difference
> here for userspace api/abi rules.

As discussed before your tolerance for risk in stable is *far* higher
than mine, if there's any value in doing this at all it's probably
within what would get taken but that doesn't mean that it's something
that it's sensible to highlight as an important fix like tagging for
stable does.  It's extremely unclear that it fits the severity criteria
that are supposed to be being applied to stable, though obviously the
documentation doesn't fit the actual practice these days.

--kJyOuHiyyBo6gZpK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSdwZ0ACgkQJNaLcl1U
h9Ay1wf/V8UaFH7JxyAo2RN57WH5Ye9RCQpALdXWBo8riXGMcrU+5V3j2BOtv6j8
n7nOp3QM2HGoTbgFuSiUK+oNFilaNjNOzwB8I9VAG5Z3td0S9n4IEIsDPQkLFsm9
zt7I8TELzcKnbq0iQ/ob8Ubw3icGzVrPXCaWbkBcBCzyxsu3e9bkI33rhnymTyNE
ZN+BevBytonv53kKAoOekPt/Q48mRMSm/9yFDDerJTHC5+Ofj2eLmCepvkrCs0t6
vGfLDa07uKyZOmPblvStwNoPHh6swDc0264D2VzB4Vn8TnNiPtbMS59Bw2oK+9d2
VHUck3TXRnm57K1nTZSoTmP3WwaY+w==
=C4my
-----END PGP SIGNATURE-----

--kJyOuHiyyBo6gZpK--
