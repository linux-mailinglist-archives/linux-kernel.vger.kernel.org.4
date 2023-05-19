Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD194709BD4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 17:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjESP6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 11:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjESP6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 11:58:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACF51713;
        Fri, 19 May 2023 08:58:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D98A658D7;
        Fri, 19 May 2023 15:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4CDC433EF;
        Fri, 19 May 2023 15:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684511880;
        bh=8q0QgbAxigpEHZ0G2EVkTNAC2ayJfznro/ZRHZZlKpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fGAMgSIQieHCpZOWtnGUopTwrPyrbB3NCQmtgTq1XwLsJiQ9HZrTmom2EzUw+J5Jl
         vFzKov0X4FPddiCr0jI2UuaA1DhVqlV7/kTY3URLKzvJKeGJrIMW3Ksiy3DjS6zChC
         SwyPFyC/BTSblOfPueg67CSAGXPwj/T7t0z9OYAZLCxQp3fq8xkIhorQTszVdZupQW
         WtKQedAa7n/MWgsazY1YdR6ImBbWTVyD9T69sFEYB5PfXSfGjK3by5J984B/ULLBCf
         3fnzOEyuTWE1j2qUGYV0pc+yPtglTtgTkTwbfv3v6+KFKUVnxwXTS78HbVyoanY+Zl
         8yr/Xc1I9XSqA==
Date:   Fri, 19 May 2023 16:57:54 +0100
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
Subject: Re: [PATCH 1/8] dt-bindings: arm: qcom: Document SDX75 platform and
 boards
Message-ID: <20230519-unbend-freight-34ef34f342f8@spud>
References: <1684487350-30476-1-git-send-email-quic_rohiagar@quicinc.com>
 <1684487350-30476-2-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vz7beVG27M3oWpDZ"
Content-Disposition: inline
In-Reply-To: <1684487350-30476-2-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vz7beVG27M3oWpDZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2023 at 02:39:03PM +0530, Rohit Agarwal wrote:
> Document the SDX75 platform binding and also the boards using it.
>=20
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--vz7beVG27M3oWpDZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGecggAKCRB4tDGHoIJi
0idDAP9XMk+6D6GHaLTN72GayAB7qNstlnTLkZB9erQEBf6sVwEA7rhasjA79ahe
ToVsaE0PsX/9Oieq2laU3j+AF6/ftwo=
=9QM1
-----END PGP SIGNATURE-----

--vz7beVG27M3oWpDZ--
