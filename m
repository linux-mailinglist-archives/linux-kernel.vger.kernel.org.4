Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C231708882
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 21:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjERTmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 15:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjERTmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 15:42:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5CCE6A;
        Thu, 18 May 2023 12:42:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BEF364AFB;
        Thu, 18 May 2023 19:42:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEAF3C433D2;
        Thu, 18 May 2023 19:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684438940;
        bh=kagisqiUflhHKXt65nKKdcvfz9NOOF0MBvMvX84P98o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IaAU/Ip1xoU/aJ2js9QJaEOr0E8o1u19morcs77+0Hb87dU65U6n6kvg4eGxd1hHc
         skqffBXmlh5wo8/dlH2esKOf4dh9Unusn9GzfAyH0Z4TfxVpzkgQhnap6YWVr8zrdD
         aGfO2lz8w/WZZ+5G+DODyZENOF72QJiEC3yCjTd2pMQ/PWY/Z5CtcSDednvPhC5bkP
         PiJdUz7/YkrqVuhj7ALqKV8ddyjtBxcGlZeXp71B+oUApEjdrS52//H+ji7yaSk/Db
         Q0/HNVKFg3ca1WFFtLIzgcbflFEsZVSiCZOlBHFPqlSCT3Fk14qhZIgQDKc0JIiccH
         NlpoQQOuubW5w==
Date:   Thu, 18 May 2023 20:42:15 +0100
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
Subject: Re: [PATCH v2 5/9] riscv: Add the T-HEAD SoC family Kconfig option
Message-ID: <20230518-affected-tackling-5b2f97debbcc@spud>
References: <20230518184541.2627-1-jszhang@kernel.org>
 <20230518184541.2627-6-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eK8PStAoZ5yEhGV0"
Content-Disposition: inline
In-Reply-To: <20230518184541.2627-6-jszhang@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eK8PStAoZ5yEhGV0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2023 at 02:45:37AM +0800, Jisheng Zhang wrote:
> The first SoC in the T-HEAD series is TH1520, containing quad T-HEAD
> C910 cores.
>=20

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--eK8PStAoZ5yEhGV0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGZ/lwAKCRB4tDGHoIJi
0jRYAQDJpFHskC8YlHAcbhrUQGr4fUTv65zT24FhJw4zJPSuXwD9EnG3KcGr/emW
M6ddKLwnWG4cHXIR5MbLRXYZKpzyPww=
=tyBT
-----END PGP SIGNATURE-----

--eK8PStAoZ5yEhGV0--
