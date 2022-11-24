Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FA8637D09
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 16:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiKXPbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 10:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKXPa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 10:30:59 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7248CB2204;
        Thu, 24 Nov 2022 07:30:57 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ud5so4908090ejc.4;
        Thu, 24 Nov 2022 07:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gLpOQFyv43x+gsdGRezusBMfoHWe+be0UwpYAvtMKbs=;
        b=czchCmsY/APqH5hCblPcH0XTjeKai6phl0U1bvNnUZrvrwXEDWFA3sXcC/8tdp3Ohx
         HHlOfyKnbwua46+Q+PN5JQuJC7b2mAX25dCxWNnI2wU3Sk7wDONiXV2y35vjr2GB3Hx+
         Qq2kW0+E+8sc2/gnwCA/zQkV0Ummzs8KrQ0H1a80T/yTZqnvOGiosijxKnC1Cug96dxG
         V3sx3nQJFn9o8ovtbPjQWZI/+l4tzXmbn5+WZ6XjVkvt0ljGDHOZQFF6WstqaPTx0PtI
         wAsVUQ80S4YSuknsANlxyENSy+P+LRzOU6usVY1sezZONIJaey0l2TYiAvf/5xXtLBVa
         Mneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLpOQFyv43x+gsdGRezusBMfoHWe+be0UwpYAvtMKbs=;
        b=zGLYeOFsRoQpKrc0+9lVu80Hne1R/3KkaITK5VHMAX6C6/1acAblhDs9hO3SgLsN6v
         9Qw/jKWY+c+FBijP2Wir3onrIsbWWX4qTVIjTDKJ0hsgoOy+m9h2VeZhSfOFi2Bi/tmo
         qs2CvUYp1I85jpHNxm4zgfpmvtYdOaSE3Mtijk8gWzqqRIgTSVyE54Tz8uP92OkTZawJ
         hvv2jQyF5F4OP2kQPgtcVrXyl9006T3tr8BrM0XSFW9lrGDOqSeW/6CHmM3kP/RhiwrF
         L9WBTQFplehL5cb18osv3p4QF/yUT4lqHCM7fCgI5gHpsLCFDwvbWTIEoIZUHV+LOmkv
         C0yA==
X-Gm-Message-State: ANoB5pmivFuDax7SyMj/TWKhRUCOt8pqWr0cnWJz1krXLVdpSCiqEyZB
        pCtLpBa0lHV6VPsq6MoRHWA=
X-Google-Smtp-Source: AA0mqf6Agx8tZhSjJfA1nk58eghkuWk7G6SREIslZc7eZOrEIUVKExqHdLFBWIHu66OwTCcFvjx79Q==
X-Received: by 2002:a17:906:ca2:b0:7b9:eef3:4435 with SMTP id k2-20020a1709060ca200b007b9eef34435mr6488715ejh.696.1669303855988;
        Thu, 24 Nov 2022 07:30:55 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.13.177])
        by smtp.gmail.com with ESMTPSA id mj22-20020a170906af9600b007ba705f8f90sm539377ejb.79.2022.11.24.07.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 07:30:55 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: addac: ad74413r: fix blank line after declaration warning
Date:   Thu, 24 Nov 2022 17:30:49 +0200
Message-Id: <20221124153049.8851-1-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch wants a blank line after all declarations. Add it now,
even though the patch has already been submitted.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
Fixes: 7b2366008125 ("iio: addac: ad74413r: add spi_device_id table")
---
 drivers/iio/addac/ad74413r.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index 61030053cbea..f32c8c2fb26d 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -1315,6 +1315,7 @@ static int ad74413r_probe(struct spi_device *spi)
 	st->chip_info = device_get_match_data(&spi->dev);
 	if (!st->chip_info) {
 		const struct spi_device_id *id = spi_get_device_id(spi);
+
 		if (id)
 			st->chip_info =
 				(struct ad74413r_chip_info *)id->driver_data;
-- 
2.38.1

