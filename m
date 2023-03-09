Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CB06B251F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjCINTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjCINTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:19:31 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28764C06;
        Thu,  9 Mar 2023 05:19:29 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D29391BF203;
        Thu,  9 Mar 2023 13:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678367968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KCS0grjDle8LqIHXYUqxgW9dQGLLuD8q9UNKbRuhYbk=;
        b=Xwei8LaM7A3PtmP2nNF4x28yyM+iJOS9s9PrMxCrGzZC58KjSVM8cHaBeXrAZI/NtfH/9j
        r01nhfdqw3Y5E4seWycsQrKTDFGGLW5n7wwD+gr+9XPRGo17l49ulVlJXO+zEXIj6W/wVp
        xHnGPGBF0BnN6CjB6Mu7s0CWOOvq/3wpWShvMBXpv9A0NVrQOjh4c49bXdwQz2Qj8hWt33
        zxizmlPdNsdJMSab2n/Xqmakf0DwsfvgnyFw9d/JVszhf957LuH1cfuu0MN5C7gxIvLwp6
        eigmkj5aTAo76n4kZiDx68XnLa0GLX9JeCOa/Bk5Ds7ImdmzV7EC+0ot+vZz3Q==
Date:   Thu, 9 Mar 2023 14:19:20 +0100
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
Message-ID: <20230309141920.1d3f774e@xps-13>
In-Reply-To: <e845b38c-d0eb-716c-dc51-b89582750f07@gmail.com>
References: <20230309112028.19215-1-zajec5@gmail.com>
        <20230309123513.43b7134f@xps-13>
        <e845b38c-d0eb-716c-dc51-b89582750f07@gmail.com>
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

zajec5@gmail.com wrote on Thu, 9 Mar 2023 13:01:19 +0100:

> On 9.03.2023 12:35, Miquel Raynal wrote:
> >> diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-prov=
ider.h
> >> index 0262b86194eb..b3c14ce87a65 100644
> >> --- a/include/linux/nvmem-provider.h
> >> +++ b/include/linux/nvmem-provider.h
> >> @@ -73,6 +73,7 @@ struct nvmem_cell_info {
> >>    * @owner:	Pointer to exporter module. Used for refcounting.
> >>    * @cells:	Optional array of pre-defined NVMEM cells.
> >>    * @ncells:	Number of elements in cells.
> >> + * @use_fixed_of_cells:	Read fixed NVMEM cells from OF. =20
> >=20
> > I'm still unhappy with the naming, especially since you explained in
> > more details the whole plan which involves using a container to put
> > these fixed cells from now on. In both cases you extract cells from
> > fixed OF nodes but this boolean needs to be set to true in one
> > case, and false in the other, which would not make sense.
> >=20
> > Also, regarding the bindings changes, I'm fairly happy with the idea,
> > but if we go this way I would prefer a full series instead of
> > individual changes with:
> >=20
> > - the boolean you introduce here (renamed, at the very least)
> > - the new bindings =20
>=20
> I assume you mean fixed-layout.yaml?

Yes!

> > - the update of the current provider bindings to take the new bindings
> >    into account and deprecate the old ones officially =20
>=20
> What has to be updated in current proceds? It seems to me that:
> 1. Current NVMEM providers reference nvmem.yaml
> 2. nvmem.yaml references nvmem-layout.yaml
> 3. nvmem-layout.yaml references fixed-layout.yaml
>=20
> what else is missing?

That's the theory, but then provider bindings should reflect the
changes as well in their own binding documents.

IOW, this one (and all its cousins) becomes legacy and must be updated:

https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bin=
dings/nvmem/imx-ocotp.yaml#L92

(and there are many files to update then)

>=20
>=20
> > - support for the new bindings in the core =20
>=20
> Please, don't get me wrong, but I'm not going to spend more hours on
> actual coding without approval of chosen path.

Well, you want to make the bindings evolve. Just updating a single
binding file is not enough, I believe we should at least provide full
support for the new description. But of course I'm fine discussing what
description we want first.

> I'll need to have
> [PATCH V2] dt-bindings: nvmem: layouts: add fixed-layout
> reviewed/acked first. If you can do that that's great.
>=20
>=20
> >>    * @keepout:	Optional array of keepout ranges (sorted ascending by s=
tart).
> >>    * @nkeepout:	Number of elements in the keepout array.
> >>    * @type:	Type of the nvmem storage
> >> @@ -103,6 +104,7 @@ struct nvmem_config {
> >>   	struct module		*owner;
> >>   	const struct nvmem_cell_info	*cells;
> >>   	int			ncells;
> >> +	bool			use_fixed_of_cells;
> >>   	const struct nvmem_keepout *keepout;
> >>   	unsigned int		nkeepout;
> >>   	enum nvmem_type		type; =20
> >=20
> > Thanks,
> > Miqu=C3=A8l =20
>=20


Thanks,
Miqu=C3=A8l
