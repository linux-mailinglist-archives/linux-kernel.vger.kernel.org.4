Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96C566BC75
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjAPLIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjAPLIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:08:30 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEBAA5D4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:08:30 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso30746489pjf.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dfRiQXYTUx6y8hhtdcAlsfGS9AhT12f1GNqfx+pyyDk=;
        b=Eztij/jKwvQgLi8FDIq5tc40NYED6o9kyjWUtMs94tSD3Q0DoNhh88GZK3QOx5Mbjl
         rqQtvulivsl9z30WiH5kwhs7vxyc4rBEs5Fa8Om0dq5CDMPtVdMp6i/fb/Ex37GBMe9q
         TDCD8Ft7g+ZKdLIbmLWSTdQqsosUGLE69BZUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dfRiQXYTUx6y8hhtdcAlsfGS9AhT12f1GNqfx+pyyDk=;
        b=bXnCpT6UrxlxsIGxINalYKwgFDt7WQP4mLdzXPgi1Qxt/n4fqPddpxEqo2pmkReLV6
         4pnS/CbehVc+DgCTUkAKfKSWD86GDvpuJPj+xXPpBEGyo7RzfJ8QnQt4Soyw+BHhAjSz
         TaSXKLjBL3XkPQVZW9D38zisAYoo66x+kyV/FrQZXwdBDxdD/pn6XIm8eWp/7n6uRN8W
         d0KKh22VnsWuKxZI5x8bQpdIQKUGy9HCkpMipjP7cm8hDfCtO+dTDKcNXO86qO9VgvQa
         ycQK3saBBzBmGmBzhK3+7eZr2kCfDtRYqc6lXMM9FJTsO5S1YlDNeXE3B24lOF62Zfyw
         hx4A==
X-Gm-Message-State: AFqh2kpHy8tW9wS2ID8gtw6wl0WPFipBCxo8z+JrQCoEC1sj5Sv+cKZH
        69bAQ/MKmntM5x8pCgPE8fi6Xw==
X-Google-Smtp-Source: AMrXdXsggwYVYYGhO1zejEuuLPLjf5Zi64UVNlp925UPkPrexYScta5K/8VyKE2HL32TxjKI4YFFag==
X-Received: by 2002:a17:90a:b110:b0:223:4308:1ab4 with SMTP id z16-20020a17090ab11000b0022343081ab4mr93379792pjq.46.1673867309636;
        Mon, 16 Jan 2023 03:08:29 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:a3f3:9ba9:fe36:fbcb])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090a138800b00226369149cesm17993686pja.21.2023.01.16.03.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 03:08:29 -0800 (PST)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        dri-devel@lists.freedesktop.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v2 0/2] Add generic-display-mux driver and bindings
Date:   Mon, 16 Jan 2023 19:08:18 +0800
Message-Id: <20230116110820.2615650-1-treapking@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the v2 the mux driver part of v1. This series is developed for
and tested on MT8173 board, whose layout looks like:

                                  /-- anx7688
-- MT8173 HDMI bridge -- GPIO mux
                                  \-- native HDMI

v1: https://patchwork.kernel.org/project/dri-devel/cover/20191211061911.238393-1-hsinyi@chromium.org/

The other drm bridge callbacks is dropped in this version because:
- The non-atomic callbacks are deprecated
- It would be complicated to pass the atomic state to the downstream
- We actually don't have the hardware to test them

Changes in v2:
- Referenced existing dt-binding schemas from graph.yaml
- Added ddc-i2c-bus into the bindings
- Dropped attach/mode_set/enable/disable callbacks
- Fixed style issues
- Removed the special case for the HDMI connector
- Made the driver only read the GPIO status in IRQ handler
- Rebased to drm-misc-next
- Updated the license: "GPL v2" --> "GPL"

Nicolas Boichat (2):
  dt-bindings: display: bridge: Add GPIO display mux binding
  drm: bridge: Generic GPIO mux driver

 .../bindings/display/bridge/gpio-mux.yaml     |  95 +++++++++
 drivers/gpu/drm/bridge/Kconfig                |  10 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/generic-gpio-mux.c     | 201 ++++++++++++++++++
 4 files changed, 307 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml
 create mode 100644 drivers/gpu/drm/bridge/generic-gpio-mux.c

-- 
2.39.0.314.g84b9a713c41-goog

