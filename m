Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC8972EC65
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239494AbjFMT6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjFMT6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:58:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5376118;
        Tue, 13 Jun 2023 12:58:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A73662EFF;
        Tue, 13 Jun 2023 19:58:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B68BC433D9;
        Tue, 13 Jun 2023 19:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686686295;
        bh=QPM/JQWhbc9ZZFnSxIH9LpBG+rM6NnSIOmkQYnFam2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q2tv+6r7KPOuZdnOaI6L85b4er2mP+vze4RjmckW5gNfhf8TP6eZGC2AODQOSpvRn
         j3ZwarKkPLqZ6zh00fXBpCayD8u5JuFSGi0KzR/rEuk61CtiJbn9FDKnDgE5hC0qy+
         JuXv0rWg7iDo9ez0jrjDFNVcSNgIyLKdRcDa8vKZYAwZEmHKnOXC7UU56e4LIBjGds
         9br6TtzsjCFFTpqhhFYEcaFVFvikQcZAbR/+0ZKigcCh/LxeX/korJBqvo95J4z1/R
         QUG60rBCMBPNDMUzHtfl+ZMtCFM5S7PmpUYSh2Nj5YJlRrMYOa3SxfWXQbbexsMaz2
         fbmbWNsl2chhQ==
Date:   Tue, 13 Jun 2023 20:58:09 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 6/7] riscv: dts: starfive: jh7110: Add syscon nodes
Message-ID: <20230613-keep-sliding-e34c39f2774e@spud>
References: <20230613125852.211636-1-xingyu.wu@starfivetech.com>
 <20230613125852.211636-7-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GKfT6rNBPc8xWVRn"
Content-Disposition: inline
In-Reply-To: <20230613125852.211636-7-xingyu.wu@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GKfT6rNBPc8xWVRn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 08:58:51PM +0800, Xingyu Wu wrote:
> From: William Qiu <william.qiu@starfivetech.com>
>=20
> Add stg_syscon/sys_syscon/aon_syscon/PLL nodes for JH7110 Soc.
>=20
> Co-developed-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--GKfT6rNBPc8xWVRn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIjKUQAKCRB4tDGHoIJi
0s8PAP4pzKCLwQ1EUqVXVMsQZlfBsL2tUqNrjaETDC2XMH3B+QEAhFyfospNgT3X
OJ2WHFf6HkK15ZnACS9Ik7nKZK2xLAo=
=i2sK
-----END PGP SIGNATURE-----

--GKfT6rNBPc8xWVRn--
