Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720055EB5AB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 01:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiIZXXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 19:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiIZXXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:23:23 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D045D0C7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 16:21:31 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 3so7911492pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 16:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Vtd4ZxGAnl6/Vc1zcYUrAA8XLjrJ22nEb+ormUd5geU=;
        b=jTrvz6bF/SB2nxH+poaFA5bWLDSCnsO21WNeMLlw76gVoxaXg7Gq/QZtdWQbRxcIax
         bLN2vkIPNOA5RNLkDDH31sRCfVZQMIvu+bt7B4k/aBaXiW2+2mtJMPQ2Rqht+u0w+QQ+
         Rsz8PsUlVS3oHYgW8J0gY85Jij0hPFZ6MRNtdBb4h9iqnsh0pYd/iUeGKdkOQ/SpGFKh
         eSU+5gCfUuVLXCXLgb7997Vw6hXSsuRgbGdoqFO/oxEUYMmGCpzdlg1uKfdP7+lKDIFV
         3kRuPIAgpIfJwGlHPdNkekGWNwU6H5s6jrve4RGVMEwZXdrxwEF+WGp6sjlO46h2ROqD
         qaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Vtd4ZxGAnl6/Vc1zcYUrAA8XLjrJ22nEb+ormUd5geU=;
        b=CnpvZSQWh01BqIOzN0V1o/aKbmLDQeKmD7LL4MbJhG8Jikub2Pt8CAdV+vc82fRgle
         rzjVt7OuQ+eXQ+1r8NG38nuLpgZXomxM+3mqLwfL8hwCgtihxoy1p7lzkgZBwRdgGQa/
         F8YvjWIhwjqvGXIpXMesVkpodX76hVmpo00m7TYjQ1dHsUkNZSF4rdDuMmjk1WMDBt4p
         y6uQUZ7NnR52wbbjhjl1q4zNaXSeSESZtDrqR4YMSONU9mbHEQ2o32C+IWRb7ahMOyqE
         v1ygzHzd1IsbjuVvmWLfd0AU5rl3ObaFeNAyO4sgg0b9d8WyZTiO6AfU5OV6lAHHMH7p
         PCXA==
X-Gm-Message-State: ACrzQf0PIvbTW7R4/O/teTfLcxSK2XBqiUcmR/zKJW9CX6mQKNvAP45H
        h7AcO/l60eysog2aPQZ3r6Ectw==
X-Google-Smtp-Source: AMsMyM7uEKP/X9XnTuCliOHf/St+XChdIOBlG6o90bLgoFJ1qlMKifAyIXQz5ljUxD640uqP+my/dQ==
X-Received: by 2002:a05:6a00:1346:b0:546:ff1e:26ae with SMTP id k6-20020a056a00134600b00546ff1e26aemr26387773pfu.45.1664234490690;
        Mon, 26 Sep 2022 16:21:30 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id bg8-20020a056a02010800b004348bd693a8sm14706pgb.31.2022.09.26.16.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 16:21:29 -0700 (PDT)
Date:   Mon, 26 Sep 2022 17:21:27 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     bjorn.andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V5 3/6] remoteproc: imx_rproc: support attaching to
 i.MX8QXP M4
Message-ID: <20220926232127.GB2817947@p14s>
References: <20220824011023.1493050-1-peng.fan@oss.nxp.com>
 <20220824011023.1493050-4-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824011023.1493050-4-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 09:10:20AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> When M4 is kicked by SCFW, M4 runs in its own hardware partition, Linux
> could only do IPC with M4, it could not start, stop, update image.
> 
> We disable recovery reboot when M4 is managed by SCFW, because
> remoteproc core still not support M4 auto-recovery without loading
> image.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 108 ++++++++++++++++++++++++++++++++-
>  1 file changed, 107 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 7cc4fd207e2d..bcba74e90020 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -6,6 +6,7 @@
>  #include <linux/arm-smccc.h>
>  #include <linux/clk.h>
>  #include <linux/err.h>
> +#include <linux/firmware/imx/sci.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/mailbox_client.h>
> @@ -59,6 +60,8 @@
>  #define IMX_SIP_RPROC_STARTED		0x01
>  #define IMX_SIP_RPROC_STOP		0x02
>  
> +#define IMX_SC_IRQ_GROUP_REBOOTED	5
> +
>  /**
>   * struct imx_rproc_mem - slim internal memory structure
>   * @cpu_addr: MPU virtual address of the memory region
> @@ -89,6 +92,10 @@ struct imx_rproc {
>  	struct work_struct		rproc_work;
>  	struct workqueue_struct		*workqueue;
>  	void __iomem			*rsc_table;
> +	struct imx_sc_ipc		*ipc_handle;
> +	struct notifier_block		rproc_nb;
> +	u32				rproc_pt;	/* partition id */
> +	u32				rsrc_id;	/* resource id */
>  };
>  
>  static const struct imx_rproc_att imx_rproc_att_imx93[] = {
> @@ -117,6 +124,18 @@ static const struct imx_rproc_att imx_rproc_att_imx93[] = {
>  	{ 0xD0000000, 0xa0000000, 0x10000000, 0 },
>  };
>  
> +static const struct imx_rproc_att imx_rproc_att_imx8qxp[] = {
> +	{ 0x08000000, 0x08000000, 0x10000000, 0 },
> +	/* TCML/U */
> +	{ 0x1FFE0000, 0x34FE0000, 0x00040000, ATT_OWN | ATT_IOMEM },
> +	/* OCRAM(Low 96KB) */
> +	{ 0x21000000, 0x00100000, 0x00018000, 0 },
> +	/* OCRAM */
> +	{ 0x21100000, 0x00100000, 0x00040000, 0 },
> +	/* DDR (Data) */
> +	{ 0x80000000, 0x80000000, 0x60000000, 0 },
> +};
> +
>  static const struct imx_rproc_att imx_rproc_att_imx8mn[] = {
>  	/* dev addr , sys addr  , size	    , flags */
>  	/* ITCM   */
> @@ -255,6 +274,12 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx8mq = {
>  	.method		= IMX_RPROC_MMIO,
>  };
>  
> +static const struct imx_rproc_dcfg imx_rproc_cfg_imx8qxp = {
> +	.att		= imx_rproc_att_imx8qxp,
> +	.att_size	= ARRAY_SIZE(imx_rproc_att_imx8qxp),
> +	.method		= IMX_RPROC_SCU_API,
> +};
> +
>  static const struct imx_rproc_dcfg imx_rproc_cfg_imx8ulp = {
>  	.att		= imx_rproc_att_imx8ulp,
>  	.att_size	= ARRAY_SIZE(imx_rproc_att_imx8ulp),
> @@ -680,6 +705,37 @@ static void imx_rproc_free_mbox(struct rproc *rproc)
>  	mbox_free_channel(priv->rx_ch);
>  }
>  
> +static void imx_rproc_put_scu(struct rproc *rproc)
> +{
> +	struct imx_rproc *priv = rproc->priv;
> +	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
> +
> +	if (dcfg->method != IMX_RPROC_SCU_API)
> +		return;
> +
> +	if (!imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
> +		return;
> +
> +	imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED, BIT(priv->rproc_pt), false);
> +	imx_scu_irq_unregister_notifier(&priv->rproc_nb);
> +}
> +
> +static int imx_rproc_partition_notify(struct notifier_block *nb,
> +				      unsigned long event, void *group)
> +{
> +	struct imx_rproc *priv = container_of(nb, struct imx_rproc, rproc_nb);
> +
> +	/* Ignore other irqs */
> +	if (!((event & BIT(priv->rproc_pt)) && (*(u8 *)group == IMX_SC_IRQ_GROUP_REBOOTED)))
> +		return 0;
> +
> +	rproc_report_crash(priv->rproc, RPROC_WATCHDOG);
> +
> +	pr_info("Partition%d reset!\n", priv->rproc_pt);
> +
> +	return 0;
> +}
> +
>  static int imx_rproc_detect_mode(struct imx_rproc *priv)
>  {
>  	struct regmap_config config = { .name = "imx-rproc" };
> @@ -689,6 +745,7 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
>  	struct arm_smccc_res res;
>  	int ret;
>  	u32 val;
> +	u8 pt;
>  
>  	switch (dcfg->method) {
>  	case IMX_RPROC_NONE:
> @@ -699,6 +756,51 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
>  		if (res.a0)
>  			priv->rproc->state = RPROC_DETACHED;
>  		return 0;
> +	case IMX_RPROC_SCU_API:
> +		ret = imx_scu_get_handle(&priv->ipc_handle);
> +		if (ret)
> +			return ret;
> +		ret = of_property_read_u32(dev->of_node, "fsl,resource-id", &priv->rsrc_id);
> +		if (ret) {
> +			dev_err(dev, "No fsl,resource-id property\n");
> +			return ret;
> +		}
> +
> +		/*
> +		 * If Mcore resource is not owned by Acore partition, It is kicked by ROM,
> +		 * and Linux could only do IPC with Mcore and nothing else.
> +		 */
> +		if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
> +			return 0;

If imx_sc_rm_is_resource_owned() return '1' than the remote processor is under
Linux's control and what follows below is not needed.  That is also coherent
with the comment in [1].

That is in contrast with what is happening in imx_rproc_put_scu().  There, if
the remote processor is _not_ owned by Linux than the condition returns without
calling imx_scu_irq_group_enable() and imx_scu_irq_unregister_notifier().  That
seems to be a bug. 

There is also a problem in patch 4/6 associated to that.

Thanks,
Mathieu


[1]. https://elixir.bootlin.com/linux/v6.0-rc7/source/drivers/firmware/imx/rm.c#L24

> +
> +		priv->rproc->state = RPROC_DETACHED;
> +		priv->rproc->recovery_disabled = true;
> +
> +		/* Get partition id and enable irq in SCFW */
> +		ret = imx_sc_rm_get_resource_owner(priv->ipc_handle, priv->rsrc_id, &pt);
> +		if (ret) {
> +			dev_err(dev, "not able to get resource owner\n");
> +			return ret;
> +		}
> +
> +		priv->rproc_pt = pt;
> +		priv->rproc_nb.notifier_call = imx_rproc_partition_notify;
> +
> +		ret = imx_scu_irq_register_notifier(&priv->rproc_nb);
> +		if (ret) {
> +			dev_warn(dev, "register scu notifier failed.\n");
> +			return ret;
> +		}
> +
> +		ret = imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED, BIT(priv->rproc_pt),
> +					       true);
> +		if (ret) {
> +			imx_scu_irq_unregister_notifier(&priv->rproc_nb);
> +			dev_warn(dev, "Enable irq failed.\n");
> +			return ret;
> +		}
> +
> +		return 0;
>  	default:
>  		break;
>  	}
> @@ -803,7 +905,7 @@ static int imx_rproc_probe(struct platform_device *pdev)
>  
>  	ret = imx_rproc_clk_enable(priv);
>  	if (ret)
> -		goto err_put_mbox;
> +		goto err_put_scu;
>  
>  	INIT_WORK(&priv->rproc_work, imx_rproc_vq_work);
>  
> @@ -820,6 +922,8 @@ static int imx_rproc_probe(struct platform_device *pdev)
>  
>  err_put_clk:
>  	clk_disable_unprepare(priv->clk);
> +err_put_scu:
> +	imx_rproc_put_scu(rproc);
>  err_put_mbox:
>  	imx_rproc_free_mbox(rproc);
>  err_put_wkq:
> @@ -837,6 +941,7 @@ static int imx_rproc_remove(struct platform_device *pdev)
>  
>  	clk_disable_unprepare(priv->clk);
>  	rproc_del(rproc);
> +	imx_rproc_put_scu(rproc);
>  	imx_rproc_free_mbox(rproc);
>  	destroy_workqueue(priv->workqueue);
>  	rproc_free(rproc);
> @@ -852,6 +957,7 @@ static const struct of_device_id imx_rproc_of_match[] = {
>  	{ .compatible = "fsl,imx8mm-cm4", .data = &imx_rproc_cfg_imx8mq },
>  	{ .compatible = "fsl,imx8mn-cm7", .data = &imx_rproc_cfg_imx8mn },
>  	{ .compatible = "fsl,imx8mp-cm7", .data = &imx_rproc_cfg_imx8mn },
> +	{ .compatible = "fsl,imx8qxp-cm4", .data = &imx_rproc_cfg_imx8qxp },
>  	{ .compatible = "fsl,imx8ulp-cm33", .data = &imx_rproc_cfg_imx8ulp },
>  	{ .compatible = "fsl,imx93-cm33", .data = &imx_rproc_cfg_imx93 },
>  	{},
> -- 
> 2.37.1
> 
