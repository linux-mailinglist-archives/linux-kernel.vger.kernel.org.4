Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD036E9D13
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 22:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjDTUXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 16:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjDTUWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 16:22:55 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3105249C7;
        Thu, 20 Apr 2023 13:22:37 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5066ce4f490so1229768a12.2;
        Thu, 20 Apr 2023 13:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682022155; x=1684614155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CydptxKkm22NUNjkNivJRkww6tHUqJf95wdwrAx7jU=;
        b=qeZdazHXe++2TOz6hvvgwzCsDzhhk45FRYs2NVtXMhGJ4HQz3A+AAdQuLlhfx+ek0Q
         zEMT2iZhflT0Q4z/sJUxzhEsmcUF9BzftQGVPF4n4v3pZMZ//P1UnjtOWTdOJB9khQqX
         Hn9Q500M1/alx6dfRks6T16p5Q/O81egJtUc/YIdkJ67rVvA4Tezoh42D/0FJHxwMBLC
         RIUjbBuvPhNJxJ3JWUypcla+jkJ+KFZW1x1HzNFi59O/p/5SICqJY2uhnf/0H+DxsAOq
         gibIKpIXRuXoDfXZaFrekhy+SLs6UMsmPIVhY6+cnMsx3wDB7xl68wdfUGXfuVTucZio
         Wdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682022155; x=1684614155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CydptxKkm22NUNjkNivJRkww6tHUqJf95wdwrAx7jU=;
        b=TWW+EQOzdZVLj007/Z/JLi1K6wHoDvzfH2aZd97o9qniiifWJLeOzlHwJhwu5Bv9Pj
         O18CfLGtozTzl1E6o1TjI5VzXO+oI5K2MmlwCIDyDvq6zTwslaQeLGACLaelmTkd9Txo
         y35QGPWYhUCJ+66NlCSm3Za0zZEj6XoGnnXJ7/7uL4u31h/vg5DFd+Tj+0PcB5N1xaCi
         cij7V8XxdjfHHUexaUQiDympweXe3R3ywsxwGOdv8ZGds3Bgg7yOalIjRO20X/tfvh51
         uLCFndBqX74hdlpNIjdr+d59BBcP7QQQuREApzOwvg75rYQn1abmq45099PnWNGKdKmj
         xJfA==
X-Gm-Message-State: AAQBX9dG/AOXxmevSP4cP2hfewLuzojxnwRNaib15qVIkuJCCDVjc18h
        QggSkfaqxJ0GpWoACyf9NP6cD3r88UQ=
X-Google-Smtp-Source: AKy350YT5VdPyi9/69jD0KFM51ldl/psBXlTJGPTE7c+rEfzMkolJTUpTUrwk7dvGHI/sHlM4HQz1A==
X-Received: by 2002:a05:6402:53:b0:506:be49:243a with SMTP id f19-20020a056402005300b00506be49243amr2931571edu.15.1682022155559;
        Thu, 20 Apr 2023 13:22:35 -0700 (PDT)
Received: from carbian.fritz.box ([2a02:8109:aa3f:ead8::d7e8])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090676ce00b00932ba722482sm1136881ejn.149.2023.04.20.13.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 13:22:35 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v2 2/5] iio: accel: kionix-kx022a: Warn on failed matches and assume compatibility
Date:   Thu, 20 Apr 2023 22:22:02 +0200
Message-Id: <b6cb3d48ab9e4177b924b18e27487f8ef763dfd6.1682019544.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1682019544.git.mehdi.djait.k@gmail.com>
References: <cover.1682019544.git.mehdi.djait.k@gmail.com>
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

Avoid error returns on a failure to match and instead just warn with
assumption that we have a correct dt-binding telling us that
some new device with a different ID is backwards compatible.

Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
v2:
- no changes, this patch is introduced in the v2

 drivers/iio/accel/kionix-kx022a.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index f98393d74666..70530005cad3 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -1038,9 +1038,7 @@ int kx022a_probe_internal(struct device *dev)
 		return dev_err_probe(dev, ret, "Failed to access sensor\n");
 
 	if (chip_id != KX022A_ID) {
-		dev_err(dev, "unsupported device 0x%x\n", chip_id);
-		return -EINVAL;
-	}
+		dev_warn(dev, "unsupported device 0x%x\n", chip_id);
 
 	irq = fwnode_irq_get_byname(fwnode, "INT1");
 	if (irq > 0) {
-- 
2.30.2

