Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53B36D7D33
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238143AbjDENAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238150AbjDENAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:00:21 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D590E7A;
        Wed,  5 Apr 2023 05:59:50 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id l27so36132459wrb.2;
        Wed, 05 Apr 2023 05:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680699588;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+lFikK3obDdMqg0chj0hTBtt1Yk9zWNE6RL9/rX25o=;
        b=ofFCzv0WVsdGvOqBwiS5Rr8FjUOUbmdrUIdtHTh1TVCnT6wuILRemS1iKE9s1clhQm
         bm26tDlVKIOxx6UK66xbrtP+HVDwvWavWIcbg7Kejtvsr9PYIPUUXmmRU6ikMZylNeDb
         8hXTf6WvUkC0K1D8qPiXHFQ2H1c36gKxYnZOb1Pgaus6q1tVQsSGI2kNYF6TQ312ljc2
         V9p9YxeQcBIAtsY5OHyLCQOVxj+SlgzA0wNZDsiydBcpJkFGSduodJw7S+MtUnKf5fyL
         lYakJk/gH8pRLunUDJOsI3ia7+zVgJeIbEVKSzgwh6m2aYgn4asNe4CRHMzEaKZsAi3E
         OoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680699588;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+lFikK3obDdMqg0chj0hTBtt1Yk9zWNE6RL9/rX25o=;
        b=yR9rXl2Hl38taGwAUw0Lim3jr8eZuHw2WalgqT6Law0AAPl9uF0T6e71Sep97g92TV
         bhOGA4KtynXauZ8s6qs0HvAX6aOS8mTBUADR1QV0x8cLSha83VxhYgbJ+xbBpWYK7LYv
         0MJyU6lpskkIVtaj5+AT5cEozGOHwk/Gggpb/LqeceTVO+e9ZInIJcEBkorYMKEQglfr
         14m0zMQz4t1byVE0kbEmD9l7weVmtVQ25uOwJG6TKWtTvl37P+bU2r8uivBtY5JbF4CL
         r3SsMMQtjjQjKPCDj60jb9Ru9sNMAlSjWi4DBAIADkDqjZlGH8CndaK9qSD3O14t63jn
         V7Qg==
X-Gm-Message-State: AAQBX9cUvccN2i9EOa70Iv/DbMlDW0aUARSj6oHlRDYVI+1Zu0gYRHe2
        UDWJhU8sBwOBjAipbFAOLdc=
X-Google-Smtp-Source: AKy350Ykf16wMuYLtSCFeblMA7nc8uf+LMlAQDEHh3tnjF/2dMp+UMsQpWUo0z1ILblbFD6peqfPXA==
X-Received: by 2002:adf:ebcd:0:b0:2e9:bb2f:ce03 with SMTP id v13-20020adfebcd000000b002e9bb2fce03mr3926718wrn.0.1680699588253;
        Wed, 05 Apr 2023 05:59:48 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id i12-20020a5d55cc000000b002c3f81c51b6sm14979643wrw.90.2023.04.05.05.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 05:59:47 -0700 (PDT)
Date:   Wed, 5 Apr 2023 14:59:46 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     ye.xingchen@zte.com.cn
Cc:     jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc/tegra: =?utf-8?Q?flowctrl?=
 =?utf-8?B?OiBVc2XCoGRldm1fcGxhdGZvcm1fZ2V0X2FuZF9pb3JlbWFwX3Jlc291cmNl?=
 =?utf-8?B?KCk=?=
Message-ID: <ZC1wwgi7bR3vluH2@orome>
References: <202302151718036138529@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9NQSCQPV1mPcQv/x"
Content-Disposition: inline
In-Reply-To: <202302151718036138529@zte.com.cn>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9NQSCQPV1mPcQv/x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2023 at 05:18:03PM +0800, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
>=20
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>=20
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/soc/tegra/flowctrl.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied, thanks.

Thierry

--9NQSCQPV1mPcQv/x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQtcMIACgkQ3SOs138+
s6FdZxAAq83d9aSFrwQ1hjhzejAAqPC3EFGTNz0bCAHMfSOleIemQ3t3whZoXpeH
IovPl9sGkfzGS7mRFXNAVrBFNUnoXgOnJUikT3em4RGlkA5xMwJJFllhy9A1zo+G
NbLbcXL7KxCW0FRYDYIlVJvyumXbdKyqNkoUU6hz7oIJoA2Up46WeT7tUmJxSKaq
WXFvV6tZP3Zg5fCNzrRFpkfS6vEac+J1lJ6ZOA3ylDXskVyis+14X0VkaenXlUA/
szvZIm4rRQkhoFjJCWztZ+eQiEUQQLNvpG9BlBy2DMxz98Fcc8TZvbhju7NppQ7F
hEbD/supkD7U07kJpkra2vqVLo9lj5j0CrxSD5WAM3J0FRGx/t0e1oe4JU5LGxtp
AD/IqW2BjXsEVJP7lE/ZAtleAHK9+vyawbNgZNJytBDCrtaTEM+AxXii4PcvEhhh
cnyqju0eCihQJ7YOLeRMZuGF0x4iMZT8l8FQ+e61hst4W70P0osYjsbr4jQA/x83
Zpb2grHA/OW74hji2twJuCN2fYwPqapx5NKC89gFKghLWg5Q/xiTxz3TcFjKE+bw
pceaV6btuksO9pUYhCmv6EDm1yVagPDa9dXxIJHwrw4QzOUG+1oT20v7GhEup2PL
SkdG8jz7Hvs7ULzEk2fxr2k7d7voH5riuTBFGL6gn8G411e2UHo=
=1ZZs
-----END PGP SIGNATURE-----

--9NQSCQPV1mPcQv/x--
