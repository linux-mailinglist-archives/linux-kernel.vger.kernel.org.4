Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A2A620014
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbiKGVCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiKGVCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:02:20 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63166403;
        Mon,  7 Nov 2022 13:02:19 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id 13so33565062ejn.3;
        Mon, 07 Nov 2022 13:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UyHjDH2OkNpKB2ikr0TO8Pj6bQxuxcX9QhNW0e830ps=;
        b=XpyuldZcA2USszrkDGtQyVwFDTemciAp0kElwwETiPYxuUV2HXYkLGzvYduc5OFpNI
         YLhG1lLfVcjL2yEjgtUJCrdj+jiZLDsY4YbLQIfAqvhkdTzieWYLKtIuCqOOBpuPd/yV
         93nl8anaDa2xwuw1U9ptaR4MtxtfG9EHwlhIVJXO3T38oWZP3gYV46B82Tyzkl9dimNI
         /fiBUejbD+l6zrIYaFCvsEUo9uqi1gnVkt3FBLwHtRoRYcFFwnEhz8j1RplUkUiFQ+F8
         zHIO0NYCXx+EwNknXxzS4pXRaEEpRsnfs2GrlhUgrQJSXcWuhPvPP7R9zWvuYTzTmI1I
         oJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UyHjDH2OkNpKB2ikr0TO8Pj6bQxuxcX9QhNW0e830ps=;
        b=AjJmdMz/MFfDBj+Z2FMABX2EXikrRIUAlZ5YMXv7MjcvsK911amcSoEOhEib/nfIjh
         n+TbCxUcRiaRY28cqiseL4KBpIt4EdAjzPHe4nesW/BfF4AtK1rHylp4NepH8JzAKSY/
         /zZyT17r4kl+l7VtAM3ys1PjNmsjxsFLLCQnfWDPA5nP80nkY01BW3IZGwwAzFnfgvBO
         KWWjp8Vis8AiVbesekp0EqQS1U859qtktcQxnzghupm5jEBLPKAkeD8vCc4ShR+3UMP+
         CLX+so+Hh0txPZ4F2Z7G8EaRne7OGNpGwKvSCjAxUKFYz8Yv6IBVbK0EKt1EAJDj2tnn
         qALQ==
X-Gm-Message-State: ACrzQf0yj76FJuElHPvycVrkS1Q3hO/g27j5mJdqRoM8HZNx7kuzxT98
        FevFB9XVuVPn/PXOvQ6Irpk=
X-Google-Smtp-Source: AMsMyM6ZfIIK9O/eDcoFcAmmG+B0PKBsNHl6D9biVAzXEQfdGkdPy4y8uA7tr1eFqDPC07OKJ/vrKg==
X-Received: by 2002:a17:907:d89:b0:7a8:d67d:87d3 with SMTP id go9-20020a1709070d8900b007a8d67d87d3mr18091609ejc.364.1667854938119;
        Mon, 07 Nov 2022 13:02:18 -0800 (PST)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id k18-20020a05640212d200b0044ef2ac2650sm4638472edx.90.2022.11.07.13.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:02:17 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wens@csie.org, samuel@sholland.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 0/3] media: sunxi: Add H6 deinterlace driver
Date:   Mon,  7 Nov 2022 22:02:05 +0100
Message-Id: <20221107210208.284261-1-jernej.skrabec@gmail.com>
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

Best regards,
Jernej

Changes from v1:
- use pm_runtime_resume_and_get() instead of pm_runtime_get_sync()
- move memory allocation and freeing outside lock
- call devm_request_irq() later, so base is already initialized
- call platform_set_drvdata() sooner
- deassert reset before enabling clocks
- set mod clock rate to 300 MHz
- set min size to 32x32 and max to 2048x1280, as suggested by user manual
  of D1, which seems to have similar deinterlace unit
- fix header year and guard
- added tags

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
 .../platform/sunxi/sun50i-di/sun50i-di.c      | 1149 +++++++++++++++++
 .../platform/sunxi/sun50i-di/sun50i-di.h      |  175 +++
 9 files changed, 1432 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun50i-h6-deinterlace.yaml
 create mode 100644 drivers/media/platform/sunxi/sun50i-di/Kconfig
 create mode 100644 drivers/media/platform/sunxi/sun50i-di/Makefile
 create mode 100644 drivers/media/platform/sunxi/sun50i-di/sun50i-di.c
 create mode 100644 drivers/media/platform/sunxi/sun50i-di/sun50i-di.h

--
2.38.1

