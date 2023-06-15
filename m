Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57553731C93
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 17:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345256AbjFOP1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 11:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345188AbjFOP0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 11:26:53 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0988813E;
        Thu, 15 Jun 2023 08:26:51 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686842810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YnpK8aRuMvnC0Ke7Gmvf/IJzrUVS+kKViuz7i3kW6rw=;
        b=GrzUTB4Ms1R/yqUOktJimCglbYJw7y2SlJeIBpYQ8rcmPZcYb9s9Osp58fj+mLBrqLEAwF
        yueMq/4hRn+Sc64jr/R4EkcV3kReKZP4Q7onPs4c7r/iQidiTFARIHB6C2rNP//0nU7rFt
        zClN9mKjjBMMvgZnNgI2tOvJhfqBMAzhNeBinkHWfrFcLtFKaYETgsssRgK3Ez3VYJFT2J
        51LZTW2FRvCl+g+HxljyjJMgAQWeH0ulapIoWyyax/E36Oft0VfBju721b+vMnr8/YXvnn
        r4johgdvKhq/Br7gyokdTssJLnkl3V5oE6MXp8W9DEYWSIml+rxlUb+kI0/pqA==
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 4B0C6FF80D;
        Thu, 15 Jun 2023 15:26:49 +0000 (UTC)
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 09/13] iio: inkern: Replace a FIXME comment by a TODO one
Date:   Thu, 15 Jun 2023 17:26:27 +0200
Message-Id: <20230615152631.224529-10-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230615152631.224529-1-herve.codina@bootlin.com>
References: <20230615152631.224529-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This FIXME comment is more a TODO one.
It is a note when someone will need for this currently unsupported case.

Change from FIXME to TODO.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/inkern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 8bfd91f74101..19ddd77adb11 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -879,7 +879,7 @@ static int iio_channel_read_max(struct iio_channel *chan,
 			*val = max_array(vals, length);
 			break;
 		default:
-			/* FIXME: learn about max for other iio values */
+			/* TODO: learn about max for other iio values */
 			return -EINVAL;
 		}
 		return 0;
-- 
2.40.1

