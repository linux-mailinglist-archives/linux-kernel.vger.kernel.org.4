Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E8E716AD1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjE3RYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbjE3RYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:24:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2765D135;
        Tue, 30 May 2023 10:23:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3350663104;
        Tue, 30 May 2023 17:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3199EC4339C;
        Tue, 30 May 2023 17:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685467370;
        bh=qMMPUtaJSONqNXtjuUIaCX7ex1x9cEgWQzEJe3CG/fM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qisgGL/Li02iPPF7G4zG9w3Ax5Zw/EcjPGQJVIFMuzAsXxVxnG4W76pxR8AaOtlhK
         +6Wy6q5mDwKFv9I8sPSZMNTmXTpiNN8YPFWSBjixB7IU+pnbXi9hwwdcacYulSCdbe
         /9At1FZbjAeaREF+d57ytivPnX2yndKC5cVb3GWQeD/TbOq0dU1UvWV1GCHncmezFv
         kXjcxLVnnXIVhMQtolBM+lNGLPD7h1PTMER1CRDXKQci/Nih8n1V0iu0ux5fLTs1t7
         zhg8YzqXrZrSmyO+tettNTfZOjtf5U4hDa7phPQyABVtsr/jdo2INEaYmWpd4ypcZ5
         PbF2ljRKGkNMQ==
Date:   Tue, 30 May 2023 18:22:45 +0100
From:   Conor Dooley <conor@kernel.org>
To:     fl.scratchpad@gmail.com
Cc:     jic23@kernel.org, Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/5] dt-bindings: iio: ad7192: Add mandatory reference
 voltage source
Message-ID: <20230530-spoils-cod-c606ff33e75a@spud>
References: <20230530075311.400686-1-fl.scratchpad@gmail.com>
 <20230530075311.400686-5-fl.scratchpad@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hIUF/pXFAuUX8uSY"
Content-Disposition: inline
In-Reply-To: <20230530075311.400686-5-fl.scratchpad@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hIUF/pXFAuUX8uSY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2023 at 09:53:10AM +0200, fl.scratchpad@gmail.com wrote:
> From: Fabrizio Lamarque <fl.scratchpad@gmail.com>
>=20
> Add required reference voltage (VRef) supply regulator.
>=20
> AD7192 requires three independent voltage sources: DVdd, AVdd and VRef
> (on REFINx pin pairs).
>=20
> Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of staging")
> Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--hIUF/pXFAuUX8uSY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHYw5QAKCRB4tDGHoIJi
0p1mAQD5TaFfWdF6Y+ChN/bcpS9KNPvj48Qj8SBqCW5Fztk4TAD/cVfgXHGMFsG2
MHk+7lYF48Xbq/2TCltKYLN6TVnU5wg=
=iYb+
-----END PGP SIGNATURE-----

--hIUF/pXFAuUX8uSY--
