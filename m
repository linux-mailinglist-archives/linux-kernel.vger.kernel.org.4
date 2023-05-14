Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FD7701EFC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 20:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjENSdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 14:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjENSdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 14:33:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30533A8F;
        Sun, 14 May 2023 11:33:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36FA060C83;
        Sun, 14 May 2023 18:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6259CC433D2;
        Sun, 14 May 2023 18:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684089223;
        bh=5sZVQgWGvQsKpb5qnI//dwgKe4KvZL+15lmnta9+UHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hmfg0RsBFozwL9i8/UC4K7hltUKQjCRojGz35CZ1HJSt7RZef2bMlVbIvHX0U10ic
         DDjnO3ikr3BgnRwGIdSMKPnL9bx/jTYKOoni/ABjmeVT/Pl+/IeM3R3ocee/gEfOFL
         1MqEECOPf57P3s8znfPeJz6/femGj+07mkkVjQFxwhIW9zH98JmNYpPmtnAMdwOqhw
         XMxd6PMGn3VuPiVevDF4pvpYdSbf1SnVGO1gHlcXSssEE0782cTHizveZZJBzHINjh
         Rx7fibhnd5vCWYJstdRDFYI/7b7Oltgqn2QbQjzFpEyjl5SBv+3pnWSAAIhzmmRiMY
         s48t4/nwEEh6Q==
Date:   Sun, 14 May 2023 19:33:37 +0100
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
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 02/10] dt-bindings: interrupt-controller: Add
 bouffalolab bl808 plic
Message-ID: <20230514-duckling-mooing-fceecc375372@spud>
References: <20230514165651.2199-1-jszhang@kernel.org>
 <20230514165651.2199-3-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aocPV6+AhBbmVr7k"
Content-Disposition: inline
In-Reply-To: <20230514165651.2199-3-jszhang@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aocPV6+AhBbmVr7k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>


--aocPV6+AhBbmVr7k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGEpgQAKCRB4tDGHoIJi
0rAhAP9UE6EyQUZTG8wUYzjm4J7EtsDJlSWF2yDAKfzDjFNDmgEA7JLDWmie/aQr
mvViMEJ+Tdd7GDPlZ+Bzi6prCBdtZQg=
=Ybds
-----END PGP SIGNATURE-----

--aocPV6+AhBbmVr7k--
