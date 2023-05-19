Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B8A709BE2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjESQAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbjESQAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:00:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A39116;
        Fri, 19 May 2023 09:00:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A89E965829;
        Fri, 19 May 2023 16:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9FAC433EF;
        Fri, 19 May 2023 16:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684512037;
        bh=so6sZQRjmbILO79b+dPaCdsSDrsOoHzIlXUlWO3H+30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H7/oE6AOlYHjm3zhqSR/or5vRYxv+vH4IbFnURZU7JP/Fvr4xyoRjCZIdiRiFuFYn
         NojJ0WgKPem9bzMztUN2/4UkyHl/KKccTpA8vHw4CdxMTH1fm2NCBEqaN+cg5Gmmyg
         TFoFDTxhlA8764PuaREvXTmbyLnIZN4+m24PEHUzv4w49VqyZfHtMIfoCyZZ8Ymp1X
         3TNmMyBvEVjOdVZvbWrjElT1Eo8IVy323jddyJgIjnJ4+2YPVeKE/MEXqVwcwjrgKB
         5Ym9gWWpOxR9I0FgTHacMh0gTHSNOENh0Uvtd9DbbWfka24rz0oswcBryVVCf3dsII
         zoK1eC4VGkPbA==
Date:   Fri, 19 May 2023 17:00:30 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, tglx@linutronix.de, maz@kernel.org,
        will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        robimarko@gmail.com, quic_gurus@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH 4/8] dt-bindings: arm-smmu: Add SDX75 SMMU compatible
Message-ID: <20230519-passerby-upheaval-899205409553@spud>
References: <1684487350-30476-1-git-send-email-quic_rohiagar@quicinc.com>
 <1684487350-30476-5-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RuBcisQOkwlJ93ST"
Content-Disposition: inline
In-Reply-To: <1684487350-30476-5-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RuBcisQOkwlJ93ST
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2023 at 02:39:06PM +0530, Rohit Agarwal wrote:
> Add devicetree binding for Qualcomm SDX75 SMMU.
>=20
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--RuBcisQOkwlJ93ST
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGedHgAKCRB4tDGHoIJi
0vAjAP9O9UeAwk5YI7aSf10G3YRugv2uXYTq+jC7o12iE3q4fAD/UhJ43B0gZI54
qM+Jzq0vRX1/6jagqe5zwe/YH6yz2QE=
=BxdN
-----END PGP SIGNATURE-----

--RuBcisQOkwlJ93ST--
