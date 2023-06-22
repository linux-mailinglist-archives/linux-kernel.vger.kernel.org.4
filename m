Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9835773A8AE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 20:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjFVS7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 14:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjFVS7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 14:59:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C622FE7D;
        Thu, 22 Jun 2023 11:59:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63744618D6;
        Thu, 22 Jun 2023 18:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E127C433C0;
        Thu, 22 Jun 2023 18:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687460378;
        bh=NV9aTfcB04hyaA/wBUYwR/eWp1snE1/lwhMpdPWU8zE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DJDv0M49XxR7xapPfqyDpyau9GCb+JU7gfceKdSrjxnku2eDn6Yi10Rdm7RbTgGJp
         kZ/GA5PD8qX492Qf9yQ4FG3JiymJ5omsdksYTg3Lv3tuPkV4TivY3Up00cBanE/IvZ
         VVcBqY7VZXd03W/yLJqos7ps1HijN1ZQAXFiuWUggdwx9dVVuRI8td3MzYRC0EraZn
         ddQxdMsljEv3T7nAu3kh5spV2aCgwicGzwmsDyrcY1QrsGzDN1f9FDsDkmzuxJLk30
         8RZG8gqMOB8HSFmLHDK960sBCoBuN7kcaok7FVd/AyT8MwdBmls5iBW+U96BaeA6Ku
         29wqvCkpK3vTQ==
Date:   Thu, 22 Jun 2023 19:59:32 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Alistair Francis <Alistair.Francis@wdc.com>,
        ajones@ventanamicro.com, apatel@ventanamicro.com,
        atishp@atishpatra.org, jrtc27@jrtc27.com, rick@andestech.com,
        ycliang@andestech.com, oleksii.kurochko@gmail.com,
        linux-riscv@lists.infradead.org, qemu-riscv@nongnu.org,
        u-boot@lists.denx.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: riscv: deprecate riscv,isa
Message-ID: <20230622-stipend-flashily-97917469f39b@spud>
References: <20230608-sitting-bath-31eddc03c5a5@spud>
 <mhng-aa00c037-6201-4548-9036-1d6dbbfc9343@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zHw74JTtVBfhm0Fq"
Content-Disposition: inline
In-Reply-To: <mhng-aa00c037-6201-4548-9036-1d6dbbfc9343@palmer-ri-x1c9a>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zHw74JTtVBfhm0Fq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2023 at 11:25:35AM -0700, Palmer Dabbelt wrote:

> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>=20
> I'm not wed to any particular encoding for the properties, IMO that's more
> of a decision for the DT folks.  IMO the important bit is to just get away
> from ISA strings and move towards some tightly-specified properties that
> indicate how the HW actually behaves.

I'm going to resubmit with Rob's list of strings. I'll keep your tags,
since the spirit of the patch will be the same, with enforced meanings
for each extension.

Cheers,
Conor.


--zHw74JTtVBfhm0Fq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJSaFAAKCRB4tDGHoIJi
0nLsAP9kIuB4WQ2zaDQIzZJDUmQQv0dwtsHhgVoBlQDxIsLhOwD/RSmCg2YNJLDn
bReL/deUbjlXqTBNq+D6jzJQm7r6VQ8=
=eP0v
-----END PGP SIGNATURE-----

--zHw74JTtVBfhm0Fq--
