Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D997166D108
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 22:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbjAPVlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 16:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjAPVlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 16:41:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BA524497;
        Mon, 16 Jan 2023 13:41:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF6516112E;
        Mon, 16 Jan 2023 21:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81ED8C433D2;
        Mon, 16 Jan 2023 21:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673905277;
        bh=V0SSjeXS5t8fvel1GS4ucmaQsKSqFY0cRpIqj5T6N/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AoYala+rV44moJwyd9aQlvh7nWBvPXGAo85sr/XXMMXS6FwiPVR+to1hVe4hUHhby
         G4RuyJAk0BUhvQUDA17MQiJP71keOAodzdQXFFKfoJWES3HtbbqoNb1Vud8USfFTby
         uFHRec702aAzsdh0GVXWapB6Yg6gA09XmNCh9RN6COf5XDIittdoNEV4pl7lvYENtQ
         V2CbCXgnRiFHUE3GiFV1pjUxa5XrHpuh5/3WmNy28A/wn6vMK2IHhpEZsygowJVKxi
         LYqLUxrdSHTsB9uPhl1zHtYLrJNL7JB6em1Rd95vytTnLevM8RBrM0rRmTgBYj6zlK
         jsyw8VjM6mpng==
Date:   Mon, 16 Jan 2023 22:41:11 +0100
From:   Wolfram Sang <wsa@kernel.org>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: i2c: renesas,rzv2m: Fix SoC specific
 string
Message-ID: <Y8XEd6v++lTSeCYn@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20221107165027.54150-1-fabrizio.castro.jz@renesas.com>
 <20221107165027.54150-2-fabrizio.castro.jz@renesas.com>
 <b5f881b7-1f59-623a-a126-d7827dec85fe@linaro.org>
 <TYWPR01MB8775AA3197A830F8769C01F4C2C19@TYWPR01MB8775.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5SuD6OMKmV3r4gcT"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB8775AA3197A830F8769C01F4C2C19@TYWPR01MB8775.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5SuD6OMKmV3r4gcT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> This patch has been reviewed by both Geert Uytterhoeven and Krzysztof
> Kozlowski. The corresponding device tree patch has already been
> taken, I was hoping this patch could be applied to v6.3?

linux-i2c was not on CC, so the patch was not in I2C patchwork. Thus, it
was not on my list.


--5SuD6OMKmV3r4gcT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmPFxHMACgkQFA3kzBSg
KbbL6xAAj4aHP9rKpTmnkVLR1+aqUSllwbfS4l4m7AKARq1TcMo/BXdi05KfpZxL
HgmiqRD412+zx+WBccouzKvhxkpi6UkgQWoy5EGD/ialjK834YkQQeQx1A9shxrA
Gww1JMlyOndXrnYUdqEpUQgjn11TQNI+7XdmrQuaDMYj/FEZlNIDDEn2Jnk4G/O6
CoysEyybeVwFKxanpnC4/LATxJ6YDHPF9YdKhLmHiBXcwutoX8zxXGXv8KqESamh
LX9VegIq6ze+X52QyhFW/lszJcDAvnfzFFCISQCC17MYTpIZcvjtcd++ogmLwjCJ
HaJoihQ+byx35EjV+nLtOBcwFKMct8+04bqB223nWuipJUPwpQAEaeCvNcaaHh56
dXhJiJJtPGzGrGcAu99Mhfrk0wC9MZg8bA8c31YMqWjEirH6zG0wChYTQuoYsH6z
fiadupbZNkAGnkK8mj2vlHbRlMSL8jWZ7KGeA0yPLlYBpnDKSh43/D+znyLdwovK
vJ3jfQQHbRclfiiA3IMROzyQfP/xjkcXjJVlSIV3e3/cXVkRKv3buLPF54E7CPp+
BVfdZ+mDW8s5xoIK+IWvh8Li/QxQGeIRSdqGaGKN+MB70137HcyGRfJXVj8q1ohj
BB0dka6uhP3nsprAYRgJ3CJ9olrb9DevgIC28mtW2a6IRyB4saA=
=baro
-----END PGP SIGNATURE-----

--5SuD6OMKmV3r4gcT--
