Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45022737397
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjFTSO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFTSO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:14:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F96199;
        Tue, 20 Jun 2023 11:14:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23E6861358;
        Tue, 20 Jun 2023 18:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78B2C433C0;
        Tue, 20 Jun 2023 18:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687284895;
        bh=o75Tf+Qcfifa+fs1Ou+3lX8Ua0X9iXBYdNjivarGk0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q+9ER6Lz9phRbPMEhhY2vVnjxBaId3vSv9ok5Ok5CBN0y9cOqwmB/VEZeylmr/iBM
         7trPLmSMuLwvsNe1KipkTMQmWJvgqxeCHIzAWYnia+07zV31AeAj2cp8WsH3FlX8Od
         YTFuUfbRoLIrTr9Ogs1QD1w4iehqmopnGiLcg9Z8CAgYt41Q1/1lHysc7t5RzZ/l3H
         od4xQZir+iw/samUxckgJOwrzJCVlB3msuBM+mmQtg1MQcOCtfQpnYDPKFS57cFfrv
         PDmJakK4IupM1vKaD975Z3wPix4U3RP4iMSo9HeKtjj1xMwUQUSQLyQVnzmkl8IyA5
         Qiz0FAOD7/LCQ==
Date:   Tue, 20 Jun 2023 19:14:51 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] dt-bindings: riscv: cpus: switch to
 unevaluatedProperties: false
Message-ID: <20230620-darkish-coherence-bd19ceda0b56@spud>
References: <20230615-creamer-emu-ade0fa0bdb68@spud>
 <mhng-9b234a44-e770-48a9-8a7b-d71a9ed671e7@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kMoWClvT2oye9axn"
Content-Disposition: inline
In-Reply-To: <mhng-9b234a44-e770-48a9-8a7b-d71a9ed671e7@palmer-ri-x1c9a>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kMoWClvT2oye9axn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2023 at 10:00:14AM -0700, Palmer Dabbelt wrote:
> On Thu, 15 Jun 2023 15:50:13 PDT (-0700), Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > Do the various bits needed to drop the additionalProperties: true that
> > we currently have in riscv/cpu.yaml, to permit actually enforcing what
> > people put in cpus nodes.
> >=20
> > Changes in v2:
> > - drop patches 2 -> 5, they're now standard in dt-schema
> >=20
> > CC: Rob Herring <robh+dt@kernel.org>
> > CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> > CC: Paul Walmsley <paul.walmsley@sifive.com>
> > CC: Palmer Dabbelt <palmer@dabbelt.com>
> > CC: linux-riscv@lists.infradead.org
> > CC: devicetree@vger.kernel.org
> > CC: linux-kernel@vger.kernel.org
> >=20
> > Conor Dooley (2):
> >   dt-bindings: riscv: cpus: add a ref the common cpu schema
> >   dt-bindings: riscv: cpus: switch to unevaluatedProperties: false
> >=20
> >  Documentation/devicetree/bindings/riscv/cpus.yaml | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

> LMK if you wanted me to pick these up?

That was my hope, please do!

Cheers,
Conor.

--kMoWClvT2oye9axn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJHsmwAKCRB4tDGHoIJi
0lcPAP9PDTzDfzslpFVPTTffz4JXBBY5mQkfPxlJ6jYCbBwguQD/dVMiOZobbFOx
gEHEevW9MOni34UbfMfQdTEzZADtDQg=
=BIXk
-----END PGP SIGNATURE-----

--kMoWClvT2oye9axn--
