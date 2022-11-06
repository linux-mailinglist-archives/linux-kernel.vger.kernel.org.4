Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A50D61E2C1
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 15:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiKFOvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 09:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiKFOvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 09:51:49 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234D9DA6;
        Sun,  6 Nov 2022 06:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667746292; bh=EDw7/ApaRoHYrFz5JFfVxSbpvRHo10Rc+evSfgmLvrk=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=MdkhUnBQDQaG7MrQw/QBa/+PdAyjUrTGB6RVIWH8I9wm6JYevgaxFNe4QjeWaHKkP
         RGmEGLlB+JI2us4eBl87Wtc3xqerLCvzIXV8zJ+28VapUl96ts5oNn2pL4C/vGPRBB
         4WYP3NJxpOIJgRos5YQlnPApIdC6xXr1+jrqe/GURG2kn1bV/htLs1B6oeWdW9VuFv
         OvSy3QMuaM6t8tUsdem+ASDJoVb3l914C+kbMDoKChE/0PZpvRof7rOsWzwbnQESeX
         8g6zIP0Hp1OpVDxgCa4bDeES3B22rGG+5asot335zXSU+K2bxGZ/NnPHB5f63qLqOh
         DVEcpFBBZpXAQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([87.78.44.193]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McpJg-1pQCjW07Yg-00ZztL; Sun, 06
 Nov 2022 15:51:32 +0100
Date:   Sun, 6 Nov 2022 15:51:30 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     kernel test robot <lkp@intel.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org,
        oe-kbuild-all@lists.linux.dev, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 7/8] spi: wpcm-fiu: Add driver for Nuvoton WPCM450 Flash
 Interface Unit (FIU)
Message-ID: <Y2fJ8jyZDC12v8pQ@probook>
References: <20221105185911.1547847-8-j.neuschaefer@gmx.net>
 <202211060522.PA6tWBXx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9VS3WmYdJL+KGKqF"
Content-Disposition: inline
In-Reply-To: <202211060522.PA6tWBXx-lkp@intel.com>
X-Provags-ID: V03:K1:oJ5ru1cyrw7RDcUHnSy09tCJMmYiyA/udXX7LddEiK7VDDR+rZZ
 +GV9CD7tqRbbej7qEZ9PLqx+a8aNSxrrl9HDJdGWxHAHFzjlluEr1uPkBGpXmnGDSdJccRz
 Ml5fWx2pc5PKhd/cGEKM8kf55FotaPq8iNFlkt/0SWQF+TN/7XcH9vGBRLbXtqjydw0JOH+
 7+8lopmfzUb1y8Anumhzg==
UI-OutboundReport: notjunk:1;M01:P0:DXR6bHdGeK0=;tnNCRqf0Konp127/y0kqNWgv1+N
 UnpAnfYAphWaHbTLTz01KKi2ydds6L6QP0fIYyxg90eq0AsZApvsniEXYRMUQ6CBdYznNnGdL
 XcyID2poxX8vYn6YKboDCnagsk1GGks3DWCSjyZYNTnwnv/aCUnMvvnPnuseOoNIVyYxoPLLE
 XqNmGAkWe6IuKdsKpxRJXd0530CNVSdyXOjXSHwiaJ4EmUfwZTiPx90KFTVL7aE5VTI9fKW91
 DWoNhqh4TDmG31i/og9+EdQ1EHaz5TRs9CaYIWFnPmuffCpyPxwhal0NuOcb0idB7GBd1z+dl
 wJCBK5varNJS+XXPEqDTWT77PPCgRwWApNyWa0aTPPbkQrgHC3Cxb/fvaWn8jIKLJ4XP41lNc
 HBnskvTa3YHfkuFQoQMAn+fVlsDQIEMxqyGIIX4e14lV7V9aJ03BrjmzhrYXWNPaqccVyzhjU
 Wctq8EbBvbJ8wycLMFKXra7x00Ly/LaaC9bRTrFZv+HXhBUOfSEBu+xzNUgl2nTvo5T/GQxQ6
 Kbm34Xle3MUYkG4V+NX35ca+p2lDFeqr5+EmlzLN0w7uukeVOblCsCW73ufuwFVjMzrfky/fh
 UPlGtM7au9AHR2rkU6mLYcOqxY8Y2iI47VngFBQheaAHTrWZe5QQE3/a6l/dp7IbhNd3ObmRz
 RB4cJIfwcAycdsjpIlT4xHlEOKdTPwQmlvJUPENe6YgkevEUX1AEP/XJSIcrH9FWHquUn7SGF
 bbUOJhBna93HVQe+1PzYpCJs87a9gexKucyvR8TzSE9SMiSCbtMcN+OMFGTkDKIW9SY5PXiWv
 xSYw/CMq6K3031aUX9LDzahtBOyGTGf+vwTppnJmjjWyWzlCwCVMv5bSAtG1y4XQzmvqpfU4x
 Qd44EHPUeJLDtVHC/C5Im+vly6n4R9MFtlDKxIZAYB6OxhLbnNev/nsVaqiBmQ/MF8hfJifnc
 TLNnjg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9VS3WmYdJL+KGKqF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 06, 2022 at 05:35:26AM +0800, kernel test robot wrote:
> >> drivers/spi/spi-wpcm-fiu.c:296:11: error: positional initialization of field in 'struct' declared with 'designated_init' attribute [-Werror=designated-init]
>      296 |         { wpcm_fiu_normal_match, wpcm_fiu_normal_exec },
>          |           ^~~~~~~~~~~~~~~~~~~~~

Alright, this is not a bad idea, I'll change it.

--9VS3WmYdJL+KGKqF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmNnyfEACgkQCDBEmo7z
X9vymg//W339DCLRB060/F+UAzAMGsYUWYjtFlIH2gAOSbNzKncYoBkyaM5vZWkm
phYrLRCBOCMU1KRi80baQxKjrdRIa+jXGqFV7c9pw/YgrgiZ/Qhxbw87JO3FN/i1
o176DXK+3TUMa6sJWM1cdTvIfZe3pgeB56948Zd3B8wCd+HaReC04kQ7qxupnzwd
bMJeZwJYUVYWZlGdy2Mai59gWGihBviPr5fY1eBXzz8R32FcB+GswNW7xkKdn/W8
JyMlTqEOnw8dJBkpmedWvRdXbN5uCmNnvSABIQvvbDuSFDenueZnGmKSbMNS9MoJ
wkgaWIGz1Npy3DyXBbAKVGbyKaXbYnAkzWGYAEZRFPns/A+rqroxaRw2CnkNCAtm
n8+cA1ZE3F5WAnhd6B1AL1m2Be8rghswOvIDNblCK72IM0D9XGgayw9IiwD8SKYV
s2fL2LeJXfm1K9ukwJVm2GlmhUkrXb5VjBqSszghtcIIoljyQx96xuT+aCK6qsiT
0gaEW+PCMoJ/RdtO4f61tcYU7+H2++MVn3oN5TU6zWIUFN62kJcm5Tj8rhON89LA
mxZVawZe57wHlamFRByWW2qnGglcg0nMoRAIEV1HZaaQTBnLB+0EFsjdZjxJC9IP
mH+iahGDdgXQrEajed/JswQKHyXieK0hVaoxHmhmeJysBckPv3c=
=pOjm
-----END PGP SIGNATURE-----

--9VS3WmYdJL+KGKqF--
