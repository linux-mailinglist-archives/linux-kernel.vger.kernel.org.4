Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656D75E6EF1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 23:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiIVV6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 17:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiIVV6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 17:58:14 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939CA10AB00
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 14:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=myXRgbifa/hnzUH8EJNQ61gteUFK
        O52ECTqp4X3tL+w=; b=l1EbvM2BeA6s7XlinyMbFqPlhhBc45ErLA1LQ+9sW3GA
        vZwcpHNdvvLVkOx3BBFxFp1LPiBfOsiOyiwG3VNpdnarrP2NwvY+Kd8yArlMx+iG
        /EbDqpaovt6q+clzdWQ8ZJf0dmr8KDG/Pw/0V7cdvZTrj3tYjE7itP0sBAuKBDs=
Received: (qmail 1793391 invoked from network); 22 Sep 2022 23:58:10 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Sep 2022 23:58:10 +0200
X-UD-Smtp-Session: l3s3148p1@npk0KEvpcOQgAwDtxwncAPgJb5TsabMI
Date:   Thu, 22 Sep 2022 23:58:09 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-renesas-soc@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: timer: renesas,tmu: Add r8a779f0 support
Message-ID: <YyzacQv61ga4+WkC@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-renesas-soc@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220830104921.7532-1-wsa+renesas@sang-engineering.com>
 <YyzQFheOv2Lg0t6F@shikoro>
 <8672aa05-0269-f8c3-50d3-e23d3793baf4@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8l5HS+T+m8MEHXhc"
Content-Disposition: inline
In-Reply-To: <8672aa05-0269-f8c3-50d3-e23d3793baf4@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8l5HS+T+m8MEHXhc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> https://git.linaro.org/people/daniel.lezcano/linux.git/commit/?h=timers/drivers/next&id=fa7fc5243f9e7d64ea7e73c247218f22499c3479

Cool, thanks a lot!


--8l5HS+T+m8MEHXhc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmMs2m4ACgkQFA3kzBSg
KbaihBAAjgxWDd9NSOsMLC2ef7JHXQGlaqy5ApHKsQjmBadbx1G1Uw+jQseHRuaM
tmZ600zwup9I74n0rArVb1CwxqYbufKA7HcAUfG8fLLoCj9SSTU+A364t8BkGz4D
PBbepiELSqw1ORM8s6zfTbL9VtaIgjUuUlSTNzZJzyLe553kyXRUS5n7NVnGHVYr
Ens7exvsDQxyUhVvsVVGoHoxzsZYZVJp0BBOPHn8sMjWt2JXGgb91l8wXrv9sY/s
V/yqi85zGE8EiYYPFpG45yyZBywiEh4VcM94b1/ImBV8EZVfHjEemgzLcYwZFZDI
Q7EFXOlD92LUN5ypoFIP0WDnOPbC4GhyXl0iNoY1n5nff+Ikv3oxI1ge2n0fMmEs
EmyliHNBL31FedXaxJbN7asRzeglyE/nBP4LYmxtZka4QDj4Qc6ckFZ9LjdPsE0u
/urtNgvoS4EGfvreqE0UjEPByPD5DBq2kF4xnfc5Z7PTJDpn2AvYaMCKKIn2HWE4
d69AmmiKRDsgdbOgFz2LgKrJCfEp8DcSYZVorizmIyViGz03lKXgAGAhOFscbOnX
tdoGRrZYxH+xCRRLG+5o+cfoKmLNPT+lr2/AE3ygl4Hlu2VhHJk15e53hm1AGA0I
BNTozGFgSOtT12ic39KPPSTVlXEExHbBGmDwKd23UI2IZCUOGQk=
=8NWN
-----END PGP SIGNATURE-----

--8l5HS+T+m8MEHXhc--
