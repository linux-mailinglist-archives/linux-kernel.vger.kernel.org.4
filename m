Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38ED970AB93
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 00:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjETWcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 18:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjETWcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 18:32:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0912DAF;
        Sat, 20 May 2023 15:32:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E17060C3C;
        Sat, 20 May 2023 22:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712C5C433D2;
        Sat, 20 May 2023 22:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684621928;
        bh=bVa6uK9/K3yB1y0WkBxJn5O5ITWcDwsD2jSOfJ5DXeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MOZyfAVsfRE/tRxD6FIoGxo1SwTnayLPoDwX7xgcCophTulGA0kaOHOa0DQvRCR0l
         zPKl+0qoIWbHiyHorkzRbNR+pR9rt4vSBI1QWwYsvZijWXyktjBNi91eYjk2al1SMF
         zMfFDALDFu80Q5UzPXOi1SSX/AoU+j4KU4y7+3qCuqCDF970hhMyM+wjqREUZ7u2sQ
         JnOv8p0/JFP1dzglUdToCkfF4KR3nJYn49xBR7hwIU6By02kPyXTjsLSXSFoj5cAXh
         ZbopQ6uiziub7jQ14CA9fz5C8vm1j6ixtYny5eRs3OEeiuAJS5O26trJpRCHPuMcqh
         Cp8++IU4rp6yg==
Date:   Sat, 20 May 2023 23:32:03 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Anup Sharma <anupnewsmail@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        u.kleine-koenig@pengutronix.de, andriy.shevchenko@linux.intel.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add dt-binding support for ti tmp006
Message-ID: <20230520-context-emblaze-2456dbeb2414@spud>
References: <cover.1684579603.git.anupnewsmail@gmail.com>
 <20230520162002.7aba7c04@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="I9PpOQQ+2tdQwxLR"
Content-Disposition: inline
In-Reply-To: <20230520162002.7aba7c04@jic23-huawei>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--I9PpOQQ+2tdQwxLR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 20, 2023 at 04:20:02PM +0100, Jonathan Cameron wrote:
> On Sat, 20 May 2023 16:21:50 +0530
> Anup Sharma <anupnewsmail@gmail.com> wrote:
>=20
> > These patches introduce device tree binding support and
> > add an of_device_id table entry to the driver.
> >=20
> > Changes in v2:
> > 	- Keep the exsisting MODULE_DEVICE_TABLE entry.
> > 	- Removed the inner comma in of_device_id.
> > 	- Order the included header to improve code organization.
> > 	- Adding missing semicolon to fix syntax error detected
> > 	  using dt_binding_check.
> > =09
> LGTM - I'll leave them a little while though for others to comment before
> picking them up.

It may be a wee bit before you here from Krzysztof, but the binding
check issues have been fixed, as have the things he pointed out in the
original submission AFAICT.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--I9PpOQQ+2tdQwxLR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGlKYwAKCRB4tDGHoIJi
0s2WAP0YKDkVZiFEQncIkp8rNF6D0YtaXGgmGUBr6sK8Ho01mwD/T0giA2lzH8jV
khnOtuvsMJkPMCqrjzZiDqciw8I2AQs=
=ZnA+
-----END PGP SIGNATURE-----

--I9PpOQQ+2tdQwxLR--
