Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3052270E2EE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237845AbjEWQuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237831AbjEWQuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:50:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48703E6;
        Tue, 23 May 2023 09:49:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D20FA616FB;
        Tue, 23 May 2023 16:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D08C433D2;
        Tue, 23 May 2023 16:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684860598;
        bh=UV5bsKa/DBQmuTfOD0yfXML3WqEBfjvCNjnvfqNgkRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ACrAhgKD+OYLCr/Y062rwu/P88jDHYmsjVxirxMBCyxEcingqk/jg1mhpS4DuJAKh
         r7I8Pe49A1fmUsQKqeblz2V3o8b23G0PsCjBH7lDT4CSOhXM0g0eJbhIrpGYoyl0im
         +BSTWopzw+fO4SP2E0YiPHeq8hfop8Y0Pl2lrSvxQEQcK9u40wMMGGaT+FZGm6aSy9
         2wh2IOIYu4t10ZvDTNTprKoiTTD43sjp2vCEwwnCBivqrL7NDP/HN0w14XtmSTG4hj
         bIcYIlvklCJqVjf1Yc6cmOVJbuBsf8BEyq4O6R7r6rOnmOYqnSd/V4ajto8Rh/fuYR
         6af5HPsRQ7G/g==
Date:   Tue, 23 May 2023 17:49:53 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm-smmu: Fix SC8280XP Adreno binding
Message-ID: <20230523-surviving-maverick-85f8294c008b@spud>
References: <20230523010441.63236-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0JTGO0kGTlpCkGjq"
Content-Disposition: inline
In-Reply-To: <20230523010441.63236-1-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0JTGO0kGTlpCkGjq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2023 at 06:04:41PM -0700, Bjorn Andersson wrote:
> The qcom,sc8280xp-smmu-500 Adreno SMMU binding has clocks, so fix up the
> binding to allow this.
>=20
> Fixes: 38db6b41b2f4 ("dt-bindings: arm-smmu: Add compatible for Qualcomm =
SC8280XP")
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--0JTGO0kGTlpCkGjq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGzusQAKCRB4tDGHoIJi
0onBAQCrdQ+srOKGMJhFkarvamoqjZTheYwAH1qqKYnNEopQlAD9GgEpsAdqz4Rz
5kOUvQjUwkVi+dSnftVMLnn8TkOS1QU=
=K0b0
-----END PGP SIGNATURE-----

--0JTGO0kGTlpCkGjq--
