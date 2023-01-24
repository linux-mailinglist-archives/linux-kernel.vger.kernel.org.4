Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312C1678F0D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 04:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjAXDlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 22:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjAXDlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 22:41:09 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0CC39CC3;
        Mon, 23 Jan 2023 19:41:04 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id q8so10450648wmo.5;
        Mon, 23 Jan 2023 19:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YW+j1R20ctI265KRNSOjTxDVRq8qUoJJnec9sKEjc5I=;
        b=QacssvAIDku6BBhYk5HElUe/kzNss/+aIhsXY8hmtP+KEGGe0qI7X/+MARPfamJwAG
         XTJv6wtwpO728nUqacxcsgC6T+eb6lhvHJ0CYT6lueg7SxxPxerA5cUQpG2bW1Z0gUtc
         cvoSwfAwwTV4aj6AoRr2U0gHPXzOD4uU1zzA4lMS4oPxChIMfV10Sjiolq4gWqJlMYjw
         Z3OjZAB8PT0sG0yaVwhd3wvFQhTrZLyGXcoG5WLLngsfV294biZZN1UwZ49JONXK2110
         y+M9mg2tjE/kX+UF9AhnUHty3WbhGl2dtlY5PainLNb1LsDhn2HGMt5MUmor3rYFKEza
         q0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YW+j1R20ctI265KRNSOjTxDVRq8qUoJJnec9sKEjc5I=;
        b=54ClSUs/bQlpIkfgOWC0SoAFwuOJf9LBp0s634Xn38I2jpT8Ed/ckFPjZZ1XyDJBPO
         B/EuVEwJWTYY9utYyu/cCqlVwMOA0xVKTYWsedamfqQiQ5aRnfU5vCfrm12y2FjAtcTd
         PlDAhO/jm0ldQ1JyI3LSBuUL+oP91SgdM88VB/PigZCdPIr5Q0vrLlPygtkmm9M6XORk
         Agfaut2csqaMxTeec2HXnVlNz33gU2Fm4SvjK4UE5w4dBfNTh8QO/w7GMOjufjjITMZr
         oePVjlAl0W3jXOYGUglg1rC3t3iomBRh23+hu67Vw4B4QsUcVpm5ZYGgcaAihrSj28Xp
         VoHg==
X-Gm-Message-State: AFqh2kpahDZidflUV4BTTatJelRD/xr7xT5u3EKf6sabEwMk0rRtmKqb
        GP6q3X7AzKE5uvbQTWZMgrY=
X-Google-Smtp-Source: AMrXdXtpg88sRjLNXZmZB6PBI4TM0NJziEBJ3T2qGyFoH8GRcylSlT26sY+YVnwuzJOACkipiigiEA==
X-Received: by 2002:a05:600c:ad4:b0:3db:11d0:21e2 with SMTP id c20-20020a05600c0ad400b003db11d021e2mr22920790wmr.29.1674531663179;
        Mon, 23 Jan 2023 19:41:03 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c310c00b003db012d49b7sm1085132wmo.2.2023.01.23.19.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 19:41:02 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 0/2] media: meson: vdec: add HEVC decode codec
Date:   Tue, 24 Jan 2023 03:40:56 +0000
Message-Id: <20230124034058.3407235-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This mini-series adds support for HEVC decoding. It combines the original codec
work done by Maxime Jourdan in 2019 [0] and improvements by Benjamin Roszak in
2021 [1]. Only GXBB/GXL/GXM are enabled as decoding currently crashes on G12A
and later SoCs when trying to decode a 10-bit HEVC stream.

The goal of upstreaming the driver in its current state is to encourage greater
community contribution towards adding missing features, and fixing the bugs and
conformance issues necessary to get out of staging.

The HEVC codec presented here is generally partnered with FFMpeg sources that
are being maintained by the Raspberry Pi Foundation [2] and [3] that contain
numerous improvements to v4l2_m2m (and v4l2_request) support. There is active
work in progress to refine the changeset and send it upstream.

Christian

[0] https://github.com/Elyotna/linux/commits/4.20/v4l2-m2m-pr
[1] https://gitlab.com/benjamin545/linux-amlogic/-/commits/aml-hevc
[2] https://github.com/jc-kynesim/rpi-ffmpeg/commits/release/4.4/rpi_import_1
[3] https://github.com/jc-kynesim/rpi-ffmpeg/tree/dev/5.1.2/rpi_import_1

Changes from v1:
- Fix unused val warning reported by kernel test robot <lkp@intel.com>

Benjamin Roszak (1):
  media: meson: vdec: implement 10bit bitstream handling

Maxime Jourdan (1):
  media: meson: vdec: add HEVC decode codec

 drivers/staging/media/meson/vdec/Makefile     |    2 +-
 drivers/staging/media/meson/vdec/codec_h264.c |    3 +-
 drivers/staging/media/meson/vdec/codec_hevc.c | 1462 +++++++++++++++++
 drivers/staging/media/meson/vdec/codec_hevc.h |   13 +
 .../media/meson/vdec/codec_hevc_common.c      |  161 +-
 .../media/meson/vdec/codec_hevc_common.h      |    3 +-
 drivers/staging/media/meson/vdec/codec_vp9.c  |   35 +-
 drivers/staging/media/meson/vdec/esparser.c   |    4 +-
 drivers/staging/media/meson/vdec/hevc_regs.h  |    1 +
 drivers/staging/media/meson/vdec/vdec.h       |    1 +
 .../staging/media/meson/vdec/vdec_helpers.c   |   44 +-
 .../staging/media/meson/vdec/vdec_helpers.h   |   10 +-
 .../staging/media/meson/vdec/vdec_platform.c  |   37 +
 13 files changed, 1677 insertions(+), 99 deletions(-)
 create mode 100644 drivers/staging/media/meson/vdec/codec_hevc.c
 create mode 100644 drivers/staging/media/meson/vdec/codec_hevc.h

-- 
2.34.1

