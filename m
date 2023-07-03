Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FA274609E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 18:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjGCQSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 12:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjGCQSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:18:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7366DE5A;
        Mon,  3 Jul 2023 09:18:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D45E060FBD;
        Mon,  3 Jul 2023 16:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B815C433C8;
        Mon,  3 Jul 2023 16:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688401115;
        bh=4LhULQvBv3u4TCWPmGK8mdbqMghJy+yfsY9e+Vry9r4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pD65x7xEqcsiKaRYzuibCnVI2RU/JWnnAlXfqoiFXtZXXcUVq16PIE5wAx5iJBPHj
         0dolgSwU29ZLQokGMwlIZ1+ltwiebNOhLPmsuP4yGk2QMRQbZ7K7QJVDxg2GWeQLFp
         VukerBXPlmiMTHHXXOFIt2+4DGI2p65lyIoHyg1Y1es0GYH+HDgjfzr3o44NYZSvIs
         N3//X+9Ce1i4LRPEyERVeKfHjNvlj25PiyzZqdegD7uA90QEaPQZDXlR/DeP5Vk0cK
         gW+Nk7kG8Rpk/BeITJO/ODJSZ4EQHJogvmb/Atr/wcev/99Qi1xwNUgrW3CLUsd3AA
         u6tgoVtgqr9DQ==
Date:   Mon, 3 Jul 2023 17:18:30 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     palmer@dabbelt.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Evan Green <evan@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/11] RISC-V: add missing single letter extension
 definitions
Message-ID: <20230703-gusto-stout-c5b8bd537885@spud>
References: <20230703-repayment-vocalist-e4f3eeac2b2a@wendy>
 <20230703-unlocking-straining-5c814e99642b@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tNKCvW7BqQMvbnRb"
Content-Disposition: inline
In-Reply-To: <20230703-unlocking-straining-5c814e99642b@wendy>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tNKCvW7BqQMvbnRb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 03, 2023 at 11:27:58AM +0100, Conor Dooley wrote:
> To facilitate adding single letter extensions to riscv_isa_ext, add
> definitions for the extensions present in base_riscv_exts that do not
> already have them.
>=20
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

=46rom v2 that I forgot:
Reviewed-by: Evan Green <evan@rivosinc.com>
https://lore.kernel.org/all/CALs-Hstveza+RF0EP2XArXv1Xy5jQWv1VxjsgFbFZDn_9M=
03fA@mail.gmail.com/

--tNKCvW7BqQMvbnRb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKL01gAKCRB4tDGHoIJi
0trlAPwMGJBMxUzESKutNZVGGuYbypLVcToW2OIneFcfCB67RwD6Ag1NrRn8cYUv
9H8ePHqMBaHQ11sajyfC15+udAfC+wE=
=9hWq
-----END PGP SIGNATURE-----

--tNKCvW7BqQMvbnRb--
