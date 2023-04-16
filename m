Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4F86E36DD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 12:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjDPKBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 06:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjDPKBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 06:01:45 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43F32728;
        Sun, 16 Apr 2023 03:01:44 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a5so212072ejb.6;
        Sun, 16 Apr 2023 03:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681639303; x=1684231303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pJigTOMieV88JCMUkFyYL25oiCUdnIAzYt3+b/d9iJU=;
        b=CK+FzezMiv2xY54n49RI1Hh4a3V/IpVGr9cPTGzt18vBdOWGwcYOMrDdyg+B7Npa83
         AHRLzfW0xHpgvt2GiDppjcWV/MIV6ZF+06gB5DBwIBUOflB9GzUyo1K8RjQjuyExyoY7
         qDVg4cBav/ryzXyQJAbh5OcUsmK/LtnWjewIgpnelQElavMAf/GdXyZChHVph3AhHaTH
         JQuJiXwljacmVOBtaPHxcvsKiOuYRII4BCh0Ex72Pvv/v1s6k2ASIb+oyZi6RlQL2m9N
         xM0CBaIH6jeYkXDIXuJcIMLxUC96ifyF/iWnO+eZTy30iJr1VB4ul3Jj5MHehbzSUcNE
         us/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681639303; x=1684231303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJigTOMieV88JCMUkFyYL25oiCUdnIAzYt3+b/d9iJU=;
        b=cnyidh1xOcajAMUGMYgyPvMuGTPyZzXEyuG8op5vPiqWO5ty2lnGzp7vXHAILwr064
         ziIUjBm3PJjm23IISYspubaIlJXuqnt9Srr1wASgoMwPn/dlLJki9reluo14zyFNLoeK
         sGsUzhgnGjCV6tCaUKRs6gRmLvBfUflzlFHqataySLKJhs3jVMOnrEiCIod4zEALBtQc
         NyVvgYFKgGlFDNV1KhgkH+Q+sTiFjvdrPOA+9CngXMKzQ2xp5Ctb1tI448wSlzYphuyQ
         JlYDJuFyPC7jLomA81a5JMvto5rX7VirCrgBLds5F4nk9L4bRUU3HjXENOoLs0QLsyKb
         nnLg==
X-Gm-Message-State: AAQBX9dgtgAhb71u4KB0LRXrGOksSz0nk4mTpeM3KBlVdrDTJJWXhWyb
        yN7fzaaBtSA7bf45EjKqeZg=
X-Google-Smtp-Source: AKy350blmIQqNb6VOqWPaRs8N1vcRDsMO1c+ca9Bz5vL8d20BlI7qVirihpC9PAbKpIxDgnp2nSTsQ==
X-Received: by 2002:a17:906:7013:b0:94e:d3e8:ec3e with SMTP id n19-20020a170906701300b0094ed3e8ec3emr3770036ejj.46.1681639303270;
        Sun, 16 Apr 2023 03:01:43 -0700 (PDT)
Received: from localhost.my.domain (83.8.121.70.ipv4.supernova.orange.pl. [83.8.121.70])
        by smtp.gmail.com with ESMTPSA id lh22-20020a170906f8d600b0094f6bf5ac9asm145232ejb.22.2023.04.16.03.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 03:01:42 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     thierry.reding@gmail.com
Cc:     sam@ravnborg.org, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH 0/3] Add Samsung S6D7AA0 panel controller driver
Date:   Sun, 16 Apr 2023 12:01:36 +0200
Message-Id: <20230416100139.13741-1-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.0
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

This patchset adds initial support for Samsung S6D7AA0-based panels.
Currently, only the S6D7AA0-LSL080AL02 panel used in the Samsung
Galaxy Tab 3 8.0 family of tablets is supported; other panels can be
added in the future.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>

Artur Weber (3):
  dt-bindings: panel: Add Samsung S6D7AA0 LCD controller bindings
  drm/panel: Add Samsung S6D7AA0 panel controller driver
  MAINTAINERS: Add myself as Samsung S6D7AA0 panel driver maintainer

 .../display/panel/samsung,s6d7aa0.yaml        |  51 +++
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/panel/Kconfig                 |   7 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c | 397 ++++++++++++++++++
 5 files changed, 462 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c

-- 
2.40.0

