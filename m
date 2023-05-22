Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB7170C445
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjEVR3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjEVR3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:29:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AFBE9;
        Mon, 22 May 2023 10:29:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BF3B62591;
        Mon, 22 May 2023 17:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1955C433D2;
        Mon, 22 May 2023 17:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684776576;
        bh=ks8uAhTxwDrri+4R3o61RYM+zPyG+kZZPeVkAE5LwfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UZdyyTt7BSyRvWWKDGAPTnQq24inkKN7HRfLrjkyv78d0uauwyDkRNxzm64VZwD0d
         PVQCcbJnWHCs7zH/DNDPe6p32iab1zm2HIgElAX3odmhcjAW4v4p1cAos5KvbssEiO
         IFuN0LlI2v32sfQoLme16MMBS+/tG8fS8yTyC6QoHHVbCgE9Fcv19SyLmvLIUIt3HN
         EWAMGiF0Zqz8gJiwXz4+wnX9ze+piWrViPkXVJ0qiem0igNfRiXGu8TS4NK9BWaKkP
         lzKeBxnfEB0XBYvfKSEM9bQavWLfcGn9Oq8jXuzfpZCYIpUflUjkQIJxu25NfQnIHL
         yVcin3zy5Apvg==
Date:   Mon, 22 May 2023 18:29:31 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: sram: qcom,imem: document qdu1000
Message-ID: <20230522-easily-upheaval-6b157fb75da9@spud>
References: <20230522151206.22654-1-quic_kbajaj@quicinc.com>
 <20230522151206.22654-2-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YRD6KCz0QyXVrEcR"
Content-Disposition: inline
In-Reply-To: <20230522151206.22654-2-quic_kbajaj@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YRD6KCz0QyXVrEcR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2023 at 08:42:05PM +0530, Komal Bajaj wrote:
> Add compatible for QDU1000 and QRU1000 SoCs IMEM.
>=20
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--YRD6KCz0QyXVrEcR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGumewAKCRB4tDGHoIJi
0p7pAQCcKAD0LMghKUuUnSu91j7/tuZFtY/814DMwTmbonVSjwD/b6BAHgnsArTH
xKl6NVwfPZJ2Pkcn6TPIBl1xtzT0YAU=
=VRtR
-----END PGP SIGNATURE-----

--YRD6KCz0QyXVrEcR--
