Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464B5744003
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjF3Qmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjF3Qms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:42:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5085F3C01;
        Fri, 30 Jun 2023 09:42:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E31E1617A2;
        Fri, 30 Jun 2023 16:42:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323A6C433C0;
        Fri, 30 Jun 2023 16:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688143365;
        bh=AsDLQehiD2Ddz03Ikj9Gqrg+mzel9zl96sFughFSDQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T2adtZrDtTG0SQamq18KanY3XaVB6ccsBpmcw0/1XhiyAZkC/QKnn8GJXUoXe1j78
         DnhgYMH14iYbhdJI5PIY38dc3rbXLTv5wKTguP93rqa+oQSfyv+qN+Zgdg3PXngRlG
         7yLTV3321PSbtLnmRWSazgMNwmMpi2sxIALgkABK4Z+9pKpsRdBrDQrU563JbEBusk
         59xpwG4OReK9EwJDjaUCLUFi6NrwRsk9hDh7pIJioytFn7T9W+EDIR4pjNtY1ug6dK
         UJOnzoPKIR5lbi8vcbr2rdAw67elfRtLh8tYVsa1zvvj/rrICy+zC5+9hLYBfu0UdU
         wU3KU8xA0XfFQ==
Date:   Fri, 30 Jun 2023 17:42:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH v2 2/4] regulator: Introduce Qualcomm REFGEN regulator
 driver
Message-ID: <edce1d82-21fa-4a24-bf21-f8d36321a409@sirena.org.uk>
References: <20230628-topic-refgen-v2-0-6136487c78c5@linaro.org>
 <20230628-topic-refgen-v2-2-6136487c78c5@linaro.org>
 <8ddbd947-6cb6-8c86-eb48-8b6ae9b4be2b@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8lqkCU9h8Shc3YwO"
Content-Disposition: inline
In-Reply-To: <8ddbd947-6cb6-8c86-eb48-8b6ae9b4be2b@linaro.org>
X-Cookie: Old mail has arrived.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8lqkCU9h8Shc3YwO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 29, 2023 at 10:44:34PM +0200, Konrad Dybcio wrote:
> On 29.06.2023 22:35, Konrad Dybcio wrote:
> > Modern Qualcomm SoCs have a REFGEN (reference voltage generator)
> > regulator, providing reference voltage to on-chip IP, like PHYs.
> >=20
> > Add a driver to support toggling that regulator.
> >=20
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> Ugh. Missed the 'const' here and below. LMK if that warrants a resend
> (or.. perhaps you just have other comments)

Please, there was a build error anyway.

--8lqkCU9h8Shc3YwO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSfBf0ACgkQJNaLcl1U
h9DtzQf/YZpKHlgLTdOMFkC3HZ2f3TPMgOKk1lmiFlPQ5fUWfvRGxR+3UFPRhxH3
obR+n3Ji9r4vNwlUe04KpzhA65zz7YbpLkSLmU2IBagoSyrRktUWz980Km1D0jYP
aq50iK3sDzpbsp3/EvXTMx36o7PvCw6LksKTeBrQ4Gdt/N8WNnCry+UMEIBaoXLf
cf5RMuXmMVkJhptiSt4KYtBNq6DsxEJ2FCipz5RnLCg/eqs/9YN+CnKWKGV66QXE
Q2tsb4NTsIdgkguQSCogUysRtNz6OJIwp1PyYXUud924LDjAIqQ18PdV1vW+ydtV
3+8KotwTm//MVThoCXKxIHrOc2EH7g==
=cpsx
-----END PGP SIGNATURE-----

--8lqkCU9h8Shc3YwO--
