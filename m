Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489F86B2324
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjCILfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjCILfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:35:30 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EDC7E7A5;
        Thu,  9 Mar 2023 03:35:22 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0D53E1C000A;
        Thu,  9 Mar 2023 11:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678361721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YkCJYe4xTl1nq4LBH2Nzf6GB3+OQQsqPo2Fge4ocTUs=;
        b=hiIMPBEnM9/0A6RUHYRZqxFHogmol9ukA6pSF9yyH7WStCrXbZROuFrMCgPWYlCuvRnkhD
        gSVPsluMhNKX56RZrjnI61iTpBTA4waKAQ6JqeRqsvyo/IWOPAl/QL51nSDgAxSyu94yKy
        PIn9wIRH2IZFlmKfSzqKCR71LaKiGkrD/HSgaRQb245/oFmYH13le2EXgsHsrIH75UqLz3
        Z11W3tJOxR+vBh6gHjbD5FbyG6FnNCzR4oHH8uG2wNHJnoqWJ9ZmEH7DlYcnZLCUcl1gLD
        mNnKh0EMvdHeQcM3phRrh+OldNLWfiXLDIRmHeLX33lUlMygrtc3mKklFPVC1A==
Date:   Thu, 9 Mar 2023 12:35:13 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-rtc@vger.kernel.org,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V3] nvmem: add explicit config option to read OF fixed
 cells
Message-ID: <20230309123513.43b7134f@xps-13>
In-Reply-To: <20230309112028.19215-1-zajec5@gmail.com>
References: <20230309112028.19215-1-zajec5@gmail.com>
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

> diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provide=
r.h
> index 0262b86194eb..b3c14ce87a65 100644
> --- a/include/linux/nvmem-provider.h
> +++ b/include/linux/nvmem-provider.h
> @@ -73,6 +73,7 @@ struct nvmem_cell_info {
>   * @owner:	Pointer to exporter module. Used for refcounting.
>   * @cells:	Optional array of pre-defined NVMEM cells.
>   * @ncells:	Number of elements in cells.
> + * @use_fixed_of_cells:	Read fixed NVMEM cells from OF.

I'm still unhappy with the naming, especially since you explained in
more details the whole plan which involves using a container to put
these fixed cells from now on. In both cases you extract cells from
fixed OF nodes but this boolean needs to be set to true in one
case, and false in the other, which would not make sense.

Also, regarding the bindings changes, I'm fairly happy with the idea,
but if we go this way I would prefer a full series instead of
individual changes with:

- the boolean you introduce here (renamed, at the very least)
- the new bindings
- the update of the current provider bindings to take the new bindings
  into account and deprecate the old ones officially
- support for the new bindings in the core

>   * @keepout:	Optional array of keepout ranges (sorted ascending by start=
).
>   * @nkeepout:	Number of elements in the keepout array.
>   * @type:	Type of the nvmem storage
> @@ -103,6 +104,7 @@ struct nvmem_config {
>  	struct module		*owner;
>  	const struct nvmem_cell_info	*cells;
>  	int			ncells;
> +	bool			use_fixed_of_cells;
>  	const struct nvmem_keepout *keepout;
>  	unsigned int		nkeepout;
>  	enum nvmem_type		type;

Thanks,
Miqu=C3=A8l
