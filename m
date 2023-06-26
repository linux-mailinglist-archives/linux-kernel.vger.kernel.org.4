Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F142B73E6E9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjFZRuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjFZRuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:50:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D713134;
        Mon, 26 Jun 2023 10:50:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC4CD60F01;
        Mon, 26 Jun 2023 17:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80599C433C8;
        Mon, 26 Jun 2023 17:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687801817;
        bh=s4nqEhUfqmqOPxDNx5EU+3Otzr9YMuFYasx7vWRTl7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BUi3o0EUGax7OuYJDS2t1keD6ocU7m+LNpkHxmMX6C+bs9JlOACvcRkXqAxfYgb7P
         JK7UHHt8lcVq+ADNCujsH5eo4qhfWCQufbWhtJW7Zojw7WrQbZIt9Zzw7RT4CIpCl2
         sa1IN70Xv9F8Qpl2Gdw9U7ZfsE3dNjRtCe3tZx9XnBWI2eZQI0F4Gdy9DvIbS80RGd
         HKBUm4qzDoUr0JvVZey1UqzJgF4czdWf33ArnasCpYhtNp0V9Uh1ZnM5YHh63tDdE7
         oEFqynFE7kHhsW1acYcfSxYSa1jT8fZZA+WTziE89DucFONUqEwsBuCt5mqwVnhR0V
         0sx0FDWtERGfQ==
Date:   Mon, 26 Jun 2023 18:50:11 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>, palmer@dabbelt.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
        Oleksii <oleksii.kurochko@gmail.com>,
        linux-riscv@lists.infradead.org, qemu-riscv@nongnu.org,
        u-boot@lists.denx.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v3] dt-bindings: riscv: deprecate riscv,isa
Message-ID: <20230626-eliminate-grimy-b229724dc830@spud>
References: <20230626-unmarked-atom-70b4d624a386@wendy>
 <CAK9=C2UesoUCeb8k0DSCHi7Zr+B5U26KQ9oCs9map3a2zzYqAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m57Jtotn9Env+EUp"
Content-Disposition: inline
In-Reply-To: <CAK9=C2UesoUCeb8k0DSCHi7Zr+B5U26KQ9oCs9map3a2zzYqAw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m57Jtotn9Env+EUp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2023 at 11:08:43PM +0530, Anup Patel wrote:
> On Mon, Jun 26, 2023 at 3:42=E2=80=AFPM Conor Dooley <conor.dooley@microc=
hip.com> wrote:

> > acpi
> > =3D=3D=3D=3D
> >
> > The current ACPI ECR is based on having a single ISA string unfortunate=
ly,
> > but ideally ACPI will move to another method, perhaps GUIDs, that give
> > explicit meaning to extensions.
>=20
> Drop this paragraph on ACPI.

Sure.

--m57Jtotn9Env+EUp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJnP0wAKCRB4tDGHoIJi
0s8VAQCUTZ2Haqv+3bKnIWj5oQn4AdHRibKGwI2p8ygrlmJ+1gD8CvNs5ZjWLL3X
2Qo1nAeXl/D8F50sG29i3UXpjYBj5wM=
=7wbM
-----END PGP SIGNATURE-----

--m57Jtotn9Env+EUp--
