Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF12638F17
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 18:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiKYRcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 12:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiKYRcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 12:32:01 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A3252167;
        Fri, 25 Nov 2022 09:32:00 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z20so7237049edc.13;
        Fri, 25 Nov 2022 09:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BS344EZ01Swu2ynnOXhwyOBzth0IMIZXcxGTSI686xc=;
        b=XpcMQbiaFOJya7+qzk3tnkNJAE8KKxSFEXhrvtyFqav0cioW2lMSpRfguFb7I1aa4A
         lioHIqrmVRCYOUMFDWf61SAhSWxCIGfwgQfMjs0y6N5bBm9vjb2ts1xUJfKQ8//WATah
         LmIBVB9FqZj3yoLKuSrquIe4J+0V3dbXwcjlumFQLphwRAVsCq6R605AIPJbzLdJrxJ6
         P35u+du2aQakbPkN+M3/6G5t3Of8Hz/K74V3T4/3G75B9m1K8ssYpciBhJsAji53S0K5
         9tOFtdLxxEXfDWS1/UuOv02+0L3ZGjs+EEh/lWKaaxX67keIAIVQKW7iF6GQrF4+gElx
         ZmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BS344EZ01Swu2ynnOXhwyOBzth0IMIZXcxGTSI686xc=;
        b=o4Pu6wATt82WTs9xFMTAWHX5lPX94/D1N9BVzymdPIee8qg1Jejot0HgneZhrS03ka
         5+uGDpOBTtdu4rjW0gZPDQ4ccI2hV2sCaxl2jEHlv1ii3Z+ub1a2mLSOxheWpmm+NIml
         1MQMQgw1hStefuIVkV+iXpB7cJeNj5JswNyNW3SJ18kPmle6XOfTDKMA1UHYTWx96cRV
         NYFtopHBLjQcm4vD7Yf2EJ0CWY/aR3o2KwrUKMl3l09ELyLzv675yiY5T5ru6upKDl5P
         3fQCUTZRtm0YS0YkkkR8MVmKbGF/zbZ0MvdIu+CE/xYJpXpPApq7Py8KMNsDaNJhGbHg
         RQhg==
X-Gm-Message-State: ANoB5pnfPckZjDGbBxiEB/umywXLddOfFojyom/ILTo5T3vRJXm6e7h3
        TCVxn2uk5Y4lFhGfMacFVhE9d+fM9NZ/Hw==
X-Google-Smtp-Source: AA0mqf4izwakw2gafJPDqWGogXbrDNIRO5y3QcetsRjPQBUysZcYUXpN2rDFH3P7EnbYBJUJ5FfGXw==
X-Received: by 2002:a05:6402:1a28:b0:469:7546:60fe with SMTP id be8-20020a0564021a2800b00469754660femr21831195edb.408.1669397519015;
        Fri, 25 Nov 2022 09:31:59 -0800 (PST)
Received: from [192.168.178.2] (dslb-092-072-004-196.092.072.pools.vodafone-ip.de. [92.72.4.196])
        by smtp.gmail.com with ESMTPSA id j9-20020a1709066dc900b007ba46867e6asm1823024ejt.16.2022.11.25.09.31.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 09:31:58 -0800 (PST)
Message-ID: <f5668d69-806a-f8c6-5279-7e84b824bd7a@gmail.com>
Date:   Fri, 25 Nov 2022 18:31:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From:   =?UTF-8?Q?Otto_Pfl=c3=bcger?= <affenull2345@gmail.com>
Subject: [PATCH 1/4] drm/mipi-dbi: Support separate I/O regulator
To:     =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI DBI specification defines separate vdd (panel power) and
vddi (I/O power) supplies. Displays that require different voltages
for the different supplies do exist, so the supplies cannot be
combined into one as they are now. Add a new io_regulator property to
the mipi_dbi_dev struct which can be set by the panel driver along
with the regulator property.

Signed-off-by: Otto Pflüger <affenull2345@gmail.com>
---
  drivers/gpu/drm/drm_mipi_dbi.c | 14 ++++++++++++++
  include/drm/drm_mipi_dbi.h     |  7 ++++++-
  2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
index a6ac56580876..047cab93a041 100644
--- a/drivers/gpu/drm/drm_mipi_dbi.c
+++ b/drivers/gpu/drm/drm_mipi_dbi.c
@@ -427,6 +427,8 @@ void mipi_dbi_pipe_disable(struct 
drm_simple_display_pipe *pipe)

  	if (dbidev->regulator)
  		regulator_disable(dbidev->regulator);
+	if (dbidev->io_regulator)
+		regulator_disable(dbidev->io_regulator);
  }
  EXPORT_SYMBOL(mipi_dbi_pipe_disable);

@@ -652,6 +654,16 @@ static int 
mipi_dbi_poweron_reset_conditional(struct mipi_dbi_dev *dbidev, bool
  		}
  	}

+	if (dbidev->io_regulator) {
+		ret = regulator_enable(dbidev->io_regulator);
+		if (ret) {
+			DRM_DEV_ERROR(dev, "Failed to enable I/O regulator (%d)\n", ret);
+			if (dbidev->regulator)
+				regulator_disable(dbidev->regulator);
+			return ret;
+		}
+	}
+
  	if (cond && mipi_dbi_display_is_on(dbi))
  		return 1;

@@ -661,6 +673,8 @@ static int mipi_dbi_poweron_reset_conditional(struct 
mipi_dbi_dev *dbidev, bool
  		DRM_DEV_ERROR(dev, "Failed to send reset command (%d)\n", ret);
  		if (dbidev->regulator)
  			regulator_disable(dbidev->regulator);
+		if (dbidev->io_regulator)
+			regulator_disable(dbidev->io_regulator);
  		return ret;
  	}

diff --git a/include/drm/drm_mipi_dbi.h b/include/drm/drm_mipi_dbi.h
index 14eaecb1825c..e4efbd8ffc9d 100644
--- a/include/drm/drm_mipi_dbi.h
+++ b/include/drm/drm_mipi_dbi.h
@@ -122,10 +122,15 @@ struct mipi_dbi_dev {
  	struct backlight_device *backlight;

  	/**
-	 * @regulator: power regulator (optional)
+	 * @regulator: power regulator (Vdd) (optional)
  	 */
  	struct regulator *regulator;

+	/**
+	 * @io_regulator: I/O power regulator (Vddi) (optional)
+	 */
+	struct regulator *io_regulator;
+
  	/**
  	 * @dbi: MIPI DBI interface
  	 */
-- 
2.30.2

