Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9263564C79B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 12:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238146AbiLNLBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 06:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238131AbiLNLAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 06:00:51 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C791C909;
        Wed, 14 Dec 2022 03:00:50 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h12so18847818wrv.10;
        Wed, 14 Dec 2022 03:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IM7/rTUFOP/ct9XAoTb4YaT/tqN70SwMVuKsM+i658Q=;
        b=kYAxkFOjJ8BzuJeJmxU+yCTPFfcPQ4CGTFE+FGQ5UtFy6M0nKKdnUZ2gIyS8kicJjR
         5AUagbwxxuWAmtXf7hxZzi5v1dUHwD8mQs1aqViQ5L0AVEQ2ILHJvcBMg2jbZ6T/fy0u
         IJsIPXvYe6HF4z4q2v2axS1K+gmGMr54L5+sS9J23Fg2vdGhvJpgNeEyJDwaMs0m0CFR
         iotMZNEgNXYFMyjjboG/omRGCfbjLhtfv1bFPnqrzq7Bma4+uBj8m67zES6/CHfoBETq
         AiniCMICab2NZUEDrm4OIiFiG9zLOkBdaJz2aeOI1TmQbqCSrrbHsfVmbRSLKDgjE9Ny
         FxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IM7/rTUFOP/ct9XAoTb4YaT/tqN70SwMVuKsM+i658Q=;
        b=tMhp7ymXVqeZfnUZGCdYwruR8TAbnIr2F+gw8AJph7r2R/pftLkoZcpWod5IY/wDy+
         XwuMHhkRe+vXdv5G1/ML9bS4QUSHRyvVonbexIgV7pB5lpCpE+J1QxymR94gFOcq9p+4
         gkT7SlyXg90C6s+cGwOkAoidGeYWyAZcDJbzggfoCw2d3kjrar3rW1MGdsA2qagbOdjt
         t9dJlVVrq0j6+/XwftZhtTmCrUn5uaB4Tesl34R9A5hNII6cRgELuv53M99kafwKSLKN
         f86DTrDZTgURlPUF29dDmOjT92EckRo4IGXTgrt4VuvjQJPSHRf6APvTF9+lzGITDlXq
         rcVQ==
X-Gm-Message-State: ANoB5pmmgEj88WnzCp0+0ZEQMbLHhbp7BLvVnOHmlHTW1tQnlxPvpdlM
        B2FbS3QH9dFXFmWYmEwaiks=
X-Google-Smtp-Source: AA0mqf40IOBJjIuybK11ISF0mlVEOSvpvOyzSUCsEaC14iHI3HUh7JjXxqyCzjP6/dgLtkI/h+MqhA==
X-Received: by 2002:adf:fbc7:0:b0:236:6c33:2130 with SMTP id d7-20020adffbc7000000b002366c332130mr15129620wrs.68.1671015648754;
        Wed, 14 Dec 2022 03:00:48 -0800 (PST)
Received: from localhost.localdomain (2a02-8428-46a0-7c01-bc7c-15f1-6c3b-ad74.rev.sfr.net. [2a02:8428:46a0:7c01:bc7c:15f1:6c3b:ad74])
        by smtp.gmail.com with ESMTPSA id h1-20020adfaa81000000b002366c3eefccsm2462096wrc.109.2022.12.14.03.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 03:00:47 -0800 (PST)
From:   Christophe Branchereau <cbranchereau@gmail.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christophe Branchereau <cbranchereau@gmail.com>
Subject: [PATCH v2 0/2] Add support for the AUO A030JTN01 TFT LCD
Date:   Wed, 14 Dec 2022 12:00:35 +0100
Message-Id: <20221214110037.149387-1-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Changes since v1:
 fixed the dt-bindings maintainer email adress

 dropped backlight, port, power-supply and reset-gpios as they're 
 provided by panel-common.yaml as pointed by Krzysztof Kozlowski

 changed reg: true to reg : maxItems: 1

Christophe Branchereau (2):
  drm/panel: add the orisetech ota5601a
  dt-bindings: display/panel: Add the Focaltech gpt3

 .../display/panel/focaltech,gpt3.yaml         |  56 +++
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-orisetech-ota5601a.c  | 351 ++++++++++++++++++
 4 files changed, 417 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/focaltech,gpt3.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-orisetech-ota5601a.c

-- 
2.35.1

