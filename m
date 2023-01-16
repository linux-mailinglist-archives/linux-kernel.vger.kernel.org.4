Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D0466BC8C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjAPLND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjAPLMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:12:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA1014487;
        Mon, 16 Jan 2023 03:12:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E35E160F68;
        Mon, 16 Jan 2023 11:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B524C433D2;
        Mon, 16 Jan 2023 11:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673867555;
        bh=+wQ25LIyeqNsuwnNuac8hPsPq35J2Ha8X2Pw4vC4ugk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M7dA4lvI6DveU5osHG3ehgQ5EcRwZhupa8q2AbikDbB8v5NouXE861wUbAJORWcFR
         C92L0v9G6PwpUNM6rckYlGByT9OvCgBhDHQtjrPk6IrvpzEK6oohxQURgj3ctk0qG3
         wB1+VuEDlF8+3evOfGVQl5nkfEiErkJRG+bqRGqVcHi0fFQ6TGhWxpGCOl0t15W6ng
         oVoyhsSRoPg/LXZ0ArbvVNeRPbZbXTCHrJ7uPnPbIUXWw9BTtDqCgAfqZ95yVsPlB1
         HEAiPwanxi/+0df7i8+4GDpqw0NQ3pos9Srw1hEsIyAqXe2/wNZf9jJFyovAOyUQaX
         g/4fZ4o4tkW1g==
Date:   Mon, 16 Jan 2023 11:12:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devi priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
Subject: Re: [PATCH 1/6] soc: qcom: smd-rpm: Add IPQ9574 compatible
Message-ID: <Y8UxHZx6Mkt3sHXq@sirena.org.uk>
References: <20230113150310.29709-1-quic_devipriy@quicinc.com>
 <20230113150310.29709-2-quic_devipriy@quicinc.com>
 <37755ba1-e8d0-cd9e-73a4-6501746022d8@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wIRK8edTiW17OVlw"
Content-Disposition: inline
In-Reply-To: <37755ba1-e8d0-cd9e-73a4-6501746022d8@linaro.org>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wIRK8edTiW17OVlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2023 at 05:42:36PM +0100, Krzysztof Kozlowski wrote:
> On 13/01/2023 16:03, devi priya wrote:
> > Adding compatible string to support RPM communication over SMD for
> > IPQ9574 SoC
> >=20
> > Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> > Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>=20
> What exactly was developed here but the other author?

It's fairly clear looking at this in the context of the series
that the same tags have been applied to every patch in the
series.  Probably a patch like this was actually written by just
one person but there's a decent chance that it's just been
forgotten who it was and fundamentally it just doesn't matter
that much.

--wIRK8edTiW17OVlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPFMRgACgkQJNaLcl1U
h9Da5gf/XnXzjuy+LtiIlDhMn/Kn8h19yQMA765qgQdrO+h8Ig/PUCRTyf9X8ksa
2kRwpMRn4wf767IWRei5rYrvsDuwTC3CObWa2H9cJ+m0mvPpH5us91mSnnaBlcKN
Pll+1q4K1o+bAxG/fwAQbkrHfMUzeVO2ctaLpDmBZ9WATahktJl34OvsUZxZ7UIb
VnyK8ZmIFFVSTrliaKzdlng39VwUK/gqWZm2s4NGLGh2EtHHWqlZdu2nL0o2gtP8
hw5fJQiIhTRIlnnyWwfUB5hSXfkW5Js+8sYBZWA3y2W6MweDf5/6uhOYmlu6cH4E
3YakshqMbXpUFGY4gRDDqkQCeHOOpw==
=3sH0
-----END PGP SIGNATURE-----

--wIRK8edTiW17OVlw--
