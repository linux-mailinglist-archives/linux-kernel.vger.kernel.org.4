Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2293F72925D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239977AbjFIIMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239605AbjFIIMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:12:18 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E141FDA;
        Fri,  9 Jun 2023 01:12:17 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b1ba50e50bso15480961fa.1;
        Fri, 09 Jun 2023 01:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686298336; x=1688890336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qodemV8tRaPN6lfvgZ3EB7MzxSemetoL3QYb7jUIQEk=;
        b=rx7774MkYxDOyFZ4M/trWVNIX33ywDo0yOSfLa4EslMGH/kZ9WSscvvf1NqZwcs2jb
         eLeKgGgoHQYiwNUlSWhNc/vnTrg/BeG7tgEu7Wpu4NE46/5Tgw2bPVW3nVZdpsgbwS1Q
         KSyrln66eVfqJRLX6VcvzzE98VluFT/i39l2vsss28MsnDI2EN1Xrg9gIPxjKn4J29UA
         5YAV6k6tEnBDDXtm6ktJpsRtipXva3+c8dPCug3FMUxSnK2byYw/D1kWwo6/xYB+RD1o
         GFUuFTykNW6cMJ3QjwTKuWxmqxR5vKrOL+Qj0cgDmYDk6i8d2GBcKnfgAqL6sta8bAQb
         liZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686298336; x=1688890336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qodemV8tRaPN6lfvgZ3EB7MzxSemetoL3QYb7jUIQEk=;
        b=lU6b7FpgCytV1CCcQohsFop+bmjpXQVd35lDy/j8Pb+y6yjJUa31hGS1X8LiAo5lQS
         080ZNDHUZ3UA9PWCDIl2ckAwVEhCy66ITHc9L8TWhCj3K+EiOcLZMpLj5O00zlny49AD
         ytP4Wi03vz0AIpultzRQKd8XGPY7LS0C9/OTmT6ARlwc8L6vhdTYQ6D1Y048IoA3MCYR
         nySjS/5b+Xgff2M0yC7AouJlkljAIeulUEblFuuJyECdADkOkEhwRBHhGj3cjwBhQuqA
         /tLUYbrWDLOs7MqOi3cwS7F270fme216m14DFJzPvekV1zOWgHklDCg43qoXdomjNysO
         wRQg==
X-Gm-Message-State: AC+VfDwnpCfeyXmMh3VGDb0TtezIdcJkRVA+v8q72Rzmio/3XmMSREup
        Nv2XwQVGLuc9j3p3luPKjdE=
X-Google-Smtp-Source: ACHHUZ5GhOCEZe6676VcuMkcOvn85TaNMJrkMeqVr8A2KgtP5S/BZ1b8HLSG20Yy9eeuyRnx478fHw==
X-Received: by 2002:a19:ca07:0:b0:4f5:1ca1:30d9 with SMTP id a7-20020a19ca07000000b004f51ca130d9mr311254lfg.68.1686298335677;
        Fri, 09 Jun 2023 01:12:15 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id l8-20020a1c7908000000b003f7f4dc6d14sm1856108wme.14.2023.06.09.01.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 01:12:15 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/connector: Fix spelling mistake "provded" -> "provided"
Date:   Fri,  9 Jun 2023 09:12:13 +0100
Message-Id: <20230609081213.1222580-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There are two spelling mistakes in drm_err messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/drm_connector.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 3ed4cfcb350c..63370c4a68ac 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2168,13 +2168,13 @@ static int drm_mode_create_colorspace_property(struct drm_connector *connector,
 		return 0;
 
 	if (!supported_colorspaces) {
-		drm_err(dev, "No supported colorspaces provded on [CONNECTOR:%d:%s]\n",
+		drm_err(dev, "No supported colorspaces provided on [CONNECTOR:%d:%s]\n",
 			    connector->base.id, connector->name);
 		return -EINVAL;
 	}
 
 	if ((supported_colorspaces & -BIT(DRM_MODE_COLORIMETRY_COUNT)) != 0) {
-		drm_err(dev, "Unknown colorspace provded on [CONNECTOR:%d:%s]\n",
+		drm_err(dev, "Unknown colorspace provided on [CONNECTOR:%d:%s]\n",
 			    connector->base.id, connector->name);
 		return -EINVAL;
 	}
-- 
2.30.2

