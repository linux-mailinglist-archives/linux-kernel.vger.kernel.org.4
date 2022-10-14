Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE2D5FE990
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 09:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJNH2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 03:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJNH2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 03:28:40 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649CA17FD6A;
        Fri, 14 Oct 2022 00:28:39 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id b2so5921871lfp.6;
        Fri, 14 Oct 2022 00:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SyMPuARgI/cMW3vAnqIKcmeUrRRRLXL+kTVTiHp6F18=;
        b=Uhk7l/TUMcB3aXP5JC4d928KA5zigdEwO6kuyDxzN04onE2qENHX2fYQ3X0VR50OWu
         yWIiBiogxa3oj5M29c8lukh9WfSS6r3itRbzKdsnRcGz2QVOmWCImh8Blw1GsXb4HeNT
         BJi/8D/+tVN/YunWReEzfo9PTRzkH0mMpjDjfE5GdeN9M2Fs7zR9xbHEo43YUZuD1NFE
         ynL0IzO9U/1brhRFHJL6RjTLLyRE8NWeJjPtq4hDdPj+aVs/YRgLqS6CMdlqknh9KOs2
         YCYkYA4N0bJMpMQqHY//x6RX3RFc/Vcc/7sTxU6cjofIfxu6o1SmyuqMExco5Sm4B3Ze
         U+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyMPuARgI/cMW3vAnqIKcmeUrRRRLXL+kTVTiHp6F18=;
        b=ELJaf09nIQnAsAEEK0PAVkiHdrp4q2oCHrcOM5noRhv29J3sVpmjnmR3J1RsqiXJSN
         9m4J0H2hQLjTYPcf+fAnn4MZ/1FOYRZ2IdILw28NKyoaewIMu4XkJ1E1HAFHomaGS+0c
         QWXaswJ+ya7Xx6QgZ3M4Fbq+7vDAy4WgwqyQT9oRHZu00+MT7f4UnfAMIUCBOsKimri6
         lmgPBj69840nLcAONfth3tHTdQQ/u7635V/BOFiwcsxJ0ddB8aVDx0StFjVGLsyqhK9L
         l39aHWEtQB03IxPKP2VD8hf4RNaj5zQWx9O3kwDjwsiO/lYMmmXOx6+zSgaEoy+kWKQ9
         Ja2w==
X-Gm-Message-State: ACrzQf3qe0+Kduza90sJHVgb8baJCWpXZoiXbRC5QP7ZFFRv3FrBqNYb
        AtNr6D0F665lBpdaX3X1P8s=
X-Google-Smtp-Source: AMsMyM7egWkgr8i9TnfRJ4inSksIa8+UNFlB0IyGYii7eeDMWqnAmy4nspLLyCI7QLACC4NVuAahAA==
X-Received: by 2002:a05:6512:458:b0:4a2:c67c:afbd with SMTP id y24-20020a056512045800b004a2c67cafbdmr1281812lfk.76.1665732517599;
        Fri, 14 Oct 2022 00:28:37 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id i14-20020a056512340e00b00497a879e552sm224136lfr.291.2022.10.14.00.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 00:28:36 -0700 (PDT)
Date:   Fri, 14 Oct 2022 09:28:36 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Peng Fan <peng.fan@oss.nxp.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] thermal: imx8mm_thermal: wait for a valid measurement
Message-ID: <Y0kPpAYYnSvV/HWR@gmail.com>
References: <20221007073057.41803-1-marcus.folkesson@gmail.com>
 <1b247906-665f-8d14-82b3-c55467659644@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zogtDrRbthaXzIxw"
Content-Disposition: inline
In-Reply-To: <1b247906-665f-8d14-82b3-c55467659644@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zogtDrRbthaXzIxw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peng,

On Fri, Oct 14, 2022 at 09:20:21AM +0800, Peng Fan wrote:
>=20
>=20
> On 10/7/2022 3:30 PM, Marcus Folkesson wrote:
> > Check if first measurement is still pending or if temperature is out of
> > range.
> > Return and try again later if that is the case.
> >=20
> > Fixes: 5eed800a6811 ("thermal: imx8mm: Add support for i.MX8MM thermal =
monitoring unit")
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>=20
> NAK:
> Please refer: https://www.nxp.com/docs/en/errata/IMX8MM_0N87W.pdf
> ERR051272: TMU: Bit 31 of registers TMU_TSCR/TMU_TRITSR/TMU_TRATSR invalid

I see, thank you.

I think it is still worth to check the upper limit though, so I will
send a patch for that.

>=20
> Thanks,
> Peng.

Best regards,
Marcus Folkesson

--zogtDrRbthaXzIxw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmNJD58ACgkQiIBOb1ld
UjIi9w/+OPV3O8sggMQbdOEJXZNCBSIxdf5ni+OQ2LXoP8vQ9kLmnpc3PCSGJ+Mn
erLM6iQriIGkONfbRrsXvX3nfejt1md3ouu9q0BMRt8XtOs3rVTcGa9H3WlhzgO5
SOg+Cc0MMcDeOqjlQVs6uc5H8PyWEAEnC88WospNVMB1NQqFrt9hf8aJ+otoZwoK
DKqgL0EiBCc8WXlDV6ab4wABglaLESH1SMr6n7+RQieHW9faNgg35OOUEwk0KV1t
F25x9iOEUnvQzMSV9NXbtAQYgpwW75o0gUWuu+JYU3kNkXe4jXvuYGfy0VIz/Qhs
VJ8r20U3FHOBinkODdU8UE9u6SV2dlq4LbYOmGGg2/v3kpqzeLU/pcIypx/3uUs6
ivQbo/O1Y10ZFLGSgwiqrcKLlvTaNS6FWnNgYFmQZxi3RgBsemsJ62zW0JfZwlwt
KQOhIl+wKjrKn2BHvBCj/k+9TQ0WMeKjx3Y5kEhamFUNDv+qr1rK9+9gDhPc/AiY
Qs5YPgccFtqnDhlUkApierjryEjb0QNTEBDJpog5LWRiph7k3Z+RGE5XokuV4c6L
1eNjNltDnJqOdkNc6HbUn67qmnFzYKEknCu/Hun5cpq7ma1NGBpSkmyoyYMFE/MC
9OBiu3Ecp99NkR4xDk1ldFZzhpHuxkx0KLElKP32Lx+EyP1d0TU=
=htvi
-----END PGP SIGNATURE-----

--zogtDrRbthaXzIxw--
