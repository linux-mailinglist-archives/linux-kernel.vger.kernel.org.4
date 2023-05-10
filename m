Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832346FE05F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237507AbjEJOdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237444AbjEJOdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:33:44 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3365BAA;
        Wed, 10 May 2023 07:33:39 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-965e4be7541so1163812866b.1;
        Wed, 10 May 2023 07:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683729217; x=1686321217;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VIvyEd23KDVSLGdEh0TI1GYL/iR/BeEbh2uJpsu6V0=;
        b=stFAXCTiC9lWh11SbHKRMHZDVgWXJfcXGrJpEzQ4cDm45isEbNDSBJw+b/Jc5v/n4q
         07NntsUU+U4owQAqo3Nt/PaeURPNLwvyhYmvVRzdQrFc1kQFLWe/GEtRFYoE7an3kOvC
         LJnHA7TcGjw4ZUe+oXs3gqBr00tTMWPGVQXVNnyObUtO6aHWFGSwvrhnsjxXMAsU79dj
         xHdQ2ptkZSAbu9orgXdqj8IWHxCixRe4qMCq+RgpdIsTpygPsvrQwivBxwJEZ156A6R0
         2h6oj699+kfl5wjdWvVs6yrm1iYU/FiXTUHYQ/SzAi0JV7e5NbLBYGxoLwdK9qsHmux8
         04aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683729217; x=1686321217;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7VIvyEd23KDVSLGdEh0TI1GYL/iR/BeEbh2uJpsu6V0=;
        b=jgQtpTzxo6jsgyB6h3IqERD1c+bK8u8Hl7GdFs/NHs9J5KcZeWtjLFL/adtJx7/CEq
         cXiI7Z5IY4usrkPkscMgZ3Id9xMAfw+oQ4P/jdgMKgt3FdwR81kjRamsRdFozJvAcpsd
         nY6etqS2VTZi+HW4R83R6VaEuU4pu3XiC4YSS83xXuPA7r+wJqnGDGaP9sXwhUwvzzi8
         wTWAUdoq5la2JBqkNmTRNIRbGIfkz1ZYhesUyXoQdqAGS8FTscjot4mIUznaSjO0EMIU
         B1zRzxsZ/f7KhksYP4YPm3qKcjx0TTNn7kKXe7pcjG53UO1DDrLJnUDCz+x+M+xfcdj8
         hKgw==
X-Gm-Message-State: AC+VfDyZwL1QETVGfHodgvf5bHZDlffU5K5/qIEtMB5Ua7ZiEkbjvK2O
        hPK2I7Ln/iw7Buj104SULWOadpHk7XI=
X-Google-Smtp-Source: ACHHUZ4Y69nlj/f68fLyE3CX9k5PDBic7whjw5LU+S2A5k0m8jklN0+e23zA9Hx6Uvm/8cZFptmofg==
X-Received: by 2002:a17:907:31ca:b0:961:8570:4591 with SMTP id xf10-20020a17090731ca00b0096185704591mr15088299ejb.40.1683729217263;
        Wed, 10 May 2023 07:33:37 -0700 (PDT)
Received: from orome (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id jr18-20020a170906515200b00965f5d778e3sm2766696ejc.120.2023.05.10.07.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 07:33:36 -0700 (PDT)
Date:   Wed, 10 May 2023 16:33:35 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     jonathanh@nvidia.com, mperttunen@nvidia.com, sudeep.holla@arm.com,
        talho@nvidia.com, robh@kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefank@nvidia.com
Subject: Re: [PATCH v2 6/6] firmware: tegra: bpmp: Add support for DRAM MRQ
 GSCs
Message-ID: <ZFurPwSFixGsXfyN@orome>
References: <20230510113129.4167493-1-pdeschrijver@nvidia.com>
 <20230510113129.4167493-7-pdeschrijver@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OqDI4t7LIoLLRcc+"
Content-Disposition: inline
In-Reply-To: <20230510113129.4167493-7-pdeschrijver@nvidia.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OqDI4t7LIoLLRcc+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2023 at 02:31:36PM +0300, Peter De Schrijver wrote:
> Implement support for DRAM MRQ GSCs.
>=20
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  drivers/firmware/tegra/bpmp-tegra186.c | 214 +++++++++++++++++--------
>  drivers/firmware/tegra/bpmp.c          |   4 +-
>  2 files changed, 153 insertions(+), 65 deletions(-)
>=20
> diff --git a/drivers/firmware/tegra/bpmp-tegra186.c b/drivers/firmware/te=
gra/bpmp-tegra186.c
> index 2e26199041cd..43e2563575fc 100644
> --- a/drivers/firmware/tegra/bpmp-tegra186.c
> +++ b/drivers/firmware/tegra/bpmp-tegra186.c
> @@ -4,8 +4,11 @@
>   */
> =20
>  #include <linux/genalloc.h>
> +#include <linux/io.h>
>  #include <linux/mailbox_client.h>
> +#include <linux/of_address.h>
>  #include <linux/platform_device.h>
> +#include <linux/range.h>

Why do we need range.h?

> =20
>  #include <soc/tegra/bpmp.h>
>  #include <soc/tegra/bpmp-abi.h>
> @@ -13,12 +16,13 @@
> =20
>  #include "bpmp-private.h"
> =20
> +enum tegra_bpmp_mem_type { TEGRA_INVALID, TEGRA_SRAM, TEGRA_RMEM };
> +

This is a strange construct. We can already use the pool pointer to
determine which type of memory is being used. Your usage of this leads
to very unintuitive code when you're error checking, etc. and prevents
you from propagating proper error codes.

>  struct tegra186_bpmp {
>  	struct tegra_bpmp *parent;
> =20
>  	struct {
> -		struct gen_pool *pool;
> -		void __iomem *virt;
> +		void *virt;

I think what we really need is a union that contains both an __iomem
annotated pointer and a regular one.

>  		dma_addr_t phys;
>  	} tx, rx;
> =20
> @@ -26,6 +30,12 @@ struct tegra186_bpmp {
>  		struct mbox_client client;
>  		struct mbox_chan *channel;
>  	} mbox;
> +
> +	struct {
> +		struct gen_pool *tx, *rx;
> +	} sram;

Please keep this in the tx/rx structure. This would perhaps be useful if
there was an equivalent "dram" structure, but as it is there's no
advantage in keeping this separate from the other memory-related fields.

> +
> +	enum tegra_bpmp_mem_type type;
>  };
> =20
>  static inline struct tegra_bpmp *
> @@ -118,8 +128,8 @@ static int tegra186_bpmp_channel_init(struct tegra_bp=
mp_channel *channel,
>  	queue_size =3D tegra_ivc_total_queue_size(message_size);
>  	offset =3D queue_size * index;
> =20
> -	iosys_map_set_vaddr_iomem(&rx, priv->rx.virt + offset);
> -	iosys_map_set_vaddr_iomem(&tx, priv->tx.virt + offset);
> +	iosys_map_set_vaddr_iomem(&rx, (void __iomem *)priv->rx.virt + offset);
> +	iosys_map_set_vaddr_iomem(&tx, (void __iomem *)priv->tx.virt + offset);

This completely defies the purpose of using the iosys_map helpers. What
you really want to do is check if we're using SRAM and use the _iomem
variant, otherwise, use the plain one, something like:

	if (priv->rx.pool)
		iosys_map_set_vaddr_iomem(&rx, priv->rx.sram + offset);
	else
		iosys_map_set_vaddr(&rx, priv->rx.dram + offset);

And repeat that for TX. I suppose you could also do the iosys_map
assignment for both in the same blocks above since we don't support
mixing SRAM and DRAM modes.

> =20
>  	err =3D tegra_ivc_init(channel->ivc, NULL, &rx, priv->rx.phys + offset,=
 &tx,
>  			     priv->tx.phys + offset, 1, message_size, tegra186_bpmp_ivc_notif=
y,
> @@ -158,64 +168,171 @@ static void mbox_handle_rx(struct mbox_client *cli=
ent, void *data)
>  	tegra_bpmp_handle_rx(bpmp);
>  }
> =20
> -static int tegra186_bpmp_init(struct tegra_bpmp *bpmp)
> +static void tegra186_bpmp_channel_deinit(struct tegra_bpmp *bpmp)
> +{
> +	int i;

Can be unsigned int. The preferred ordering for variable declarations is
the inverse christmas tree (i.e. sort by length in decreasing order). It
often matches the result of sorting by importance (i.e. the "priv"
pointer is more important than the loop variable).

> +	struct tegra186_bpmp *priv =3D bpmp->priv;
> +
> +	for (i =3D 0; i < bpmp->threaded.count; i++) {
> +		if (!bpmp->threaded_channels[i].bpmp)
> +			continue;
> +
> +		tegra186_bpmp_channel_cleanup(&bpmp->threaded_channels[i]);
> +	}
> +
> +	tegra186_bpmp_channel_cleanup(bpmp->rx_channel);
> +	tegra186_bpmp_channel_cleanup(bpmp->tx_channel);
> +
> +	if (priv->type =3D=3D TEGRA_SRAM) {
> +		gen_pool_free(priv->sram.tx, (unsigned long)priv->tx.virt, 4096);
> +		gen_pool_free(priv->sram.rx, (unsigned long)priv->rx.virt, 4096);
> +	} else if (priv->type =3D=3D TEGRA_RMEM) {
> +		memunmap(priv->tx.virt);
> +	}

This introduces a bit of an asymmetry because tegra_bpmp_channel_setup()
doesn't actually set up the pool or reserved-memory. Since the memory is
only used for the channels, we can probably move the initialization into
tegra186_bpmp_channel_setup() below.

> +}
> +
> +static int tegra186_bpmp_channel_setup(struct tegra_bpmp *bpmp)

This name could be confusing because we already use the
tegra186_bpmp_channel_ prefix for functions that operate on individual
channels, whereas this function operates on the BPMP object.

Perhaps something like tegra186_bpmp_setup_channels() would better
reflect what this does.

The same goes for tegra186_bpmp_channel_deinit() above. Maybe something
like tegra186_bpmp_cleanup_channels() to make it more obvious that it's
the counterpart of tegra186_bpmp_setup_channels().

>  {
> -	struct tegra186_bpmp *priv;
>  	unsigned int i;
>  	int err;
> =20
> -	priv =3D devm_kzalloc(bpmp->dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv)
> -		return -ENOMEM;
> +	err =3D tegra186_bpmp_channel_init(bpmp->tx_channel, bpmp,
> +					 bpmp->soc->channels.cpu_tx.offset);
> +	if (err < 0)
> +		return err;
> =20
> -	bpmp->priv =3D priv;
> -	priv->parent =3D bpmp;
> +	err =3D tegra186_bpmp_channel_init(bpmp->rx_channel, bpmp,
> +					 bpmp->soc->channels.cpu_rx.offset);
> +	if (err < 0) {
> +		tegra186_bpmp_channel_cleanup(bpmp->tx_channel);
> +		return err;
> +	}
> +
> +	for (i =3D 0; i < bpmp->threaded.count; i++) {
> +		unsigned int index =3D bpmp->soc->channels.thread.offset + i;
> =20
> -	priv->tx.pool =3D of_gen_pool_get(bpmp->dev->of_node, "shmem", 0);
> -	if (!priv->tx.pool) {
> +		err =3D tegra186_bpmp_channel_init(&bpmp->threaded_channels[i],
> +						 bpmp, index);
> +		if (err < 0)
> +			break;
> +	}
> +
> +	if (err < 0)
> +		tegra186_bpmp_channel_deinit(bpmp);

See how the name is confusing here? This is very close to the call to
tegra186_bpmp_channel_init() above and the common prefix makes it seem
like this would undo the effects of the above and then immediately
raises the question why it's only undoing all of the above channel
initializations. You then have to actually look at the implementation to
find out that that's exactly what it does.

> +
> +	return err;
> +}
> +
> +static void tegra186_bpmp_reset_channels(struct tegra_bpmp *bpmp)
> +{
> +	unsigned int i;
> +
> +	tegra186_bpmp_channel_reset(bpmp->tx_channel);
> +	tegra186_bpmp_channel_reset(bpmp->rx_channel);
> +
> +	for (i =3D 0; i < bpmp->threaded.count; i++)
> +		tegra186_bpmp_channel_reset(&bpmp->threaded_channels[i]);
> +}

I think this now matches the tegra186_bpmp_resume() implementation, so
it could be reused in that.

> +
> +static int tegra186_bpmp_sram_init(struct tegra_bpmp *bpmp)
> +{
> +	int err;
> +	struct tegra186_bpmp *priv =3D bpmp->priv;
> +
> +	priv->sram.tx =3D of_gen_pool_get(bpmp->dev->of_node, "shmem", 0);
> +	if (!priv->sram.tx) {
>  		dev_err(bpmp->dev, "TX shmem pool not found\n");
>  		return -EPROBE_DEFER;
>  	}
> =20
> -	priv->tx.virt =3D (void __iomem *)gen_pool_dma_alloc(priv->tx.pool, 409=
6, &priv->tx.phys);
> +	priv->tx.virt =3D gen_pool_dma_alloc(priv->sram.tx, 4096, &priv->tx.phy=
s);
>  	if (!priv->tx.virt) {
>  		dev_err(bpmp->dev, "failed to allocate from TX pool\n");
>  		return -ENOMEM;
>  	}
> =20
> -	priv->rx.pool =3D of_gen_pool_get(bpmp->dev->of_node, "shmem", 1);
> -	if (!priv->rx.pool) {
> +	priv->sram.rx =3D of_gen_pool_get(bpmp->dev->of_node, "shmem", 1);
> +	if (!priv->sram.rx) {
>  		dev_err(bpmp->dev, "RX shmem pool not found\n");
>  		err =3D -EPROBE_DEFER;
>  		goto free_tx;
>  	}
> =20
> -	priv->rx.virt =3D (void __iomem *)gen_pool_dma_alloc(priv->rx.pool, 409=
6, &priv->rx.phys);
> +	priv->rx.virt =3D gen_pool_dma_alloc(priv->sram.rx, 4096, &priv->rx.phy=
s);
>  	if (!priv->rx.virt) {
>  		dev_err(bpmp->dev, "failed to allocate from RX pool\n");
>  		err =3D -ENOMEM;
>  		goto free_tx;
>  	}
> =20
> -	err =3D tegra186_bpmp_channel_init(bpmp->tx_channel, bpmp,
> -					 bpmp->soc->channels.cpu_tx.offset);
> -	if (err < 0)
> -		goto free_rx;
> +	priv->type =3D TEGRA_SRAM;
> =20
> -	err =3D tegra186_bpmp_channel_init(bpmp->rx_channel, bpmp,
> -					 bpmp->soc->channels.cpu_rx.offset);
> -	if (err < 0)
> -		goto cleanup_tx_channel;
> +	return 0;
> =20
> -	for (i =3D 0; i < bpmp->threaded.count; i++) {
> -		unsigned int index =3D bpmp->soc->channels.thread.offset + i;
> +free_tx:
> +	gen_pool_free(priv->sram.tx, (unsigned long)priv->tx.virt, 4096);
> =20
> -		err =3D tegra186_bpmp_channel_init(&bpmp->threaded_channels[i],
> -						 bpmp, index);
> +	return err;
> +}
> +
> +static enum tegra_bpmp_mem_type tegra186_bpmp_dram_init(struct tegra_bpm=
p *bpmp)
> +{
> +	int err;
> +	struct resource res;
> +	struct device_node *np;
> +	struct tegra186_bpmp *priv =3D bpmp->priv;
> +
> +	np =3D of_parse_phandle(bpmp->dev->of_node, "memory-region", 0);
> +	if (!np)
> +		return TEGRA_INVALID;
> +
> +	err =3D of_address_to_resource(np, 0, &res);
> +	if (err) {
> +		dev_warn(bpmp->dev,  "Parsing memory region returned: %d\n", err);
> +		return TEGRA_INVALID;
> +	}
> +
> +	if ((res.end - res.start + 1) < 0x2000) {

resource_size(), and maybe use SZ_8K instead of the literal here.

> +		dev_warn(bpmp->dev,  "DRAM region less than 0x2000 bytes\n");

Also, better to use a more human-readable string here. While at it,
perhaps we can make this a bit more assertive, maybe something like:

	"DRAM region must be larger than 8 KiB"

?

> +		return TEGRA_INVALID;
> +	}

This doesn't allow the caller to differentiate between potentially fatal
errors and non-fatal ones. For instance, we don't want the absence of a
"memory-region" property to be fatal (because we want to fall back to
use SRAM in that case, or at least attempt to), but if "memory-region"
exists, any of the subsequent errors probably should be fatal. It's
easier to deal with that situation if you return regular error codes
here. The !np check above could return -ENODEV, for example, as a way of
letting the caller know that we don't have DRAM support in DT. For the
of_address_to_resource() failure we can instead propagate the error code
and so on.

Also, I think it'd be better to use a named constant like SZ_8K instead
of the literal 0x2000 above.=20

> +
> +	priv->tx.phys =3D res.start;
> +	priv->rx.phys =3D res.start + 0x1000;

SZ_4K

> +
> +	priv->tx.virt =3D memremap(priv->tx.phys, res.end - res.start + 1, MEMR=
EMAP_WC);

Another case where we can use resource_size(). Might be a good idea to
introduce a local "size" variable.

> +	if (priv->tx.virt =3D=3D NULL) {
> +		dev_warn(bpmp->dev,  "DRAM region mapping failed\n");
> +		return TEGRA_INVALID;
> +	}
> +	priv->rx.virt =3D priv->tx.virt + 0x1000;

SZ_4K

We should probably do the same thing for the SRAM paths, but that should
be a separate patch and can be done at another time.

> +
> +	return TEGRA_RMEM;
> +}
> +
> +static int tegra186_bpmp_init(struct tegra_bpmp *bpmp)
> +{
> +	struct tegra186_bpmp *priv;
> +	int err;
> +
> +	priv =3D devm_kzalloc(bpmp->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	bpmp->priv =3D priv;
> +	priv->parent =3D bpmp;
> +
> +	priv->type =3D tegra186_bpmp_dram_init(bpmp);
> +	if (priv->type =3D=3D TEGRA_INVALID) {
> +		err =3D tegra186_bpmp_sram_init(bpmp);
>  		if (err < 0)
> -			goto cleanup_channels;
> +			return err;
>  	}

As I mentioned previously, I think we can move the block above into
tegra186_bpmp_setup_channels() to make it symmetric with the teardown of
this in tegra186_bpmp_cleanup_channels().

Thierry

> =20
> +	err =3D tegra186_bpmp_channel_setup(bpmp);
> +	if (err < 0)
> +		return err;
> +
>  	/* mbox registration */
>  	priv->mbox.client.dev =3D bpmp->dev;
>  	priv->mbox.client.rx_callback =3D mbox_handle_rx;
> @@ -226,51 +343,22 @@ static int tegra186_bpmp_init(struct tegra_bpmp *bp=
mp)
>  	if (IS_ERR(priv->mbox.channel)) {
>  		err =3D PTR_ERR(priv->mbox.channel);
>  		dev_err(bpmp->dev, "failed to get HSP mailbox: %d\n", err);
> -		goto cleanup_channels;
> +		tegra186_bpmp_channel_deinit(bpmp);
> +		return err;
>  	}
> =20
> -	tegra186_bpmp_channel_reset(bpmp->tx_channel);
> -	tegra186_bpmp_channel_reset(bpmp->rx_channel);
> -
> -	for (i =3D 0; i < bpmp->threaded.count; i++)
> -		tegra186_bpmp_channel_reset(&bpmp->threaded_channels[i]);
> +	tegra186_bpmp_reset_channels(bpmp);
> =20
>  	return 0;
> -
> -cleanup_channels:
> -	for (i =3D 0; i < bpmp->threaded.count; i++) {
> -		if (!bpmp->threaded_channels[i].bpmp)
> -			continue;
> -
> -		tegra186_bpmp_channel_cleanup(&bpmp->threaded_channels[i]);
> -	}
> -
> -	tegra186_bpmp_channel_cleanup(bpmp->rx_channel);
> -cleanup_tx_channel:
> -	tegra186_bpmp_channel_cleanup(bpmp->tx_channel);
> -free_rx:
> -	gen_pool_free(priv->rx.pool, (unsigned long)priv->rx.virt, 4096);
> -free_tx:
> -	gen_pool_free(priv->tx.pool, (unsigned long)priv->tx.virt, 4096);
> -
> -	return err;
>  }
> =20
>  static void tegra186_bpmp_deinit(struct tegra_bpmp *bpmp)
>  {
>  	struct tegra186_bpmp *priv =3D bpmp->priv;
> -	unsigned int i;
> =20
>  	mbox_free_channel(priv->mbox.channel);
> =20
> -	for (i =3D 0; i < bpmp->threaded.count; i++)
> -		tegra186_bpmp_channel_cleanup(&bpmp->threaded_channels[i]);
> -
> -	tegra186_bpmp_channel_cleanup(bpmp->rx_channel);
> -	tegra186_bpmp_channel_cleanup(bpmp->tx_channel);
> -
> -	gen_pool_free(priv->rx.pool, (unsigned long)priv->rx.virt, 4096);
> -	gen_pool_free(priv->tx.pool, (unsigned long)priv->tx.virt, 4096);
> +	tegra186_bpmp_channel_deinit(bpmp);
>  }
> =20
>  static int tegra186_bpmp_resume(struct tegra_bpmp *bpmp)
> diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
> index 8b5e5daa9fae..17bd3590aaa2 100644
> --- a/drivers/firmware/tegra/bpmp.c
> +++ b/drivers/firmware/tegra/bpmp.c
> @@ -735,6 +735,8 @@ static int tegra_bpmp_probe(struct platform_device *p=
dev)
>  	if (!bpmp->threaded_channels)
>  		return -ENOMEM;
> =20
> +	platform_set_drvdata(pdev, bpmp);
> +
>  	err =3D bpmp->soc->ops->init(bpmp);
>  	if (err < 0)
>  		return err;
> @@ -758,8 +760,6 @@ static int tegra_bpmp_probe(struct platform_device *p=
dev)
> =20
>  	dev_info(&pdev->dev, "firmware: %.*s\n", (int)sizeof(tag), tag);
> =20
> -	platform_set_drvdata(pdev, bpmp);
> -
>  	err =3D of_platform_default_populate(pdev->dev.of_node, NULL, &pdev->de=
v);
>  	if (err < 0)
>  		goto free_mrq;
> --=20
> 2.34.1
>=20

--OqDI4t7LIoLLRcc+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmRbqzwACgkQ3SOs138+
s6Gh6hAAmsDxQ7PJv9KWy4Elq+uEIUkv4A1aBAL0Pi6yMOyxRS8f7YtvTufk2uAN
T1veD4qF2/YC5kj0vGtF/C8JzWCMeow3LGywyooAMLsR98FhIW/rRlChr69CIhQu
6rDoZNQ4m4sWboWhMrRHJbG4fKx6nQxGfTHyWmM1oGJy8+V4xsRnOOwH4xrIxTw6
yMOBAS3lex7NPlucZzd2XXsBGx9WFvaZVvHX+7kWc5QXvC8dMw0eIspxtKya7yX9
CcQYKGvakXn+s/b+pwQdP+NPKV3vbzU9TgAwzgEtTFaFsHrs2SBsWrgwLXpeiXHf
BQE3Q3eOlDbaCDzvrSc1sNbxhcUVI/jAMjjdvNlBdI74aXRagBJvhLfl+C+tPyDZ
o4dFnHZzvVudbhUOERVHhj2u1kjYFvQiYIWA99UlnztRWM5j6fmeyK1cu0EsliMM
XWWwEwuhaQq0EnhTXdct2MSBnxwi4+9KTkmWApmmZBwDCUqb2Z5NVZyakZWCsgK6
OdfMBeJnfkfj12MSC6cAVXZyKt4fdB9xznz61nUl5LfTJAC7aoyzzKfnon/BfmvL
EENlFroAHuqRviNgjKMhrfhL9FMjaHeagsOm5RufGq6SjzPZd+C9UiJrfOnYdIWu
g1N1H2RudYO5ZFWNNGaEQX3XJZd0gyUiy+mdjMigI7G4Nngvpo0=
=xWS8
-----END PGP SIGNATURE-----

--OqDI4t7LIoLLRcc+--
