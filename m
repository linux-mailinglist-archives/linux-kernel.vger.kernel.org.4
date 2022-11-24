Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853B863779A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiKXLYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiKXLYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:24:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A4C167F4;
        Thu, 24 Nov 2022 03:24:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFF3C62082;
        Thu, 24 Nov 2022 11:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C18EC433C1;
        Thu, 24 Nov 2022 11:23:55 +0000 (UTC)
Message-ID: <3b85e6ad-e734-8b36-37bf-06b9c560ca92@xs4all.nl>
Date:   Thu, 24 Nov 2022 12:23:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [Patch v3 05/15] Documention: v4l: Documentation for VP9 CIDs.
Content-Language: en-US
To:     aakarsh jain <aakarsh.jain@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        jernej.skrabec@gmail.com, benjamin.gaignard@collabora.com,
        stanimir.varbanov@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, andi@etezian.org,
        alim.akhtar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, linux-fsd@tesla.com, smitha.t@samsung.com
References: <20221011122516.32135-1-aakarsh.jain@samsung.com>
 <CGME20221011125155epcas5p1e47309b4dd767e81817c316aa0e8b7ca@epcas5p1.samsung.com>
 <20221011122516.32135-6-aakarsh.jain@samsung.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20221011122516.32135-6-aakarsh.jain@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 14:25, aakarsh jain wrote:
> From: Smitha T Murthy <smitha.t@samsung.com>
> 
> Adds V4l2 controls for VP9 encoder documention.
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> ---
>  .../media/v4l/ext-ctrls-codec.rst             | 167 ++++++++++++++++++
>  1 file changed, 167 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index 2a165ae063fb..2277d83a7cf0 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> @@ -2187,6 +2187,16 @@ enum v4l2_mpeg_video_vp8_profile -
>      * - ``V4L2_MPEG_VIDEO_VP8_PROFILE_3``
>        - Profile 3
>  
> +VP9 Control Reference

This is wrong. There is a VPX Control Reference section for both VP8 and VP9
controls. That's where this should be added. I suspect several of the controls
you are adding here already exist, e.g. V4L2_CID_MPEG_VIDEO_VPX_MIN_QP. The
documentation may have to be updated to specify that it is for both VP8 and VP9.

> +---------------------
> +
> +The VP9 controls include controls for encoding parameters of VP9 video
> +codec.
> +
> +.. _vp9-control-id:
> +
> +VP9 Control IDs
> +
>  .. _v4l2-mpeg-video-vp9-profile:
>  
>  ``V4L2_CID_MPEG_VIDEO_VP9_PROFILE``
> @@ -2253,6 +2263,163 @@ enum v4l2_mpeg_video_vp9_level -
>      * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_6_2``
>        - Level 6.2
>  
> +``V4L2_CID_CODEC_VP9_I_FRAME_QP``

If you do need to add new controls, then please use the same MPEG_VIDEO_ prefix.
It's a bit ugly and historical, but let's keep it consistent with the others.

Regards,

	Hans

> +    Quantization parameter for an I frame for VP9. Valid range: from 1 to 255.
> +
> +``V4L2_CID_CODEC_VP9_P_FRAME_QP``
> +    Quantization parameter for an P frame for VP9. Valid range: from 1 to 255.
> +
> +``V4L2_CID_CODEC_VP9_MAX_QP``
> +    Maximum quantization parameter for VP9. Valid range: from 1 to 255.
> +    Recommended range for MFC is from 230 to 255.
> +
> +``V4L2_CID_CODEC_VP9_MIN_QP``
> +    Minimum quantization parameter for VP9. Valid range: from 1 to 255.
> +    Recommended range for MFC is from 1 to 24.
> +
> +``V4L2_CID_CODEC_VP9_RC_FRAME_RATE``
> +    Indicates the number of evenly spaced subintervals, called ticks, within
> +    one second. This is a 16 bit unsigned integer and has a maximum value up to
> +    0xffff and a minimum value of 1.
> +
> +``V4L2_CID_CODEC_VP9_GF_REFRESH_PERIOD``
> +    Indicates the refresh period of the golden frame for VP9 encoder.
> +
> +.. _v4l2-vp9-golden-frame-sel:
> +
> +``V4L2_CID_CODEC_VP9_GOLDEN_FRAMESEL``
> +    (enum)
> +
> +enum v4l2_mpeg_vp9_golden_framesel -
> +    Selects the golden frame for encoding. Valid when NUM_OF_REF is 2.
> +    Possible values are:
> +
> +.. raw:: latex
> +
> +    \footnotesize
> +
> +.. tabularcolumns:: |p{9.0cm}|p{8.0cm}|
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +
> +    * - ``V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_PREV``
> +      - Use the (n-2)th frame as a golden frame, current frame index being
> +        'n'.
> +    * - ``V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_REF_PERIOD``
> +      - Use the previous specific frame indicated by
> +        ``V4L2_CID_CODEC_VP9_GF_REFRESH_PERIOD`` as a
> +        golden frame.
> +
> +.. raw:: latex
> +
> +    \normalsize
> +
> +
> +``V4L2_CID_CODEC_VP9_HIERARCHY_QP_ENABLE``
> +    Allows host to specify the quantization parameter values for each
> +    temporal layer through HIERARCHICAL_QP_LAYER. This is valid only
> +    if HIERARCHICAL_CODING_LAYER is greater than 1. Setting the control
> +    value to 1 enables setting of the QP values for the layers.
> +
> +.. _v4l2-vp9-ref-number-of-pframes:
> +
> +``V4L2_CID_CODEC_VP9_REF_NUMBER_FOR_PFRAMES``
> +    (enum)
> +
> +enum v4l2_mpeg_vp9_ref_num_for_pframes -
> +    Number of reference pictures for encoding P frames.
> +
> +.. raw:: latex
> +
> +    \footnotesize
> +
> +.. tabularcolumns:: |p{9.0cm}|p{8.0cm}|
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +
> +    * - ``V4L2_CID_CODEC_VP9_1_REF_PFRAME``
> +      - Indicates one reference frame, last encoded frame will be searched.
> +    * - ``V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_REF_PERIOD``
> +      - Indicates 2 reference frames, last encoded frame and golden frame
> +        will be searched.
> +
> +.. raw:: latex
> +
> +    \normalsize
> +
> +
> +``V4L2_CID_CODEC_VP9_HIERARCHICAL_CODING_LAYER``
> +    Indicates the number of hierarchial coding layer.
> +    In normal encoding (non-hierarchial coding), it should be zero.
> +    VP9 has upto 3 layer of encoder.
> +
> +``V4L2_CID_CODEC_VP9_HIERARCHY_RC_ENABLE``
> +    Indicates enabling of bit rate for hierarchical coding layers VP9 encoder.
> +
> +``V4L2_CID_CODEC_VP9_HIER_CODING_L0_BR``
> +    Indicates bit rate for hierarchical coding layer 0 for VP9 encoder.
> +
> +``V4L2_CID_CODEC_VP9_HIER_CODING_L1_BR``
> +    Indicates bit rate for hierarchical coding layer 1 for VP9 encoder.
> +
> +``V4L2_CID_CODEC_VP9_HIER_CODING_L2_BR``
> +    Indicates bit rate for hierarchical coding layer 2 for VP9 encoder.
> +
> +``V4L2_CID_CODEC_VP9_HIER_CODING_L0_QP``
> +    Indicates quantization parameter for hierarchical coding layer 0.
> +    Valid range: [V4L2_CID_CODEC_VP9_MIN_QP,
> +    V4L2_CID_CODEC_VP9_MAX_QP].
> +
> +``V4L2_CID_CODEC_VP9_HIER_CODING_L1_QP``
> +    Indicates quantization parameter for hierarchical coding layer 1.
> +    Valid range: [V4L2_CID_CODEC_VP9_MIN_QP,
> +    V4L2_CID_CODEC_VP9_MAX_QP].
> +
> +``V4L2_CID_CODEC_VP9_HIER_CODING_L2_QP``
> +    Indicates quantization parameter for hierarchical coding layer 2.
> +    Valid range: [V4L2_CID_CODEC_VP9_MIN_QP,
> +    V4L2_CID_CODEC_VP9_MAX_QP].
> +
> +.. _v4l2-vp9-max-partition-depth:
> +
> +``V4L2_CID_CODEC_VP9_MAX_PARTITION_DEPTH``
> +    (enum)
> +
> +enum v4l2_mpeg_vp9_num_partitions -
> +    Indicate maximum coding unit depth.
> +
> +.. raw:: latex
> +
> +    \footnotesize
> +
> +.. tabularcolumns:: |p{9.0cm}|p{8.0cm}|
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +
> +    * - ``V4L2_CID_CODEC_VP9_0_PARTITION``
> +      - No coding unit partition depth.
> +    * - ``V4L2_CID_CODEC_VP9_1_PARTITION``
> +      - Allows one coding unit partition depth.
> +
> +.. raw:: latex
> +
> +    \normalsize
> +
> +
> +``V4L2_CID_CODEC_VP9_DISABLE_INTRA_PU_SPLIT``
> +    Zero indicates enable intra NxN PU split.
> +    One indicates disable intra NxN PU split.
> +
> +``V4L2_CID_CODEC_VP9_DISABLE_IVF_HEADER``
> +    Indicates IVF header generation. Zero indicates enable IVF format.
> +    One indicates disable IVF format.
> +
>  
>  High Efficiency Video Coding (HEVC/H.265) Control Reference
>  ===========================================================

