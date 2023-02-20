Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9700069C918
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjBTK46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjBTK44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:56:56 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B724A1ADC0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 02:56:36 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id qi12-20020a17090b274c00b002341621377cso772662pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 02:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YJcv8LUYaIlwAg857IbZtsnq5/e4cQ1o9TdJmssUG8Q=;
        b=CIOog46F7QdVSNDWN9y9Cgbs11r+Oa8oNbTRDNTRJ4J/LBXhMous8r3W/s28/Ip1Mb
         VHZzkQXRlaNnJ2v++qDD6gvoZkdhq4s71XKZSr5H2DHgjXikzujGmZ9UIV1ZybIfGgV1
         tSaLaqKxY8PUqIS/nbTn7jGXoiTZwcXEfdIW74mg+wMOj9JDBmN7Gzn9QXScJKsl1sRh
         uuZ2JsrV3PulYVqH8zULrw1+gSZyUPLN/izs4hzvSnG74ltz+sKDrcp+iv4y1kJuxJNE
         3bCv5Z0e9UoP8NwkW+k982RrVPs5upZR9fK/aLyXPXNUbL/WzWXJFo/oGwosaZYUfqfG
         HUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJcv8LUYaIlwAg857IbZtsnq5/e4cQ1o9TdJmssUG8Q=;
        b=EBV+nQoxC9woStKMF+DFJODCApz9aUXgEzztWHKR1vI+8RU90j1PTHJ4LlKX/5RCPu
         Ikolv2BvXD9D9IODXtlnTma8tzxzbJ0qGTLtipung3ONA7Pr3NWRRB9QyIOmWFHQokQZ
         QQRyDhTgPLmesm+aBHnpFlq8DEgOnKYGuUMQqnCZ6phEzfG4R9UKfzx6KGBa7o7K0saR
         a1hgeikej/aSDawfbkO2Hi92GgVycjSQCebPKsjhCvbi6JQYfjXAdUmqrtydnWcOxhpf
         /Vs66HedUOUpwEmvEkDNnazcSb2BEHuAdDX7m4i/ZISfi+EjWu6XkBdqu6YCA1g9GKve
         Vkaw==
X-Gm-Message-State: AO0yUKWbrymXi7s1lYrsTAQIcJM+RmDffSwFAgmramBoZ6Hi+AevLQmJ
        b3vp+NNeocIAOObZYyL4Suy1ew==
X-Google-Smtp-Source: AK7set/MvDUDrnXAMhWcLAWJyNvOiTLdmkM+oYpvdgksiKjJUNDfGXGy3iLoQNnpQ8zMj4DXN4XS2A==
X-Received: by 2002:a05:6a20:8412:b0:c6:b962:dd08 with SMTP id c18-20020a056a20841200b000c6b962dd08mr864432pzd.13.1676890595770;
        Mon, 20 Feb 2023 02:56:35 -0800 (PST)
Received: from alpha.. (122-117-179-2.hinet-ip.hinet.net. [122.117.179.2])
        by smtp.googlemail.com with ESMTPSA id n64-20020a632743000000b004fbd533fea2sm1870315pgn.52.2023.02.20.02.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 02:56:35 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: max597x: Fix error return code in max597x_get_status
Date:   Mon, 20 Feb 2023 18:56:14 +0800
Message-Id: <20230220105614.356187-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

REGULATOR_FAILED_RETRY should not be used in max597x_get_status error path.
Othewise, the regulator core will treat it as REGULATOR_STATUS_ON.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/max597x-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/max597x-regulator.c b/drivers/regulator/max597x-regulator.c
index f0fb0f56e420..648e3641885a 100644
--- a/drivers/regulator/max597x-regulator.c
+++ b/drivers/regulator/max597x-regulator.c
@@ -193,7 +193,7 @@ static int max597x_get_status(struct regulator_dev *rdev)
 
 	ret = regmap_read(rdev->regmap, MAX5970_REG_STATUS3, &val);
 	if (ret)
-		return REGULATOR_FAILED_RETRY;
+		return ret;
 
 	if (val & MAX5970_STATUS3_ALERT)
 		return REGULATOR_STATUS_ERROR;
-- 
2.34.1

