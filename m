Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0157C70FF4E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 22:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjEXUea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 16:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbjEXUe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 16:34:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D262AE42;
        Wed, 24 May 2023 13:34:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D76C61221;
        Wed, 24 May 2023 20:34:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14B4C4339B;
        Wed, 24 May 2023 20:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684960451;
        bh=kiVdWQSTTav/tshrrGYq/uWbw/+JKIr66Tdi+u9F4eg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ePUf6CTM3RQFyjPtTOOcu4EjixxuaPcm824GPFrSFSO3dSTs9ZvGUFN1eJbX6pIvb
         KgmuEDbTPt2s0sNkLZxCWrACnF3VAlzGVOfz7PpfLIWR5b/sFjC+ppfpNW8slpuu+4
         NaZH1U9E6s2wEggXCV61Dxb46Im9taS7IHPEFit+SeCFGxVb1WefmvOYc4SvqHLdJY
         kgWvOkiCiwABLmlVPwgCffeiQKtg/aDlTN4J5LY5xKpJPFvzhrTUn2rUorruoZUXxD
         +iyHCquWKqrEPXzbxHhXPp30rLBDcM88iCPmgZLvppSllPXlG7GsByBq+MgXRs2LMH
         F354+8R5flg8Q==
Date:   Wed, 24 May 2023 21:34:06 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/6] dt-bindings: sram: qcom,ocmem: Add msm8226 support
Message-ID: <20230524-conjure-gag-731ab10fd7ff@spud>
References: <20230506-msm8226-ocmem-v2-0-177d697e43a9@z3ntu.xyz>
 <20230506-msm8226-ocmem-v2-4-177d697e43a9@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nS212F5uUQ8wUpOz"
Content-Disposition: inline
In-Reply-To: <20230506-msm8226-ocmem-v2-4-177d697e43a9@z3ntu.xyz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nS212F5uUQ8wUpOz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2023 at 10:55:11PM +0200, Luca Weiss wrote:
> Add the compatible for the OCMEM found on msm8226 which compared to
> msm8974 only has a core clock and no iface clock.
>=20
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Could you please either send me the cover-letter or include the
changelog in the patch under the ---?

Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--nS212F5uUQ8wUpOz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG50vgAKCRB4tDGHoIJi
0oV5AP4muNXeDIDKZSnwI44nTQX8Oq7xiJgcllvvUusHL5Dq7wEAroPwkJCcfwiA
zWyvNeuCPs9ELGc0lBPSmZUvWOSuvgc=
=WxuP
-----END PGP SIGNATURE-----

--nS212F5uUQ8wUpOz--
