Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FFC712CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243514AbjEZSvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243417AbjEZSvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:51:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD179E50;
        Fri, 26 May 2023 11:50:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4109D60FB1;
        Fri, 26 May 2023 18:50:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F13C433EF;
        Fri, 26 May 2023 18:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685127058;
        bh=qwWvD+SDS8uafhcLh9NhqGJWERJTfArj7SSjyAz4TNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=csoNAlrEiArbNIaIuxOXduyyA4FitbwavUxYoUnjaDCylvGiaYr0b4yE2pRfzZCm/
         C1kiHyUounMOgLEuHls/4yxz2PqG0pxupggaCq01ivaArFGk3ZdU1pp/PuX0he5B3P
         Lwts0eSvDw8nkUmY7pTq4q44C6SG6kqUI6850yiR5RzdMbPqXlJbUmrhGwvruU9YJl
         34ChWXWEMDd+OWKMmS8ECfEY5uJt6I4ZfTSK4MxHFki+sJF0mH40uQrVAMvmLiMti0
         3NByjKpblpwMXhrMORGdn+43Td1w7dLYG9GNklFMjIkBpYGE8nWjEviK9se7nkmGnK
         sb0PqNDuyPn6g==
Date:   Fri, 26 May 2023 19:50:53 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: document AL02-C8 board based
 on IPQ9574 family
Message-ID: <20230526-calamity-boned-670e1bad7a6c@spud>
References: <20230526153152.777-1-quic_devipriy@quicinc.com>
 <20230526153152.777-2-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vcXuDeNW1ivsfzBs"
Content-Disposition: inline
In-Reply-To: <20230526153152.777-2-quic_devipriy@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vcXuDeNW1ivsfzBs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2023 at 09:01:51PM +0530, Devi Priya wrote:
> Document AL02-C8 (Reference Design Platform 453) board based on IPQ9574
> family of SoCs.
>=20
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--vcXuDeNW1ivsfzBs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHD/jQAKCRB4tDGHoIJi
0sPUAQCpG0E60EZwCFggBm7I1+72+WdMwQy4GYNpg9aN3s9o+AEAjqzgMD4DEWAR
f8CElr1TM+a5ct5TznVxRlt3BkrVNgQ=
=JAKI
-----END PGP SIGNATURE-----

--vcXuDeNW1ivsfzBs--
