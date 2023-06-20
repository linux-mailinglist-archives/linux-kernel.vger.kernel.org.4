Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF0C73779B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 00:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjFTWwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 18:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjFTWwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 18:52:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCE21703;
        Tue, 20 Jun 2023 15:52:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DFB461325;
        Tue, 20 Jun 2023 22:52:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4EBC433C0;
        Tue, 20 Jun 2023 22:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687301572;
        bh=J3EgEpt+Xo4EHMGQ9rhqqELAOOLQCNRzgg8Uw4ATbsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kk0IVbQCO1hQAYvvcGZOX/qt/Ut3MYFzLr4WYYWwH0rHw5gkHtq/I8YlFvjXLk8ff
         7HAS0qSNdDVRq8kNnYBmPzqgp8b8vHD0ZQywmMh8Tup/neufSHq3NoYz8+36uOpd7f
         +LgolFNRpXxW6zr/JqjQaCjuJTy/KtDc1w6FX3eedfZjWWv1Kow4F/UaIDz+3f+U1w
         RwLbZFv6FseqNWOZgYCemsbP8TgECCJngAepp76Y5kLzCtmfhkFyu9kEc9N3Tpi3hV
         JQModJag9LexqiMOHXHVWe1eLC+u5aW40y1cjaB9mp977ZLI6WsJDUHnynPEdAc/ug
         eDdA249kPhXfQ==
Date:   Tue, 20 Jun 2023 23:52:46 +0100
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
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, arnd@arndb.de
Subject: Re: [PATCH v3 0/8] Add Sipeed Lichee Pi 4A RISC-V board support
Message-ID: <20230620-catcher-jaybird-945d26a4f642@spud>
References: <20230617161529.2092-1-jszhang@kernel.org>
 <20230617-duress-phantom-3da79e33f204@spud>
 <ZI8wEp52bpqaCHAl@xhacker>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2oHa4guy7ghistNk"
Content-Disposition: inline
In-Reply-To: <ZI8wEp52bpqaCHAl@xhacker>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oHa4guy7ghistNk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 19, 2023 at 12:25:54AM +0800, Jisheng Zhang wrote:
> On Sat, Jun 17, 2023 at 07:20:43PM +0100, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>

> > I'll send it to Arnd as a "RISC-V Devicetrees for v6.5 Part 2" once it
> > has been in linux-next for a day or two.
>=20
> Thank you so much for helping the PR this time.

Just FYI, since I think only I get the notif emails, Arnd has merged it:
https://git.kernel.org/soc/soc/c/c9a5aa0e53d0

Cheers,
Conor.

--2oHa4guy7ghistNk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJItvgAKCRB4tDGHoIJi
0q5oAQD0U2WdmDEwFxLUHGeOYdSuiPCZnmm81xEa3Njmye//qQD/QZh5UdvnVUp5
Yw1KIPNM2IkrNs5apM9qSmiwTzQSfgs=
=BlB5
-----END PGP SIGNATURE-----

--2oHa4guy7ghistNk--
