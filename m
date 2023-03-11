Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA1C6B5C0C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 13:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjCKM4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 07:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjCKM4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 07:56:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C35101F28;
        Sat, 11 Mar 2023 04:56:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45C3860BC1;
        Sat, 11 Mar 2023 12:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2387CC433D2;
        Sat, 11 Mar 2023 12:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678539404;
        bh=SVKT2tlVgR4kmjgwkwYg/YZjMp5Rbrtwa0inqkDaNRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rVva0TiSi9gsfM702I1FOxZOyrelUaECsuxtKA3rd1puDDILnnv5BmF6x10QdXcmO
         K0BczMuYtw0j8Qw998PxF4sT8g9+BfC46iG0QqQnheQc1z+6kD4rfnAQJPT8S7/mAh
         1jE0rBRZI9BIhlAVdCCmkngQEwt+uk0tcVPWEdWW964u6nwLy7YlBnroIjMq4liU8K
         sZc7cBw6ScDPj07X5RAs1Xqo+9UWr8p8RDRy1b2mMxcu1rQ/Wzdva+O0g7Gq4XNOLF
         W5FhuLqINdqci6GSt5J3MbROMa1cejEhW0zQID+SIlgCCjRXbQmpu+N8n6sNQ0lzBB
         gLghqDNUWpU8g==
Date:   Sat, 11 Mar 2023 12:56:38 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 05/21] reset: starfive: Replace SOC_STARFIVE with
 ARCH_STARFIVE
Message-ID: <d04e0c9c-9d78-4af6-b6c2-77129f6a9c44@spud>
References: <20230311090733.56918-1-hal.feng@starfivetech.com>
 <20230311090733.56918-6-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HmUvBcXkJbp6emfl"
Content-Disposition: inline
In-Reply-To: <20230311090733.56918-6-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HmUvBcXkJbp6emfl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--HmUvBcXkJbp6emfl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAx6hgAKCRB4tDGHoIJi
0oFOAPsHigDLYTOnkkGO1ybXlSMETKL/8Nw5hyNbCiX9/zkSygEAoKYeQK/IfApW
XAbUiL3tMFSmJvxIwpXM3OlVX22EYAQ=
=5l1P
-----END PGP SIGNATURE-----

--HmUvBcXkJbp6emfl--
