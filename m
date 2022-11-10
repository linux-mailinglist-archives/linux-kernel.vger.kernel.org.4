Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3686241D9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiKJMBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiKJMBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:01:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5D71B1D0;
        Thu, 10 Nov 2022 04:01:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 231D6615D8;
        Thu, 10 Nov 2022 12:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADDBC433C1;
        Thu, 10 Nov 2022 12:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668081663;
        bh=nJA6lVr6zgeitszBqXo+vCIv1PWS9CxH/k89lrSezzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YwDUDPzxlqtjltIIWBWr8WtYZkATmN3l4/u1T//eXkcnmeOFo49LNvhT83dIufhj/
         gOrTYoF49BrZYxvkQz8IuPVVXOzPdNl/H7xSnr8jdp+06HG1X4DAp8BTHF8FxM7c6e
         LpAdRBQEgSEwAu5WBWa4ovqTZFWpZST8WbCpafllI+iYSXMKb5AZmZsYZO3Wm0lKFa
         4qTvl2yhlL14iS1wk3GVbe8DosfgN/rIFEn1bs/xFSbFO5kq9OPjQQBhcbva4OT8Cf
         tFWmMSkNazlukJ8zD+W0X6OjHOqImun/uRemLb1XrVQQq7lJPxcL1tNjxO/0CEufsk
         o+2gSI6ggGyWg==
Date:   Thu, 10 Nov 2022 12:00:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     andersson@kernel.org, linux-arm-msm@vger.kernel.org,
        krzysztof.kozlowski@linaro.org, agross@kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, patches@linaro.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: regulator: qcom,smd: Document PMR735a
Message-ID: <Y2zn+a7eL8PnGgWo@sirena.org.uk>
References: <20221109110846.45789-1-konrad.dybcio@linaro.org>
 <166807822235.115312.17138185226634439165.b4-ty@kernel.org>
 <bf3e5725-8cf7-3a0e-aa9b-0b05a4507868@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1soP19EYi/kSFqKE"
Content-Disposition: inline
In-Reply-To: <bf3e5725-8cf7-3a0e-aa9b-0b05a4507868@linaro.org>
X-Cookie: Torque is cheap.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1soP19EYi/kSFqKE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 10, 2022 at 12:09:10PM +0100, Konrad Dybcio wrote:
> On 10/11/2022 12:03, Mark Brown wrote:

> >     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

> Please apply v2 instead:

> https://lore.kernel.org/linux-arm-msm/20221110091736.3344-2-konrad.dybcio@linaro.org/T/#u

As the mail you are replying to says:

> > If any updates are required or you are submitting further changes they
> > should be sent as incremental updates against current git, existing
> > patches will not be replaced.

--1soP19EYi/kSFqKE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNs5/kACgkQJNaLcl1U
h9C4Ewf/SHnnNEjZLkzNtk+rdcrPTtswUMrxgkedFWh/57GMkuA7p5zDjAXECpYm
2ePQYgKNfj3XmtXOfS+q+rRBO1xmncS9l8gvo1jKesSPk8jGsQ9KanBmjT2wH+Gb
yz2RCLDusrNm7rz18H5CcVR9fSMb+lCugjywrb2GlTnfyax8hA3RtnuYEg/8QA1R
bqZTm6E2cvK75GVIV0uKdvX4w2fcA8WmPfrJrHdEZXYvrdmLJVZQHUuMILvDroJW
ZJQvQGZ3BYn5DZFE8J/DbWhQHfbWoNUMHVGHbNYKiNXxLtjcSbYVfeQlzjVG6luN
OckQVWFaQfYiVIbWjsk8LWfit2fRzA==
=ApaU
-----END PGP SIGNATURE-----

--1soP19EYi/kSFqKE--
