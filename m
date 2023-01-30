Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E15A680B61
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbjA3K5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236236AbjA3K5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:57:02 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05A4303CF;
        Mon, 30 Jan 2023 02:56:58 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 53506C0005;
        Mon, 30 Jan 2023 10:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675076217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tb+knWc8+xa2/HboMdrehqj8n7prrLHVDVYJpjds7L0=;
        b=dx0eBt2DUT9QA1cUStZpuihlEBjkczXXHUN7eU6qohkq9uyVgu99pZNPUks9lSEf3INjMe
        Yk8daT6J86YqnA/B749t+i0aoTWOFeYnHU6r5y/0fJJSOUi3MRXDw9D9SQn4vEPv7ob+Iv
        HClmkGs85gjGN4KrO/JLMUoCIivBRYhtPZEfCX/7fDzyFJm8cjHrFsSgJSqWAiToFduHke
        g+yQgy/o2aFDXLO0kePwXPqFG0xQCGm/wtZ2TqApAzolFZqEWmE+5URoKMtHkCwBTruRE2
        Onu1MugaQI9Bkiq1OP9apqs4rDufSuPPP/CDM4Iriyr7tOq0h/tR04GnMRsqPw==
Date:   Mon, 30 Jan 2023 11:56:54 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u-boot@lists.denx.de,
        =?UTF-8?B?UmFmYcWC?= =?UTF-8?B?IE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V3 1/6] nvmem: core: add nvmem_dev_size() helper
Message-ID: <20230130115654.0041716d@xps-13>
In-Reply-To: <20230127125709.32191-1-zajec5@gmail.com>
References: <20230127125709.32191-1-zajec5@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafa=C5=82,

zajec5@gmail.com wrote on Fri, 27 Jan 2023 13:57:04 +0100:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> This is required by layouts that need to read whole NVMEM space. It
> applies to NVMEM devices without hardcoded layout (like U-Boot
> environment data block).
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> ---
> V2: Drop "const" from "const size_t"

It would be good if you could always add a cover-letter, just so that
we can reply to the whole series. In my case I wanted to add a global

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Because I gave this series a quick review and it looks good to me.

Thanks,
Miqu=C3=A8l

> ---
>  drivers/nvmem/core.c           | 13 +++++++++++++
>  include/linux/nvmem-consumer.h |  1 +
>  2 files changed, 14 insertions(+)
>=20
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 38a5728bc65c..9e77af0164aa 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -2063,6 +2063,19 @@ void nvmem_del_cell_lookups(struct nvmem_cell_look=
up *entries, size_t nentries)
>  }
>  EXPORT_SYMBOL_GPL(nvmem_del_cell_lookups);
> =20
> +/**
> + * nvmem_dev_size() - Get the size of a given nvmem device.
> + *
> + * @nvmem: nvmem device.
> + *
> + * Return: size of the nvmem device.
> + */
> +size_t nvmem_dev_size(struct nvmem_device *nvmem)
> +{
> +	return nvmem->size;
> +}
> +EXPORT_SYMBOL_GPL(nvmem_dev_size);
> +
>  /**
>   * nvmem_dev_name() - Get the name of a given nvmem device.
>   *
> diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consume=
r.h
> index fa030d93b768..c3005ab6cc4f 100644
> --- a/include/linux/nvmem-consumer.h
> +++ b/include/linux/nvmem-consumer.h
> @@ -78,6 +78,7 @@ ssize_t nvmem_device_cell_read(struct nvmem_device *nvm=
em,
>  int nvmem_device_cell_write(struct nvmem_device *nvmem,
>  			    struct nvmem_cell_info *info, void *buf);
> =20
> +size_t nvmem_dev_size(struct nvmem_device *nvmem);
>  const char *nvmem_dev_name(struct nvmem_device *nvmem);
> =20
>  void nvmem_add_cell_lookups(struct nvmem_cell_lookup *entries,

