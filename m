Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820587201E6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbjFBMU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbjFBMUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:20:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5DCE6E;
        Fri,  2 Jun 2023 05:19:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B14D564FCC;
        Fri,  2 Jun 2023 12:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96100C433D2;
        Fri,  2 Jun 2023 12:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685708354;
        bh=v1yv6jsgbmHl+5NaoACfNaefQuLeoFE1uwpGD8SeaIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=al0vYMzs78qApmR2nyyVBNzdSuWQh0Ug+iqj0oX5yM4zClF2iv8KLNBh4sC6OgclM
         /3V+58WCgUImIh2y6B5Ohc9ZwBL2Y/wvaQbIdVnI25kpHYhnVEOUeJlb0wcRjNlaAl
         ohVAn01nQN9GWX1k4dK9xh22RrBx0tOm5DPaUQk8g29E4ZavfVQtCmGwgENhzIwP9n
         iTLh+oA37gfB1tpSr7wIgigy1QTx32++LuofsLrwvK+60i0LCsubykSMGFc5RDykQz
         zBOyFWsNcIzuXOMW+L3KKwCpXNYI8dy23TzX28Y77a/Hli95kfTPV+7IgQwoL9Gp/c
         m5cxwIyPMqj/g==
Date:   Fri, 2 Jun 2023 13:19:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alvin =?utf-8?Q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc:     Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] ASoC: dt-bindings: document new symmetric-clock-role
 flag
Message-ID: <91b6d02a-25d5-4835-942e-3f8072bd8897@sirena.org.uk>
References: <20230602090322.1876359-1-alvin@pqrs.dk>
 <20230602090322.1876359-2-alvin@pqrs.dk>
 <3fe93662-82b0-4834-b6c3-473669c66210@sirena.org.uk>
 <7csvw25vhyal2jsznb3jykuijxqpk7bzyguxvl7cyitosgga2w@pxmkce22cm3d>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eKLqXSuhsjfwfQXk"
Content-Disposition: inline
In-Reply-To: <7csvw25vhyal2jsznb3jykuijxqpk7bzyguxvl7cyitosgga2w@pxmkce22cm3d>
X-Cookie: War is an equal opportunity destroyer.
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eKLqXSuhsjfwfQXk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 02, 2023 at 12:12:52PM +0000, Alvin =C5=A0ipraga wrote:
> On Fri, Jun 02, 2023 at 12:43:51PM +0100, Mark Brown wrote:

> > Why would we have a property for this and not just describe whatever the
> > actual clocking arrangement is?

> Sure - let me just elaborate on my thinking and maybe you can help me wit=
h a
> better approach:

> The clocking arrangement is encoded in the dai_fmt field of snd_soc_dai_l=
ink,
> but this is a single value that describes the format on both ends. The cu=
rrent
> behaviour of ASoC is to flip the clock roles encoded in dai_fmt when appl=
ying it
> to the CPU side of the link.

> Looking from a DT perspective, if I do not specify e.g. bitclock-master on
> either side of the link, then the dai_fmt will describe the codec as a bi=
tclock
> consumer and (after flipping) the CPU as a provider. That's the default
> implication of the DT bindings and I can't break compatibility there.

None of this addresses my question.  To repeat why would we not just
describe the actual clocking arrangement here - this property does not
specify where the clock actually comes from at all, we're still going to
need additional information for that and if we've described that clock
then we already know it's there without having to specify any more
properties.

> The other issue is that for the simple-card the DAI format is only parsed=
 in one
> place and applied to the whole link. Are you proposing that it be modifie=
d to
> explicitly try and parse both ends in order to determine if both sides wa=
nt to
> be clock consumers? In that case I'd have to also introduce bitclock-cons=
umer
> and frameclock-consumer properties to mirror the existing bitclock-master=
 and
> frameclock-master properties, as an explicit absence of the *-master prop=
erty on
> both sides would have to default to the original ASoC behaviour described=
 above.

If simple-card can't be made to work that's fine, it's deprecated
anyway.

--eKLqXSuhsjfwfQXk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR53jsACgkQJNaLcl1U
h9AqQgf+Jtc2Ihjbp82B3yzWnRCVZupKiJ+T2iC3qd0hfq3+jWz+RFnFHdNMk1Zw
iXOOvYCFENv9fZ3QnfkSGDXxEFfoPxPMaHZw3TgCWz3SjjotWePvHqRbEsvEOYFk
IB9Qp1phuf/2LLkB7wowMhaPjieW0MM2ju5LtpR8Ghf/f1Uq2GsI5cyHqme/9vd0
0q4Ti4HqvkAcrxIFsxp/PAY2z16ZKqPWLfErn3eFXsMpncYxyPu3Uzp51WFEdoTJ
BhbptiaicarUbEua7PiWAWEMo5p9lfUavssHcAbShWxI0rGof7/3PwlzKdlmjbv1
2Xc68INUB1l4EBgnVbZtFeX8YqFScw==
=FVEu
-----END PGP SIGNATURE-----

--eKLqXSuhsjfwfQXk--
