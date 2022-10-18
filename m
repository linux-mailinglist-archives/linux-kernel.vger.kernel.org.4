Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC877602F26
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiJRPFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiJRPFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:05:53 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C79C3545
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:05:49 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id o22so8794485qkl.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HBKwtGOVmBtQkFbjQTDFgGB6zvwH5MNmJgIbqMQ1y9k=;
        b=09Q41mf2aoi3/7NEVmbm7OtPYPGMVz8N7WKCs9RPB1gECe1tgaHi0zDIQo8qcRIRiK
         ItSi4NzFHQAmyD/+NkV6A8hsQttxXfeE7oy5LwjA18OrZ5g02aDI+BCVlDjcHfKNDw0i
         OrJlDveEohPFdg6hr6Xbr737QLcDiQ6NUoQu5PVj0OBanF++upl5vfdawnl/ru/OuQTQ
         GTKvVrh01HdWh9EZBQmzkIgSo1oCT0fsYnS1WcFYmfkWYnm7WZ8nn7LiCDfxtqaLQL41
         D9HjXQQu8rMhoHwFmcgzKTsKEtcw9AgVbZFU6D5HwKAI8TZXroDl2ojUKBTDOXOqW0FQ
         ydQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HBKwtGOVmBtQkFbjQTDFgGB6zvwH5MNmJgIbqMQ1y9k=;
        b=FEiuC9e2m4maq/Oer3TbKMs1ZnQAcUb3XKZ+9vAYWvylaJvA8Hzdh634zIV64ujkRT
         YMKltBE9TiHWf/vt5CkOcVvQQA1i++dDPIol4OM5bFDu3cl5EsymNP+jH9fkPkDzPtOF
         v3l3/H+DQLv/Q2u0xPLeBJchrVwtebh+ylY/+XwOP/nI6WEar/+wyiFtf/Z/PICmNPnx
         1sOCoAdZF4oAjeTShl9Qd6uJcM2O974yG8w3nspiPVIUfaGwyEbwx9RokXlUwO7uDIOE
         XDhqumAu7dClc80YPLMs1iCE4TrWbceaDeKd4pTLZ87Nb3Qhm7NnS3ma2nsX/HWnvf7g
         cL+g==
X-Gm-Message-State: ACrzQf0vH0DI883O2aO8S4zExW+F6nGJx42va01OcLtla8gPvqRoC5C3
        EUMVDC6sjxGniB132wxGeueNZQ==
X-Google-Smtp-Source: AMsMyM58jA4nq6UJTkAANjtbM75ThReTOH7ATEAhmrna6g/A2N6qMPmE3HrjMHIcyJEwnWjZHdjtLQ==
X-Received: by 2002:ae9:e002:0:b0:6eb:adfb:5e03 with SMTP id m2-20020ae9e002000000b006ebadfb5e03mr2096467qkk.243.1666105548289;
        Tue, 18 Oct 2022 08:05:48 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id h14-20020ac8568e000000b0039913d588fbsm2075232qta.48.2022.10.18.08.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 08:05:46 -0700 (PDT)
Message-ID: <1f3b8e326d64810999e1430da56fbe2f3efc0a91.camel@ndufresne.ca>
Subject: Re: [Patch v3 05/15] Documention: v4l: Documentation for VP9 CIDs.
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     aakarsh jain <aakarsh.jain@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, smitha.t@samsung.com
Date:   Tue, 18 Oct 2022 11:05:44 -0400
In-Reply-To: <20221011122516.32135-6-aakarsh.jain@samsung.com>
References: <20221011122516.32135-1-aakarsh.jain@samsung.com>
         <CGME20221011125155epcas5p1e47309b4dd767e81817c316aa0e8b7ca@epcas5p1.samsung.com>
         <20221011122516.32135-6-aakarsh.jain@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks for your patch, very minor comment below.

Le mardi 11 octobre 2022 =C3=A0 17:55 +0530, aakarsh jain a =C3=A9crit=C2=
=A0:
> From: Smitha T Murthy <smitha.t@samsung.com>
>=20
> Adds V4l2 controls for VP9 encoder documention.
>=20
> Cc: linux-fsd@tesla.com
> Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> ---
>  .../media/v4l/ext-ctrls-codec.rst             | 167 ++++++++++++++++++
>  1 file changed, 167 insertions(+)
>=20
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/=
Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index 2a165ae063fb..2277d83a7cf0 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> @@ -2187,6 +2187,16 @@ enum v4l2_mpeg_video_vp8_profile -
>      * - ``V4L2_MPEG_VIDEO_VP8_PROFILE_3``
>        - Profile 3
> =20
> +VP9 Control Reference
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
> =20
>  ``V4L2_CID_MPEG_VIDEO_VP9_PROFILE``
> @@ -2253,6 +2263,163 @@ enum v4l2_mpeg_video_vp9_level -
>      * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_6_2``
>        - Level 6.2
> =20
> +``V4L2_CID_CODEC_VP9_I_FRAME_QP``
> +    Quantization parameter for an I frame for VP9. Valid range: from 1 t=
o 255.
> +
> +``V4L2_CID_CODEC_VP9_P_FRAME_QP``
> +    Quantization parameter for an P frame for VP9. Valid range: from 1 t=
o 255.
> +
> +``V4L2_CID_CODEC_VP9_MAX_QP``
> +    Maximum quantization parameter for VP9. Valid range: from 1 to 255.
> +    Recommended range for MFC is from 230 to 255.

We don't usually want every single HW to be documented in the generic part =
of
the documentation. The range supported by the HW should be found at run-tim=
e I
suppose, by querying the control. Would that work for you to remove the MFC
specifics here and in other controls ?

> +
> +``V4L2_CID_CODEC_VP9_MIN_QP``
> +    Minimum quantization parameter for VP9. Valid range: from 1 to 255.
> +    Recommended range for MFC is from 1 to 24.
> +
> +``V4L2_CID_CODEC_VP9_RC_FRAME_RATE``
> +    Indicates the number of evenly spaced subintervals, called ticks, wi=
thin
> +    one second. This is a 16 bit unsigned integer and has a maximum valu=
e up to
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
> +      - Use the (n-2)th frame as a golden frame, current frame index bei=
ng
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
> +      - Indicates one reference frame, last encoded frame will be search=
ed.
> +    * - ``V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_REF_PERIOD``
> +      - Indicates 2 reference frames, last encoded frame and golden fram=
e
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
> +    Indicates enabling of bit rate for hierarchical coding layers VP9 en=
coder.
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
> =20
>  High Efficiency Video Coding (HEVC/H.265) Control Reference
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

