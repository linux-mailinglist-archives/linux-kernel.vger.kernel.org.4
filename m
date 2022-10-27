Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0ABC6100C4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 20:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiJ0SzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 14:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbiJ0Sy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 14:54:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FC323E88;
        Thu, 27 Oct 2022 11:54:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4066B8276C;
        Thu, 27 Oct 2022 18:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B693C433C1;
        Thu, 27 Oct 2022 18:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666896892;
        bh=Kun1EPlhNAljLOOaLOtA+3eyTsZ+9G8Vw30cBcFPzrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gG3+6gQ96c5YkWOO1XAfUf+tlK5NY4nF4uTtmxhAOG9iUO7MH9NjYl9uV+zXmZ6Bm
         kFj0j3YREptD0FDWmPJ24tgUVBO3t0ApQhzUwcvP9b2hiUTQqC9d47bFYNT1vs8hwQ
         i/c6SqDjPDKCrAbV6p1kiVsv2/u5agF8eijGbDwULjDnDHxoF0sbAcvBzcfkCtwfnd
         TSL+BgYXXEBX+dHAAH2unY4GjcdQ6sKFPNi8ZompKDMZwhl0/GacW8Sj5E+kYczgjr
         cpztnNKpPTfvQHkzReT7E4YAqXTDz3MCDfL0W9XJtJO6W5s9ZgKbivsWxULuzcx8hK
         kgFA8999iDY4Q==
Date:   Thu, 27 Oct 2022 19:54:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Rob Herring <robh@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Naresh Solanki <naresh.solanki@9elements.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH 2/3] dt-bindings: regulator: Add regulator-output binding
Message-ID: <Y1rT96QzwIn5pIVn@sirena.org.uk>
References: <20220925220319.12572-1-zev@bewilderbeest.net>
 <20220925220319.12572-3-zev@bewilderbeest.net>
 <20220929210714.GA2684335-robh@kernel.org>
 <YzYNt+IQRomycRLs@hatter.bewilderbeest.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M3zmNXbrrfzH3Cim"
Content-Disposition: inline
In-Reply-To: <YzYNt+IQRomycRLs@hatter.bewilderbeest.net>
X-Cookie: Forgive and forget.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M3zmNXbrrfzH3Cim
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 29, 2022 at 02:27:19PM -0700, Zev Weiss wrote:
> On Thu, Sep 29, 2022 at 02:07:14PM PDT, Rob Herring wrote:

> never as any sort of default/automatic action.  The two obvious things to
> guard against there seem to be automatic enablement during initialization
> and automatic disablement on de-init (shutdown, unbind, etc.).  The former I
> think can be avoided by simply not setting regulator-boot-on, so I added
> this as a corresponding property to avoid the latter.

> I'm definitely open to suggestions for a better approach though.

regulator-boot-on mainly exists for handover of state from the
bootloader where we can't read back the state of the hardware rather
than as a control for boot purposes.

--M3zmNXbrrfzH3Cim
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNa0/YACgkQJNaLcl1U
h9B8Rgf8Du4thvptLuiv5L6LjqHMUAYet63k3rRYwGIvleliwoEFk8gYQZEKdFGB
UEvvGOWF+AY0gTKrHEtdHgYUOi2QTwN2quCetFLxTajIVYtluNKZ76hi+9Zt7xaN
JlSpqehmuCeCHsxzSjMfCgDTPJL7jnVFORAk7azYpQt+22dzgGwimK/QUq0BDwEX
Sz7moED/aqfH5MiDo9tIS6OoePaXDqlUOBAgoQOe8pDwNN/ZZsvJ8H5AlDMBV7tL
KbCtshLetmnDzd7a/pbi6zOkagoRhqHkP1TQAdxZXdDN/RThDsMXZ40IK7YEKbLy
zar4ki4tO6ZqSMJ31ztcMXVgYzaQmg==
=S//I
-----END PGP SIGNATURE-----

--M3zmNXbrrfzH3Cim--
