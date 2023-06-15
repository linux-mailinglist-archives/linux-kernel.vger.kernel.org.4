Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CF3731F8A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237432AbjFORzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbjFORyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:54:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1262700;
        Thu, 15 Jun 2023 10:54:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6687D60BB5;
        Thu, 15 Jun 2023 17:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25FDC433C8;
        Thu, 15 Jun 2023 17:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686851689;
        bh=E095E2E+VR+02jy+1Q8NMseLgVQlZJG8SbBWQl50WwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E7FR2dghDPxJlV4F0bxJPGW1SrmbIn1uJ4woSz22XNREnGOm+aYCoUz707nKCNWmU
         qKb6/ab+k5Urr63smCYYaFRhN7aDI6k9g11/Mk8JnsP7Ua8C9cZBXeRXfgWGpfPhX2
         zzG4UTqTwkMHWgjCl0mYiIQ9GN2/aAcIswTIZtq2e+Y2QOMPlG5DkhMsjmGwzjLdj2
         CH+df8Dp1v96usEm7yiPdfeF4h4kF8+mDy0kGuzfhhNwFHOD2unxXW0ZI9rqwsWmsj
         W+3Lt3wfRuUpGQMHJEE9h9yQxAFtLWZU3ub0Kb7/eFVFG7S49V0YFtpNgre1QNUpwS
         wJ1xmGO+RYo/g==
Date:   Thu, 15 Jun 2023 18:54:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Praveen Talari <quic_ptalari@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
        quic_vnivarth@quicinc.com, quic_arandive@quicinc.com
Subject: Re: [PATCH v2 0/3] spi-geni-qcom: Add SPI SLAVE mode support for
Message-ID: <7cbb220e-997f-4de5-97c8-2a2b3a9185f6@sirena.org.uk>
References: <20230615070706.18322-1-quic_ptalari@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iZkYj92B089URvNK"
Content-Disposition: inline
In-Reply-To: <20230615070706.18322-1-quic_ptalari@quicinc.com>
X-Cookie: You are false data.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iZkYj92B089URvNK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 15, 2023 at 12:37:03PM +0530, Praveen Talari wrote:
> This series adds spi slave mode functionality to geni based Qupv3.
> The common header file contains spi slave related registers and masks.

The more modern terminology here is device mode, pleaae prefer to use
that where possible.

--iZkYj92B089URvNK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSLUGIACgkQJNaLcl1U
h9CXwAf9FCQdRel9BXQRnVWzWs9p3Ipyttl0Iri3279Nsy2RoQM+i95fGPm0JtbT
2jF19FPHusIbBSzfdHy51SX+c55NctHGAgdktodikBBHl2ZpXPFJG3/Hp4VG3/ty
rE0pRx/BqEwf8A6qwrBzwtqquC1SKLzwVJmk32NacbJOSE1M8dg6npEUsqNuIz2i
SKQRc4p7/U4iIieRDekYdu4ryQmAAYgLAPYP6tHjbhIhch3p+17yt2ZAmxk08A8w
ztl4bxpT4dVYYGDNtajIKMuHOHtQW9FdJoa855YvP+YEt5OggpTkydR3nMOshMQm
ELhSw+prkU337rx7xybjJ4S+Zysveg==
=UEjY
-----END PGP SIGNATURE-----

--iZkYj92B089URvNK--
