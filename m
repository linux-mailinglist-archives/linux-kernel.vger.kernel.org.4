Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBEA717FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbjEaMaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjEaMaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:30:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CB410F;
        Wed, 31 May 2023 05:30:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94B79635AD;
        Wed, 31 May 2023 12:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B127DC433EF;
        Wed, 31 May 2023 12:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685536213;
        bh=dNwI4ZbTwgCMxh4vZGo35+Qsvm1o276a6U7l/Y0GiL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iAZ3O4pDWaGBWsYJ6QQAyP4fAk1byCoBaNhgtyKp73js+7RWUY7qmS+hWq6RXmQJS
         qa0I0a/aodLDySGYiP1N/+zOmhKo8MyRg5TpxHtvaGzErpT8OtUy7nfHVDLlmCdsGi
         6iIyy1Md5+EXiwc8EkRKslQSLigCZngeOKlNUB3orcJqKB+wVRcyckQQw4dLqih1+C
         Aoh7p7ib+HGJhUldv0RC7MeClyHFHGcVqoMmokrQXAPR7EJClLbmBPnYcJQQxlTx0v
         3FEcVLde5tf9RjLA3E1ytjVyYMTSeqyvZTD7UhDigrWJ25985Ty3tKzn+kp2Z/5XHj
         poR/FeK7ABCng==
Date:   Wed, 31 May 2023 13:30:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: qcom-rpmh: Revert "regulator: qcom-rpmh: Use
 PROBE_FORCE_SYNCHRONOUS"
Message-ID: <04f5501a-03ff-4ac9-9355-ad17281350b1@sirena.org.uk>
References: <20230324063357.1.Ifdf3625a3c5c9467bd87bfcdf726c884ad220a35@changeid>
 <CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com>
 <552345c5-b1e9-41f6-f275-b6eeeb51df25@linaro.org>
 <CAMi1Hd05z8uBotO4vs7Ropmt7W2gSA__tTu_=X1t0mze7bXrhg@mail.gmail.com>
 <CAD=FV=VSFDe445WEVTHXxU1WS_HGUV5jR5E8_Vgd4eyhn3rHyA@mail.gmail.com>
 <CAMi1Hd28FJUjB8A-9YF7xpKOzSyNWXX3qung4aDjpLBhOvw_eA@mail.gmail.com>
 <CAD=FV=W13L0H88G1gt8qRnXfpV-_7E9QfHufN_a23_B1bb=aww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8xWbXyiwbCVWQaMo"
Content-Disposition: inline
In-Reply-To: <CAD=FV=W13L0H88G1gt8qRnXfpV-_7E9QfHufN_a23_B1bb=aww@mail.gmail.com>
X-Cookie: Will Rogers never met you.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8xWbXyiwbCVWQaMo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 16, 2023 at 02:24:06PM -0700, Doug Anderson wrote:
> On Tue, May 16, 2023 at 11:12=E2=80=AFAM Amit Pundir <amit.pundir@linaro.=
org> wrote:

> > Tried out a few changes today but none of them worked or were
> > effective enough to debug this crash further, other than setting
> > fw_devlink=3Dpermissive.

> It still feels to me like _something_ is happening at the same time as
> the RPMH regulator driver is loading, though, I'm just not sure how to
> suggest debugging it. I guess other thoughts:

This discussion seems to have ground to a halt with no resolution so it
looks like the best option here is to apply the revert unless there's
some progress happened off list?

--8xWbXyiwbCVWQaMo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR3PcwACgkQJNaLcl1U
h9AV0Qf+KbzSssf/im8H1bGzXtEXWtIA1y9qKKuU+iOAo9QW86zNr7laFSsWQEvA
g1qZ2LH3yZrogaPHkgudLcRz5KQo/bGycaSW3H3Vmlz5sznmmdX0XhvCmyNOef3o
xFsimGWOOAkzf1xVSns4NjENWVnBoXueQFDlaHl2BA8zUQnPpxZpDI4PQPKvrj9T
JulZ7WDnaSFj0Usp3zGVZJ/iuRgH95ACokr+mts1UycCx4MfVBB5EKCsZqY+4cmJ
N5bIoUbEvkwUIP9Nzmv73AeWC2ZJVzy5sCoVwZ/yZ1j0ROTHGkFUuKmgQmBHymV3
vH8qB8cAYFTOn4AFY1on2zM9pKM6vQ==
=l3jN
-----END PGP SIGNATURE-----

--8xWbXyiwbCVWQaMo--
