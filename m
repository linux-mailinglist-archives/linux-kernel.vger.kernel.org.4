Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2289D706F92
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjEQRgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjEQRgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:36:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00B0768D;
        Wed, 17 May 2023 10:36:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A0416499B;
        Wed, 17 May 2023 17:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835BEC433EF;
        Wed, 17 May 2023 17:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684344992;
        bh=se/F0SuZ64EJhZ35GhRHANkzOwMy2zYc/0SNkVI0hXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TsQe0LPaLbX2sFjeyphGtBMEYtkFzUaGjRAJI9ocCTDXLAhUSgDUzf5UcBEDIF+ON
         tr1LY5f6d+iGunWqrWsXdYm560VA0Jz5Qegfa5O70rWTA93iA6Jx0V5tuSxe8yGNGF
         mS08YjuFd3fJkYEbNHivGveNO//GLtF6seJxP7F/vJwwIYwtuEsqZ3V/aaT70k4Hs5
         VDKUIernjnvb9j+0YGszxVCigfCk0iTNYCSQAm2IFi7E15xeDsjs7dDTsNMPoNLIrv
         UQHOvf3XXWM1EmjPybrgGjbsUBUlnYVszTADxvHKNSFrCCWu7G0WwJrOJs7rPlrDFF
         7vTmvf3NYo2WQ==
Date:   Wed, 17 May 2023 18:36:28 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] More RPMhPD levels + sm8550
Message-ID: <20230517-pauper-rigging-8cc6d2600eb6@spud>
References: <20230517-topic-kailua-rpmhpd-v1-0-cd3013d051a6@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gWnuExCoIoY1TXG2"
Content-Disposition: inline
In-Reply-To: <20230517-topic-kailua-rpmhpd-v1-0-cd3013d051a6@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gWnuExCoIoY1TXG2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2023 at 03:19:42PM +0200, Konrad Dybcio wrote:
> Bring in missing RPMhPd levels from downstream and add ones we'll
> need for GPU on SM8550.
>=20
> Patch 1 adds the missing ones with an easy-to-read diff, patch 2
> reformats the block and patch 3 adds the necessary levels to 8550 dt.
>=20
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Konrad Dybcio (3):

>       dt-bindings: power: qcom,rpmpd: add missing RPMH levels
>       dt-bindings: power: qcom,rpmpd: Format RPMh levels better

If you're going to add these defines regardless of a to change your
approach:
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--gWnuExCoIoY1TXG2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGUQmwAKCRB4tDGHoIJi
0gJYAP9E93KGAQmQeDgXCzw5x6ClSilHDxtkVU7r0Ge6UCimJgEAtqTVSSPgHQfD
v/6TNmOg8QfmFf3aLHo2+U7Z9DaMGQk=
=TnAO
-----END PGP SIGNATURE-----

--gWnuExCoIoY1TXG2--
