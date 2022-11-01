Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD7F6149E4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 12:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbiKALuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 07:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiKALuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 07:50:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34DC18356;
        Tue,  1 Nov 2022 04:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667303193; bh=JJv66pqUZLGSuwjn2/9tXQQ7SlOBgLn8HpmJOkx7aPg=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=rrF+YsPAa3IV99mB0UyIPdZwWMj2a1Sd0W7yTqGVoVzjeF8p5DGkY21ppeA/EkzVP
         z29N0cxCAoRyzprHerp0+BAqwljinzvwpce1Lg7MiZ1vJP9Rk37TF1FM37YSicCAfS
         GvgTL6gQ03dZbcvlZ7yBfu9G2Pqa+3c3dBIDpjQnOoAxXaDG3pyBZpDwjCpnqOsON/
         tttbO5e9jyjL7PdPPwFl16q8Z0rlbEb/Ege3qZYNr1RKU8QPTEFjv1UccAXSXyyPJm
         QUNd8yjya2RYv6Se09sOur3sGcgB1xfB9HItkpVppf5L0QmhhhOtmFsSx9tzaAxVuM
         R6kxCeq4gnCAQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.31]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRmfo-1oSIKp2Fsg-00T9OQ; Tue, 01
 Nov 2022 12:46:33 +0100
Date:   Tue, 1 Nov 2022 12:46:24 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 2/7] clocksource: timer-npcm7xx: Enable timer 1 clock
 before use
Message-ID: <Y2EHEMja1KuhUJda@probook>
References: <20220508194333.2170161-1-j.neuschaefer@gmx.net>
 <20220508194333.2170161-3-j.neuschaefer@gmx.net>
 <0972c833-432d-a850-958f-0d4f482e25a4@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Cg4Yx/SYZOk1zL3s"
Content-Disposition: inline
In-Reply-To: <0972c833-432d-a850-958f-0d4f482e25a4@linaro.org>
X-Provags-ID: V03:K1:nQWEA620M0xDRJA3lx//ZeEp2fNJGNFvQyYu7/vR8QZvRV2AKUU
 cSEYUB1J0pIUVc5JeZ2F/CgCHKgi6EA8TJF0TaTBz1hrzvsJrSw+LR/YoClr6L0s9FNay4e
 jrrN+GvUJYPXquSebUUbVnWqeUkfq+nlBn3j/nkhv9R+WufeU26d+h7jEsD8Jp8IBc7qepy
 xhmnYem6U8/Xzz52cQr1A==
UI-OutboundReport: notjunk:1;M01:P0:K8gGFXdxteQ=;f+EuOcF2T+Nx30Flx0u0xHWGvPw
 zziIdeP5O68bmUXfyk/H2heXB3PcrROiY5DzSCTaX5UPhQs9h5DRdnFWsQwOE7x1K3urzYsTW
 eORz1MN0uvXw2vEBv5nPWyM8NPwQMuBddVXqQQljlpEqE3nnZb1EdY5c7i0lrN3A5aJanrzQU
 L/eBIFF/XdT5gx9TT5Vcmo/VgNbNn2kDYhWYMVzKfp+BrRsq150Ah6hHc0VeeVu+t66TFi5Kh
 q2zMJVvUhjSaom/4uvlJesJTzhkzHCmE9XP+wK0UK1JNXfI8k37bi86NMoptJAuDsHXHUUiP4
 XzgwSuDJObE6H/Uk9ID96wuqTZBAmQzGusKFiATq3ZA1OvCvUvJhpTICJ0BBEidqTmvirMxHE
 PZegy8D9J7Ioajz8NV91MYVk7/cvv7S1q/a1uSxsqtzUBTAjxA9tnm7VQXsDgiuiDeSNfPRXg
 68hV3VYt8emm19JfVjW+z9HRJljWYFGQMgjPucsBj7HDnDgUQTMb3lXOl2pwNhTvYP0VgWsU7
 +w8dzpIddaG+7Cet54hmjAHXscoSb8oyCaI898FGxmAVE6VN5KtQVqa02QlrnwKSbTEh0vm+w
 5/VGC4guFNGSHaBZ9/YUcKA3fPBvzTif8rb10dS11sOMF/wV8ukzx6wDeN1ZJ/4yponjo+1BH
 Qb5/Zzi4B7P+u4oanm1+0zKrRd4lXnTGRDR3TVC/BdtiJyBJIX9TqQch3POA/i6HPB2glmGiK
 y83xB46YjNmmv4Igi1LZQdrpY31k9osWi7f7+a3qsHQ0MLdR8TEgg7q+I2Ek9mhVxaMDc4ykZ
 H+neKgeBt0upoGbGora8TQBDbr8K5YuNoLLEW+s/6cF9Uy2Gv64M/ZGUKWZzE/UaOInC1xLBO
 rcV3DsTsM1EctieH6rybO4oH71kbpNIcoxVuXZ6JraJQIfmRgfhTkY7Bk2Aw+VTd/yALlYiJT
 VAi5nms9oxarNm0kKWwiKfpr8fQ=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Cg4Yx/SYZOk1zL3s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 09, 2022 at 01:37:40PM +0200, Daniel Lezcano wrote:
> On 08/05/2022 21:43, Jonathan Neusch=C3=A4fer wrote:
> > In the WPCM450 SoC, the clocks for each timer can be gated individually.
> > To prevent the timer 1 clock from being gated, enable it explicitly.
> >=20
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > ---
>=20
>=20
> Applied, thanks

Hi, I didn't see this patch in linux-next. May I know where you applied it?

If it got lost somehow, I can also resend it later.


Best regards,
Jonathan

--Cg4Yx/SYZOk1zL3s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmNhBu4ACgkQCDBEmo7z
X9veJBAAzD5hLwhrXHZk7IC3NjXxmXkEvjxqi+k1w8isyz9tr6/ldQGEmQ9m2YJc
Lqw+QYmq2MvpPeEDYzsX+wGq8kjbQmdn5rztX/k5wx2I4MaZEtKmHEl8WlAJ973M
ryvuLYqzsdparwWYam7WdjdhIPBsrtDvlQYtThoCYSSQlDgUgwv1/pfZE2Rh3nXT
KhTmM/eZ0xVh0DT9VzaiVQForAg6mokDB0OdTBf0ZcXTctCTAkHo8Mjr5Yb7iIlZ
lWnM5NG7Nhykn8AbVFOE6dQMIaiPJzwhpYY35APp+5qvPLJcYMc1H8hsDowVXK2c
rwEEhKFOreq8ovc9zjFiQ37QH71Qvv4o1xJ3/1Q0HmF06KiF9zidWopokC8o5pe6
RT1HY+7+D14CHL2+HnF9vjCqhyfZsVUraGBxscolgxoK/q3sfX0tWunle6qM17vc
MjeYmkjnjV5SyQg7TL8/8BKttzYt/wC9mqEtkFzCnHtCtBpGgJJ9QbP8OfCJxZTs
Fw4iww/01aZQSvC1HvBISotocCFDmXejtBjkQCdkbQOQbHI7u78Z/2RTG3DNtq6r
lgi0ZvzjeA47j7XAX+jLm2K4XhnGJnhv+X30z2llNFfPa+fFt3UovL7het7hIXfR
NONeccaOnV9J5M0Y/hPw2cGEi4RwJCjjxIv2/YK3sfnXX2QUPIM=
=g5U2
-----END PGP SIGNATURE-----

--Cg4Yx/SYZOk1zL3s--
