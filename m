Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51696D2178
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 15:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbjCaN2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 09:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjCaN2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 09:28:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF66E1E726;
        Fri, 31 Mar 2023 06:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680269281; x=1711805281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gV+tAsjJDIVkSYDuoFFsyrszwDoMsykTp5jYI6zFdSs=;
  b=l+YJ1ERkEWVaWRkHUfjh3T9bFN4Kylo9cY7Qy/mwPylDvPbBwunLJ/sz
   Gq9wx500EXRnyqkuGt9mdqL+xaHh+yKKRBSRuyHvtyn4/SObvG6UR+Nub
   UVJZcvHDHwLfePV30cQ2X4E5IuzfjkoWAUULfSmOIXHYUvBeDiLE12RQL
   4LFD4yO9Ju+zFJRaYK/xsIceE63yiXdVr7tiDwBKV2e4ePTWgQjBxUMK+
   uJx7ryPHq9stkA2JlJuhvQujHV3AObqHyBXgrfUVeOzJfzvlQybIKyw1H
   OTSua+JoUMmvr3NrCc/SjGTA7vEbCNe6mIEUNMKEU80PIppVImhG9A9aU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="369237482"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="369237482"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 06:28:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="749642602"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="749642602"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 06:27:56 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 3F0E411F931;
        Fri, 31 Mar 2023 16:27:54 +0300 (EEST)
Date:   Fri, 31 Mar 2023 16:27:54 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Vaishnav Achath <vaishnav.a@ti.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        mripard@kernel.org, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        laurent.pinchart@ideasonboard.com, tomi.valkeinen@ideasonboard.com,
        linux-kernel@vger.kernel.org, bparrot@ti.com,
        niklas.soderlund+renesas@ragnatech.se, j-luthra@ti.com,
        devarsht@ti.com, praneeth@ti.com, u-kumar1@ti.com, vigneshr@ti.com,
        nm@ti.com, martyn.welch@collabora.com
Subject: Re: [PATCH v7 10/13] media: ti: Add CSI2RX support for J721E
Message-ID: <ZCbf2nWohkkD1orW@kekkonen.localdomain>
References: <20230314115516.667-1-vaishnav.a@ti.com>
 <20230314115516.667-11-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314115516.667-11-vaishnav.a@ti.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vaishnav,

On Tue, Mar 14, 2023 at 05:25:13PM +0530, Vaishnav Achath wrote:
...
> +static int ti_csi2rx_querycap(struct file *file, void *priv,
> +			      struct v4l2_capability *cap)
> +{
> +	struct ti_csi2rx_dev *csi = video_drvdata(file);
> +
> +	strscpy(cap->driver, TI_CSI2RX_MODULE_NAME, sizeof(cap->driver));
> +	strscpy(cap->card, TI_CSI2RX_MODULE_NAME, sizeof(cap->card));
> +
> +	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:%s",
> +		 dev_name(csi->dev));

You don't need to assign bus_info for platform devices anymore, this is
done in v4l_querycap().

> +
> +	return 0;
> +}
> +
> +static int ti_csi2rx_enum_fmt_vid_cap(struct file *file, void *priv,
> +				      struct v4l2_fmtdesc *f)
> +{
> +	if (f->index >= num_formats)
> +		return -EINVAL;
> +
> +	memset(f->reserved, 0, sizeof(f->reserved));

This is done by the framework already.

> +	f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;

Not needed.

> +	f->pixelformat = formats[f->index].fourcc;
> +
> +	return 0;
> +}
> +
> +static int ti_csi2rx_g_fmt_vid_cap(struct file *file, void *prov,
> +				   struct v4l2_format *f)
> +{
> +	struct ti_csi2rx_dev *csi = video_drvdata(file);
> +
> +	*f = csi->v_fmt;
> +
> +	return 0;
> +}
> +
> +static int ti_csi2rx_try_fmt_vid_cap(struct file *file, void *priv,
> +				     struct v4l2_format *f)
> +{
> +	const struct ti_csi2rx_fmt *fmt;
> +
> +	/*
> +	 * Default to the first format if the requested pixel format code isn't
> +	 * supported.
> +	 */
> +	fmt = find_format_by_pix(f->fmt.pix.pixelformat);
> +	if (!fmt)
> +		fmt = &formats[0];
> +
> +	if (f->fmt.pix.field == V4L2_FIELD_ANY)
> +		f->fmt.pix.field = V4L2_FIELD_NONE;
> +
> +	if (f->fmt.pix.field != V4L2_FIELD_NONE)
> +		/* Interlaced formats are not supported. */
> +		f->fmt.pix.field = V4L2_FIELD_NONE;
> +
> +	ti_csi2rx_fill_fmt(fmt, f);
> +
> +	return 0;
> +}
> +
> +static int ti_csi2rx_s_fmt_vid_cap(struct file *file, void *priv,
> +				   struct v4l2_format *f)
> +{
> +	struct ti_csi2rx_dev *csi = video_drvdata(file);
> +	struct vb2_queue *q = &csi->vidq;
> +	int ret;
> +
> +	if (vb2_is_busy(q))
> +		return -EBUSY;
> +
> +	ret = ti_csi2rx_try_fmt_vid_cap(file, priv, f);
> +	if (ret < 0)
> +		return ret;
> +
> +	csi->v_fmt = *f;
> +
> +	return 0;
> +}
> +
> +static int ti_csi2rx_enum_framesizes(struct file *file, void *fh,
> +				     struct v4l2_frmsizeenum *fsize)
> +{
> +	const struct ti_csi2rx_fmt *fmt;
> +	unsigned int pixels_in_word;
> +	u8 bpp;
> +
> +	fmt = find_format_by_pix(fsize->pixel_format);
> +	if (!fmt)
> +		return -EINVAL;
> +
> +	bpp = ALIGN(fmt->bpp, 8);
> +
> +	/*
> +	 * Number of pixels in one PSI-L word. The transfer happens in multiples
> +	 * of PSI-L word sizes.
> +	 */
> +	pixels_in_word = PSIL_WORD_SIZE_BYTES * 8 / bpp;
> +
> +	fsize->type = V4L2_FRMSIZE_TYPE_STEPWISE;
> +	fsize->stepwise.min_width = pixels_in_word;
> +	fsize->stepwise.max_width = rounddown(MAX_WIDTH_BYTES * 8 / bpp,
> +					      pixels_in_word);
> +	fsize->stepwise.step_width = pixels_in_word;
> +	fsize->stepwise.min_height = 1;
> +	fsize->stepwise.max_height = MAX_HEIGHT_LINES;
> +	fsize->stepwise.step_height = 1;
> +
> +	return 0;
> +}
> +
> +static const struct v4l2_ioctl_ops csi_ioctl_ops = {
> +	.vidioc_querycap      = ti_csi2rx_querycap,
> +	.vidioc_enum_fmt_vid_cap = ti_csi2rx_enum_fmt_vid_cap,
> +	.vidioc_try_fmt_vid_cap = ti_csi2rx_try_fmt_vid_cap,
> +	.vidioc_g_fmt_vid_cap = ti_csi2rx_g_fmt_vid_cap,
> +	.vidioc_s_fmt_vid_cap = ti_csi2rx_s_fmt_vid_cap,
> +	.vidioc_enum_framesizes = ti_csi2rx_enum_framesizes,
> +	.vidioc_reqbufs       = vb2_ioctl_reqbufs,
> +	.vidioc_create_bufs   = vb2_ioctl_create_bufs,
> +	.vidioc_prepare_buf   = vb2_ioctl_prepare_buf,
> +	.vidioc_querybuf      = vb2_ioctl_querybuf,
> +	.vidioc_qbuf          = vb2_ioctl_qbuf,
> +	.vidioc_dqbuf         = vb2_ioctl_dqbuf,
> +	.vidioc_expbuf        = vb2_ioctl_expbuf,
> +	.vidioc_streamon      = vb2_ioctl_streamon,
> +	.vidioc_streamoff     = vb2_ioctl_streamoff,
> +};
> +
> +static const struct v4l2_file_operations csi_fops = {
> +	.owner = THIS_MODULE,
> +	.open = v4l2_fh_open,
> +	.release = vb2_fop_release,
> +	.read = vb2_fop_read,
> +	.poll = vb2_fop_poll,
> +	.unlocked_ioctl = video_ioctl2,
> +	.mmap = vb2_fop_mmap,
> +};
> +
> +static inline int ti_csi2rx_video_register(struct ti_csi2rx_dev *csi)
> +{
> +	struct video_device *vdev = &csi->vdev;
> +	int ret, src_pad;
> +
> +	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
> +	if (ret)
> +		return ret;
> +
> +	src_pad = media_entity_get_fwnode_pad(&csi->subdev->entity,
> +					      csi->subdev->fwnode,
> +					      MEDIA_PAD_FL_SOURCE);
> +	if (src_pad < 0) {
> +		dev_err(csi->dev, "Couldn't find source pad for subdev\n");
> +		return src_pad;
> +	}
> +
> +	ret = media_create_pad_link(&csi->subdev->entity, src_pad,
> +				    &vdev->entity, 0,
> +				    MEDIA_LNK_FL_IMMUTABLE |
> +				    MEDIA_LNK_FL_ENABLED);
> +	if (ret) {
> +		video_unregister_device(vdev);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int csi_async_notifier_bound(struct v4l2_async_notifier *notifier,
> +				    struct v4l2_subdev *subdev,
> +				    struct v4l2_async_subdev *asd)
> +{
> +	struct ti_csi2rx_dev *csi = dev_get_drvdata(notifier->v4l2_dev->dev);
> +
> +	csi->subdev = subdev;
> +
> +	return 0;
> +}
> +
> +static int csi_async_notifier_complete(struct v4l2_async_notifier *notifier)
> +{
> +	struct ti_csi2rx_dev *csi = dev_get_drvdata(notifier->v4l2_dev->dev);
> +	int ret;
> +
> +	ret = ti_csi2rx_video_register(csi);
> +	if (ret)
> +		return ret;
> +
> +	return v4l2_device_register_subdev_nodes(&csi->v4l2_dev);
> +}
> +
> +static const struct v4l2_async_notifier_operations csi_async_notifier_ops = {
> +	.bound = csi_async_notifier_bound,
> +	.complete = csi_async_notifier_complete,
> +};
> +
> +static int ti_csi2rx_init_subdev(struct ti_csi2rx_dev *csi)
> +{
> +	struct fwnode_handle *fwnode;
> +	struct v4l2_async_subdev *asd;
> +	struct device_node *node;
> +	int ret;
> +
> +	node = of_get_child_by_name(csi->dev->of_node, "csi-bridge");
> +	if (!node)
> +		return -EINVAL;
> +
> +	fwnode = of_fwnode_handle(node);
> +	if (!fwnode) {
> +		of_node_put(node);
> +		return -EINVAL;
> +	}
> +
> +	v4l2_async_nf_init(&csi->notifier);
> +	csi->notifier.ops = &csi_async_notifier_ops;
> +
> +	asd = v4l2_async_nf_add_fwnode(&csi->notifier, fwnode,
> +				       struct v4l2_async_subdev);
> +	of_node_put(node);
> +	if (IS_ERR(asd)) {
> +		v4l2_async_nf_cleanup(&csi->notifier);
> +		return PTR_ERR(asd);
> +	}
> +
> +	ret = v4l2_async_nf_register(&csi->v4l2_dev, &csi->notifier);
> +	if (ret) {
> +		v4l2_async_nf_cleanup(&csi->notifier);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void ti_csi2rx_setup_shim(struct ti_csi2rx_dev *csi)
> +{
> +	const struct ti_csi2rx_fmt *fmt;
> +	unsigned int reg;
> +
> +	fmt = find_format_by_pix(csi->v_fmt.fmt.pix.pixelformat);
> +	if (!fmt) {
> +		dev_err(csi->dev, "Unknown format\n");
> +		return;
> +	}
> +
> +	/* De-assert the pixel interface reset. */
> +	reg = SHIM_CNTL_PIX_RST;
> +	writel(reg, csi->shim + SHIM_CNTL);
> +
> +	reg = SHIM_DMACNTX_EN;
> +	reg |= FIELD_PREP(SHIM_DMACNTX_FMT, fmt->csi_dt);
> +
> +	/*
> +	 * Using the values from the documentation gives incorrect ordering for
> +	 * the luma and chroma components. In practice, the "reverse" format
> +	 * gives the correct image. So for example, if the image is in UYVY, the
> +	 * reverse would be YVYU.
> +	 */
> +	switch (fmt->fourcc) {
> +	case V4L2_PIX_FMT_UYVY:
> +		reg |= FIELD_PREP(SHIM_DMACNTX_YUV422,
> +					SHIM_DMACNTX_YVYU);
> +		break;
> +	case V4L2_PIX_FMT_VYUY:
> +		reg |= FIELD_PREP(SHIM_DMACNTX_YUV422,
> +					SHIM_DMACNTX_YUYV);
> +		break;
> +	case V4L2_PIX_FMT_YUYV:
> +		reg |= FIELD_PREP(SHIM_DMACNTX_YUV422,
> +					SHIM_DMACNTX_VYUY);
> +		break;
> +	case V4L2_PIX_FMT_YVYU:
> +		reg |= FIELD_PREP(SHIM_DMACNTX_YUV422,
> +					SHIM_DMACNTX_UYVY);
> +		break;
> +	default:
> +		/* Ignore if not YUV 4:2:2 */
> +		break;
> +	}
> +
> +	writel(reg, csi->shim + SHIM_DMACNTX);
> +
> +	reg = FIELD_PREP(SHIM_PSI_CFG0_SRC_TAG, 0) |
> +	      FIELD_PREP(SHIM_PSI_CFG0_DST_TAG, 0);
> +	writel(reg, csi->shim + SHIM_PSI_CFG0);
> +}
> +
> +static void ti_csi2rx_dma_callback(void *param)
> +{
> +	struct ti_csi2rx_buffer *buf = param;
> +	struct ti_csi2rx_dev *csi = buf->csi;
> +	struct ti_csi2rx_dma *dma = &csi->dma;
> +	unsigned long flags;
> +
> +	buf->vb.vb2_buf.timestamp = ktime_get_ns();
> +	buf->vb.sequence = csi->sequence++;
> +
> +	spin_lock_irqsave(&dma->lock, flags);
> +
> +	WARN_ON(dma->curr != buf);
> +	vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
> +
> +	/* If there are more buffers to process then start their transfer. */
> +	dma->curr = NULL;
> +	while (!list_empty(&dma->queue)) {
> +		buf = list_entry(dma->queue.next, struct ti_csi2rx_buffer, list);
> +		list_del(&buf->list);
> +
> +		if (ti_csi2rx_start_dma(csi, buf)) {
> +			dev_err(csi->dev, "Failed to queue the next buffer for DMA\n");
> +			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
> +		} else {
> +			dma->curr = buf;
> +			break;
> +		}
> +	}
> +
> +	if (!dma->curr)
> +		dma->state = TI_CSI2RX_DMA_IDLE;
> +
> +	spin_unlock_irqrestore(&dma->lock, flags);
> +}
> +
> +static int ti_csi2rx_start_dma(struct ti_csi2rx_dev *csi,
> +			       struct ti_csi2rx_buffer *buf)
> +{
> +	unsigned long addr;
> +	struct dma_async_tx_descriptor *desc;
> +	size_t len = csi->v_fmt.fmt.pix.sizeimage;
> +	dma_cookie_t cookie;
> +	int ret = 0;
> +
> +	addr = vb2_dma_contig_plane_dma_addr(&buf->vb.vb2_buf, 0);
> +	desc = dmaengine_prep_slave_single(csi->dma.chan, addr, len,
> +					   DMA_DEV_TO_MEM,
> +					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +	if (!desc)
> +		return -EIO;
> +
> +	desc->callback = ti_csi2rx_dma_callback;
> +	desc->callback_param = buf;
> +
> +	cookie = dmaengine_submit(desc);
> +	ret = dma_submit_error(cookie);
> +	if (ret)
> +		return ret;
> +
> +	dma_async_issue_pending(csi->dma.chan);
> +
> +	return 0;
> +}
> +
> +static void ti_csi2rx_cleanup_buffers(struct ti_csi2rx_dev *csi,
> +				      enum vb2_buffer_state state)
> +{
> +	struct ti_csi2rx_dma *dma = &csi->dma;
> +	struct ti_csi2rx_buffer *buf = NULL, *tmp;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&dma->lock, flags);
> +	list_for_each_entry_safe(buf, tmp, &csi->dma.queue, list) {
> +		list_del(&buf->list);
> +		vb2_buffer_done(&buf->vb.vb2_buf, state);
> +	}
> +
> +	if (dma->curr)
> +		vb2_buffer_done(&dma->curr->vb.vb2_buf, state);
> +
> +	dma->curr = NULL;
> +	dma->state = TI_CSI2RX_DMA_STOPPED;
> +	spin_unlock_irqrestore(&dma->lock, flags);
> +}
> +
> +static int ti_csi2rx_queue_setup(struct vb2_queue *q, unsigned int *nbuffers,
> +				 unsigned int *nplanes, unsigned int sizes[],
> +				 struct device *alloc_devs[])
> +{
> +	struct ti_csi2rx_dev *csi = vb2_get_drv_priv(q);
> +	unsigned int size = csi->v_fmt.fmt.pix.sizeimage;
> +
> +	if (*nplanes) {
> +		if (sizes[0] < size)
> +			return -EINVAL;
> +		size = sizes[0];
> +	}
> +
> +	*nplanes = 1;
> +	sizes[0] = size;
> +
> +	return 0;
> +}
> +
> +static int ti_csi2rx_buffer_prepare(struct vb2_buffer *vb)
> +{
> +	struct ti_csi2rx_dev *csi = vb2_get_drv_priv(vb->vb2_queue);
> +	unsigned long size = csi->v_fmt.fmt.pix.sizeimage;
> +
> +	if (vb2_plane_size(vb, 0) < size) {
> +		dev_err(csi->dev, "Data will not fit into plane\n");
> +		return -EINVAL;
> +	}
> +
> +	vb2_set_plane_payload(vb, 0, size);
> +	return 0;
> +}
> +
> +static void ti_csi2rx_buffer_queue(struct vb2_buffer *vb)
> +{
> +	struct ti_csi2rx_dev *csi = vb2_get_drv_priv(vb->vb2_queue);
> +	struct ti_csi2rx_buffer *buf;
> +	struct ti_csi2rx_dma *dma = &csi->dma;
> +	unsigned long flags = 0;
> +	int ret;
> +
> +	buf = container_of(vb, struct ti_csi2rx_buffer, vb.vb2_buf);
> +	buf->csi = csi;
> +
> +	spin_lock_irqsave(&dma->lock, flags);
> +	/*
> +	 * Usually the DMA callback takes care of queueing the pending buffers.
> +	 * But if DMA has stalled due to lack of buffers, restart it now.
> +	 */
> +	if (dma->state == TI_CSI2RX_DMA_IDLE) {
> +		ret = ti_csi2rx_start_dma(csi, buf);
> +		if (ret) {
> +			dev_err(csi->dev, "Failed to start DMA: %d\n", ret);
> +			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_QUEUED);
> +			goto unlock;
> +		}
> +
> +		dma->curr = buf;
> +		dma->state = TI_CSI2RX_DMA_ACTIVE;
> +	} else {
> +		list_add_tail(&buf->list, &dma->queue);
> +	}
> +
> +unlock:
> +	spin_unlock_irqrestore(&dma->lock, flags);
> +}
> +
> +static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int count)
> +{
> +	struct ti_csi2rx_dev *csi = vb2_get_drv_priv(vq);
> +	struct ti_csi2rx_dma *dma = &csi->dma;
> +	struct ti_csi2rx_buffer *buf;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	spin_lock_irqsave(&dma->lock, flags);
> +	if (list_empty(&dma->queue))
> +		ret = -EIO;
> +	spin_unlock_irqrestore(&dma->lock, flags);
> +	if (ret)
> +		return ret;
> +
> +	ret = media_pipeline_start(&csi->vdev.entity.pads[0], &csi->pipe);
> +	if (ret)
> +		goto err;
> +
> +	ti_csi2rx_setup_shim(csi);
> +
> +	csi->sequence = 0;
> +
> +	spin_lock_irqsave(&dma->lock, flags);
> +	buf = list_entry(dma->queue.next, struct ti_csi2rx_buffer, list);
> +	list_del(&buf->list);
> +	dma->state = TI_CSI2RX_DMA_ACTIVE;
> +	dma->curr = buf;
> +
> +	ret = ti_csi2rx_start_dma(csi, buf);
> +	if (ret) {
> +		dev_err(csi->dev, "Failed to start DMA: %d\n", ret);
> +		spin_unlock_irqrestore(&dma->lock, flags);
> +		goto err_pipeline;
> +	}
> +
> +	spin_unlock_irqrestore(&dma->lock, flags);
> +
> +	ret = v4l2_subdev_call(csi->subdev, video, s_stream, 1);
> +	if (ret)
> +		goto err_dma;
> +
> +	return 0;
> +
> +err_dma:
> +	dmaengine_terminate_sync(csi->dma.chan);
> +	writel(0, csi->shim + SHIM_DMACNTX);
> +err_pipeline:
> +	media_pipeline_stop(&csi->vdev.entity.pads[0]);
> +err:
> +	ti_csi2rx_cleanup_buffers(csi, VB2_BUF_STATE_QUEUED);
> +	return ret;
> +}
> +
> +static void ti_csi2rx_stop_streaming(struct vb2_queue *vq)
> +{
> +	struct ti_csi2rx_dev *csi = vb2_get_drv_priv(vq);
> +	int ret;
> +
> +	media_pipeline_stop(&csi->vdev.entity.pads[0]);
> +
> +	ret = v4l2_subdev_call(csi->subdev, video, s_stream, 0);
> +	if (ret)
> +		dev_err(csi->dev, "Failed to stop subdev stream\n");
> +
> +	writel(0, csi->shim + SHIM_CNTL);
> +
> +	ret = dmaengine_terminate_sync(csi->dma.chan);
> +	if (ret)
> +		dev_err(csi->dev, "Failed to stop DMA: %d\n", ret);
> +
> +	writel(0, csi->shim + SHIM_DMACNTX);
> +
> +	ti_csi2rx_cleanup_buffers(csi, VB2_BUF_STATE_ERROR);
> +}
> +
> +static const struct vb2_ops csi_vb2_qops = {
> +	.queue_setup = ti_csi2rx_queue_setup,
> +	.buf_prepare = ti_csi2rx_buffer_prepare,
> +	.buf_queue = ti_csi2rx_buffer_queue,
> +	.start_streaming = ti_csi2rx_start_streaming,
> +	.stop_streaming = ti_csi2rx_stop_streaming,
> +	.wait_prepare = vb2_ops_wait_prepare,
> +	.wait_finish = vb2_ops_wait_finish,
> +};
> +
> +static int ti_csi2rx_init_vb2q(struct ti_csi2rx_dev *csi)
> +{
> +	struct vb2_queue *q = &csi->vidq;
> +	int ret;
> +
> +	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
> +	q->io_modes = VB2_MMAP | VB2_DMABUF | VB2_READ;
> +	q->drv_priv = csi;
> +	q->buf_struct_size = sizeof(struct ti_csi2rx_buffer);
> +	q->ops = &csi_vb2_qops;
> +	q->mem_ops = &vb2_dma_contig_memops;
> +	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
> +	q->dev = dmaengine_get_dma_device(csi->dma.chan);
> +	q->lock = &csi->mutex;
> +	q->min_buffers_needed = 1;
> +
> +	ret = vb2_queue_init(q);
> +	if (ret)
> +		return ret;
> +
> +	csi->vdev.queue = q;
> +
> +	return 0;
> +}
> +
> +static int ti_csi2rx_link_validate_get_fmt(struct media_pad *pad,
> +					   struct v4l2_subdev_format *fmt)
> +{
> +	if (is_media_entity_v4l2_subdev(pad->entity)) {
> +		struct v4l2_subdev *sd =
> +			media_entity_to_v4l2_subdev(pad->entity);
> +
> +		fmt->which = V4L2_SUBDEV_FORMAT_ACTIVE;
> +		fmt->pad = pad->index;
> +		return v4l2_subdev_call(sd, pad, get_fmt, NULL, fmt);
> +	}
> +
> +	WARN(pad->entity->function != MEDIA_ENT_F_IO_V4L,
> +	     "Driver bug! Wrong media entity type 0x%08x, entity %s\n",
> +	     pad->entity->function, pad->entity->name);
> +
> +	return -EINVAL;
> +}
> +
> +static int ti_csi2rx_link_validate(struct media_link *link)
> +{
> +	struct media_entity *entity = link->sink->entity;
> +	struct video_device *vdev = media_entity_to_video_device(entity);
> +	struct ti_csi2rx_dev *csi = container_of(vdev, struct ti_csi2rx_dev, vdev);
> +	struct v4l2_pix_format *csi_fmt = &csi->v_fmt.fmt.pix;
> +	struct v4l2_subdev_format source_fmt;
> +	const struct ti_csi2rx_fmt *ti_fmt;
> +	int ret;
> +
> +	if (!(link->flags & MEDIA_LNK_FL_ENABLED)) {
> +		dev_info(csi->dev, "video node %s pad not connected\n",
> +			 vdev->name);
> +		return -ENOTCONN;
> +	}
> +
> +	ret = ti_csi2rx_link_validate_get_fmt(link->source, &source_fmt);
> +	if (ret)
> +		return ret;
> +
> +	if (source_fmt.format.width != csi_fmt->width) {
> +		dev_err(csi->dev, "Width does not match (source %u, sink %u)\n",
> +			source_fmt.format.width, csi_fmt->width);
> +		return -EPIPE;
> +	}
> +
> +	if (source_fmt.format.height != csi_fmt->height) {
> +		dev_err(csi->dev, "Height does not match (source %u, sink %u)\n",
> +			source_fmt.format.height, csi_fmt->height);
> +		return -EPIPE;
> +	}
> +
> +	if (source_fmt.format.field != csi_fmt->field &&
> +	    csi_fmt->field != V4L2_FIELD_NONE) {
> +		dev_err(csi->dev, "Field does not match (source %u, sink %u)\n",
> +			source_fmt.format.field, csi_fmt->field);
> +		return -EPIPE;
> +	}
> +
> +	ti_fmt = find_format_by_code(source_fmt.format.code);
> +	if (!ti_fmt) {
> +		dev_err(csi->dev, "Media bus format 0x%x not supported\n",
> +			source_fmt.format.code);
> +		return -EPIPE;
> +	}
> +
> +	if (source_fmt.format.code == MEDIA_BUS_FMT_YUYV8_2X8 ||
> +	    source_fmt.format.code == MEDIA_BUS_FMT_VYUY8_2X8 ||
> +	    source_fmt.format.code == MEDIA_BUS_FMT_YVYU8_2X8) {
> +		dev_err(csi->dev,
> +			"Only UYVY input allowed for YUV422 8-bit. Output format can be configured.\n");
> +		return -EPIPE;
> +	}
> +
> +	if (source_fmt.format.code != ti_fmt->code) {
> +		dev_err(csi->dev,
> +			"Cannot transform source fmt 0x%x to sink fmt 0x%x\n",
> +			source_fmt.format.code, ti_fmt->code);
> +		return -EPIPE;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct media_entity_operations ti_csi2rx_video_entity_ops = {
> +	.link_validate = ti_csi2rx_link_validate,
> +};
> +
> +static int ti_csi2rx_init_dma(struct ti_csi2rx_dev *csi)
> +{
> +	struct dma_slave_config cfg = {
> +		.src_addr_width = DMA_SLAVE_BUSWIDTH_16_BYTES };
> +	int ret;
> +
> +	INIT_LIST_HEAD(&csi->dma.queue);
> +	spin_lock_init(&csi->dma.lock);
> +
> +	csi->dma.state = TI_CSI2RX_DMA_STOPPED;
> +
> +	csi->dma.chan = dma_request_chan(csi->dev, "rx0");
> +	if (IS_ERR(csi->dma.chan))
> +		return PTR_ERR(csi->dma.chan);
> +
> +	ret = dmaengine_slave_config(csi->dma.chan, &cfg);
> +	if (ret) {
> +		dma_release_channel(csi->dma.chan);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ti_csi2rx_v4l2_init(struct ti_csi2rx_dev *csi)
> +{
> +	struct media_device *mdev = &csi->mdev;
> +	struct video_device *vdev = &csi->vdev;
> +	const struct ti_csi2rx_fmt *fmt;
> +	struct v4l2_pix_format *pix_fmt = &csi->v_fmt.fmt.pix;
> +	int ret;
> +
> +	fmt = find_format_by_pix(V4L2_PIX_FMT_UYVY);
> +	if (!fmt)
> +		return -EINVAL;
> +
> +	pix_fmt->width = 640;
> +	pix_fmt->height = 480;
> +	pix_fmt->field = V4L2_FIELD_NONE;
> +
> +	ti_csi2rx_fill_fmt(fmt, &csi->v_fmt);
> +
> +	mdev->dev = csi->dev;
> +	mdev->hw_revision = 1;
> +	strscpy(mdev->model, "TI-CSI2RX", sizeof(mdev->model));
> +	snprintf(mdev->bus_info, sizeof(mdev->bus_info), "platform:%s",
> +		 dev_name(mdev->dev));

Not needed anymore, done by media_device_init().

> +
> +	media_device_init(mdev);
> +
> +	strscpy(vdev->name, TI_CSI2RX_MODULE_NAME, sizeof(vdev->name));
> +	vdev->v4l2_dev = &csi->v4l2_dev;
> +	vdev->vfl_dir = VFL_DIR_RX;
> +	vdev->fops = &csi_fops;
> +	vdev->ioctl_ops = &csi_ioctl_ops;
> +	vdev->release = video_device_release_empty;
> +	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING |
> +			    V4L2_CAP_IO_MC;
> +	vdev->lock = &csi->mutex;
> +	video_set_drvdata(vdev, csi);
> +
> +	csi->pad.flags = MEDIA_PAD_FL_SINK;
> +	vdev->entity.ops = &ti_csi2rx_video_entity_ops;
> +	ret = media_entity_pads_init(&csi->vdev.entity, 1, &csi->pad);
> +	if (ret)
> +		return ret;
> +
> +	csi->v4l2_dev.mdev = mdev;
> +
> +	ret = v4l2_device_register(csi->dev, &csi->v4l2_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = media_device_register(mdev);
> +	if (ret) {
> +		v4l2_device_unregister(&csi->v4l2_dev);
> +		media_device_cleanup(mdev);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void ti_csi2rx_cleanup_dma(struct ti_csi2rx_dev *csi)
> +{
> +	dma_release_channel(csi->dma.chan);
> +}
> +
> +static void ti_csi2rx_cleanup_v4l2(struct ti_csi2rx_dev *csi)
> +{
> +	media_device_unregister(&csi->mdev);
> +	v4l2_device_unregister(&csi->v4l2_dev);
> +	media_device_cleanup(&csi->mdev);
> +}
> +
> +static void ti_csi2rx_cleanup_subdev(struct ti_csi2rx_dev *csi)
> +{
> +	v4l2_async_nf_unregister(&csi->notifier);
> +	v4l2_async_nf_cleanup(&csi->notifier);
> +}
> +
> +static void ti_csi2rx_cleanup_vb2q(struct ti_csi2rx_dev *csi)
> +{
> +	vb2_queue_release(&csi->vidq);
> +}
> +
> +static int ti_csi2rx_probe(struct platform_device *pdev)
> +{
> +	struct ti_csi2rx_dev *csi;
> +	struct resource *res;
> +	int ret;
> +
> +	csi = devm_kzalloc(&pdev->dev, sizeof(*csi), GFP_KERNEL);
> +	if (!csi)
> +		return -ENOMEM;
> +
> +	csi->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, csi);
> +
> +	mutex_init(&csi->mutex);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	csi->shim = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(csi->shim)) {
> +		ret = PTR_ERR(csi->shim);
> +		goto err_mutex;
> +	}
> +
> +	ret = ti_csi2rx_init_dma(csi);
> +	if (ret)
> +		goto err_mutex;
> +
> +	ret = ti_csi2rx_v4l2_init(csi);
> +	if (ret)
> +		goto err_dma;
> +
> +	ret = ti_csi2rx_init_vb2q(csi);
> +	if (ret)
> +		goto err_v4l2;
> +
> +	ret = ti_csi2rx_init_subdev(csi);
> +	if (ret)
> +		goto err_vb2q;
> +
> +	ret = of_platform_populate(csi->dev->of_node, NULL, NULL, csi->dev);
> +	if (ret) {
> +		dev_err(csi->dev, "Failed to create children: %d\n", ret);
> +		goto err_subdev;
> +	}
> +
> +	return 0;
> +
> +err_subdev:
> +	ti_csi2rx_cleanup_subdev(csi);
> +err_vb2q:
> +	ti_csi2rx_cleanup_vb2q(csi);
> +err_v4l2:
> +	ti_csi2rx_cleanup_v4l2(csi);
> +err_dma:
> +	ti_csi2rx_cleanup_dma(csi);
> +err_mutex:
> +	mutex_destroy(&csi->mutex);
> +	return ret;
> +}
> +
> +static int ti_csi2rx_remove(struct platform_device *pdev)
> +{
> +	struct ti_csi2rx_dev *csi = platform_get_drvdata(pdev);
> +
> +	video_unregister_device(&csi->vdev);
> +
> +	ti_csi2rx_cleanup_vb2q(csi);
> +	ti_csi2rx_cleanup_subdev(csi);
> +	ti_csi2rx_cleanup_v4l2(csi);
> +	ti_csi2rx_cleanup_dma(csi);
> +
> +	mutex_destroy(&csi->mutex);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ti_csi2rx_of_match[] = {
> +	{ .compatible = "ti,j721e-csi2rx", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ti_csi2rx_of_match);
> +
> +static struct platform_driver ti_csi2rx_pdrv = {
> +	.probe = ti_csi2rx_probe,
> +	.remove = ti_csi2rx_remove,
> +	.driver = {
> +		.name = TI_CSI2RX_MODULE_NAME,
> +		.of_match_table = ti_csi2rx_of_match,
> +	},
> +};
> +
> +module_platform_driver(ti_csi2rx_pdrv);
> +
> +MODULE_DESCRIPTION("TI J721E CSI2 RX Driver");
> +MODULE_AUTHOR("Pratyush Yadav <p.yadav@ti.com>");
> +MODULE_LICENSE("GPL");

-- 
Kind regards,

Sakari Ailus
