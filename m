Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DF9731F69
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbjFORkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjFORkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:40:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADB8271E;
        Thu, 15 Jun 2023 10:40:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A812161699;
        Thu, 15 Jun 2023 17:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A11C433C0;
        Thu, 15 Jun 2023 17:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686850835;
        bh=vqU6dirgEC8/IAf15RrIFka6wBf5PWMJGHsHVuhG1i0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QRJwE12qPoIbZk/MdTsvAkT23bwzOBP63RT4WjdWZVAQP9sUeRlMJw3JrJ5DjyPqx
         SCy+zvs1/Ovc+CtizzMuNkWp09RW9wYgApxu7B3bK+GYV6kPKsc/4lfaxJa5HVcgr1
         uoxSLaTcvWtzXFesIgY4rQ+6Mhvl5vYE9UYHKU2mjoPkS9HA07+I/zdwP1Q86CXk3F
         QZfkjURlR1k/oxD5nWT6z4t/K+omYNrsldwUcCat6vvGVfsfg3oZHwRsTzjO350F/z
         La+NP4tiGhJxbEXDAAfaywliR0YnN25XRjxhPg5Oa8BU8T0Q9Z0gHfVjHGmFRsd2qy
         dOlm5sAKels1A==
Date:   Thu, 15 Jun 2023 18:40:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Valentin CARON <valentin.caron@foss.st.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] dt-bindings: spi: stm32: disable spi-slave
 property for stm32f4-f7
Message-ID: <1e831d7c-cb38-4ac3-ba53-1fbb20423202@sirena.org.uk>
References: <20230615075815.310261-1-valentin.caron@foss.st.com>
 <20230615075815.310261-4-valentin.caron@foss.st.com>
 <479bf05e-342d-f94b-87f3-4cc0a95fb01a@linaro.org>
 <b25d30de-8a22-b5ea-e58c-78b3d55b3cac@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s0RwalaAUfUSjMSq"
Content-Disposition: inline
In-Reply-To: <b25d30de-8a22-b5ea-e58c-78b3d55b3cac@foss.st.com>
X-Cookie: You are false data.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s0RwalaAUfUSjMSq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 15, 2023 at 07:38:36PM +0200, Valentin CARON wrote:
> On 6/15/23 15:36, Krzysztof Kozlowski wrote:
> > On 15/06/2023 09:58, Valentin Caron wrote:

> > > STM32F4 and STM32F7 can't switch to spi device mode.
> > > Forbid this property with compatible "st,stm32f4-spi".

> > Just to clarify - driver cannot switch or hardware does not support it?

> Driver can't support it right now but hardware can.

That shouldn't be a restriction in the DT then, please send a patch
dropping this.

--s0RwalaAUfUSjMSq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSLTQsACgkQJNaLcl1U
h9CKjAf/WPDS/CcbstHeaOr6BdtAydD//XXBQyx+pfD0IPD95FHAUwMB6zSldA2z
0J7gV535K/RlxZ+S93Tz3zSkV4lEM6K/1ytKXT1ZS7Nv/McWwey6ByuP9uHTlDWX
thCjOJIQOFr6SwbmYsCA9loj6j1NAVuPei4t6RO7lWW3GGz93KoxexyqE9IsnEmz
+uZZ/2Ut3PgkFoduYs3LCwuwYcRWO5/xutqVE9WAXQXduZbpiHJuRb2P4AcDx6t2
qcuRGnZ5O+1xO+eV0r0U6GfuDb3T6vK52p/W1pkVWVQlUdC/IbBIsERAK+gfyy6j
W1scy4S6HNlIbra4E+lhnQIQ9KH2Og==
=URnM
-----END PGP SIGNATURE-----

--s0RwalaAUfUSjMSq--
