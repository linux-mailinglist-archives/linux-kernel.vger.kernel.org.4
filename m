Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4C16E2509
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjDNODV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjDNODT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:03:19 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3E2B76E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:02:45 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id r9so5220566ljp.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1681480962; x=1684072962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6CmKFXx/xfojEaW7/QBPIIKO9g8KorbKrua0cC4RrJY=;
        b=nX4KdpatJdru56O41hIK0y/nHXVcDcxnMfPovuQbKYYpANGyF6FaK2xOBz+EgXHDVP
         J+loYySH+aJNuAgpdPoY79jVbGug7NsdV+BPBjueeICVJAQmRhT4OBSH3V8oUXz8Qr7q
         B2GgoRHJ0lz/lG/r6ThO9OeqNGVDXumR+mkV6++4NWDuIq5yzxWrTmvSbBN6CA5ivlSV
         /PVnLgk5cHVDlFUj9rrKxPhbb357nqwGQHaanx8dudSlqq3x0A1yYE2Ow7kVDtSGWL/k
         sxJj1+PrqSf/xFHXi/J56wNGnyeVEAqfLx2wWhFEk5j2IZWk89QtiR46kJga7RCBLJzN
         FGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681480962; x=1684072962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6CmKFXx/xfojEaW7/QBPIIKO9g8KorbKrua0cC4RrJY=;
        b=j05tFX/GA3RlBM5oyj/twLPUeOVZQX/jNKX+My5oWl3gU/UT4GqkcxS/utfzs/yhwc
         PhJAjjzssjmEVYP0H3kQz0wTsJOBNS/d5COJcw0iDf22Br2MXogVRSFgO0jAKCmEdmia
         nqd/cU6FRxnO13UbLwZxuTKoafil8PmO7x1HSPW242dRvyuUVcdB4cgavQr4z8TaSu28
         zmKCdJaO3N4Gi4ABruym6lXL5yHdwNLnr+X3+oh/hUqPkbx+7Q1YcbrcWrRXAuGQBJZ2
         pX9hRzSWcE4uyL8nfh5DpvWdRyqXLzWgdxcq/i/dwMvTgEwq1+q7USI0vKEoLOhDE8kt
         OhRA==
X-Gm-Message-State: AAQBX9eVKcPapebWsAeyXC/dlFpX6lND4LWzAkGEftfbMkXSR7LQ/or1
        HJCc1I+g/sXWInmk1PkzxtpAlg==
X-Google-Smtp-Source: AKy350ZKVU9Q0jCCIA9VriNQc1B7S0oO5F5h9xArFBdAxOSR8FmbdC8A69TYdJ5iCGu/V+wGWtgclA==
X-Received: by 2002:a2e:8542:0:b0:2a7:6daa:da39 with SMTP id u2-20020a2e8542000000b002a76daada39mr2266282ljj.22.1681480962193;
        Fri, 14 Apr 2023 07:02:42 -0700 (PDT)
Received: from panikiel.roam.corp.google.com (staticline-31-182-201-26.toya.net.pl. [31.182.201.26])
        by smtp.gmail.com with ESMTPSA id 15-20020a2eb2cf000000b002a76e2dedbcsm828684ljz.139.2023.04.14.07.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:02:41 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH 0/9] Add Chameleon v3 ASoC audio
Date:   Fri, 14 Apr 2023 16:01:54 +0200
Message-ID: <20230414140203.707729-1-pan@semihalf.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Google Chameleon v3 is a device made for testing audio and video
paths of other devices. This patchset adds support for ASoC audio on
this device. It has two audio sources: HDMI audio from the it68051 chip
(RX only), and analog audio from the ssm2603 chip (RX and TX).

The patchset adds the ASoC platform and machine drivers, as well as some
changes to the existing ssm2602 codec driver.

Paweł Anikiel (9):
  ASoC: Add Chameleon v3 audio
  dt-bindings: ASoC: Add chv3-i2s
  dt-bindings: ASoC: Add chv3-audio
  dt-bindings: ASoC: Add it68051
  ASoC: ssm2602: Add workaround for playback with external MCLK
  ASoC: ssm2602: Add support for CLKDIV2
  ASoC: ssm2602: Add mute gpio
  dt-bindings: ASoC: Add mute-gpio to ssm2602
  ARM: dts: chameleonv3: Add ssm2603 mute gpio

 .../devicetree/bindings/sound/adi,ssm2602.txt |   4 +
 .../bindings/sound/google,chv3-audio.yaml     |  49 +++
 .../bindings/sound/google,chv3-i2s.yaml       |  42 +++
 .../bindings/sound/ite,it68051.yaml           |  23 ++
 .../boot/dts/socfpga_arria10_chameleonv3.dts  |  30 ++
 sound/soc/Kconfig                             |   1 +
 sound/soc/Makefile                            |   1 +
 sound/soc/chameleonv3/Kconfig                 |   7 +
 sound/soc/chameleonv3/Makefile                |   2 +
 sound/soc/chameleonv3/chv3-audio.c            | 111 ++++++
 sound/soc/chameleonv3/chv3-i2s.c              | 347 ++++++++++++++++++
 sound/soc/chameleonv3/chv3-it68051.c          |  41 +++
 sound/soc/codecs/ssm2602.c                    |  37 +-
 13 files changed, 692 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/google,chv3-audio.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/google,chv3-i2s.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/ite,it68051.yaml
 create mode 100644 sound/soc/chameleonv3/Kconfig
 create mode 100644 sound/soc/chameleonv3/Makefile
 create mode 100644 sound/soc/chameleonv3/chv3-audio.c
 create mode 100644 sound/soc/chameleonv3/chv3-i2s.c
 create mode 100644 sound/soc/chameleonv3/chv3-it68051.c

-- 
2.40.0.634.g4ca3ef3211-goog

