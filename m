Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3D75EDC28
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbiI1MB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbiI1MBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:01:49 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E02C6D540;
        Wed, 28 Sep 2022 05:01:46 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x92so3787493ede.9;
        Wed, 28 Sep 2022 05:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=dxu2OvV7EkR74oImSWAPrEQpf5qWpS/N4G3imzt8Kwc=;
        b=HHhCI4hsQ/1Jg0qSAdwJQahZ4v0r/djosFNCZo+7gJjD8TDjTb797Ll+nplojKCnoI
         xNK0aCuPFMoqzotj1wtxmm7yYdMirHmqP0OkmdrWZ0uUGSRhoii6M6x/SsAadLtMq9YH
         7v8rh4ENnA7vPNAnYMj1Te476d9dcexdcCXyDQKPblnYZOP7PuQzNimZzXFBehYQSDhh
         z9r43ZPQYd5cAIrqo50yPFAn1fB0ScqOyDl9sTXVGWzosvaSH+KD/nZdR4wTVS4WGvGO
         nXeilgGK8DnjOAwuu/EJLMesTVGSQt8N/i9bk9QAJ6w4skiKgjKSny7TRdMSBMTAZLIl
         p0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dxu2OvV7EkR74oImSWAPrEQpf5qWpS/N4G3imzt8Kwc=;
        b=ZseFMqtWHvNq7m/vOBJJWgX8xN1BAvsR7RBJyu5znRQUDIP9OGfojiysDD0n8TaWPD
         a5xdo7zQiXGpf0Jt7SmuAgUTxYjFjs29C63aw1mWpv0//Vemuax/kbFO8KakuXgha8kt
         3WKtXFStcZ5aXpM8jg7iPolKcGpBM/5LsFhebW4SI/ptdprQoVW0i22V5hDF/ZyMmEyd
         Njy8ch+/Vj7gi/ZyEU/MgU2eFtWNcEu3b6llyrGKMXQmLj1xCx+6MQvbd06/KcJCHBxI
         tsnwx2HhEb9gYUnxgQCpsV/JcoYV5mAmjrbrqvY1lxEjtbxrzMAsCc0cJHieqJAa6KTe
         tmkg==
X-Gm-Message-State: ACrzQf0DWRSQktVlJLCaZd8Eaf3mMtOnvdhUv978krzKo1sVASvJEjMH
        2J8TbcI2F8WFrSEb//eVxkQ=
X-Google-Smtp-Source: AMsMyM4dNSFiIdi46xobvaunWwBUgINlADlsibMnyAgKQil1xkGkAYqSRar+ptRCxG6+cAiwlxJg1g==
X-Received: by 2002:a05:6402:249f:b0:453:eb1b:1f8b with SMTP id q31-20020a056402249f00b00453eb1b1f8bmr32545025eda.235.1664366504775;
        Wed, 28 Sep 2022 05:01:44 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id v2-20020aa7d9c2000000b00457c321454asm2914946eds.37.2022.09.28.05.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 05:01:43 -0700 (PDT)
Date:   Wed, 28 Sep 2022 14:01:42 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     zhaoxiao <zhaoxiao@uniontech.com>
Cc:     heiko@sntech.de, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATH v5] pwm: rockchip: Convert to use dev_err_probe()
Message-ID: <YzQ3puvqsnWgnVQs@orome>
References: <20220822081848.5126-1-zhaoxiao@uniontech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zHYWCWBx7NmYQlRn"
Content-Disposition: inline
In-Reply-To: <20220822081848.5126-1-zhaoxiao@uniontech.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zHYWCWBx7NmYQlRn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 22, 2022 at 04:18:48PM +0800, zhaoxiao wrote:
> It's fine to call dev_err_probe() in ->probe() when error code is known.
> Convert the driver to use dev_err_probe().
>=20
> Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
> ---
>  v5: delete the redundant ret and %d.
>  drivers/pwm/pwm-rockchip.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)

Applied, thanks.

Thierry

--zHYWCWBx7NmYQlRn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmM0N6UACgkQ3SOs138+
s6Fd8w/+OgFefafybG6NdOA/Xib6VZJm2VIPFCndAetyNtEM+EgvkjFigNoSCYjS
x9BKfY4rMC+bqAdHLg+OLqHsYTH8hz7OiGHovIZMaTrF7A+sMkNzspjJeM7JdM+S
P1eQzcZbnWE/RQxk7eu4MXJtUxR66+quCkXAdQE1+HmXGECubjLG2j3aBXFDG3On
PMRc3p/gRZ/pbmwbv5K5dLDAbvb93xEjr+6TYPQBFSsM7N3Oxov8K29MkkrBDhAK
T8AbP7qF39Hkld+8CRVPIMO4ShYGoCF5F/boN/+LIRjyjHRRvVMZUf9OB6Z0Peed
nqORMItNM+YAuVGB/QWAAuU7n7GAMzH8IiMx112V2upFeArtKLnqvsTi+1GmCxXc
vCnAnZIJqZdJ0zF1G/aSY2ZreDUm4yUl1RO34soF9TrsaO7Mpw6oatqHsh/op0G2
lWWY3O38m/YW18XU5RD1TuU/+pEahfW4AUHCvB9khHe3o6lQev0nCZppM1UmyUmy
9ipeLbqDfyHzzqCOS75dDf/RpnY3ySKfXQgxzp8okbxBSba4PdKWGlL9Hdvo9CZ/
OZyIFso8paDKqTiW2jlpi8oZQr2YxAyhcm9qGRzUjHbK26VkF/IUNEr98IKva5uQ
t2lVXy2OCKdcm1xPzAoEUdTNw/w6H5HDwlm0icqapzWzlmt+JDI=
=IiTE
-----END PGP SIGNATURE-----

--zHYWCWBx7NmYQlRn--
