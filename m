Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE0A62085B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 05:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbiKHEl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 23:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbiKHEls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 23:41:48 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87B5E0C5;
        Mon,  7 Nov 2022 20:41:46 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id io19so13130496plb.8;
        Mon, 07 Nov 2022 20:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1LhW8LVwSoxQQpyW4009bvl9o+iGdIJ8EYui4FeN5lI=;
        b=JrLTnqEqQQX/olx97uyFYEYYUbQ36qk5VkyCuZyuuWn1R7J3wu+34ybKhjRzMLHpkK
         SLYbJcs9eIRjjJmcIfRkwNgdkz/j98i7O1M2SL0VB8dHybCDB7FgWk32NbOPFCD3LOpf
         xTbXcCVQ6J1hJ9CQgnf8YLZQlKaACiv/VX+iAnPD/iL/0nnjzqyM7jorrphS2C3j5rsV
         W9ZWnrLfcasVe1qsmIqxMfUtyNb4e8wGiVo6tzHOE9t49CmEKZP3m4JR2CtX9tI6wkqo
         WOqvpRjODd2B1RADPzMGK8q0DyHrNxzgd2RTkFe8W1rXXGhYEbv/UjzGnmNJClev36Qi
         CDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1LhW8LVwSoxQQpyW4009bvl9o+iGdIJ8EYui4FeN5lI=;
        b=evA+SMW1RbiuujN1jMf5EK3kB3WJqnqX9w1vuFTYzJ3pUVdmTlSuF8EieSdTLNOIT0
         Amg6F00wSufSkYG2iQtW8QYciwM9ps78uy/TzNN/bx63O2sUYdYC0XmXaORlxmhOk2y/
         PKRPyjslC0eMi6Wr7QX7GcXZ2dZL0mLJyFRZlBP5gs/oRs3OKEK6+rAkzL5IbL7PejKi
         mcYFYquPE0gjWUMHVVnnc7OAHwAbIf8bZBbRIlAbrmzwN8/b9XnFp+YDt1D2++Ur8Plq
         GtSPSwzNuWLlnEmtAlBuZjdwDCQb1tizp5YlOU6eron9Os7DRf9rweeoyGN5TEZGokO5
         7+lQ==
X-Gm-Message-State: ACrzQf3+O5Z+dbIadr7Ys/aSigrAcxPj2WomMn6k4S+/m8h4jwUVk6zm
        dRdr/dthPtZKcxCvbe8Iok5VesWd9N8=
X-Google-Smtp-Source: AMsMyM7L1FtirDOVqJjIsUVZ7WCVdzk4jypU9W5LWPfUxEa7dwpdnbp8zexf2QhSOS+ruG6K0QT3zg==
X-Received: by 2002:a17:90a:c7c7:b0:20a:db08:8a8a with SMTP id gf7-20020a17090ac7c700b0020adb088a8amr913509pjb.141.1667882506250;
        Mon, 07 Nov 2022 20:41:46 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:fb10:b5b0:232e:4afb])
        by smtp.gmail.com with ESMTPSA id y11-20020a1709029b8b00b00178b6ccc8a0sm5810357plp.51.2022.11.07.20.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 20:41:45 -0800 (PST)
Date:   Mon, 7 Nov 2022 20:41:42 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] drm/tegra: switch to using devm_fwnode_gpiod_get()
Message-ID: <Y2neBkfe6b+MzQGa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_gpiod_get_from_of_node() is going away and GPIO consumers should
use generic device/firmware node APIs to fetch GPIOs assigned to them.
Switch the driver to use devm_fwnode_gpiod_get() instead.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Marked as "resend" since the contents of the patch are the same (however
I did update the description a bit).

 drivers/gpu/drm/tegra/output.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tegra/output.c b/drivers/gpu/drm/tegra/output.c
index 47d26b5d9945..a8925dcd7edd 100644
--- a/drivers/gpu/drm/tegra/output.c
+++ b/drivers/gpu/drm/tegra/output.c
@@ -133,11 +133,11 @@ int tegra_output_probe(struct tegra_output *output)
 		}
 	}
 
-	output->hpd_gpio = devm_gpiod_get_from_of_node(output->dev,
-						       output->of_node,
-						       "nvidia,hpd-gpio", 0,
-						       GPIOD_IN,
-						       "HDMI hotplug detect");
+	output->hpd_gpio = devm_fwnode_gpiod_get(output->dev,
+					of_fwnode_handle(output->of_node),
+					"nvidia,hpd",
+					GPIOD_IN,
+					"HDMI hotplug detect");
 	if (IS_ERR(output->hpd_gpio)) {
 		if (PTR_ERR(output->hpd_gpio) != -ENOENT)
 			return PTR_ERR(output->hpd_gpio);
-- 
2.38.1.431.g37b22c650d-goog


-- 
Dmitry
