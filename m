Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA3061A748
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 04:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiKED2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 23:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKED2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 23:28:39 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F63226E0;
        Fri,  4 Nov 2022 20:28:37 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id F068D3200786;
        Fri,  4 Nov 2022 23:28:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 04 Nov 2022 23:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1667618913; x=
        1667705313; bh=ZSEveSA+x+H7MIAbgUpKTfCG+A8XTMg2wIBglmu8gaw=; b=U
        E6s9MjVL4cmB43Fl+OXhgBFm0nFhyaZcyu893ky3qnkMwsuRQo4l2eoUB0bxL76f
        fNdxeg38Y3/c98nd/B1IibG3RSZy8jdPK855TDDf3WaGcAHoTS1ArMA5s1KH6s7s
        pP4qYhgCB3uKJCR8BxuAc6XxpYsm29IjSPZTRHLcWuEi0p82QpAj7Oy3faz1BCTN
        0ntuQBhot5FSBe6vbK5kplrY/fxWQ6UcXHwU9aoUJllVYznHS5POv6KxzsfVERha
        4njW58NP2mwzyUQ6FrYU+MBAc3dqH0tCFd5CKlwtqxn+nW+vt/txx3je3F4+728A
        imXFedNxp1OxB4Rt39Hgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1667618913; x=
        1667705313; bh=ZSEveSA+x+H7MIAbgUpKTfCG+A8XTMg2wIBglmu8gaw=; b=n
        rhRerV1fah/wtJJIr3Jtv8sFOMAf/gWLwkiF+AijiY6PZ2WSPy++7mLGsQmGXzY9
        MH0L1zBqqNTtN76gNMxbFwOHHRzgqNWvhsYtwlKkF6pQv3IyChxXCYcS4SX2bBAA
        456saopTE0niU/2MV2OEJx55X3x/kTfZMjEI2Huwr3MAWHJTz2b+ryyZ3kP3xxl1
        dGT0TUOo3d7kzMXgVPre5pV24c6REHpYVU3V0Z/uJyJ/GrIRAoRLgYjb+fYZvK1M
        jMIxmCIZwZZBRSQHzFXtRmFDPO2z/tF6WTSO4QEVu67Z2oFHIR225qdSPu1XenRY
        fxaFlDP3QbTjU6i+H+DNQ==
X-ME-Sender: <xms:YdhlYzBxbtNvAlTvxlDNTG3qXv07icd2uP9fSwFtIQvCXASYr-WwBA>
    <xme:YdhlY5ht7X8idKFGJOPLFb6w1gJ7vCiDRC9IfaL0AKsVEfVFkxVpx91l0wDZ752mi
    1qZ_WMLuCICVDYN6Q>
X-ME-Received: <xmr:YdhlY-mRDpgkO_FkH4xbp0fSBdykBgJjk2DY5588VQoWSqJPSbsz8QrsLHGuJI-CFVauDYG2Ww5ZqOfFlRWmB4tv7kddowcCXYKd4YYtF_t0Nmj05t6nBfGVCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvddvgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepjefgfffhudejfedtuedugeeutdetgfeiteffffehjeeugfeuvdeh
    jeetfedtffdtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:YdhlY1zi-qrQJS_nORV-ujNRFBUO_NTQC9cMi1BC6Mkj6PMjLJdjaw>
    <xmx:YdhlY4TNROWtxl1vFu_QFifBHiDL1__qTJek6SF8k-oNZaK9zuXeUQ>
    <xmx:YdhlY4a1ht1HNfRxREjRM2dzBNz5P7EipoyhvUgTyyHzgsVqiZpEyQ>
    <xmx:YdhlYx9SPY6xdiNcPUq7CfqDlty7VJKLPD3DyTbK6c_APAs2gDk1Dg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Nov 2022 23:28:32 -0400 (EDT)
Message-ID: <a32d9cc3-b5e7-3531-43c6-d92846fece1c@sholland.org>
Date:   Fri, 4 Nov 2022 22:28:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Jernej Skrabec <jernej.skrabec@gmail.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wens@csie.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221101123201.3021129-1-jernej.skrabec@gmail.com>
 <20221101123201.3021129-3-jernej.skrabec@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 2/3] media: sunxi: Add H6 deinterlace driver
In-Reply-To: <20221101123201.3021129-3-jernej.skrabec@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

On 11/1/22 07:32, Jernej Skrabec wrote:
> This driver covers H6 deinterlace core, which is marked in vendor driver
> as v2.3. Contrary to older cores, covered by sun8i-di, it doesn't
> support scaling, but it supports iommu and has additional motion
> compensated deinterlacing algorithm.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  MAINTAINERS                                   |    4 +-
>  drivers/media/platform/sunxi/Kconfig          |    1 +
>  drivers/media/platform/sunxi/Makefile         |    1 +
>  .../media/platform/sunxi/sun50i-di/Kconfig    |   15 +
>  .../media/platform/sunxi/sun50i-di/Makefile   |    2 +
>  .../platform/sunxi/sun50i-di/sun50i-di.c      | 1142 +++++++++++++++++
>  .../platform/sunxi/sun50i-di/sun50i-di.h      |  175 +++
>  7 files changed, 1339 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/media/platform/sunxi/sun50i-di/Kconfig
>  create mode 100644 drivers/media/platform/sunxi/sun50i-di/Makefile
>  create mode 100644 drivers/media/platform/sunxi/sun50i-di/sun50i-di.c
>  create mode 100644 drivers/media/platform/sunxi/sun50i-di/sun50i-di.h
> 
> [...]
>
> +static int deinterlace_start_streaming(struct vb2_queue *vq, unsigned int count)
> +{
> +	struct deinterlace_ctx *ctx = vb2_get_drv_priv(vq);
> +	struct device *dev = ctx->dev->dev;
> +	int ret;
> +
> +	if (V4L2_TYPE_IS_OUTPUT(vq->type)) {
> +		ret = pm_runtime_get_sync(dev);

This should use pm_runtime_resume_and_get().

> +		if (ret < 0) {
> +			dev_err(dev, "Failed to enable module\n");
> +
> +			goto err_runtime_get;
> +		}
> +
> +		ctx->first_field =
> +			ctx->src_fmt.field == V4L2_FIELD_INTERLACED_BT;
> +		ctx->field = ctx->first_field;
> +
> +		ctx->prev[0] = NULL;
> +		ctx->prev[1] = NULL;
> +		ctx->aborting = 0;
> +
> +		ctx->flag1_buf = dma_alloc_coherent(dev, FLAG_SIZE,
> +						    &ctx->flag1_buf_dma,
> +						    GFP_KERNEL);
> +		if (!ctx->flag1_buf) {
> +			ret = -ENOMEM;
> +
> +			goto err_no_mem1;
> +		}
> +
> +		ctx->flag2_buf = dma_alloc_coherent(dev, FLAG_SIZE,
> +						    &ctx->flag2_buf_dma,
> +						    GFP_KERNEL);
> +		if (!ctx->flag2_buf) {
> +			ret = -ENOMEM;
> +
> +			goto err_no_mem2;
> +		}
> +	}
> +
> +	return 0;
> +
> +err_no_mem2:
> +	dma_free_coherent(dev, FLAG_SIZE, ctx->flag1_buf,
> +			  ctx->flag1_buf_dma);
> +err_no_mem1:
> +	pm_runtime_put(dev);
> +err_runtime_get:
> +	deinterlace_queue_cleanup(vq, VB2_BUF_STATE_QUEUED);
> +
> +	return ret;
> +}
> +
> +static void deinterlace_stop_streaming(struct vb2_queue *vq)
> +{
> +	struct deinterlace_ctx *ctx = vb2_get_drv_priv(vq);
> +
> +	if (V4L2_TYPE_IS_OUTPUT(vq->type)) {
> +		struct device *dev = ctx->dev->dev;
> +
> +		dma_free_coherent(dev, FLAG_SIZE, ctx->flag1_buf,
> +				  ctx->flag1_buf_dma);
> +		dma_free_coherent(dev, FLAG_SIZE, ctx->flag2_buf,
> +				  ctx->flag2_buf_dma);
> +
> +		pm_runtime_put(dev);
> +	}
> +
> +	deinterlace_queue_cleanup(vq, VB2_BUF_STATE_ERROR);
> +}
> +
> +static const struct vb2_ops deinterlace_qops = {
> +	.queue_setup		= deinterlace_queue_setup,
> +	.buf_prepare		= deinterlace_buf_prepare,
> +	.buf_queue		= deinterlace_buf_queue,
> +	.start_streaming	= deinterlace_start_streaming,
> +	.stop_streaming		= deinterlace_stop_streaming,
> +	.wait_prepare		= vb2_ops_wait_prepare,
> +	.wait_finish		= vb2_ops_wait_finish,
> +};
> +
> +static int deinterlace_queue_init(void *priv, struct vb2_queue *src_vq,
> +				  struct vb2_queue *dst_vq)
> +{
> +	struct deinterlace_ctx *ctx = priv;
> +	int ret;
> +
> +	src_vq->type = V4L2_BUF_TYPE_VIDEO_OUTPUT;
> +	src_vq->io_modes = VB2_MMAP | VB2_DMABUF;
> +	src_vq->drv_priv = ctx;
> +	src_vq->buf_struct_size = sizeof(struct v4l2_m2m_buffer);
> +	src_vq->min_buffers_needed = 1;
> +	src_vq->ops = &deinterlace_qops;
> +	src_vq->mem_ops = &vb2_dma_contig_memops;
> +	src_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
> +	src_vq->lock = &ctx->dev->dev_mutex;
> +	src_vq->dev = ctx->dev->dev;
> +
> +	ret = vb2_queue_init(src_vq);
> +	if (ret)
> +		return ret;
> +
> +	dst_vq->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
> +	dst_vq->io_modes = VB2_MMAP | VB2_DMABUF;
> +	dst_vq->drv_priv = ctx;
> +	dst_vq->buf_struct_size = sizeof(struct v4l2_m2m_buffer);
> +	dst_vq->min_buffers_needed = 2;
> +	dst_vq->ops = &deinterlace_qops;
> +	dst_vq->mem_ops = &vb2_dma_contig_memops;
> +	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
> +	dst_vq->lock = &ctx->dev->dev_mutex;
> +	dst_vq->dev = ctx->dev->dev;
> +
> +	ret = vb2_queue_init(dst_vq);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int deinterlace_open(struct file *file)
> +{
> +	struct deinterlace_dev *dev = video_drvdata(file);
> +	struct deinterlace_ctx *ctx = NULL;
> +	int ret;
> +
> +	if (mutex_lock_interruptible(&dev->dev_mutex))
> +		return -ERESTARTSYS;
> +
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);

This memory allocation does not need to be inside the lock.

> +	if (!ctx) {
> +		mutex_unlock(&dev->dev_mutex);
> +		return -ENOMEM;
> +	}
> +
> +	/* set default output and capture format */
> +	deinterlace_set_out_format(ctx, &ctx->src_fmt);
> +
> +	v4l2_fh_init(&ctx->fh, video_devdata(file));
> +	file->private_data = &ctx->fh;
> +	ctx->dev = dev;
> +
> +	ctx->fh.m2m_ctx = v4l2_m2m_ctx_init(dev->m2m_dev, ctx,
> +					    &deinterlace_queue_init);
> +	if (IS_ERR(ctx->fh.m2m_ctx)) {
> +		ret = PTR_ERR(ctx->fh.m2m_ctx);
> +		goto err_free;
> +	}
> +
> +	v4l2_fh_add(&ctx->fh);
> +
> +	mutex_unlock(&dev->dev_mutex);
> +
> +	return 0;
> +
> +err_free:
> +	kfree(ctx);
> +	mutex_unlock(&dev->dev_mutex);
> +
> +	return ret;
> +}
> +
> +static int deinterlace_release(struct file *file)
> +{
> +	struct deinterlace_dev *dev = video_drvdata(file);
> +	struct deinterlace_ctx *ctx = container_of(file->private_data,
> +						   struct deinterlace_ctx, fh);
> +
> +	mutex_lock(&dev->dev_mutex);
> +
> +	v4l2_fh_del(&ctx->fh);
> +	v4l2_fh_exit(&ctx->fh);
> +	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
> +
> +	kfree(ctx);

This does not need to be inside the lock either.

> +
> +	mutex_unlock(&dev->dev_mutex);
> +
> +	return 0;
> +}
> +
> +static const struct v4l2_file_operations deinterlace_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= deinterlace_open,
> +	.release	= deinterlace_release,
> +	.poll		= v4l2_m2m_fop_poll,
> +	.unlocked_ioctl	= video_ioctl2,
> +	.mmap		= v4l2_m2m_fop_mmap,
> +};
> +
> +static const struct video_device deinterlace_video_device = {
> +	.name		= DEINTERLACE_NAME,
> +	.vfl_dir	= VFL_DIR_M2M,
> +	.fops		= &deinterlace_fops,
> +	.ioctl_ops	= &deinterlace_ioctl_ops,
> +	.minor		= -1,
> +	.release	= video_device_release_empty,
> +	.device_caps	= V4L2_CAP_VIDEO_M2M | V4L2_CAP_STREAMING,
> +};
> +
> +static const struct v4l2_m2m_ops deinterlace_m2m_ops = {
> +	.device_run	= deinterlace_device_run,
> +	.job_ready	= deinterlace_job_ready,
> +	.job_abort	= deinterlace_job_abort,
> +};
> +
> +static int deinterlace_probe(struct platform_device *pdev)
> +{
> +	struct deinterlace_dev *dev;
> +	struct video_device *vfd;
> +	int irq, ret;
> +
> +	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	dev->vfd = deinterlace_video_device;
> +	dev->dev = &pdev->dev;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq <= 0)
> +		return irq;
> +
> +	ret = devm_request_irq(dev->dev, irq, deinterlace_irq,
> +			       0, dev_name(dev->dev), dev);

You should expect to receive an interrupt as soon as you call this
function, but dev->base is not initialized yet.

> +	if (ret) {
> +		dev_err(dev->dev, "Failed to request IRQ\n");
> +
> +		return ret;
> +	}
> +
> +	dev->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(dev->base))
> +		return PTR_ERR(dev->base);
> +
> +	dev->bus_clk = devm_clk_get(dev->dev, "bus");
> +	if (IS_ERR(dev->bus_clk))
> +		return dev_err_probe(dev->dev, PTR_ERR(dev->bus_clk),
> +				     "Failed to get bus clock\n");
> +
> +	dev->mod_clk = devm_clk_get(dev->dev, "mod");
> +	if (IS_ERR(dev->mod_clk))
> +		return dev_err_probe(dev->dev, PTR_ERR(dev->mod_clk),
> +				     "Failed to get mod clock\n");
> +
> +	dev->ram_clk = devm_clk_get(dev->dev, "ram");
> +	if (IS_ERR(dev->ram_clk))
> +		return dev_err_probe(dev->dev, PTR_ERR(dev->ram_clk),
> +				     "Failed to get ram clock\n");
> +
> +	dev->rstc = devm_reset_control_get(dev->dev, NULL);
> +	if (IS_ERR(dev->rstc))
> +		return dev_err_probe(dev->dev, PTR_ERR(dev->rstc),
> +				     "Failed to get reset control\n");
> +
> +	dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(32));
> +	dma_set_max_seg_size(dev->dev, UINT_MAX);
> +
> +	mutex_init(&dev->dev_mutex);
> +
> +	INIT_DELAYED_WORK(&dev->watchdog_work, deinterlace_watchdog);
> +
> +	ret = v4l2_device_register(&pdev->dev, &dev->v4l2_dev);
> +	if (ret) {
> +		dev_err(dev->dev, "Failed to register V4L2 device\n");
> +
> +		return ret;
> +	}
> +
> +	vfd = &dev->vfd;
> +	vfd->lock = &dev->dev_mutex;
> +	vfd->v4l2_dev = &dev->v4l2_dev;
> +
> +	snprintf(vfd->name, sizeof(vfd->name), "%s",
> +		 deinterlace_video_device.name);
> +	video_set_drvdata(vfd, dev);
> +
> +	ret = video_register_device(vfd, VFL_TYPE_VIDEO, 0);
> +	if (ret) {
> +		v4l2_err(&dev->v4l2_dev, "Failed to register video device\n");
> +
> +		goto err_v4l2;
> +	}
> +
> +	v4l2_info(&dev->v4l2_dev,
> +		  "Device registered as /dev/video%d\n", vfd->num);
> +
> +	dev->m2m_dev = v4l2_m2m_init(&deinterlace_m2m_ops);
> +	if (IS_ERR(dev->m2m_dev)) {
> +		v4l2_err(&dev->v4l2_dev,
> +			 "Failed to initialize V4L2 M2M device\n");
> +		ret = PTR_ERR(dev->m2m_dev);
> +
> +		goto err_video;
> +	}
> +
> +	platform_set_drvdata(pdev, dev);
> +
> +	pm_runtime_enable(dev->dev);
> +
> +	return 0;
> +
> +err_video:
> +	video_unregister_device(&dev->vfd);
> +err_v4l2:
> +	v4l2_device_unregister(&dev->v4l2_dev);
> +
> +	return ret;
> +}
> +
> +static int deinterlace_remove(struct platform_device *pdev)
> +{
> +	struct deinterlace_dev *dev = platform_get_drvdata(pdev);
> +
> +	v4l2_m2m_release(dev->m2m_dev);
> +	video_unregister_device(&dev->vfd);
> +	v4l2_device_unregister(&dev->v4l2_dev);
> +
> +	pm_runtime_force_suspend(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static int deinterlace_runtime_resume(struct device *device)
> +{
> +	struct deinterlace_dev *dev = dev_get_drvdata(device);
> +	int ret;
> +
> +	ret = clk_prepare_enable(dev->bus_clk);
> +	if (ret) {
> +		dev_err(dev->dev, "Failed to enable bus clock\n");
> +
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(dev->mod_clk);
> +	if (ret) {
> +		dev_err(dev->dev, "Failed to enable mod clock\n");
> +
> +		goto err_bus_clk;
> +	}
> +
> +	ret = clk_prepare_enable(dev->ram_clk);
> +	if (ret) {
> +		dev_err(dev->dev, "Failed to enable ram clock\n");
> +
> +		goto err_mod_clk;
> +	}
> +
> +	ret = reset_control_deassert(dev->rstc);
> +	if (ret) {
> +		dev_err(dev->dev, "Failed to apply reset\n");
> +
> +		goto err_ram_clk;
> +	}

The manuals generally recommend deasserting the reset before enabling
the clock.

Also, the BSP sets the module clock rate to 300 MHz (PLL_PERIPH0 / 2).
Do you think we should do the same? I am guessing the default is 600 MHz
(PLL_PERIPH0 / 1), which is fine as long as the module works at that
frequency, although it may not be optimal for power usage.

> +
> +	deinterlace_init(dev);
> +
> +	return 0;
> +
> +err_ram_clk:
> +	clk_disable_unprepare(dev->ram_clk);
> +err_mod_clk:
> +	clk_disable_unprepare(dev->mod_clk);
> +err_bus_clk:
> +	clk_disable_unprepare(dev->bus_clk);
> +
> +	return ret;
> +}
> +
> +static int deinterlace_runtime_suspend(struct device *device)
> +{
> +	struct deinterlace_dev *dev = dev_get_drvdata(device);
> +
> +	reset_control_assert(dev->rstc);
> +
> +	clk_disable_unprepare(dev->ram_clk);
> +	clk_disable_unprepare(dev->mod_clk);
> +	clk_disable_unprepare(dev->bus_clk);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id deinterlace_dt_match[] = {
> +	{ .compatible = "allwinner,sun50i-h6-deinterlace" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, deinterlace_dt_match);
> +
> +static const struct dev_pm_ops deinterlace_pm_ops = {
> +	.runtime_resume		= deinterlace_runtime_resume,
> +	.runtime_suspend	= deinterlace_runtime_suspend,
> +};
> +
> +static struct platform_driver deinterlace_driver = {
> +	.probe		= deinterlace_probe,
> +	.remove		= deinterlace_remove,
> +	.driver		= {
> +		.name		= DEINTERLACE_NAME,
> +		.of_match_table	= deinterlace_dt_match,
> +		.pm		= &deinterlace_pm_ops,
> +	},
> +};
> +module_platform_driver(deinterlace_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Jernej Skrabec <jernej.skrabec@gmail.com>");
> +MODULE_DESCRIPTION("Allwinner sun50i deinterlace driver");
> diff --git a/drivers/media/platform/sunxi/sun50i-di/sun50i-di.h b/drivers/media/platform/sunxi/sun50i-di/sun50i-di.h
> new file mode 100644
> index 000000000000..c6eae30040e9
> --- /dev/null
> +++ b/drivers/media/platform/sunxi/sun50i-di/sun50i-di.h
> @@ -0,0 +1,175 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Allwinner Deinterlace driver
> + *
> + * Copyright (C) 2020 Jernej Skrabec <jernej.skrabec@gmail.com>
> + */
> +
> +#ifndef _SUN8I_DEINTERLACE_H_
> +#define _SUN8I_DEINTERLACE_H_

The header guard doesn't match the file.

Regards,
Samuel

