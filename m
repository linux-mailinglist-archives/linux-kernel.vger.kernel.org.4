Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A416D660304
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 16:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjAFPWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 10:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjAFPWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 10:22:20 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D96E43E53
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 07:22:18 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id ja17so1269950wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 07:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5448HrIOtG3qg7cNyqeGSJ1amHCS+A+LsmthYxpJtsU=;
        b=lMyHuZKUbItvv9u2YgdlbP0RfmZ98/8vECzVK2EpU+s98gxDoFsl4VwZ3y/engsxpt
         Aeyunb/ZNykaZKubNTYMG/CXG8ewD/aQaFdacAFHrIJ25TL8G01sLDZdJtfn37kiEVJZ
         xCFa7UCk4wRk7wWWa2eW/CIu8XKCsCgjLC2bju0iJiJ5DIt0W0pou43EsCZ82Fe5Xdqh
         QSAySzNrLjygJmJndxHNF63Kuy156ZPtmH447gv5lArq/qRcoGhQs4PjPm3zPjesEwU7
         gcwCd8rTZ/+kwmOOGzLg6wH3NZjwYd4jtOZm42rt+xsQH142k5MNToE01ats1i7StnNr
         g/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5448HrIOtG3qg7cNyqeGSJ1amHCS+A+LsmthYxpJtsU=;
        b=hQI51yuKrS/qRJU9oF0qz4v2fF3QJ5Y0R7Din13MpeEeZpE9Y96gFICoBnLK/WVOS6
         UsJnXKs1sG3CSUtD4wESRPbo8aD2/ElYt3nMPEuY/2GkUXWvb6bj3uTMCOGbcf3rPCN+
         GdJDFSvobGPq3K75R0MjjcURF6NmsX/cGVEBOVLwGK5ivC4uV/Ds2lq/BdSsklJmkx2N
         IcT2KW4rRDq3gQslaZRlbLUd/uaZBbZJm3E9lzak3nozyoRdBUndAS+lYqynDt/s3+1d
         kYh0XZXwgBgDj9Hfnj6IAQeyo59hxZHxbn82o1aMrcbkdGnp1gXMyRQD0z0p/cX9wHjU
         dRHg==
X-Gm-Message-State: AFqh2kotHDhD+o/OHnFvDkPIFjKU+iRlOuxGzQf3RpernzJzCT2mvGxg
        MiY5ZqZwhbDd/3kUgTTiPfIT0g==
X-Google-Smtp-Source: AMrXdXtO1Ur6htopLZ7W7ZdF4WUpaDejvcTT/leWUemR6GFc25w+s0cRCBCKxxR4Q47FEercGlhRhw==
X-Received: by 2002:a05:600c:3b93:b0:3d2:1bf6:5796 with SMTP id n19-20020a05600c3b9300b003d21bf65796mr40185727wms.35.1673018537127;
        Fri, 06 Jan 2023 07:22:17 -0800 (PST)
Received: from prec5560.. ([2001:bf7:830:a7a8:fcbc:15aa:78f5:e9b2])
        by smtp.gmail.com with ESMTPSA id j18-20020a05600c191200b003d9dee823a3sm1246820wmq.5.2023.01.06.07.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 07:22:16 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     akpm@linux-foundation.org, arnd@arndb.de, qyousef@layalina.io,
        kvalo@kernel.org, tkhai@ya.ru, baolin.wang@linux.alibaba.com,
        vasily.averin@linux.dev, colin.i.king@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     Robert Foss <robert.foss@linaro.org>,
        Robert Foss <rfoss@kernel.org>
Subject: [PATCH v1] MAINTAINERS: Update Robert Foss' email address
Date:   Fri,  6 Jan 2023 16:21:51 +0100
Message-Id: <20230106152151.115648-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the email address for Robert's maintainer entries and fill in
.mailmap accordingly.

Signed-off-by: Robert Foss <rfoss@kernel.org>
---
 .mailmap    | 1 +
 MAINTAINERS | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index ccba4cf0d8938..7a882bc7f376f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -371,6 +371,7 @@ Rémi Denis-Courmont <rdenis@simphalempin.com>
 Ricardo Ribalda <ribalda@kernel.org> <ricardo@ribalda.com>
 Ricardo Ribalda <ribalda@kernel.org> Ricardo Ribalda Delgado <ribalda@kernel.org>
 Ricardo Ribalda <ribalda@kernel.org> <ricardo.ribalda@gmail.com>
+Robert Foss <rfoss@kernel.org> <robert.foss@linaro.org>
 Roman Gushchin <roman.gushchin@linux.dev> <guro@fb.com>
 Roman Gushchin <roman.gushchin@linux.dev> <guroan@gmail.com>
 Roman Gushchin <roman.gushchin@linux.dev> <klamm@yandex-team.ru>
diff --git a/MAINTAINERS b/MAINTAINERS
index 9033d9ec71961..36dbb3f6da5c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6965,7 +6965,7 @@ F:	drivers/gpu/drm/atmel-hlcdc/
 DRM DRIVERS FOR BRIDGE CHIPS
 M:	Andrzej Hajda <andrzej.hajda@intel.com>
 M:	Neil Armstrong <neil.armstrong@linaro.org>
-M:	Robert Foss <robert.foss@linaro.org>
+M:	Robert Foss <rfoss@kernel.org>
 R:	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
 R:	Jonas Karlman <jonas@kwiboo.se>
 R:	Jernej Skrabec <jernej.skrabec@gmail.com>
@@ -17267,7 +17267,7 @@ F:	Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
 F:	drivers/net/wwan/qcom_bam_dmux.c
 
 QUALCOMM CAMERA SUBSYSTEM DRIVER
-M:	Robert Foss <robert.foss@linaro.org>
+M:	Robert Foss <rfoss@kernel.org>
 M:	Todor Tomov <todor.too@gmail.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
@@ -17347,7 +17347,7 @@ F:	drivers/dma/qcom/hidma*
 
 QUALCOMM I2C CCI DRIVER
 M:	Loic Poulain <loic.poulain@linaro.org>
-M:	Robert Foss <robert.foss@linaro.org>
+M:	Robert Foss <rfoss@kernel.org>
 L:	linux-i2c@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
-- 
2.34.1

