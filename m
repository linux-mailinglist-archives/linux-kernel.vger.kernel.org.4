Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EE16DFE8A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjDLTOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDLTOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:14:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8505BB1;
        Wed, 12 Apr 2023 12:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1681326839; i=j.neuschaefer@gmx.net;
        bh=T3r05AvByQ78pgr1f+lKaqtb69c4CJPLVX+ymwewCz0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=BMDmPowP9+uvcrSgaSX3EcRgQBsMoAV4dSlY2URUK6PSdUTENrBQ3WVLDpyKF+I7e
         sD6cUSF3TqA3yddz9KCUrVUQXlx50ilGMnA2JLiHcPzjLUM6JRCzPXrvEU2JmWtkB1
         oVoQALEjco2fA7BFx4SvPtC2PbH1r8O8Ya2oicg2mBZYWDN1pMG82+6Cq705JjJPm7
         sKTGbLNlXQ3vEIRvWl5y2nnhv/M6vWKXAZmyjQ8R86tJGymBi/IWzaFrIysn2L0ce9
         4ZJqapG0/788qtp8tTcRnVyhuikYCCyI0DvuDsPoS8oJnCniaStsHqY5Pj9KTpAIWu
         henKw6Jdd+H3Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([185.66.193.41]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4s4r-1pkklt3ghD-0022df; Wed, 12
 Apr 2023 21:13:59 +0200
Date:   Wed, 12 Apr 2023 21:13:56 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v5 3/6] dt-bindings: clock: Add Nuvoton WPCM450
 clock/reset controller
Message-ID: <ZDcC9JBidzfu94NW@probook>
References: <20221104161850.2889894-1-j.neuschaefer@gmx.net>
 <20221104161850.2889894-4-j.neuschaefer@gmx.net>
 <20221209202120.0AFACC433D2@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NpfuWbq9gkMhlu2M"
Content-Disposition: inline
In-Reply-To: <20221209202120.0AFACC433D2@smtp.kernel.org>
X-Provags-ID: V03:K1:jUhIJfNgdC6wpEPx0keI2q2HMSs6qQtOBLXprOGbFfn5tkVL2Le
 D4mUx7y9IdovWAByCWzmeqOc/Jda5pRaQeNLOBlbXCyJ6kfiuhlK136i0yzPEdWy+PmdHQA
 g/YcNZCdyosbqrpM8xaMk6vPRgapkJSGCNbZQpbn6mo1XziL7xFM2Q/LtrGcXz7LtLQJZqb
 i9OAiRhoyf+BgC8bGgFWQ==
UI-OutboundReport: notjunk:1;M01:P0:aCI64BL1rgk=;TL2u7xYyP8bK5xqtVfvB7EBtY5T
 Gw7znmdjLs8JpkvMQFwfxDU8G8fLi47mDtkSmJzJtYQoSFOlRTgLOILJduh01l4p/hf5Ypi4P
 sxF5bGN4WfEhhaGfnuFIT2pcQJkaHqygv+MLvRXEeUT4yOx7NiZeUpOqNF9nKfoUGn4m8PB8u
 qWIzHFJyarkEcZGRgEY/gDbR93z8LW73zNWiXkJjDWdI62izJ/pm7ZxZEeaGl2uK7XH9BLH2Z
 fFFMcjQnVxgj2N8xfeuK8pbbp5++95p2HOPPHlnBnZuqql8e+XzkPljyFRtulxIrR6L7G5phy
 teL9XySDInzWUojCzPLV9TC3QyOKtCQ/yt5uXjFEcbo4U5zLCAW9ys6YYnfQ1EviXCc2GoOru
 S2cXsa7diI0rAGPyVhNVMqZUK3SozdU/XlM6MhN23EQA7OdoJmnrLhhGeUinwfVZJmBlHgT8b
 +TUQlKpPp7ZCZ0sBcKSDatfAF+fyKi5DweIw4IxSutCtmavrh3BE3s7y6eAW7IEmlJliJwOXW
 gwa5kSbNvP879KKFDngK8OpGoneGx0N40FmM4ICEuJcbIPcWg2UActy442702QD29EpZj5qAW
 1UiVCrOVNBJrvFsdSdhVnNvUiu2jxy7ixO8Dv/O7OPcUBg0JOX70p1UNKdqxYaj6PjH9LDSjt
 V8ueMb/dmvvAWQlIJQBGL/02JdlmVI99vDvmg0BMNsdM+aHx2VCg9PVEEie0amBJdUNj/Xnol
 DIRdCLxnpcjIBfgxZA/MmQhuw/dhQuI6HuL68HCvY10EZ5o2RxUBsWWQBTMLypUVy2AilStJc
 vjgsgtuNSMQE7YwPjY+4R/m1cYln8xsO8Ztm/XSg/iFDoGeowZXZ0Ztx6Ng8LOgtut+3/0zIw
 tH+jWbCo3nO0udRfne7yiuwrAWHNnaksJzBFRmVXfEWabRJkRqpIj1tqOSaW9Qjf7X9BOIHdj
 I5jfaQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NpfuWbq9gkMhlu2M
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 09, 2022 at 12:21:17PM -0800, Stephen Boyd wrote:
> Quoting Jonathan Neusch=C3=A4fer (2022-11-04 09:18:47)
> > The Nuvoton WPCM450 SoC has a combined clock and reset controller.
> > Add a devicetree binding for it, as well as definitions for the bit
> > numbers used by it.
> >=20
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
>=20
> Applied to clk-next

I don't see this patch in clk/linux.git's clk-next branch. Did it get
lost somehow?


Best regards,
Jonathan

--NpfuWbq9gkMhlu2M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmQ3AtAACgkQCDBEmo7z
X9sIKRAAiN2ZmLRYACFaEh3bwfcujm/d3XGjZwlH08eGmyruyMebk/PfHKBWvAkT
Fy4gl2t3YBljBGEK/T/TXymbEYALVNV2hIubLWjy35GCj+q/be0a1Ko3zIQTJY7P
xG6ldUH6deZOCSeyVc5VB/z+fZY1x5rMB3ZJJCLxYj6SQPjcxBuLVdIfkQExTmp6
uNf8Uxc7LMAZJ1IBfUoyTnfCgJZ5rNwSOhUQ9sDYwBKdi8lJHVR7ZQtGZPg3tKMx
BK/PP04jvsV/1BlncBsp7WVemVjaMRdJRG71mMU+Rm5Gl5//ZyyBdx1bxouPXqMZ
+hpDpvXXJ8CDGVprURGaM3U9zcR6P43RfldCwocHqNLnz4b3a11ONboiN18mujds
bB5XTWXBC7LeN+q0WC7Pv6soVK0EnQzaze+ts8Bf0DoPpTFvphwTvLlEMLYwSFeP
w2y7iH8nxWDQjxSpgrly1YdR6/ivLbnqzTWAgPEInJAT1jsVdDJM/ARza3T/WGaB
0wVAJR8A2fJz3iAwR54/LQ5av90kGQMT+Vmslzmpfrye0EW0gIuOY2iiWidcUlcz
q3kAwaN6iAILBRhko5ihBznj7fTGBBRd6//0aaP6Cr39c+N+e7dmq0cLSqgjRZjI
lL64RXXcalaOanGUa1C7lVLR8lt4pmwnNWx1GUdJonrZwTvomLA=
=diBx
-----END PGP SIGNATURE-----

--NpfuWbq9gkMhlu2M--
