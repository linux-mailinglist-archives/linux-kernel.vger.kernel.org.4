Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE73614AB8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 13:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiKAMcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 08:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKAMcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 08:32:21 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B5F17E10;
        Tue,  1 Nov 2022 05:32:20 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a14so19904235wru.5;
        Tue, 01 Nov 2022 05:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=asoWekP0S6I4rKhiYwy8FgHvcv/s8ZlTBqdD48kgwrs=;
        b=SV/rrSTjwUPVGv5ixCHdcN+wfHbDMCSfpgFpNcYO6UyADssLZD1Ro4bQWQwaE6iSFF
         6pxN5PxMmGGuUDbQV1lkcT+bsDnQX8LI+YSbbrAuehqYvlzy4dfCxQJj8L3ZRsqBeqrn
         eMNUNoaB16qd+hLTF/yRzieHKp6Zfe2MkfJJoLk91V1vnCzsj+DtdGsGGfBEXOMYkycH
         BPK8J+X4ZgFkkS+MM8PP1UKzBKJcvGGdcT7sYdM1mRjTFE4zuSswJQXqiKCxV6I1uYhS
         EpxltdmTLZtbO6Je/PIR9/TLFUPH6fFkvW8LIUgoz625eJdgdUeD2APgdv+3HPhPrs1G
         nm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=asoWekP0S6I4rKhiYwy8FgHvcv/s8ZlTBqdD48kgwrs=;
        b=yEBLcNrimGbUO9j8EDKMQ3ZAVIq06BnYxGmgo7fjuKLTNmbwfq3ubVZCtrDJ9kBHi9
         DQwi7WDVMu+vbShpPlvx/uYjAdDM3bur719WySOrbJVsM1JT8u20tcB2oduu0FE8ybcB
         Pi0CC5JdfW9NNwIkS8H/z424z5Vo1b7clywVj3YFp85I8TjS6kO9sf1mEL+4w2G476EG
         Iaenmzkc6DkI1uJ5trE9psPJ8ZdBdIy30OXDn+tZqBwrtdrloZupjVIZgSsCg3Ikj54i
         nqtEDtweCQaAleVVt9HczOR8RmOifHCjTCFF9i4a8ghvErP4PkkptQC3qU8ffKMDwb9W
         0FQw==
X-Gm-Message-State: ACrzQf2TEZWQWa47ZSS1g34P7szug4CzQPjB3fM+TeXeS/ujRSfXvdrD
        XOvWUNBiQMPMzc/tsp6s10Q=
X-Google-Smtp-Source: AMsMyM7yIX+qGuPW1i/7qFvjN9goSNuVqX60VD/ARdYElANN5QYXIPnACp6wyWxRCeRKJIQuEwpSug==
X-Received: by 2002:a05:6000:1887:b0:236:7b1a:b14c with SMTP id a7-20020a056000188700b002367b1ab14cmr11561165wri.173.1667305939174;
        Tue, 01 Nov 2022 05:32:19 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id f18-20020a1cc912000000b003cf5ec79bf9sm10404176wmb.40.2022.11.01.05.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 05:32:18 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wens@csie.org, samuel@sholland.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 0/3] media: sunxi: Add H6 deinterlace driver
Date:   Tue,  1 Nov 2022 13:31:58 +0100
Message-Id: <20221101123201.3021129-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements driver for H6 deinterlace core, which is
newer version of core, covered by sun8i-di (v2.3). Contrary to
older one, it doesn't support scaling, but it supports iommu,
has additional motion compensated deinterlacing algorithm and
supports different pixel formats.

v4l2-compliance 1.23.0-4961, 64 bits, 64-bit time_t
v4l2-compliance SHA: f86484524f32 2022-10-21 10:08:58

Compliance test for sun50i-di device /dev/video0:

Driver Info:
        Driver name      : sun50i-di
        Card type        : sun50i-di
        Bus info         : platform:sun50i-di
        Driver version   : 6.1.0
        Capabilities     : 0x84208000
                Video Memory-to-Memory
                Streaming
                Extended Pix Format
                Device Capabilities
        Device Caps      : 0x04208000
                Video Memory-to-Memory
                Streaming
                Extended Pix Format

Required ioctls:
        test VIDIOC_QUERYCAP: OK
        test invalid ioctls: OK

Allow for multiple opens:
        test second /dev/video0 open: OK
        test VIDIOC_QUERYCAP: OK
        test VIDIOC_G/S_PRIORITY: OK
        test for unlimited opens: OK

Debug ioctls:
        test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
        test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
        test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
        test VIDIOC_ENUMAUDIO: OK (Not Supported)
        test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDIO: OK (Not Supported)
        Inputs: 0 Audio Inputs: 0 Tuners: 0

Output ioctls:
        test VIDIOC_G/S_MODULATOR: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_ENUMAUDOUT: OK (Not Supported)
        test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDOUT: OK (Not Supported)
        Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
        test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
        test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
        test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
        test VIDIOC_G/S_EDID: OK (Not Supported)

Control ioctls:
        test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK (Not Supported)
        test VIDIOC_QUERYCTRL: OK (Not Supported)
        test VIDIOC_G/S_CTRL: OK (Not Supported)
        test VIDIOC_G/S/TRY_EXT_CTRLS: OK (Not Supported)
        test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK (Not Supported)
        test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
        Standard Controls: 0 Private Controls: 0

Format ioctls:
        test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
        test VIDIOC_G/S_PARM: OK (Not Supported)
        test VIDIOC_G_FBUF: OK (Not Supported)
        test VIDIOC_G_FMT: OK
        test VIDIOC_TRY_FMT: OK
        test VIDIOC_S_FMT: OK
        test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
        test Cropping: OK (Not Supported)
        test Composing: OK (Not Supported)
        test Scaling: OK (Not Supported)

Codec ioctls:
        test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
        test VIDIOC_G_ENC_INDEX: OK (Not Supported)
        test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls:
        test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
        test VIDIOC_EXPBUF: OK
        test Requests: OK (Not Supported)

Total for sun50i-di device /dev/video0: 45, Succeeded: 45, Failed: 0, Warnings: 0

Best regards,
Jernej

Jernej Skrabec (3):
  media: dt-bindings: media: Add Allwinner H6 Deinterlace binding
  media: sunxi: Add H6 deinterlace driver
  arm64: dts: allwinner: h6: Add deinterlace node

 .../allwinner,sun50i-h6-deinterlace.yaml      |   74 ++
 MAINTAINERS                                   |    4 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |   12 +
 drivers/media/platform/sunxi/Kconfig          |    1 +
 drivers/media/platform/sunxi/Makefile         |    1 +
 .../media/platform/sunxi/sun50i-di/Kconfig    |   15 +
 .../media/platform/sunxi/sun50i-di/Makefile   |    2 +
 .../platform/sunxi/sun50i-di/sun50i-di.c      | 1142 +++++++++++++++++
 .../platform/sunxi/sun50i-di/sun50i-di.h      |  175 +++
 9 files changed, 1425 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun50i-h6-deinterlace.yaml
 create mode 100644 drivers/media/platform/sunxi/sun50i-di/Kconfig
 create mode 100644 drivers/media/platform/sunxi/sun50i-di/Makefile
 create mode 100644 drivers/media/platform/sunxi/sun50i-di/sun50i-di.c
 create mode 100644 drivers/media/platform/sunxi/sun50i-di/sun50i-di.h

--
2.38.1

