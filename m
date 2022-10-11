Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9175FBF9D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 05:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJLDsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 23:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJLDsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 23:48:02 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887BCA50EC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 20:47:49 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221012034747epoutp036765a8dd4cb71ed81c7b133b2ed0c018~dNbASpwnR2833228332epoutp03r
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:47:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221012034747epoutp036765a8dd4cb71ed81c7b133b2ed0c018~dNbASpwnR2833228332epoutp03r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665546467;
        bh=Vod73UxxDDF6/1UwF8ErhkgY2evirPrqZuccBO7Gzrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mm/eoJEIKmcqRMtgebNJW+2q29aAosovxIZAur/f+Bcd8RmSl+xuoXts5mWzDsm81
         RWostWLGmQZ7n2rJBSrjj8xTHSWZveu9HJzzyEGVBHq/w4AGM3makZ24aYCxJYv40z
         KDk/KpG7AzfMCyojcQTCn4222BOyC1YPwcxEPduw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221012034746epcas5p30913758ec6eaddf9e3a10c840b1243e3~dNa-b1Lw61683016830epcas5p3G;
        Wed, 12 Oct 2022 03:47:46 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4MnJWg3QcBz4x9Ps; Wed, 12 Oct
        2022 03:47:43 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        23.2E.26992.FD836436; Wed, 12 Oct 2022 12:47:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221011125155epcas5p1e47309b4dd767e81817c316aa0e8b7ca~dBMz2YuYK3098030980epcas5p1J;
        Tue, 11 Oct 2022 12:51:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221011125155epsmtrp206f24d925e521a9ae8ce504b08b9f26b~dBMz1OKAT1820318203epsmtrp2_;
        Tue, 11 Oct 2022 12:51:55 +0000 (GMT)
X-AuditID: b6c32a49-0c7ff70000016970-48-634638df547a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.0D.14392.BE665436; Tue, 11 Oct 2022 21:51:55 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221011125152epsmtip11fb87b5cc95cb155429249f50976d5a8~dBMwvzaTN2178621786epsmtip1s;
        Tue, 11 Oct 2022 12:51:52 +0000 (GMT)
From:   aakarsh jain <aakarsh.jain@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, smitha.t@samsung.com, aakarsh.jain@samsung.com
Subject: [Patch v3 05/15] Documention: v4l: Documentation for VP9 CIDs.
Date:   Tue, 11 Oct 2022 17:55:06 +0530
Message-Id: <20221011122516.32135-6-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011122516.32135-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe1BUVRzHO/fevXdhBucGKEcmcOdO2kCw7sbDAwky5NgtGaGpsGya9bbc
        AWRf7C5mlAkqlgQqFcUriJc0IA+Xh5tC8ViglApEIdSFVWwAZzJlIwGh2uVC/ff5/c73+/vO
        /M45YtzdRnqLkzVGXq/hVAzpSrT1+PkFTqBdStlSxXr0m7lQhGylbSSqnJ/C0ESlnUDdza0U
        arlWjKOa/k4RKrP8LEIXuu4Q6Py043So0EqgqbIGgGaKxklkmhwRodv39qLhiyUkymlqFaF6
        i5VC1aNDGDprWsJQReufFMrqsFDI2t4G0PETFiwKsudKzwHWbK0C7GjVLM5+W2Sl2Mr2GYw1
        1Z4k2Vsj7STbXHWEzepdJNhTLbWA/fvoVxSbbRklWbvJl708Z6fi1u1L2Z7Ecwm8XsJrlNqE
        ZE1iBLP7VcULipBQmTxQHoa2MRINp+YjmJ0xcYG7klWONTCSg5wqzdGK4wwGZmvkdr02zchL
        krQGYwTD6xJUumCd1MCpDWmaRKmGN4bLZbLnQhzC/SlJOZcGSV2f7NAf5XmiDPDFM9nARQzp
        YPhRZiHIBq5id/oSgMWmWUooZgFsHZrDhOIvAOfsudiaZTpnGRcOOgA8lveAEIosDNY115BO
        FUkHwu+rO1fYk84EcPJjo1OE08cIaB147AgRiz3oF6GtOMqpIejN8Lv82yttNzoCPi5YDdsE
        65o6cSe70JHwYXUf6RwD6U9c4ELHTUIQ7YSPzs6uGjzgvf4WSmBvaL/fQQqshJMVM7jAKtjY
        /vmqdwfsvFZCOHNx2g82XtwqtH1g/uWGlZE4vQ7mPr67Ot4NmkvXeAssuTUvEvgp2FNXDQRm
        4dxC7eqC8gBcyhmnzgDfov8jvgagFmzkdQZ1Im8I0ck1/Lv/3ZpSqzaBlafu/5IZWG0PpN0A
        E4NuAMU44+kGyqKV7m4J3HvpvF6r0KepeEM3CHHsLw/3Xq/UOv6KxqiQB4fJgkNDQ4PDgkLl
        jJdbZYG/0p1O5Ix8Cs/reP2aDxO7eGdgMTpZbt4Vz83aD96xfjhWr3AxVrwWTsX+4jXx6YHU
        TJj8SNJvebMxoPcEpk0fON97/X6JcWxCGoX8Div+aao/ojKVD/gpbF3ZrtZkRUABtxxwKLqq
        3LRINC88nZFactBu6Yre4Mkh23x8bu3rg2MbcZFPfOZPWza8X12+/Fnql9L9HgE1YaPbyq05
        0TXRC+jZH3tm9lwxvTw8G/EEf+r3N76Jf7hoDpq8I9/r02L3LR1siv3V3AdGvLxGp2J+uC6B
        Qfvgslr6/FvdZ65q9FFqVz42rOHt3VVp0ydPux7IV+2JVOpv3jh69cl02SubwjOHGX6cO35D
        1H7h7o4plj0cZeIYwpDEyf1xvYH7F9GaDFdzBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsWy7bCSnO7rNNdkg6U/JCye7pjJavFg3jY2
        i8U/njNZ3F/8mcXi0Oat7BZbrsxmtlh+/ACrxfwj51gtth98xGKx8QVQ9uLMuywWz+evY7R4
        Oesem8Wmx9dYLR6+Cre4vGsOm0XPhq2sFmuP3GW3WHr9IpPFsk1/mCwWbf3CbtG69wi7xd09
        2xgtWtqOMDlIeKyZt4bRY8fdJYwe15d8YvbYOesuu8fiPS+ZPDat6mTzuHNtD5vH5iX1Hq1H
        f7F49G1Zxejxr2kuu0fXketsHp83yXmc+vqZPYAvissmJTUnsyy1SN8ugSujZ/cFtoJjBhXv
        F05kbWCcpt7FyMkhIWAi8aLnL3MXIxeHkMBuRolnfbtZIRIyEv/bjrFD2MISK/89Z4coamaS
        6LuwGqyITUBXYv/SA2wgCRGBVkaJ6ys7mUAcZoHZLBI/Jh0AquLgEBZwl3gw2wGkgUVAVWLf
        1IfsIGFeAVuJ3zOYIBbIS6zecIAZxOYUsJP4uPQYG4gtBFTS+H4q0wRGvgWMDKsYJVMLinPT
        c4sNCwzzUsv1ihNzi0vz0vWS83M3MYLjTktzB+P2VR/0DjEycTAeYpTgYFYS4WWc75QsxJuS
        WFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA5NLnII2p8v1+2u9
        V5y/3GMT53Hm1G3/gLO/jMTvPbcM2H7Qe8MZ7qOiYjsF2HfWh5Ys8+uN0pl4Z/lTqbjG55v+
        7onelGnksnae+KLv068I3F55tr+Yn9N/1Z2cLy9z19QnXD/49rv1O8NTbQl3Hny0elZ0K3JG
        UFVFoUmG4eZVV3ZyyR31dJCWPvqu4crdaCGpwyFpGzwz3HW7vXJL235WL+2PN0hyPzld4KvO
        XpNOmwbXO41xXKUbhHXuidXebAqvj55woWCVrgvD3dAbs+ccmbB5fvJX7TfzQnpevP6WZ8Yz
        6doRn+9X5vbOyDv/34ExcurMe0lntsqu3v52Z/jJNYkrQwzK2FI3hL24q/xCiaU4I9FQi7mo
        OBEAiDX9ZSoDAAA=
X-CMS-MailID: 20221011125155epcas5p1e47309b4dd767e81817c316aa0e8b7ca
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221011125155epcas5p1e47309b4dd767e81817c316aa0e8b7ca
References: <20221011122516.32135-1-aakarsh.jain@samsung.com>
        <CGME20221011125155epcas5p1e47309b4dd767e81817c316aa0e8b7ca@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Smitha T Murthy <smitha.t@samsung.com>

Adds V4l2 controls for VP9 encoder documention.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 .../media/v4l/ext-ctrls-codec.rst             | 167 ++++++++++++++++++
 1 file changed, 167 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index 2a165ae063fb..2277d83a7cf0 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -2187,6 +2187,16 @@ enum v4l2_mpeg_video_vp8_profile -
     * - ``V4L2_MPEG_VIDEO_VP8_PROFILE_3``
       - Profile 3
 
+VP9 Control Reference
+---------------------
+
+The VP9 controls include controls for encoding parameters of VP9 video
+codec.
+
+.. _vp9-control-id:
+
+VP9 Control IDs
+
 .. _v4l2-mpeg-video-vp9-profile:
 
 ``V4L2_CID_MPEG_VIDEO_VP9_PROFILE``
@@ -2253,6 +2263,163 @@ enum v4l2_mpeg_video_vp9_level -
     * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_6_2``
       - Level 6.2
 
+``V4L2_CID_CODEC_VP9_I_FRAME_QP``
+    Quantization parameter for an I frame for VP9. Valid range: from 1 to 255.
+
+``V4L2_CID_CODEC_VP9_P_FRAME_QP``
+    Quantization parameter for an P frame for VP9. Valid range: from 1 to 255.
+
+``V4L2_CID_CODEC_VP9_MAX_QP``
+    Maximum quantization parameter for VP9. Valid range: from 1 to 255.
+    Recommended range for MFC is from 230 to 255.
+
+``V4L2_CID_CODEC_VP9_MIN_QP``
+    Minimum quantization parameter for VP9. Valid range: from 1 to 255.
+    Recommended range for MFC is from 1 to 24.
+
+``V4L2_CID_CODEC_VP9_RC_FRAME_RATE``
+    Indicates the number of evenly spaced subintervals, called ticks, within
+    one second. This is a 16 bit unsigned integer and has a maximum value up to
+    0xffff and a minimum value of 1.
+
+``V4L2_CID_CODEC_VP9_GF_REFRESH_PERIOD``
+    Indicates the refresh period of the golden frame for VP9 encoder.
+
+.. _v4l2-vp9-golden-frame-sel:
+
+``V4L2_CID_CODEC_VP9_GOLDEN_FRAMESEL``
+    (enum)
+
+enum v4l2_mpeg_vp9_golden_framesel -
+    Selects the golden frame for encoding. Valid when NUM_OF_REF is 2.
+    Possible values are:
+
+.. raw:: latex
+
+    \footnotesize
+
+.. tabularcolumns:: |p{9.0cm}|p{8.0cm}|
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - ``V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_PREV``
+      - Use the (n-2)th frame as a golden frame, current frame index being
+        'n'.
+    * - ``V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_REF_PERIOD``
+      - Use the previous specific frame indicated by
+        ``V4L2_CID_CODEC_VP9_GF_REFRESH_PERIOD`` as a
+        golden frame.
+
+.. raw:: latex
+
+    \normalsize
+
+
+``V4L2_CID_CODEC_VP9_HIERARCHY_QP_ENABLE``
+    Allows host to specify the quantization parameter values for each
+    temporal layer through HIERARCHICAL_QP_LAYER. This is valid only
+    if HIERARCHICAL_CODING_LAYER is greater than 1. Setting the control
+    value to 1 enables setting of the QP values for the layers.
+
+.. _v4l2-vp9-ref-number-of-pframes:
+
+``V4L2_CID_CODEC_VP9_REF_NUMBER_FOR_PFRAMES``
+    (enum)
+
+enum v4l2_mpeg_vp9_ref_num_for_pframes -
+    Number of reference pictures for encoding P frames.
+
+.. raw:: latex
+
+    \footnotesize
+
+.. tabularcolumns:: |p{9.0cm}|p{8.0cm}|
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - ``V4L2_CID_CODEC_VP9_1_REF_PFRAME``
+      - Indicates one reference frame, last encoded frame will be searched.
+    * - ``V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_REF_PERIOD``
+      - Indicates 2 reference frames, last encoded frame and golden frame
+        will be searched.
+
+.. raw:: latex
+
+    \normalsize
+
+
+``V4L2_CID_CODEC_VP9_HIERARCHICAL_CODING_LAYER``
+    Indicates the number of hierarchial coding layer.
+    In normal encoding (non-hierarchial coding), it should be zero.
+    VP9 has upto 3 layer of encoder.
+
+``V4L2_CID_CODEC_VP9_HIERARCHY_RC_ENABLE``
+    Indicates enabling of bit rate for hierarchical coding layers VP9 encoder.
+
+``V4L2_CID_CODEC_VP9_HIER_CODING_L0_BR``
+    Indicates bit rate for hierarchical coding layer 0 for VP9 encoder.
+
+``V4L2_CID_CODEC_VP9_HIER_CODING_L1_BR``
+    Indicates bit rate for hierarchical coding layer 1 for VP9 encoder.
+
+``V4L2_CID_CODEC_VP9_HIER_CODING_L2_BR``
+    Indicates bit rate for hierarchical coding layer 2 for VP9 encoder.
+
+``V4L2_CID_CODEC_VP9_HIER_CODING_L0_QP``
+    Indicates quantization parameter for hierarchical coding layer 0.
+    Valid range: [V4L2_CID_CODEC_VP9_MIN_QP,
+    V4L2_CID_CODEC_VP9_MAX_QP].
+
+``V4L2_CID_CODEC_VP9_HIER_CODING_L1_QP``
+    Indicates quantization parameter for hierarchical coding layer 1.
+    Valid range: [V4L2_CID_CODEC_VP9_MIN_QP,
+    V4L2_CID_CODEC_VP9_MAX_QP].
+
+``V4L2_CID_CODEC_VP9_HIER_CODING_L2_QP``
+    Indicates quantization parameter for hierarchical coding layer 2.
+    Valid range: [V4L2_CID_CODEC_VP9_MIN_QP,
+    V4L2_CID_CODEC_VP9_MAX_QP].
+
+.. _v4l2-vp9-max-partition-depth:
+
+``V4L2_CID_CODEC_VP9_MAX_PARTITION_DEPTH``
+    (enum)
+
+enum v4l2_mpeg_vp9_num_partitions -
+    Indicate maximum coding unit depth.
+
+.. raw:: latex
+
+    \footnotesize
+
+.. tabularcolumns:: |p{9.0cm}|p{8.0cm}|
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - ``V4L2_CID_CODEC_VP9_0_PARTITION``
+      - No coding unit partition depth.
+    * - ``V4L2_CID_CODEC_VP9_1_PARTITION``
+      - Allows one coding unit partition depth.
+
+.. raw:: latex
+
+    \normalsize
+
+
+``V4L2_CID_CODEC_VP9_DISABLE_INTRA_PU_SPLIT``
+    Zero indicates enable intra NxN PU split.
+    One indicates disable intra NxN PU split.
+
+``V4L2_CID_CODEC_VP9_DISABLE_IVF_HEADER``
+    Indicates IVF header generation. Zero indicates enable IVF format.
+    One indicates disable IVF format.
+
 
 High Efficiency Video Coding (HEVC/H.265) Control Reference
 ===========================================================
-- 
2.17.1

