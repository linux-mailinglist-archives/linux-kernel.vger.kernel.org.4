Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F54670A713
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 12:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjETJ77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 05:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjETJ75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 05:59:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255A8E46;
        Sat, 20 May 2023 02:59:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6F9360FE0;
        Sat, 20 May 2023 09:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B863DC433D2;
        Sat, 20 May 2023 09:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684576796;
        bh=DxoajCPa+2FvZZ5OhrT8JkkDXOxmrx33rD6QPWVeGqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pnBKgCHh2Q+afDI+ZhBdd1yB/TC3tRFlHvcThgL37HN7hPeY501rNvey5TpCg8ahS
         p05rFzz0JNZNbxBVmOMj5rWYhqwXfnhFnE76NFzlm8ksVkjeh0Eu5WOZHT+mf9NVIU
         5ZBgI4K1NGbUlnR3ahkiTjWknQQv33eaqqOHE/Cdqw0p11KwCzAUPtBw9wtp4gYPgd
         61iok8Jl/wy2qpA6ywjBY7bd76rvwSLUW+xScI6+H9LzVvlYbiPKjxlZoOvj3hwHDJ
         NMpM3P4eOJnRKhHt6z40Cb57ooL/lopO/Y/ykYCINC49dGjDacgD8Zs/e87IUQm0n0
         ELpkA8v3nBDTQ==
Date:   Sat, 20 May 2023 10:59:51 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Matti =?iso-8859-1?Q?Lehtim=E4ki?= <matti.lehtimaki@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: sram: qcom,imem: Document MSM8226
Message-ID: <20230520-waltz-growing-13c2536672d6@spud>
References: <20230519210903.117030-1-matti.lehtimaki@gmail.com>
 <20230519210903.117030-2-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aHnMxTr/suFljBxF"
Content-Disposition: inline
In-Reply-To: <20230519210903.117030-2-matti.lehtimaki@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aHnMxTr/suFljBxF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 20, 2023 at 12:08:58AM +0300, Matti Lehtim=E4ki wrote:
> Add compatible for MSM8226 IMEM.
>=20
> Signed-off-by: Matti Lehtim=E4ki <matti.lehtimaki@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--aHnMxTr/suFljBxF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGiaFwAKCRB4tDGHoIJi
0m9BAP9Fs9SqElbBNdiIcqgKQXkILr2JclrTyc15gnm3eqUxPAD+PRA14Dnvy6Et
WLuMC/14lmHv/xCXCR1KzcEIyJmbXgE=
=KCh3
-----END PGP SIGNATURE-----

--aHnMxTr/suFljBxF--
