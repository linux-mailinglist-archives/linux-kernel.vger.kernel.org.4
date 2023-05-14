Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28DA701EDE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 20:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjENSRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 14:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjENSRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 14:17:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C85E7D;
        Sun, 14 May 2023 11:17:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58B5C60C83;
        Sun, 14 May 2023 18:17:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A925C433EF;
        Sun, 14 May 2023 18:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684088253;
        bh=SXJLVv/HvNDzSRRKMFSxrVM4xR+cEIslWBlIbmqArow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iE6+p7ALLemY+7tmB7CNTX4o5H7iYKssz/NaNU+tfDQZQ/sorTRwd7Fbf+ZAWbuIY
         dXyfw+odRVZoe3FUn7+m5tWtJYurYT7PZTRX9Lpz2b2GJeTLA+Po4SZoVdpRnGKoxH
         tPsCevqXuuScEcRncjUQqQVGCTjVObKPvDWsFDFqmqE0mMDNYk8xVSl10eHoQJri9l
         ylEqq2QbSXYc603Tegi9kKMFRZIJalHwQbvIPytXWFL5NUyTexD2csMuTSgORd+FOB
         UE3bafqueIaM17vgICWjFjgWlt4yJoKs0Km7QA8e/TSL11xc/5KoAcut/DgmnqgxhD
         MPhgPhkKIR6pw==
Date:   Sun, 14 May 2023 19:17:27 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v3 03/10] dt-bindings: serial: add documentation for
 Bouffalolab UART Driver
Message-ID: <20230514-bust-slam-10c7b9cbe455@spud>
References: <20230514165651.2199-1-jszhang@kernel.org>
 <20230514165651.2199-4-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ki4ujBbqbmYfXfWC"
Content-Disposition: inline
In-Reply-To: <20230514165651.2199-4-jszhang@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ki4ujBbqbmYfXfWC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 15, 2023 at 12:56:44AM +0800, Jisheng Zhang wrote:

> +$id: http://devicetree.org/schemas/serial/bouffalolab,uart.yaml#

$id: relative path/filename doesn't match actual path or filename
        expected: http://devicetree.org/schemas/serial/bouffalolab,bl808-uart.yaml#

Please test the bindings before submission - even dtbs_check catches
that one!
Otherwise, looks fine.

Thanks,
Conor.

--Ki4ujBbqbmYfXfWC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGEltwAKCRB4tDGHoIJi
0sJzAP4wOVsTrnPAx57F7gbDXMwebUBq2uM/cNtSEUKhxRG3hQEA1rTf27u+b4/N
rFfHcmLPetqevaLUWqT9ZTVqLimRyAA=
=QtXo
-----END PGP SIGNATURE-----

--Ki4ujBbqbmYfXfWC--
