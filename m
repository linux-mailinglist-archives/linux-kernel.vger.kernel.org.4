Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C7C70FFC0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 23:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjEXVNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 17:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjEXVNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 17:13:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA26C1;
        Wed, 24 May 2023 14:13:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67ECB61221;
        Wed, 24 May 2023 21:13:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E658EC433EF;
        Wed, 24 May 2023 21:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684962779;
        bh=O4tVFqzxzYJMltd6cz92CwwCySf1erTEHtbiFOsH+OE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JT1cBJ8PDH+s5KW76ymG6ic5d90KB6voto/Su6ZJ9TqYi7V8g2DOZk2okNs55QIPE
         8SCSO5VIxb9bhz7yo9xHKRD9tp0lU247Ry6q3CUpKQMN7EYac1jYaVmwxCaS4baQLd
         W8G3XXoStpIoECvbRhH/nWgM3hQV2izBXajGk9bSdz6jgq4kKPPBXDgBvO2xh7F67Y
         KR10V2K+fEUYWUtVs/IDwChbPcb4vUovO2qaT7VVrFKkF2yV6Y7y0hFrQqfuGc1MxH
         4Pm0ZVv//CR5CnivIeiRzrbO2nCR3Qq1y2PGbIxJJP76azryjt5r6PQY7e2AyC800Y
         fWmUTD6Bb755Q==
Date:   Wed, 24 May 2023 22:12:54 +0100
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
Message-ID: <20230524-sesame-badly-b641dd49b2f2@spud>
References: <20230506-msm8226-ocmem-v2-0-177d697e43a9@z3ntu.xyz>
 <20230506-msm8226-ocmem-v2-4-177d697e43a9@z3ntu.xyz>
 <20230524-conjure-gag-731ab10fd7ff@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MRlk0mJGvtQbkhPr"
Content-Disposition: inline
In-Reply-To: <20230524-conjure-gag-731ab10fd7ff@spud>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MRlk0mJGvtQbkhPr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2023 at 09:34:06PM +0100, Conor Dooley wrote:
> On Tue, May 23, 2023 at 10:55:11PM +0200, Luca Weiss wrote:
> > Add the compatible for the OCMEM found on msm8226 which compared to
> > msm8974 only has a core clock and no iface clock.
> >=20
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
>=20
> Could you please either send me the cover-letter or include the
> changelog in the patch under the ---?

Apparently I did get the cover, but in another mailbox for IDK what
reason. Sorry!

>=20
> Otherwise,
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Thanks,
> Conor.



--MRlk0mJGvtQbkhPr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG591gAKCRB4tDGHoIJi
0gInAP0UWgoIftKXeOkrEkouygZ+REuYZ1hiD+xn6WbVRSDAyAD/b8FuHIVmUBmu
6jmEoMlmJSBHbbVNJe40n8+/NNOO1QE=
=G8Yn
-----END PGP SIGNATURE-----

--MRlk0mJGvtQbkhPr--
