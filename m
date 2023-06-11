Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F6C72B154
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 12:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjFKKV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 06:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFKKV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 06:21:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AC812B;
        Sun, 11 Jun 2023 03:21:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C62761086;
        Sun, 11 Jun 2023 10:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696E8C433EF;
        Sun, 11 Jun 2023 10:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686478914;
        bh=eDy1DNnFmuqct2VM5FZyW/QF4ZpT++8h8SfJtyuKwWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=crix+RAzPczBIvCUNOTOtGmr51kjEkLyMRIif2FGs/Wj63GML/XRx8wbbffMRURWj
         Xdj8FDVuZxtQi5SZgQ4vtvL4njVRIriONzPtWlwVniFzlpAfLDlw8ArZ83VRG7Hfmj
         c2poavuA7dKGhcxMmppwXl8AYbL6sGbBGKXiqoTZXhnSC+tL9xqXM1EC9xt554hqWJ
         Gehbnw3u0PM/xsWc5CYFADJe+UYKvI1x2ce4lGeN7kmEakEi4J/0iB8676wn8zWHRq
         d8sTF0VYbFCkiWl4nzsSn2ziMGTjfndy4eeLoJ58iTrJG1nwtMdchrj+epLrgdC/62
         m08HeCfqu0nfQ==
Date:   Sun, 11 Jun 2023 11:21:47 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Maksim Kiselev <bigunclemax@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: thermal: sun8i: Add binding for
 D1/T113s THS controller
Message-ID: <20230611-lilly-lilly-fba1c6fe8c5d@spud>
References: <20230610204225.1133473-1-bigunclemax@gmail.com>
 <20230610204225.1133473-2-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pp3DI5TDdJDuqtL4"
Content-Disposition: inline
In-Reply-To: <20230610204225.1133473-2-bigunclemax@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pp3DI5TDdJDuqtL4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 10, 2023 at 11:42:18PM +0300, Maksim Kiselev wrote:
> From: Maxim Kiselev <bigunclemax@gmail.com>
>=20
> Add a binding for D1/T113s thermal sensor controller.
>=20
> Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>

Since the calibration stuff now makes sense to me (and thanks for that),
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--pp3DI5TDdJDuqtL4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIWgOwAKCRB4tDGHoIJi
0udzAQDzhi9sIZfLH+m04LetoCOBs1Pmxigngt06hVp/ljyoNAD/abfWCWC5ETGg
5j257iZ4rNVAc0LpMOZfitAsJZ3c3Q8=
=bfL2
-----END PGP SIGNATURE-----

--pp3DI5TDdJDuqtL4--
