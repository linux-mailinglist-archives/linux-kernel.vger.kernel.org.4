Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94747704967
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjEPJfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjEPJfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:35:30 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32E498;
        Tue, 16 May 2023 02:35:28 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-965ab8ed1c0so2332821866b.2;
        Tue, 16 May 2023 02:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684229727; x=1686821727;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqGNQlwMx1+Ogs6surmgImDAecFNm6DtkKzA0x5eExc=;
        b=W96Obq6Kwcr4OetGcA3e6EA08+zU0vL9He1o7bfJHXzN17HPtSZReEWaIIMt2yt24g
         Ew6cVSbA6jBoWKlen23blhnoHdyJbHi4ICb44jMpgAN5U9Xj/wYw7SQXbL7V4vZOnXr6
         5BLCOGp4LdSMehP9ePLGGcIO7qz2vOcHfqA/vlAKTk9oNJsNNeoLlvuVSl7gC6qPVkBY
         6pt+qidwNL4LjxnX9wjXIT5PTdtlkNUxoAPXc2h+n/O985M1RKlp52b/dhNoyFuN0+La
         4mOfz3xDOpH3PqVrevMD+XLvac3yvwk5HAPNDCue8uCRvw4HHM8/k3ibClCNbVkKX2Q6
         WFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684229727; x=1686821727;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqGNQlwMx1+Ogs6surmgImDAecFNm6DtkKzA0x5eExc=;
        b=C6h7er3icxVWqPvV3GCTaFdyn0EIgx4WSSXr/3x6Rucpb1eiQYBnSNrw+mvDEKvU9l
         zeC/fAsSuYJWO/RQ6W5CV9bYoK17pM8n+cXhCM8dDXx3TMZTu9hNH2aIszKzQulGJs0t
         vHhJMWuTuGcvPzTbs4TO4quLMnYWVPAe4VbnBhkZI5A/cvkurV7P43WeLwEQ7cZEn/EH
         /I4ZCPJMKvbaKsds1y49725gANFfgMlGHHtXAtS9CIMY78waGvJWh8wdFj2qnPY5WmMr
         3EO5kouWif39/ZYKDMYUItOrbKhKYdSSnuldRg8lTy72T+5JeNi0gC/AJJxlw9F+Hs1D
         NpCA==
X-Gm-Message-State: AC+VfDxbqnWnUw7zBPrjIf12NBmfK2I2siJflciM+D2o5udOiCMhrKb1
        8NYQfpmZK0eKYT0xVV3Z7nY=
X-Google-Smtp-Source: ACHHUZ6EF+4ZmDxZNVD6IuepFP0JX54P53UIpTR/tniJEeIm1VuD8GcVE6QpIQqKBuSXvRhrU2K5MA==
X-Received: by 2002:a17:907:5c5:b0:95f:56e8:1c3c with SMTP id wg5-20020a17090705c500b0095f56e81c3cmr34307227ejb.17.1684229726983;
        Tue, 16 May 2023 02:35:26 -0700 (PDT)
Received: from orome (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id la26-20020a170906ad9a00b00967a18df1easm10693805ejb.117.2023.05.16.02.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 02:35:26 -0700 (PDT)
Date:   Tue, 16 May 2023 11:35:24 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     jonathanh@nvidia.com, mperttunen@nvidia.com, sudeep.holla@arm.com,
        talho@nvidia.com, robh@kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefank@nvidia.com,
        krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v4 6/6] firmware: tegra: bpmp: Add support for DRAM MRQ
 GSCs
Message-ID: <ZGNOXO3rRtFx_12R@orome>
References: <20230511132048.1122075-1-pdeschrijver@nvidia.com>
 <20230511132048.1122075-7-pdeschrijver@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FcNmRFebYumcoH83"
Content-Disposition: inline
In-Reply-To: <20230511132048.1122075-7-pdeschrijver@nvidia.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FcNmRFebYumcoH83
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2023 at 04:20:51PM +0300, Peter De Schrijver wrote:
> Implement support for DRAM MRQ GSCs.
>=20
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  drivers/firmware/tegra/bpmp-tegra186.c | 232 ++++++++++++++++++-------
>  drivers/firmware/tegra/bpmp.c          |   4 +-
>  2 files changed, 168 insertions(+), 68 deletions(-)
>=20
> diff --git a/drivers/firmware/tegra/bpmp-tegra186.c b/drivers/firmware/te=
gra/bpmp-tegra186.c
> index 2e26199041cd..74575c9f0014 100644
> --- a/drivers/firmware/tegra/bpmp-tegra186.c
> +++ b/drivers/firmware/tegra/bpmp-tegra186.c
> @@ -4,7 +4,9 @@
>   */
> =20
>  #include <linux/genalloc.h>
> +#include <linux/io.h>
>  #include <linux/mailbox_client.h>
> +#include <linux/of_address.h>
>  #include <linux/platform_device.h>
> =20
>  #include <soc/tegra/bpmp.h>
> @@ -13,12 +15,21 @@
> =20
>  #include "bpmp-private.h"
> =20
> +enum tegra_bpmp_mem_type { TEGRA_INVALID, TEGRA_SRAM, TEGRA_DRAM };

Still not convinced about this one.

> +
>  struct tegra186_bpmp {
>  	struct tegra_bpmp *parent;
> =20
>  	struct {
> -		struct gen_pool *pool;
> -		void __iomem *virt;
> +		union {
> +			struct {
> +				void __iomem *virt;
> +				struct gen_pool *pool;
> +			} sram;
> +			struct {
> +				void *virt;
> +			} dram;
> +		};

The drawback of these unions is that they can lead to ambiguity, so you
need the tegra_bpmp_mem_type enum to differentiate between the two.

If you change this to something like:

	struct {
		struct gen_pool *pool;
		void __iomem *sram;
		void *dram;
		dma_addr_t phys;
	} tx, rx;

you eliminate all ambiguity because you can either have pool and sram
set, or you can have dram set, and depending on which are set you know
which type of memory you're dealing with.

Plus you then don't need the extra enum to differentiate between them.

Another alternative would be to use something like:

	union {
		void __iomem *sram;
		void *dram;
	} virt;

if you want to avoid the extra 8 bytes. But to be honest, I wouldn't
bother.

>  		dma_addr_t phys;
>  	} tx, rx;
> =20
> @@ -26,6 +37,8 @@ struct tegra186_bpmp {
>  		struct mbox_client client;
>  		struct mbox_chan *channel;
>  	} mbox;
> +
> +	enum tegra_bpmp_mem_type type;
>  };
> =20
>  static inline struct tegra_bpmp *
> @@ -118,8 +131,17 @@ static int tegra186_bpmp_channel_init(struct tegra_b=
pmp_channel *channel,
>  	queue_size =3D tegra_ivc_total_queue_size(message_size);
>  	offset =3D queue_size * index;
> =20
> -	iosys_map_set_vaddr_iomem(&rx, priv->rx.virt + offset);
> -	iosys_map_set_vaddr_iomem(&tx, priv->tx.virt + offset);
> +	if (priv->type =3D=3D TEGRA_SRAM) {
> +		iosys_map_set_vaddr_iomem(&rx, priv->rx.sram.virt + offset);
> +		iosys_map_set_vaddr_iomem(&tx, priv->tx.sram.virt + offset);
> +	} else if (priv->type =3D=3D TEGRA_DRAM) {
> +		iosys_map_set_vaddr(&rx, priv->rx.dram.virt + offset);
> +		iosys_map_set_vaddr(&tx, priv->tx.dram.virt + offset);
> +	} else {
> +		dev_err(bpmp->dev, "Inconsistent state %d of priv->type detected in %s=
\n",
> +				priv->type, __func__);
> +		return -EINVAL;
> +	}

With an enum you need to do this because theoretically it could happen.
But practically it will never happen and you can just rely on the pool
variable, for example, to distinguish.

Thierry

--FcNmRFebYumcoH83
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmRjTloACgkQ3SOs138+
s6HTCxAAiwPF3YuFt2+2YuS9k1+CsKkjOjDesfjtMcnvO5MVQqrB1Ip3JfSaqlOR
Jnfwm3BtscLNdppy1H91pVbPunZpBlLDPsb0jUpHz//rJBJv6zRPhGcgONJs9L5M
EWlzz2wlAEraOggoTIIqh7Zk71l0hTl5IuZgiG8Kag2CONg1OzR1BI+nSSnoKH8Y
1CyiYqzPNjYYm9n59XVEWhlfojVuHkaTzUFa4vb+JN4eC3v6iGkophBruh+M6YcA
xk53akXqXGXJVL1OGOGAH/nmIccvpoWalTMB7PrMyaPa/Tm0hXIo1f1r3RhgqyNz
rflto9GBIIwcNN85ojy8abrQHammczomtTsPmxkdWGanvqmFzx8jJQrAugGqAGgN
6Mky76sUXGmwDsHJ3HX2T11xyYE0Sfc1jnIKNuZ12Z90ag545O8XNZJ8iflKCvgd
nb3VwcMJz2ECHc9/80wB8ECJMxekrdccOhmedXwgC6sP127wrQTrDZbe2Bm07jTA
23AiIWGLm8uptkq6NvzYHlexoYM9ma/3bk06rodXJIRmTrldLt+OFZsS3FcS/SaK
BUBbFQLiKpNtRvVcnBzAkiNEu4Yu+oxqkeasC8VnWKTicenIb/M/5mpGyJ6PUBvy
wCTV0MTG+FPONz855yiIj0Qz2a8G85whHcicZKsEKPMpDOyUXzg=
=1YeJ
-----END PGP SIGNATURE-----

--FcNmRFebYumcoH83--
