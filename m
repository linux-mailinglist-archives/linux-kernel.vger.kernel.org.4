Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525B45ECBCD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiI0R5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbiI0R44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:56:56 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6E11D6D2B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:56:53 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d10so9232978pfh.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=npXFT+mjvaF7cfnD8CxiTTNYuAp08TyXdAvzMZ7WB0E=;
        b=FXEDE4x70H0Is7C/hx8lkGwvdWxh7hJ19zA8UbzyZWPdRsrfOZ6AVz/eH3jWH4NIcW
         o5jXf4Anq/LH1hqZP21ZxcZ5CayaXNIEz/iW9+jkBp9BzCFzLv6+0abzAh7I8PrWuaKO
         n5hNxuDgXLUpCxgyriiItcfLZc2O1pONS97l4AoQra3lwyM5zES+0WFGvRVOgoN5KQbr
         3jIPssitQUW4KwBW96fb3qfjfHRVVt1uHP7i1wcOGrqN/gDM4+2d3w+GxZdCk5Q431ON
         KopKWKFQrD7/rBGZ4PDyTF7BkgxpAb4GqOjBLSB9PdkvDnTAh7OjagGUZOCe5ptumhKn
         OnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=npXFT+mjvaF7cfnD8CxiTTNYuAp08TyXdAvzMZ7WB0E=;
        b=uod1cI8ZrF7k9rTt0xr2TxotuLMSSNWY++5oUdzhnYo+a9VUVk/qZQAglucDrUGDct
         NjUIe1a2/SoFegNlXer/76cxZb8es+iwnnhzmP2zOC6u2f7/erAYrRzC0FekTqGTosok
         EMqNuTCrzAiJOEZ6B7+2FhJ9/EPbJDJ1ZTD+3v9ejpMacJ3jAAhBK1ic02Mcv8cFeIyZ
         3bPCwUmY0yydfqI1CB8wbmF37fcwRBf7kJcxiZnJllUsFpoHWvWy4wlRwk3VJEdFczee
         iCPgcOOi1gH6ekFuTYSZmltE3bibZ+ll7jHnMgHnTpa2Zln6DORM54He0dh0PWgTiQWm
         UTnA==
X-Gm-Message-State: ACrzQf1GBlTGusxtvAez9BUapW0/Hu1kPm3iyfgngsp1yy6rTohEQ8cC
        gATW0ZImDmVKnDVDTEbPtlCZQg==
X-Google-Smtp-Source: AMsMyM7pClnn7d2S7QkkyRqRw2ml8Z4IXC698YLr0EVxeg6WSPtY6R2UjU+UfJJp6CHGnUYqYvaeIA==
X-Received: by 2002:a63:31d6:0:b0:43a:1129:e485 with SMTP id x205-20020a6331d6000000b0043a1129e485mr25530376pgx.177.1664301413282;
        Tue, 27 Sep 2022 10:56:53 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id 206-20020a6214d7000000b005572ad31d95sm2096760pfu.209.2022.09.27.10.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 10:56:51 -0700 (PDT)
Date:   Tue, 27 Sep 2022 11:56:49 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "bjorn.andersson@kernel.org" <bjorn.andersson@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 3/6] remoteproc: imx_rproc: support attaching to
 i.MX8QXP M4
Message-ID: <20220927175649.GB2883698@p14s>
References: <20220824011023.1493050-1-peng.fan@oss.nxp.com>
 <20220824011023.1493050-4-peng.fan@oss.nxp.com>
 <20220926232127.GB2817947@p14s>
 <DU0PR04MB9417EABB1B0A9B550E94236288559@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417EABB1B0A9B550E94236288559@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 02:48:02AM +0000, Peng Fan wrote:
> Hi Mathieu,
> 
> Thanks for reviewing this patchset.
> > Subject: Re: [PATCH V5 3/6] remoteproc: imx_rproc: support attaching to
> > i.MX8QXP M4
> > 
> > On Wed, Aug 24, 2022 at 09:10:20AM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > When M4 is kicked by SCFW, M4 runs in its own hardware partition,
> > > Linux could only do IPC with M4, it could not start, stop, update image.
> > >
> > > We disable recovery reboot when M4 is managed by SCFW, because
> > > remoteproc core still not support M4 auto-recovery without loading
> > > image.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  drivers/remoteproc/imx_rproc.c | 108
> > > ++++++++++++++++++++++++++++++++-
> > >  1 file changed, 107 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/remoteproc/imx_rproc.c
> > > b/drivers/remoteproc/imx_rproc.c index 7cc4fd207e2d..bcba74e90020
> > > 100644
> > > --- a/drivers/remoteproc/imx_rproc.c
> > > +++ b/drivers/remoteproc/imx_rproc.c
> > > @@ -6,6 +6,7 @@
> > >  #include <linux/arm-smccc.h>
> > >  #include <linux/clk.h>
> > >  #include <linux/err.h>
> > > +#include <linux/firmware/imx/sci.h>
> > >  #include <linux/interrupt.h>
> > >  #include <linux/kernel.h>
> > >  #include <linux/mailbox_client.h>
> > > @@ -59,6 +60,8 @@
> > >  #define IMX_SIP_RPROC_STARTED		0x01
> > >  #define IMX_SIP_RPROC_STOP		0x02
> > >
> > > +#define IMX_SC_IRQ_GROUP_REBOOTED	5
> > > +
> > >  /**
> > >   * struct imx_rproc_mem - slim internal memory structure
> > >   * @cpu_addr: MPU virtual address of the memory region @@ -89,6
> > > +92,10 @@ struct imx_rproc {
> > >  	struct work_struct		rproc_work;
> > >  	struct workqueue_struct		*workqueue;
> > >  	void __iomem			*rsc_table;
> > > +	struct imx_sc_ipc		*ipc_handle;
> > > +	struct notifier_block		rproc_nb;
> > > +	u32				rproc_pt;	/* partition id */
> > > +	u32				rsrc_id;	/* resource id */
> > >  };
> > >
> > >  static const struct imx_rproc_att imx_rproc_att_imx93[] = { @@ -117,6
> > > +124,18 @@ static const struct imx_rproc_att imx_rproc_att_imx93[] = {
> > >  	{ 0xD0000000, 0xa0000000, 0x10000000, 0 },  };
> > >
> > > +static const struct imx_rproc_att imx_rproc_att_imx8qxp[] = {
> > > +	{ 0x08000000, 0x08000000, 0x10000000, 0 },
> > > +	/* TCML/U */
> > > +	{ 0x1FFE0000, 0x34FE0000, 0x00040000, ATT_OWN | ATT_IOMEM },
> > > +	/* OCRAM(Low 96KB) */
> > > +	{ 0x21000000, 0x00100000, 0x00018000, 0 },
> > > +	/* OCRAM */
> > > +	{ 0x21100000, 0x00100000, 0x00040000, 0 },
> > > +	/* DDR (Data) */
> > > +	{ 0x80000000, 0x80000000, 0x60000000, 0 }, };
> > > +
> > >  static const struct imx_rproc_att imx_rproc_att_imx8mn[] = {
> > >  	/* dev addr , sys addr  , size	    , flags */
> > >  	/* ITCM   */
> > > @@ -255,6 +274,12 @@ static const struct imx_rproc_dcfg
> > imx_rproc_cfg_imx8mq = {
> > >  	.method		= IMX_RPROC_MMIO,
> > >  };
> > >
> > > +static const struct imx_rproc_dcfg imx_rproc_cfg_imx8qxp = {
> > > +	.att		= imx_rproc_att_imx8qxp,
> > > +	.att_size	= ARRAY_SIZE(imx_rproc_att_imx8qxp),
> > > +	.method		= IMX_RPROC_SCU_API,
> > > +};
> > > +
> > >  static const struct imx_rproc_dcfg imx_rproc_cfg_imx8ulp = {
> > >  	.att		= imx_rproc_att_imx8ulp,
> > >  	.att_size	= ARRAY_SIZE(imx_rproc_att_imx8ulp),
> > > @@ -680,6 +705,37 @@ static void imx_rproc_free_mbox(struct rproc
> > *rproc)
> > >  	mbox_free_channel(priv->rx_ch);
> > >  }
> > >
> > > +static void imx_rproc_put_scu(struct rproc *rproc) {
> > > +	struct imx_rproc *priv = rproc->priv;
> > > +	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
> > > +
> > > +	if (dcfg->method != IMX_RPROC_SCU_API)
> > > +		return;
> > > +
> > > +	if (!imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
> > > +		return;
> > > +
> > > +	imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED,
> > BIT(priv->rproc_pt), false);
> > > +	imx_scu_irq_unregister_notifier(&priv->rproc_nb);
> > > +}
> > > +
> > > +static int imx_rproc_partition_notify(struct notifier_block *nb,
> > > +				      unsigned long event, void *group) {
> > > +	struct imx_rproc *priv = container_of(nb, struct imx_rproc,
> > > +rproc_nb);
> > > +
> > > +	/* Ignore other irqs */
> > > +	if (!((event & BIT(priv->rproc_pt)) && (*(u8 *)group ==
> > IMX_SC_IRQ_GROUP_REBOOTED)))
> > > +		return 0;
> > > +
> > > +	rproc_report_crash(priv->rproc, RPROC_WATCHDOG);
> > > +
> > > +	pr_info("Partition%d reset!\n", priv->rproc_pt);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static int imx_rproc_detect_mode(struct imx_rproc *priv)  {
> > >  	struct regmap_config config = { .name = "imx-rproc" }; @@ -689,6
> > > +745,7 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
> > >  	struct arm_smccc_res res;
> > >  	int ret;
> > >  	u32 val;
> > > +	u8 pt;
> > >
> > >  	switch (dcfg->method) {
> > >  	case IMX_RPROC_NONE:
> > > @@ -699,6 +756,51 @@ static int imx_rproc_detect_mode(struct
> > imx_rproc *priv)
> > >  		if (res.a0)
> > >  			priv->rproc->state = RPROC_DETACHED;
> > >  		return 0;
> > > +	case IMX_RPROC_SCU_API:
> > > +		ret = imx_scu_get_handle(&priv->ipc_handle);
> > > +		if (ret)
> > > +			return ret;
> > > +		ret = of_property_read_u32(dev->of_node, "fsl,resource-id",
> > &priv->rsrc_id);
> > > +		if (ret) {
> > > +			dev_err(dev, "No fsl,resource-id property\n");
> > > +			return ret;
> > > +		}
> > > +
> > > +		/*
> > > +		 * If Mcore resource is not owned by Acore partition, It is
> > kicked by ROM,
> > > +		 * and Linux could only do IPC with Mcore and nothing else.
> > > +		 */
> > > +		if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv-
> > >rsrc_id))
> > > +			return 0;
> > 
> > If imx_sc_rm_is_resource_owned() return '1' than the remote processor is
> > under Linux's control and what follows below is not needed.  That is also
> > coherent with the comment in [1].
> 
> Case 1: If M4 is owned by Linux, here directly return 0.
> Case 2: If M4 is not owned by Linux, the following code after this line will set
> state as RPROC_DETACHED.

I understand that part.

> 
> Patch 3/6(this patch) is only to support case 2.
> Patch 4/6 is to support case 1.
> 

Let's leave the subsequent patches alone for now.

> > 
> > That is in contrast with what is happening in imx_rproc_put_scu().  There, if
> > the remote processor is _not_ owned by Linux than the condition returns
> > without calling imx_scu_irq_group_enable() and
> > imx_scu_irq_unregister_notifier().  That seems to be a bug.
> 
> No. The two functions only needed when M4 is in a separate hardware partition.
> 
> The scu irq is only needed when M4 is out of linux control and need some
> notification such as M4 is reset by SCU(System Control Unit). That linux got
> notification that M4 is reset by SCU.

I also understand that part.

What I am underlining here is that when the M4 is independent, function
imx_scu_irq_register_notifier() and imx_scu_irq_group_enable() are called but
their cleanup equivalent are not called in imx_rproc_put_scu() because of the '!'
in the if() statement.

> 
> > 
> > There is also a problem in patch 4/6 associated to that.
> 
> If the upper explanation eliminate your concern, "a problem in patch 4/6" should
> not be a problem.
> 
> When M4 is owned by Linux, Linux need handle the power domain. If M4 is not owned
> by Linux, SCU firmware will handle the power domain, and Linux has no permission to
> touch that.
> 
> Thanks
> Peng
> 
> > 
> > Thanks,
> > Mathieu
> > 
> > 
> > [1].
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir
> > .bootlin.com%2Flinux%2Fv6.0-
> > rc7%2Fsource%2Fdrivers%2Ffirmware%2Fimx%2Frm.c%23L24&amp;data=0
> > 5%7C01%7Cpeng.fan%40nxp.com%7Cbe679e9a409a48b834b908daa015d92
> > c%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637998312946913
> > 710%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu
> > MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=
> > JDRvoDGGgEiSmbhj3410V2DNxamZbDmMS0U2GvBnI74%3D&amp;reserved
> > =0
> > 
> > > +
> > > +		priv->rproc->state = RPROC_DETACHED;
> > > +		priv->rproc->recovery_disabled = true;
> > > +
> > > +		/* Get partition id and enable irq in SCFW */
> > > +		ret = imx_sc_rm_get_resource_owner(priv->ipc_handle,
> > priv->rsrc_id, &pt);
> > > +		if (ret) {
> > > +			dev_err(dev, "not able to get resource owner\n");
> > > +			return ret;
> > > +		}
> > > +
> > > +		priv->rproc_pt = pt;
> > > +		priv->rproc_nb.notifier_call = imx_rproc_partition_notify;
> > > +
> > > +		ret = imx_scu_irq_register_notifier(&priv->rproc_nb);
> > > +		if (ret) {
> > > +			dev_warn(dev, "register scu notifier failed.\n");
> > > +			return ret;
> > > +		}
> > > +
> > > +		ret =
> > imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED, BIT(priv-
> > >rproc_pt),
> > > +					       true);
> > > +		if (ret) {
> > > +			imx_scu_irq_unregister_notifier(&priv->rproc_nb);
> > > +			dev_warn(dev, "Enable irq failed.\n");
> > > +			return ret;
> > > +		}
> > > +
> > > +		return 0;
> > >  	default:
> > >  		break;
> > >  	}
> > > @@ -803,7 +905,7 @@ static int imx_rproc_probe(struct platform_device
> > > *pdev)
> > >
> > >  	ret = imx_rproc_clk_enable(priv);
> > >  	if (ret)
> > > -		goto err_put_mbox;
> > > +		goto err_put_scu;
> > >
> > >  	INIT_WORK(&priv->rproc_work, imx_rproc_vq_work);
> > >
> > > @@ -820,6 +922,8 @@ static int imx_rproc_probe(struct platform_device
> > > *pdev)
> > >
> > >  err_put_clk:
> > >  	clk_disable_unprepare(priv->clk);
> > > +err_put_scu:
> > > +	imx_rproc_put_scu(rproc);
> > >  err_put_mbox:
> > >  	imx_rproc_free_mbox(rproc);
> > >  err_put_wkq:
> > > @@ -837,6 +941,7 @@ static int imx_rproc_remove(struct
> > platform_device
> > > *pdev)
> > >
> > >  	clk_disable_unprepare(priv->clk);
> > >  	rproc_del(rproc);
> > > +	imx_rproc_put_scu(rproc);
> > >  	imx_rproc_free_mbox(rproc);
> > >  	destroy_workqueue(priv->workqueue);
> > >  	rproc_free(rproc);
> > > @@ -852,6 +957,7 @@ static const struct of_device_id
> > imx_rproc_of_match[] = {
> > >  	{ .compatible = "fsl,imx8mm-cm4", .data =
> > &imx_rproc_cfg_imx8mq },
> > >  	{ .compatible = "fsl,imx8mn-cm7", .data =
> > &imx_rproc_cfg_imx8mn },
> > >  	{ .compatible = "fsl,imx8mp-cm7", .data =
> > &imx_rproc_cfg_imx8mn },
> > > +	{ .compatible = "fsl,imx8qxp-cm4", .data =
> > &imx_rproc_cfg_imx8qxp },
> > >  	{ .compatible = "fsl,imx8ulp-cm33", .data =
> > &imx_rproc_cfg_imx8ulp },
> > >  	{ .compatible = "fsl,imx93-cm33", .data = &imx_rproc_cfg_imx93 },
> > >  	{},
> > > --
> > > 2.37.1
> > >
