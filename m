Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60286EC6D3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 09:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjDXHMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 03:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjDXHL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:11:56 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DCDA0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 00:11:55 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id qqMbpbWv0mfq9qqMbpYclq; Mon, 24 Apr 2023 09:11:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1682320314;
        bh=7YBvMG+Q90cl5k9Iz9PAi2dEYCl89Sqol9+/WdhaNKA=;
        h=From:To:Cc:Subject:Date;
        b=M6DhZrCqx+oL4E15ADIyF/2+Hqzc/ZpQoMI0P5KC/uD2yf59MNBOZYgCIADvJDZ7H
         iA8FlWK9GCGIDXL78ZFfP6dYWbSPYH634cW00eJ6l+HQNr5sdUBlyJ9/CV1brjYN1P
         rED44zr34vwdwUR0lokZ5OWZCMqi1w7AdFsPazASl424mrXv9w1UgIVDHH3RjcZYGv
         dNP6UXslTorFMiQmV7xBfg+Lvl4hRoQlIBQJBL0RdYXqIjHPADX3ljuVJ/Ql4qu0z/
         puB6pMvFMWfnPvCbeSkm6djz5VoQPwmwUyS5zmnyO4ExyD5b1kDKM2FibIblc06ZBY
         gaxDOrjXHSoWw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 24 Apr 2023 09:11:54 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: palmas: Remove the unneeded include <linux/i2c.h>
Date:   Mon, 24 Apr 2023 09:11:51 +0200
Message-Id: <9d23cd04d7f99dc8d813584aae5268b57f92fcd8.1682320298.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver does not use i2c, so there is no point in including
<linux/i2c.h>

Remove it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/iio/adc/palmas_gpadc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index c1c439215aeb..42c519504529 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -14,7 +14,6 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
-#include <linux/i2c.h>
 #include <linux/pm.h>
 #include <linux/mfd/palmas.h>
 #include <linux/completion.h>
-- 
2.34.1

