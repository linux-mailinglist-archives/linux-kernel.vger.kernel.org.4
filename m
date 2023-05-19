Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A013709BD7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 17:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjESP6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 11:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbjESP6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 11:58:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52533E6E;
        Fri, 19 May 2023 08:58:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9981B658AB;
        Fri, 19 May 2023 15:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CDE4C433D2;
        Fri, 19 May 2023 15:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684511901;
        bh=LC6PcaBY4YfGm3Kw6jQO/40YFqlZ2fHoiFiPjCm+frk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J4CbgkhF+V9w51/QCHJJhNJqrb/S/A8YvRWMROB3HXR5gfr5CsntI8Iqh8EA3Tp0U
         cl+rNglK/dxf/FPuuLZgSIBWwTv+BLsRtHtsHDHX5Itj4jnmBWQZKj+PNtOfpFUd2F
         jI6TfNFslueB+K74vZdKgOjCzga53+gvamysyDjIPBpT2n/jVaZ9XfqGXaFp47FWC9
         VijhesyPJlivzOZK5d1H12bCJQbmGeSYFiZM98Oy3aeXSyDptPfhTuTUVRLadXHEVk
         HjuYhtjN2nx2UW4jkj+70d9KcOq99AzXr1V6M17G7fXFZnysWfn3Bz7jzo429tu8Li
         BTEhhcPHVDlDA==
Date:   Fri, 19 May 2023 16:58:14 +0100
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
Subject: Re: [PATCH 3/8] dt-bindings: interrupt-controller: Add SDX75 PDC
 compatible
Message-ID: <20230519-refutable-driller-4a00748f887f@spud>
References: <1684487350-30476-1-git-send-email-quic_rohiagar@quicinc.com>
 <1684487350-30476-4-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7fDnlwn1h0elCcSx"
Content-Disposition: inline
In-Reply-To: <1684487350-30476-4-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7fDnlwn1h0elCcSx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2023 at 02:39:05PM +0530, Rohit Agarwal wrote:
> Add device tree bindings for PDC on SDX75 SOC.
>=20
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--7fDnlwn1h0elCcSx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGeclgAKCRB4tDGHoIJi
0rSSAPwIn2e6W1u5UBCOK0Eay5g1fokOGE3V6Yjd03iWXmAzngEAuQoKayqRVrg/
4fg1AjCTzPnGRq3H40eAryAcif0N/QY=
=d9Qk
-----END PGP SIGNATURE-----

--7fDnlwn1h0elCcSx--
