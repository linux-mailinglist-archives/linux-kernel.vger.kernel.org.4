Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E509570D4A3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbjEWHPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbjEWHPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:15:00 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C8D11F
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:14:58 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ae3fe67980so67260535ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684826098; x=1687418098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YSv4qK17upGZVUg1/lq65wOHu9RBsXTrYATpqU4QzkQ=;
        b=myKSEI+jZuiqf4A2Qqpcoi6jThXBCM7zOXtvBHZm/Orph/5U5tvbkwjUjzZKMacpb0
         zH1sUe1wjiQS7n4emYwGTo4c2FV8oYFLP4XPeBsKL/gHg99YaZZrg3flTOedeoHpglUs
         bjIODmdn5LiCFrH/AY5ib4QeliiJIhBnQdNgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684826098; x=1687418098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSv4qK17upGZVUg1/lq65wOHu9RBsXTrYATpqU4QzkQ=;
        b=P+VVxqecNyccUoYs5Hvjh9uuD+OUBfWYzmHHeWKzSAn/WF0l23Hk5mkHppwU5h4vyG
         74L7z5pjDv6TL6tMbpEheYJx48VpsSl+xZXqRahIOJ8z6MiTLz1AW+2cURzE8VBqjETA
         op+qn/V/Mt1PrrzYfESt4gAnrhe9ycg+iUMI360Vo5f/xFF+mEztbHMJ4XQ5uo7+glk5
         w/OU/PUmBJ0vk2aLPkze0ZGkcxfARgSMCxni+j7avEbh14NIwrN5Aez21rJAncO2RRMX
         vQSXblJiwf335xewJDXsjV+UPV96t2sj/QjqbIBFDDPlsD+cMiGKdqrYTX2A/L7amU3A
         q40A==
X-Gm-Message-State: AC+VfDyLP4LtwqhtiQ0i1R6sBYBASniJihwVAaE9S3eEhzCFWYhiPQYl
        27TIQus58YSy5USpWdbJngQlQw==
X-Google-Smtp-Source: ACHHUZ7Q5fYjrnS4KpE9SjvZZHOsPFXdX+PzyZrRhtHHw7hCo0awVxDS79J6i6X3G1Y1kblQa39rZw==
X-Received: by 2002:a17:902:ab59:b0:1ac:83d1:9246 with SMTP id ij25-20020a170902ab5900b001ac83d19246mr10985091plb.61.1684826098202;
        Tue, 23 May 2023 00:14:58 -0700 (PDT)
Received: from chromium.org (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902650e00b001ac381f1ce9sm6109823plk.185.2023.05.23.00.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 00:14:57 -0700 (PDT)
Date:   Tue, 23 May 2023 07:14:52 +0000
From:   Tomasz Figa <tfiga@chromium.org>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     m.szyprowski@samsung.com, mchehab@kernel.org, ming.qian@nxp.com,
        shijie.qin@nxp.com, eagle.zhou@nxp.com, bin.liu@mediatek.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        tiffany.lin@mediatek.com, andrew-ct.chen@mediatek.com,
        yunfei.dong@mediatek.com, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, daniel.almeida@collabora.com,
        hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        jernel@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 4/8] media: videobuf2: Stop define VB2_MAX_FRAME as
 global
Message-ID: <20230523071452.2h2tilwrwejtmmrc@chromium.org>
References: <20230321102855.346732-1-benjamin.gaignard@collabora.com>
 <20230321102855.346732-5-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321102855.346732-5-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 11:28:51AM +0100, Benjamin Gaignard wrote:
> After changing bufs arrays to a dynamic allocated array
> VB2_MAX_FRAME doesn't mean anything for videobuf2 core.
> Remove it from the core definitions but keep it for drivers internal
> needs.

This made me think that some drivers could behave really badly if they
get more than VB2_MAX_FRAME (or VIDEO_MAX_FRAME) buffers. I certainly
see some having fixed-size arrays of exactly that size. Should we have a
queue flag that enables more buffers, so it is only available for
drivers which can handle them?

Best regards,
Tomasz

> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  drivers/media/common/videobuf2/videobuf2-core.c               | 2 ++
>  drivers/media/platform/amphion/vdec.c                         | 1 +
>  .../media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c | 2 ++
>  drivers/media/platform/qcom/venus/hfi.h                       | 2 ++
>  drivers/media/platform/verisilicon/hantro_hw.h                | 2 ++
>  drivers/staging/media/ipu3/ipu3-v4l2.c                        | 2 ++
>  include/media/videobuf2-core.h                                | 1 -
>  include/media/videobuf2-v4l2.h                                | 4 ----
>  8 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index f4da917ccf3f..3c6ced360770 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -31,6 +31,8 @@
>  
>  #include <trace/events/vb2.h>
>  
> +#define VB2_MAX_FRAME	32
> +
>  static int debug;
>  module_param(debug, int, 0644);
>  
> diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
> index 87f9f8e90ab1..bef0c1b869be 100644
> --- a/drivers/media/platform/amphion/vdec.c
> +++ b/drivers/media/platform/amphion/vdec.c
> @@ -28,6 +28,7 @@
>  
>  #define VDEC_MIN_BUFFER_CAP		8
>  #define VDEC_MIN_BUFFER_OUT		8
> +#define VB2_MAX_FRAME			32
>  
>  struct vdec_fs_info {
>  	char name[8];
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> index f5958b6d834a..ba208caf3043 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> @@ -16,6 +16,8 @@
>  #include "../vdec_drv_if.h"
>  #include "../vdec_vpu_if.h"
>  
> +#define VB2_MAX_FRAME	32
> +
>  /* reset_frame_context defined in VP9 spec */
>  #define VP9_RESET_FRAME_CONTEXT_NONE0 0
>  #define VP9_RESET_FRAME_CONTEXT_NONE1 1
> diff --git a/drivers/media/platform/qcom/venus/hfi.h b/drivers/media/platform/qcom/venus/hfi.h
> index f25d412d6553..bd5ca5a8b945 100644
> --- a/drivers/media/platform/qcom/venus/hfi.h
> +++ b/drivers/media/platform/qcom/venus/hfi.h
> @@ -10,6 +10,8 @@
>  
>  #include "hfi_helper.h"
>  
> +#define VB2_MAX_FRAME				32
> +
>  #define VIDC_SESSION_TYPE_VPE			0
>  #define VIDC_SESSION_TYPE_ENC			1
>  #define VIDC_SESSION_TYPE_DEC			2
> diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/media/platform/verisilicon/hantro_hw.h
> index e83f0c523a30..9e8faf7ba6fb 100644
> --- a/drivers/media/platform/verisilicon/hantro_hw.h
> +++ b/drivers/media/platform/verisilicon/hantro_hw.h
> @@ -15,6 +15,8 @@
>  #include <media/v4l2-vp9.h>
>  #include <media/videobuf2-core.h>
>  
> +#define VB2_MAX_FRAME	32
> +
>  #define DEC_8190_ALIGN_MASK	0x07U
>  
>  #define MB_DIM			16
> diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c b/drivers/staging/media/ipu3/ipu3-v4l2.c
> index e530767e80a5..6627b5c2d4d6 100644
> --- a/drivers/staging/media/ipu3/ipu3-v4l2.c
> +++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
> @@ -10,6 +10,8 @@
>  #include "ipu3.h"
>  #include "ipu3-dmamap.h"
>  
> +#define VB2_MAX_FRAME	32
> +
>  /******************** v4l2_subdev_ops ********************/
>  
>  #define IPU3_RUNNING_MODE_VIDEO		0
> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> index b8b34a993e04..4aa43c5c7c58 100644
> --- a/include/media/videobuf2-core.h
> +++ b/include/media/videobuf2-core.h
> @@ -21,7 +21,6 @@
>  #include <media/media-request.h>
>  #include <media/frame_vector.h>
>  
> -#define VB2_MAX_FRAME	(32)
>  #define VB2_MAX_PLANES	(8)
>  
>  /**
> diff --git a/include/media/videobuf2-v4l2.h b/include/media/videobuf2-v4l2.h
> index 5a845887850b..88a7a565170e 100644
> --- a/include/media/videobuf2-v4l2.h
> +++ b/include/media/videobuf2-v4l2.h
> @@ -15,10 +15,6 @@
>  #include <linux/videodev2.h>
>  #include <media/videobuf2-core.h>
>  
> -#if VB2_MAX_FRAME != VIDEO_MAX_FRAME
> -#error VB2_MAX_FRAME != VIDEO_MAX_FRAME
> -#endif
> -
>  #if VB2_MAX_PLANES != VIDEO_MAX_PLANES
>  #error VB2_MAX_PLANES != VIDEO_MAX_PLANES
>  #endif
> -- 
> 2.34.1
> 
