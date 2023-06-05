Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5962722B27
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjFEPft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjFEPfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:35:47 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E6894;
        Mon,  5 Jun 2023 08:35:46 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f730c1253fso17359085e9.1;
        Mon, 05 Jun 2023 08:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685979344; x=1688571344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=htyzL0DjV5Lc50hokO9Af5DiNz1kzZvBY/56oEJzmVM=;
        b=qaF4+yXoTFnr3l0g8hEf2fNbEUSs5asWf98he64/HqfXZ4im2qr0wYATDTZdOAATTX
         Z8ESksFQz9OfbhCyu/KUNtTcLCyjjbx5iPUZhXAxh38zuEfwatL15p7EGSNhNYI3Uu/R
         gY+MsXdLyAUeawOi3qNa6wLXmddXf2ESs67hv+VTcBJD+DzfCq8px3le8wftcOImRtWC
         +XVI5g6v2mCS089T5oKI9eGDxuAcOLLJSDHIGyoPUrnla5q9DAZJIO1zkQvwA1xOw0wX
         ch/y2Z05doMVavDXZwlCSw3nyrucJ/SkPzBplSeJkqBFIAzHB/4iLsxv4yoE+4iBC9gs
         FjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685979344; x=1688571344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htyzL0DjV5Lc50hokO9Af5DiNz1kzZvBY/56oEJzmVM=;
        b=dTr4St9OSfO5HUC7xpulCpfitGgWYBiWFfYOTAwABj3Vl1rFNSzQxEQ0GvvfIbyPk8
         y+DVwqoItghIpLJtsQT3DDDgylUfzxqtuHABC7DegPXqD2tEU0PGVXNjUPnGSwSfEIAs
         RtRWEYLm8v0dLOpeDz/pZUNCa1qnETTZSdIbM5uTzx+ZmdIhTkfwwiRVF8jR57MyXYYP
         HJxHr+wo15pERPKI69yx3L7XocgEZ8ZnJTsx+do4nfgv7P1t2sMVK/aMqYM3jlLckTC/
         Z5RbVRco0n6Fg38I8UphDuEcfmzdFwIIsEVES4tWhnemigSJcOQgSTnB+NFsNtXv5LIr
         vJJQ==
X-Gm-Message-State: AC+VfDy8hMLcyLPpgA9WDVFVELRGoIy67HPctTT+Sj0f2A3zVaNnuB5I
        SDw1olEzqBCG2y/M7d6YYYvtVbXyJ/n6mwjO
X-Google-Smtp-Source: ACHHUZ6k2cu5hNqWNN2GDgt+MuYzzz5eHpOFCbz4N/i4rluW/D/mdeKV38uycJVoLCYjFYL77p+Qjw==
X-Received: by 2002:a1c:7413:0:b0:3f4:298b:d925 with SMTP id p19-20020a1c7413000000b003f4298bd925mr7525469wmc.41.1685979344453;
        Mon, 05 Jun 2023 08:35:44 -0700 (PDT)
Received: from fedora.. ([95.168.107.36])
        by smtp.gmail.com with ESMTPSA id y17-20020a1c4b11000000b003f7298a32ccsm9741165wma.41.2023.06.05.08.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 08:35:43 -0700 (PDT)
From:   Paulo Pavacic <pavacic.p@gmail.com>
To:     neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Paulo Pavacic <pavacic.p@gmail.com>
Subject: [PATCH v2 0/3] drm/panel: add fannal c3004 panel
Date:   Mon,  5 Jun 2023 17:35:36 +0200
Message-Id: <20230605153539.497602-1-pavacic.p@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fannal C3004 is a 2 lane MIPI DSI 480x800 panel which requires initialization with DSI DCS
commands. After few initialization commands delay is required.

Paulo Pavacic (3):
  dt-bindings: add fannal vendor prefix
  dt-bindings: display: panel: add fannal,c3004
  drm/panel-fannal-c3003: Add fannal c3004 DSI panel

 .../bindings/display/panel/fannal,c3004.yaml  |  78 +++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-fannal-c3004.c    | 319 ++++++++++++++++++
 6 files changed, 418 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/fannal,c3004.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-fannal-c3004.c

-- 
2.40.1

