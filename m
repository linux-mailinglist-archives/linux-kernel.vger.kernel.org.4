Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF7E73B302
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjFWI7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjFWI6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:58:52 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C742137;
        Fri, 23 Jun 2023 01:58:50 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687510729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/hsiLkhiPhkv1THloCiztKYYIF7LrdRF7qyhpJmA/Ws=;
        b=ONhXLrnBHT9aoyHuwq5KlvouXzbQh+QAmv9J7ceVVSq34ivg6s8qyGIr6i04Sagh36RmE5
        QX5t9pUBXx8h4CQxdlHYVRAdUnpCPiZ7B64oigbrIStqKvmyXOxh4QsLrrg4MvujZFuNaP
        BqfMwsfKiRw7UaBllrYpDvsidpVA5t8euhAHUmC0W4piebJHsAK+XMLIylcD1yi8cbCk1l
        fUpajUGxh2VxZM8U6BfKDYpZmT1NIw+chgYSsMPisZnwSJPEE27cYzbiWk6/kFRs0qWjK3
        JkttD8Dx+vz3+ndT3Ph4yLXVgJZsZrX90UlV3MAc4PdcN/q8wXB1fbwC98NNow==
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
X-GND-Sasl: herve.codina@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 2F61FE0004;
        Fri, 23 Jun 2023 08:58:48 +0000 (UTC)
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
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 05/13] iio: inkern: Remove the 'unused' variable usage in iio_channel_read_max()
Date:   Fri, 23 Jun 2023 10:58:22 +0200
Message-Id: <20230623085830.749991-6-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230623085830.749991-1-herve.codina@bootlin.com>
References: <20230623085830.749991-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code uses a local variable to initialize a null pointer in order to
avoid accessing this null pointer later on.

Simply removed the 'unused' variable and check for the null pointer just
before accessing it.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/inkern.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index f738db9a0c04..ce537b4ca6ca 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -849,14 +849,10 @@ static int iio_channel_read_max(struct iio_channel *chan,
 				int *val, int *val2, int *type,
 				enum iio_chan_info_enum info)
 {
-	int unused;
 	const int *vals;
 	int length;
 	int ret;
 
-	if (!val2)
-		val2 = &unused;
-
 	ret = iio_channel_read_avail(chan, &vals, type, &length, info);
 	if (ret < 0)
 		return ret;
@@ -869,7 +865,8 @@ static int iio_channel_read_max(struct iio_channel *chan,
 			break;
 		default:
 			*val = vals[4];
-			*val2 = vals[5];
+			if (val2)
+				*val2 = vals[5];
 		}
 		return 0;
 
-- 
2.40.1

