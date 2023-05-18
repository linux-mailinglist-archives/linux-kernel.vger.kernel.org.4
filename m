Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0713708870
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 21:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjERTiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 15:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjERTiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 15:38:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A35E7C;
        Thu, 18 May 2023 12:37:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2B66651CF;
        Thu, 18 May 2023 19:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC741C433D2;
        Thu, 18 May 2023 19:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684438650;
        bh=48S/trYlbvuQ+ZXi8dbcQuCb+JDmr3PM3R6F8Gzah7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aqdy3kBpe8bJjnSZRCR472aUOMcwzytqj3lSAWroHLhrpFlgh5ghqRzISQzdgp8ts
         cJjI4z+lZwNPZvgdPO+CEw4HjREH8r0BfH4lh411FBIA9IsUu9Q0lvXRWsbructKZE
         INA2sWZM/UviEMVJdlsrATPU0/Apg7z3qYpmQV3bqXERJkKLogQS6WHeY8olKETEbd
         7Wb0oi1XxwKifSGg+nnYzWw9ONs65qnahBdAQwWDuPZeW49hYxBPgQ6Q0oodeTSDSO
         6yr+vQVwGFUSt8IPnMDB4P9i8fSREpTnNfIV5lTwre/lSw6KKPO1cWGNP+2L4/fOBk
         6rTFLsFxAhF7w==
Date:   Thu, 18 May 2023 20:37:24 +0100
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
Subject: Re: [PATCH v2 2/9] dt-bindings: timer: Add T-HEAD TH1520 clint
Message-ID: <20230518-hardwood-walk-0c8d6400c131@spud>
References: <20230518184541.2627-1-jszhang@kernel.org>
 <20230518184541.2627-3-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XE3hl1LmPqq7FBDh"
Content-Disposition: inline
In-Reply-To: <20230518184541.2627-3-jszhang@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XE3hl1LmPqq7FBDh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2023 at 02:45:34AM +0800, Jisheng Zhang wrote:
> Add compatible string for the T-HEAD TH1520 clint.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--XE3hl1LmPqq7FBDh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGZ+dAAKCRB4tDGHoIJi
0qPZAP0c/P6VHu9vnZ6dZc+o9GzqiUhmQaEVMAWnHXkRnuG71AEAsfucwpiDftg1
kG6rm5BeQLmS42VK0mHti4Br27u4FAg=
=CdGE
-----END PGP SIGNATURE-----

--XE3hl1LmPqq7FBDh--
