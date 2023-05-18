Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F32A70886D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 21:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjERThM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 15:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjERThG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 15:37:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E263B199;
        Thu, 18 May 2023 12:36:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DAE8651D6;
        Thu, 18 May 2023 19:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59833C4339E;
        Thu, 18 May 2023 19:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684438617;
        bh=HmmA947lbPkI5VPGJi4CvyBYO/PqjO5ZEsI8MkVFGBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uPqjlzN2XirTFxtn/nWN5Za0q3U5VcJAK7dOFneoRhCV+aLYQVqj8r4q0hXWA6tNq
         7QOtTyd/1IPMyaJe03VAu94KRi3k2Mr4JWQoXqpfylWDPyYczlw7feYRoJ143yK7JK
         8MfcqLbpIEesqyxJkExVZsbMz+H5m91L3M7RiFS6x7KDe3b5GXoPxbkd1TFz4M5Vk7
         WnBioFqQpnthNj0U4mUJG0ZlLHGBqFBZZB9o/3oZfujtnfZnZ0poVhgH81XlHVGi7H
         AXsM0jJhikbssNmi/kLzyhUdJ0X90Bz/Mz/A9/K60SOLFUUF9MXFkUAp03eH87pRmI
         AhAXDgrQCjxbA==
Date:   Thu, 18 May 2023 20:36:51 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Yangtao Li <frank.li@vivo.com>,
        Wei Fu <wefu@redhat.com>, Icenowy Zheng <uwu@icenowy.me>
Subject: Re: [PATCH v2 1/9] dt-bindings: interrupt-controller: Add T-HEAD's
 TH1520 PLIC
Message-ID: <20230518-fetch-essential-94a36fa3ca28@spud>
References: <20230518184541.2627-1-jszhang@kernel.org>
 <20230518184541.2627-2-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="63Cg3z6uikryQhIS"
Content-Disposition: inline
In-Reply-To: <20230518184541.2627-2-jszhang@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--63Cg3z6uikryQhIS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2023 at 02:45:33AM +0800, Jisheng Zhang wrote:
> Add compatible string for T-HEAD TH1520 plic.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--63Cg3z6uikryQhIS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGZ+UwAKCRB4tDGHoIJi
0mM+AQDknQzLLt2ANvZGKCCzkHR/sCTD7Eemb4V3ZeNQwJkOSAEAif5MkwEXv4VG
KKyb8rPNwnhyIWet0QV/Fu2DZB9AUQk=
=g/0j
-----END PGP SIGNATURE-----

--63Cg3z6uikryQhIS--
