Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167997438ED
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 12:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjF3KFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 06:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbjF3KFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 06:05:34 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C21E2122;
        Fri, 30 Jun 2023 03:05:31 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkzdf0gkyyyyyyyyyyyyt-3.rev.dnainternet.fi [IPv6:2001:14ba:4506:4f15::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4QsrY16f6sz49Q3M;
        Fri, 30 Jun 2023 13:05:25 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1688119527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6qcAL44V2VQPq8nW4DQ+CM8zwpG0FjZ9MKM6NQq5bKo=;
        b=OQNlOj2ifgFuY5Z58PueDGVtRMoGfQlMq/fhl/MMqHhgiId3zuEN5DGn+einZotd6rnAtI
        mfDnDJ96+VBbt7I1L1OaR735WNT2qhDmmUzQrwqVupu6t8mYW/QESNpEQn6GRmfybYkbUt
        2e5IVRDVEAjn20ywuT+qt1eoXJ2lgprEsJXQ+N5x+wc3rFbseYeilalJB9m6wfR0La84u+
        0JhelEg5hDR5iO7jAq4Kv3z0tK14NCYIy255H2HV3hTBmCJm9WStWj7yGSzFfjYphlsVie
        NKV7yXiYsJAgXTX6sTPE0wtpMGT6/08LQrwj5DIqbrDd/QIvWT7kSAo5Jp7Sbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1688119527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6qcAL44V2VQPq8nW4DQ+CM8zwpG0FjZ9MKM6NQq5bKo=;
        b=f69EeWpqh1bUOkWZMFZvrfBmqAFqZS5lHnhS1v/eVBcWO217U6rYNMFhVxLUe3ydapV4ak
        rMtxj7mN65e/XUkM4d3YNDK72JILhSfadpI3dfjRun7beAI9EQxMcEmgx0hUGd94TOo5Ke
        d5ha3Rf1eHIdljIHFOp6xhqcJVhm1lE8LJLIAMrdiXjlCn8lMKv29tqDxHhPtwcXH2QJEa
        vQYis0d0lbZWJByzbhlW9jakuJc3E9+CW/YySmL2VruAvKtuJSMDJCR4f0sY3490d6Lj0Y
        xYwJlNJ7BITQq8iHu/6yGWZfYTONZ8/ELEpinz1O6N63Y1Ok2RdhCbhkCU9/uA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1688119527; a=rsa-sha256;
        cv=none;
        b=Iirl49YpCiFZUxiJjAhpe6vncipdoxx9m9KqBYKIODu9XDLSiVotLHm00FJ6MWCLVr8Z4X
        EUbA22GdsoUWpHoVSBogmt+kCDRfPiyt3EaRKViZuzmBk1mQtgJtERF8Qi+HEH7rzBiM5T
        /5Fc8KpS6Kr3Jdnf/p50l9ZGcwbBDC1Qzeqnta2VA+HReSBw42ge/TpkM7Z2PwOq/tmMKJ
        wU6bBbdBmkrnHiCaWrhHUAZTy5uY+oa/7MG2wgpW8UYzptxaZM+jG+IJYhg4YR/q0qtUCU
        VyfcMq5LXgdmw/3lVR9bGhMuakwFND5NWZ+TiVrHjSjsfqykv/3ZBEoJXwaexg==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 34A37634C91;
        Fri, 30 Jun 2023 13:05:25 +0300 (EEST)
Date:   Fri, 30 Jun 2023 10:05:25 +0000
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, hverkuil@xs4all.nl,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: Re: [PATCH 1/6] media: v4l2: Add audio capture and output support
Message-ID: <ZJ6o5fT4V4HXivFa@valkosipuli.retiisi.eu>
References: <1688002673-28493-1-git-send-email-shengjiu.wang@nxp.com>
 <1688002673-28493-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1688002673-28493-2-git-send-email-shengjiu.wang@nxp.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shengjiu,

On Thu, Jun 29, 2023 at 09:37:48AM +0800, Shengjiu Wang wrote:
> Audio signal processing has the requirement for memory to
> memory similar as Video.
> 
> This patch is to add this support in v4l2 framework, defined
> new buffer type V4L2_BUF_TYPE_AUDIO_CAPTURE and
> V4L2_BUF_TYPE_AUDIO_OUTPUT, defined new format v4l2_audio_format
> for audio case usage.

Why are you proposing to add this to V4L2 framework instead of doing this
within ALSA?

Also cc Hans and Jacopo.

> 
> The created audio device is named "/dev/audioX".
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../media/common/videobuf2/videobuf2-v4l2.c   |  4 ++
>  drivers/media/v4l2-core/v4l2-dev.c            | 17 ++++++
>  drivers/media/v4l2-core/v4l2-ioctl.c          | 52 +++++++++++++++++++
>  include/media/v4l2-dev.h                      |  2 +
>  include/media/v4l2-ioctl.h                    | 34 ++++++++++++
>  include/uapi/linux/videodev2.h                | 19 +++++++
>  6 files changed, 128 insertions(+)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> index c7a54d82a55e..12f2be2773a2 100644
> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> @@ -785,6 +785,10 @@ int vb2_create_bufs(struct vb2_queue *q, struct v4l2_create_buffers *create)
>  	case V4L2_BUF_TYPE_META_OUTPUT:
>  		requested_sizes[0] = f->fmt.meta.buffersize;
>  		break;
> +	case V4L2_BUF_TYPE_AUDIO_CAPTURE:
> +	case V4L2_BUF_TYPE_AUDIO_OUTPUT:
> +		requested_sizes[0] = f->fmt.audio.buffersize;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
> index f81279492682..67484f4c6eaf 100644
> --- a/drivers/media/v4l2-core/v4l2-dev.c
> +++ b/drivers/media/v4l2-core/v4l2-dev.c
> @@ -553,6 +553,7 @@ static void determine_valid_ioctls(struct video_device *vdev)
>  	bool is_tch = vdev->vfl_type == VFL_TYPE_TOUCH;
>  	bool is_meta = vdev->vfl_type == VFL_TYPE_VIDEO &&
>  		       (vdev->device_caps & meta_caps);
> +	bool is_audio = vdev->vfl_type == VFL_TYPE_AUDIO;
>  	bool is_rx = vdev->vfl_dir != VFL_DIR_TX;
>  	bool is_tx = vdev->vfl_dir != VFL_DIR_RX;
>  	bool is_io_mc = vdev->device_caps & V4L2_CAP_IO_MC;
> @@ -664,6 +665,19 @@ static void determine_valid_ioctls(struct video_device *vdev)
>  		SET_VALID_IOCTL(ops, VIDIOC_S_FMT, vidioc_s_fmt_meta_out);
>  		SET_VALID_IOCTL(ops, VIDIOC_TRY_FMT, vidioc_try_fmt_meta_out);
>  	}
> +	if (is_audio && is_rx) {
> +		/* audio capture specific ioctls */
> +		SET_VALID_IOCTL(ops, VIDIOC_ENUM_FMT, vidioc_enum_fmt_audio_cap);
> +		SET_VALID_IOCTL(ops, VIDIOC_G_FMT, vidioc_g_fmt_audio_cap);
> +		SET_VALID_IOCTL(ops, VIDIOC_S_FMT, vidioc_s_fmt_audio_cap);
> +		SET_VALID_IOCTL(ops, VIDIOC_TRY_FMT, vidioc_try_fmt_audio_cap);
> +	} else if (is_audio && is_tx) {
> +		/* audio output specific ioctls */
> +		SET_VALID_IOCTL(ops, VIDIOC_ENUM_FMT, vidioc_enum_fmt_audio_out);
> +		SET_VALID_IOCTL(ops, VIDIOC_G_FMT, vidioc_g_fmt_audio_out);
> +		SET_VALID_IOCTL(ops, VIDIOC_S_FMT, vidioc_s_fmt_audio_out);
> +		SET_VALID_IOCTL(ops, VIDIOC_TRY_FMT, vidioc_try_fmt_audio_out);
> +	}
>  	if (is_vbi) {
>  		/* vbi specific ioctls */
>  		if ((is_rx && (ops->vidioc_g_fmt_vbi_cap ||
> @@ -927,6 +941,9 @@ int __video_register_device(struct video_device *vdev,
>  	case VFL_TYPE_TOUCH:
>  		name_base = "v4l-touch";
>  		break;
> +	case VFL_TYPE_AUDIO:
> +		name_base = "audio";
> +		break;
>  	default:
>  		pr_err("%s called with unknown type: %d\n",
>  		       __func__, type);
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index a858acea6547..26bc4b0d8ef0 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -188,6 +188,8 @@ const char *v4l2_type_names[] = {
>  	[V4L2_BUF_TYPE_SDR_OUTPUT]         = "sdr-out",
>  	[V4L2_BUF_TYPE_META_CAPTURE]       = "meta-cap",
>  	[V4L2_BUF_TYPE_META_OUTPUT]	   = "meta-out",
> +	[V4L2_BUF_TYPE_AUDIO_CAPTURE]      = "audio-cap",
> +	[V4L2_BUF_TYPE_AUDIO_OUTPUT]	   = "audio-out",
>  };
>  EXPORT_SYMBOL(v4l2_type_names);
>  
> @@ -276,6 +278,7 @@ static void v4l_print_format(const void *arg, bool write_only)
>  	const struct v4l2_sliced_vbi_format *sliced;
>  	const struct v4l2_window *win;
>  	const struct v4l2_meta_format *meta;
> +	const struct v4l2_audio_format *audio;
>  	u32 pixelformat;
>  	u32 planes;
>  	unsigned i;
> @@ -346,6 +349,12 @@ static void v4l_print_format(const void *arg, bool write_only)
>  		pr_cont(", dataformat=%p4cc, buffersize=%u\n",
>  			&pixelformat, meta->buffersize);
>  		break;
> +	case V4L2_BUF_TYPE_AUDIO_CAPTURE:
> +	case V4L2_BUF_TYPE_AUDIO_OUTPUT:
> +		audio = &p->fmt.audio;
> +		pr_cont(", rate=%u, format=%u, channels=%u, buffersize=%u\n",
> +			audio->rate, audio->format, audio->channels, audio->buffersize);
> +		break;
>  	}
>  }
>  
> @@ -927,6 +936,7 @@ static int check_fmt(struct file *file, enum v4l2_buf_type type)
>  	bool is_tch = vfd->vfl_type == VFL_TYPE_TOUCH;
>  	bool is_meta = vfd->vfl_type == VFL_TYPE_VIDEO &&
>  		       (vfd->device_caps & meta_caps);
> +	bool is_audio = vfd->vfl_type == VFL_TYPE_AUDIO;
>  	bool is_rx = vfd->vfl_dir != VFL_DIR_TX;
>  	bool is_tx = vfd->vfl_dir != VFL_DIR_RX;
>  
> @@ -992,6 +1002,14 @@ static int check_fmt(struct file *file, enum v4l2_buf_type type)
>  		if (is_meta && is_tx && ops->vidioc_g_fmt_meta_out)
>  			return 0;
>  		break;
> +	case V4L2_BUF_TYPE_AUDIO_CAPTURE:
> +		if (is_audio && is_rx && ops->vidioc_g_fmt_audio_cap)
> +			return 0;
> +		break;
> +	case V4L2_BUF_TYPE_AUDIO_OUTPUT:
> +		if (is_audio && is_tx && ops->vidioc_g_fmt_audio_out)
> +			return 0;
> +		break;
>  	default:
>  		break;
>  	}
> @@ -1592,6 +1610,16 @@ static int v4l_enum_fmt(const struct v4l2_ioctl_ops *ops,
>  			break;
>  		ret = ops->vidioc_enum_fmt_meta_out(file, fh, arg);
>  		break;
> +	case V4L2_BUF_TYPE_AUDIO_CAPTURE:
> +		if (unlikely(!ops->vidioc_enum_fmt_audio_cap))
> +			break;
> +		ret = ops->vidioc_enum_fmt_audio_cap(file, fh, arg);
> +		break;
> +	case V4L2_BUF_TYPE_AUDIO_OUTPUT:
> +		if (unlikely(!ops->vidioc_enum_fmt_audio_out))
> +			break;
> +		ret = ops->vidioc_enum_fmt_audio_out(file, fh, arg);
> +		break;
>  	}
>  	if (ret == 0)
>  		v4l_fill_fmtdesc(p);
> @@ -1668,6 +1696,10 @@ static int v4l_g_fmt(const struct v4l2_ioctl_ops *ops,
>  		return ops->vidioc_g_fmt_meta_cap(file, fh, arg);
>  	case V4L2_BUF_TYPE_META_OUTPUT:
>  		return ops->vidioc_g_fmt_meta_out(file, fh, arg);
> +	case V4L2_BUF_TYPE_AUDIO_CAPTURE:
> +		return ops->vidioc_g_fmt_audio_cap(file, fh, arg);
> +	case V4L2_BUF_TYPE_AUDIO_OUTPUT:
> +		return ops->vidioc_g_fmt_audio_out(file, fh, arg);
>  	}
>  	return -EINVAL;
>  }
> @@ -1779,6 +1811,16 @@ static int v4l_s_fmt(const struct v4l2_ioctl_ops *ops,
>  			break;
>  		memset_after(p, 0, fmt.meta);
>  		return ops->vidioc_s_fmt_meta_out(file, fh, arg);
> +	case V4L2_BUF_TYPE_AUDIO_CAPTURE:
> +		if (unlikely(!ops->vidioc_s_fmt_audio_cap))
> +			break;
> +		memset_after(p, 0, fmt.audio);
> +		return ops->vidioc_s_fmt_audio_cap(file, fh, arg);
> +	case V4L2_BUF_TYPE_AUDIO_OUTPUT:
> +		if (unlikely(!ops->vidioc_s_fmt_audio_out))
> +			break;
> +		memset_after(p, 0, fmt.audio);
> +		return ops->vidioc_s_fmt_audio_out(file, fh, arg);
>  	}
>  	return -EINVAL;
>  }
> @@ -1887,6 +1929,16 @@ static int v4l_try_fmt(const struct v4l2_ioctl_ops *ops,
>  			break;
>  		memset_after(p, 0, fmt.meta);
>  		return ops->vidioc_try_fmt_meta_out(file, fh, arg);
> +	case V4L2_BUF_TYPE_AUDIO_CAPTURE:
> +		if (unlikely(!ops->vidioc_try_fmt_audio_cap))
> +			break;
> +		memset_after(p, 0, fmt.audio);
> +		return ops->vidioc_try_fmt_audio_cap(file, fh, arg);
> +	case V4L2_BUF_TYPE_AUDIO_OUTPUT:
> +		if (unlikely(!ops->vidioc_try_fmt_audio_out))
> +			break;
> +		memset_after(p, 0, fmt.audio);
> +		return ops->vidioc_try_fmt_audio_out(file, fh, arg);
>  	}
>  	return -EINVAL;
>  }
> diff --git a/include/media/v4l2-dev.h b/include/media/v4l2-dev.h
> index e0a13505f88d..0924e6d1dab1 100644
> --- a/include/media/v4l2-dev.h
> +++ b/include/media/v4l2-dev.h
> @@ -30,6 +30,7 @@
>   * @VFL_TYPE_SUBDEV:	for V4L2 subdevices
>   * @VFL_TYPE_SDR:	for Software Defined Radio tuners
>   * @VFL_TYPE_TOUCH:	for touch sensors
> + * @VFL_TYPE_AUDIO:	for audio input/output devices
>   * @VFL_TYPE_MAX:	number of VFL types, must always be last in the enum
>   */
>  enum vfl_devnode_type {
> @@ -39,6 +40,7 @@ enum vfl_devnode_type {
>  	VFL_TYPE_SUBDEV,
>  	VFL_TYPE_SDR,
>  	VFL_TYPE_TOUCH,
> +	VFL_TYPE_AUDIO,
>  	VFL_TYPE_MAX /* Shall be the last one */
>  };
>  
> diff --git a/include/media/v4l2-ioctl.h b/include/media/v4l2-ioctl.h
> index edb733f21604..f840cf740ce1 100644
> --- a/include/media/v4l2-ioctl.h
> +++ b/include/media/v4l2-ioctl.h
> @@ -45,6 +45,12 @@ struct v4l2_fh;
>   * @vidioc_enum_fmt_meta_out: pointer to the function that implements
>   *	:ref:`VIDIOC_ENUM_FMT <vidioc_enum_fmt>` ioctl logic
>   *	for metadata output
> + * @vidioc_enum_fmt_audio_cap: pointer to the function that implements
> + *	:ref:`VIDIOC_ENUM_FMT <vidioc_enum_fmt>` ioctl logic
> + *	for audio capture
> + * @vidioc_enum_fmt_audio_out: pointer to the function that implements
> + *	:ref:`VIDIOC_ENUM_FMT <vidioc_enum_fmt>` ioctl logic
> + *	for audio output
>   * @vidioc_g_fmt_vid_cap: pointer to the function that implements
>   *	:ref:`VIDIOC_G_FMT <vidioc_g_fmt>` ioctl logic for video capture
>   *	in single plane mode
> @@ -79,6 +85,10 @@ struct v4l2_fh;
>   *	:ref:`VIDIOC_G_FMT <vidioc_g_fmt>` ioctl logic for metadata capture
>   * @vidioc_g_fmt_meta_out: pointer to the function that implements
>   *	:ref:`VIDIOC_G_FMT <vidioc_g_fmt>` ioctl logic for metadata output
> + * @vidioc_g_fmt_audio_cap: pointer to the function that implements
> + *	:ref:`VIDIOC_G_FMT <vidioc_g_fmt>` ioctl logic for audio capture
> + * @vidioc_g_fmt_audio_out: pointer to the function that implements
> + *	:ref:`VIDIOC_G_FMT <vidioc_g_fmt>` ioctl logic for audio output
>   * @vidioc_s_fmt_vid_cap: pointer to the function that implements
>   *	:ref:`VIDIOC_S_FMT <vidioc_g_fmt>` ioctl logic for video capture
>   *	in single plane mode
> @@ -113,6 +123,10 @@ struct v4l2_fh;
>   *	:ref:`VIDIOC_S_FMT <vidioc_g_fmt>` ioctl logic for metadata capture
>   * @vidioc_s_fmt_meta_out: pointer to the function that implements
>   *	:ref:`VIDIOC_S_FMT <vidioc_g_fmt>` ioctl logic for metadata output
> + * @vidioc_s_fmt_audio_cap: pointer to the function that implements
> + *	:ref:`VIDIOC_S_FMT <vidioc_g_fmt>` ioctl logic for audio capture
> + * @vidioc_s_fmt_audio_out: pointer to the function that implements
> + *	:ref:`VIDIOC_S_FMT <vidioc_g_fmt>` ioctl logic for audio output
>   * @vidioc_try_fmt_vid_cap: pointer to the function that implements
>   *	:ref:`VIDIOC_TRY_FMT <vidioc_g_fmt>` ioctl logic for video capture
>   *	in single plane mode
> @@ -149,6 +163,10 @@ struct v4l2_fh;
>   *	:ref:`VIDIOC_TRY_FMT <vidioc_g_fmt>` ioctl logic for metadata capture
>   * @vidioc_try_fmt_meta_out: pointer to the function that implements
>   *	:ref:`VIDIOC_TRY_FMT <vidioc_g_fmt>` ioctl logic for metadata output
> + * @vidioc_try_fmt_audio_cap: pointer to the function that implements
> + *	:ref:`VIDIOC_TRY_FMT <vidioc_g_fmt>` ioctl logic for audio capture
> + * @vidioc_try_fmt_audio_out: pointer to the function that implements
> + *	:ref:`VIDIOC_TRY_FMT <vidioc_g_fmt>` ioctl logic for audio output
>   * @vidioc_reqbufs: pointer to the function that implements
>   *	:ref:`VIDIOC_REQBUFS <vidioc_reqbufs>` ioctl
>   * @vidioc_querybuf: pointer to the function that implements
> @@ -315,6 +333,10 @@ struct v4l2_ioctl_ops {
>  					struct v4l2_fmtdesc *f);
>  	int (*vidioc_enum_fmt_meta_out)(struct file *file, void *fh,
>  					struct v4l2_fmtdesc *f);
> +	int (*vidioc_enum_fmt_audio_cap)(struct file *file, void *fh,
> +					 struct v4l2_fmtdesc *f);
> +	int (*vidioc_enum_fmt_audio_out)(struct file *file, void *fh,
> +					 struct v4l2_fmtdesc *f);
>  
>  	/* VIDIOC_G_FMT handlers */
>  	int (*vidioc_g_fmt_vid_cap)(struct file *file, void *fh,
> @@ -345,6 +367,10 @@ struct v4l2_ioctl_ops {
>  				     struct v4l2_format *f);
>  	int (*vidioc_g_fmt_meta_out)(struct file *file, void *fh,
>  				     struct v4l2_format *f);
> +	int (*vidioc_g_fmt_audio_cap)(struct file *file, void *fh,
> +				      struct v4l2_format *f);
> +	int (*vidioc_g_fmt_audio_out)(struct file *file, void *fh,
> +				      struct v4l2_format *f);
>  
>  	/* VIDIOC_S_FMT handlers */
>  	int (*vidioc_s_fmt_vid_cap)(struct file *file, void *fh,
> @@ -375,6 +401,10 @@ struct v4l2_ioctl_ops {
>  				     struct v4l2_format *f);
>  	int (*vidioc_s_fmt_meta_out)(struct file *file, void *fh,
>  				     struct v4l2_format *f);
> +	int (*vidioc_s_fmt_audio_cap)(struct file *file, void *fh,
> +				      struct v4l2_format *f);
> +	int (*vidioc_s_fmt_audio_out)(struct file *file, void *fh,
> +				      struct v4l2_format *f);
>  
>  	/* VIDIOC_TRY_FMT handlers */
>  	int (*vidioc_try_fmt_vid_cap)(struct file *file, void *fh,
> @@ -405,6 +435,10 @@ struct v4l2_ioctl_ops {
>  				       struct v4l2_format *f);
>  	int (*vidioc_try_fmt_meta_out)(struct file *file, void *fh,
>  				       struct v4l2_format *f);
> +	int (*vidioc_try_fmt_audio_cap)(struct file *file, void *fh,
> +					struct v4l2_format *f);
> +	int (*vidioc_try_fmt_audio_out)(struct file *file, void *fh,
> +					struct v4l2_format *f);
>  
>  	/* Buffer handlers */
>  	int (*vidioc_reqbufs)(struct file *file, void *fh,
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index aee75eb9e686..a7af28f4c8c3 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -153,6 +153,8 @@ enum v4l2_buf_type {
>  	V4L2_BUF_TYPE_SDR_OUTPUT           = 12,
>  	V4L2_BUF_TYPE_META_CAPTURE         = 13,
>  	V4L2_BUF_TYPE_META_OUTPUT	   = 14,
> +	V4L2_BUF_TYPE_AUDIO_CAPTURE        = 15,
> +	V4L2_BUF_TYPE_AUDIO_OUTPUT         = 16,
>  	/* Deprecated, do not use */
>  	V4L2_BUF_TYPE_PRIVATE              = 0x80,
>  };
> @@ -169,6 +171,7 @@ enum v4l2_buf_type {
>  	 || (type) == V4L2_BUF_TYPE_VBI_OUTPUT			\
>  	 || (type) == V4L2_BUF_TYPE_SLICED_VBI_OUTPUT		\
>  	 || (type) == V4L2_BUF_TYPE_SDR_OUTPUT			\
> +	 || (type) == V4L2_BUF_TYPE_AUDIO_OUTPUT		\
>  	 || (type) == V4L2_BUF_TYPE_META_OUTPUT)
>  
>  #define V4L2_TYPE_IS_CAPTURE(type) (!V4L2_TYPE_IS_OUTPUT(type))
> @@ -2404,6 +2407,20 @@ struct v4l2_meta_format {
>  	__u32				buffersize;
>  } __attribute__ ((packed));
>  
> +/**
> + * struct v4l2_audio_format - audio data format definition
> + * @rate:		sample rate
> + * @format:		sample format
> + * @channels:		channel numbers
> + * @buffersize:		maximum size in bytes required for data
> + */
> +struct v4l2_audio_format {
> +	__u32				rate;
> +	__u32				format;
> +	__u32				channels;
> +	__u32				buffersize;
> +} __attribute__ ((packed));
> +
>  /**
>   * struct v4l2_format - stream data format
>   * @type:	enum v4l2_buf_type; type of the data stream
> @@ -2412,6 +2429,7 @@ struct v4l2_meta_format {
>   * @win:	definition of an overlaid image
>   * @vbi:	raw VBI capture or output parameters
>   * @sliced:	sliced VBI capture or output parameters
> + * @audio:	definition of an audio format
>   * @raw_data:	placeholder for future extensions and custom formats
>   * @fmt:	union of @pix, @pix_mp, @win, @vbi, @sliced, @sdr, @meta
>   *		and @raw_data
> @@ -2426,6 +2444,7 @@ struct v4l2_format {
>  		struct v4l2_sliced_vbi_format	sliced;  /* V4L2_BUF_TYPE_SLICED_VBI_CAPTURE */
>  		struct v4l2_sdr_format		sdr;     /* V4L2_BUF_TYPE_SDR_CAPTURE */
>  		struct v4l2_meta_format		meta;    /* V4L2_BUF_TYPE_META_CAPTURE */
> +		struct v4l2_audio_format	audio;   /* V4L2_BUF_TYPE_AUDIO_CAPTURE */
>  		__u8	raw_data[200];                   /* user-defined */
>  	} fmt;
>  };
> -- 
> 2.34.1
> 

-- 
Sakari Ailus
