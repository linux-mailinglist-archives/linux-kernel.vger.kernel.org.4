Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C64712CA4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242835AbjEZSjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjEZSju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:39:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE4F10C1;
        Fri, 26 May 2023 11:39:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFE8A6527E;
        Fri, 26 May 2023 18:38:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7B8C433EF;
        Fri, 26 May 2023 18:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685126324;
        bh=NrFb9Wj74u9c5ZnvWwv73iHlGH1QgmDSGvk+pcpUcSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oMAPgrdZbjnDJ1S6wkyhOCn5RcKJJjjngqwJI9pYU3mGqPYYwzSrVYFQgPBc9rOOt
         m6RT5liSkbpnFfiyNsrHV5R0HWuNsaN1Ebl/Svea8buwve4QjO5B2NwtKaROh7o2vt
         7IxOoM3GDH8LXrOhV84T7vr0NdnwSICEClQc0R+pi1RZOJLw/vD/CU6DGO35DMbFod
         VusnnL3yN0HdfsxRNGOf7skQnp0npLYQuJHri2qlaTflAni4U8rshFu56MpSRQoTe9
         k5W5Wego72vQMmrKyCis/xnhMAOw1jjRuWGnmVtTq3ic2bdsbEUrMLym4/rReK/NdG
         BG9MFoF+eKMTw==
Date:   Fri, 26 May 2023 19:38:38 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Vignesh Viswanathan <quic_viswanat@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_kathirav@quicinc.com,
        quic_anusha@quicinc.com, quic_sjaganat@quicinc.com,
        quic_srichara@quicinc.com, quic_varada@quicinc.com
Subject: Re: [PATCH 1/3] dt-bindings: mfd: qcom,tcsr: add the compatible for
 IPQ8074
Message-ID: <20230526-race-ripping-d099a2772fd1@spud>
References: <20230526110653.27777-1-quic_viswanat@quicinc.com>
 <20230526110653.27777-2-quic_viswanat@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aSf09WvGUhoAHRN5"
Content-Disposition: inline
In-Reply-To: <20230526110653.27777-2-quic_viswanat@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aSf09WvGUhoAHRN5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2023 at 04:36:51PM +0530, Vignesh Viswanathan wrote:
> Document the qcom,tcsr-ipq8074 compatible.
>=20
> Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--aSf09WvGUhoAHRN5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHD8rgAKCRB4tDGHoIJi
0pRrAP9hGS2J0BQmIrvtEq6pLs3XL3dSjzMJA4b1V9Se1Dt5JQD/UqvlEoB4fTNV
vHlkAagembC7ao8ICTkyf/fTbowYJw8=
=+N3/
-----END PGP SIGNATURE-----

--aSf09WvGUhoAHRN5--
