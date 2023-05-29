Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29A3714BDD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjE2ORb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjE2OR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:17:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47958BE;
        Mon, 29 May 2023 07:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685369844; x=1716905844;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QJcnTBFqLSso7I149K/7bYRpFd+idvVMmtjIYAQ5p2E=;
  b=SUY3T0VwF0DBzMAwBpd0XYx+rldvJqzTIwuwZBC+CmUATMPj62ZE0npn
   +pBCMzoO9gDqe7k2XHpQ4sC+Qkt1bexJ1Qj1Q08at/TeTMbCA9oQOPjC9
   wkUvI+7PoL/ZSoq31xMS39u0x3HnUG459Js/s6HvMGE0p1qgh4cGGaTvB
   N6m5W0Wg76XTr23Wmn7K+bfKyNwXFmEtoTz/poZNgsyqoYmM5dD3Fiwse
   S1ZsEV5LzGVNOJGv8XXC0tvsoTbdLj/l5iMyweOOqwpcCLouokdCJQYeh
   knmIJxmlKQeQ7bTRl+B0Of/DvxsbAKUt6qZX3Hzlks4fhpoBclYpaRSlR
   w==;
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="asc'?scan'208";a="154446873"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 May 2023 07:17:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 29 May 2023 07:17:12 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 29 May 2023 07:17:10 -0700
Date:   Mon, 29 May 2023 15:16:47 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
CC:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <jirislaby@kernel.org>, <jringle@gridpoint.com>,
        <l.perczak@camlintechnologies.com>, <tomasz.mon@camlingroup.com>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v4 6/9] dt-bindings: sc16is7xx: Add property to change
 GPIO function
Message-ID: <20230529-seventy-stash-0446d9ae02e8@wendy>
References: <20230529140711.896830-1-hugo@hugovil.com>
 <20230529140711.896830-7-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+085Gn19puYh7ZJS"
Content-Disposition: inline
In-Reply-To: <20230529140711.896830-7-hugo@hugovil.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--+085Gn19puYh7ZJS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Hugo,

On Mon, May 29, 2023 at 10:07:08AM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>=20
> Some variants in this series of UART controllers have GPIO pins that
> are shared between GPIO and modem control lines.
>=20
> The pin mux mode (GPIO or modem control lines) can be set for each
> ports (channels) supported by the variant.
>=20
> This adds a property to the device tree to set the GPIO pin mux to
> modem control lines on selected ports if needed.
>=20
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Did I not ack this in v2? I didn't notice a reason for dropping it
in the cover etc. Was it intentionally dropped, or missed?

Cheers,
Conor.

--+085Gn19puYh7ZJS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHSzzwAKCRB4tDGHoIJi
0npZAQCPFQ52PwxbkPmD/kvN+12IBZ4QQ9I02aZB1j7w6DaqDgD/SNbcnScnBM8m
pp0jJoZcKtbiuZljo4tvKhya4e5kawc=
=YYyF
-----END PGP SIGNATURE-----

--+085Gn19puYh7ZJS--
