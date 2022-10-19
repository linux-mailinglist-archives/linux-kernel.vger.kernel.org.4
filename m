Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69DB60380A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 04:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiJSC0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 22:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiJSC0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 22:26:25 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200FF67050;
        Tue, 18 Oct 2022 19:26:25 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d24so15611365pls.4;
        Tue, 18 Oct 2022 19:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5kRp6+wZV1IqSqFh++86bvcEQ1KvLXlLFzw/1FVTp/s=;
        b=ePi9xYJTX3A3TZ2Ce0XHItekJJRd3/bUb2Pd5HrzAZSPf8XnuSMUhJwh6QFgMDiDj3
         xEIVzwXU5JCxUA479sNxUE9bs1rmVFPRIOqhucxY3R+C02VKU56UkRMgO11rezqkrWwB
         Vl+v6MvZF8g2TmS46D6dpmKdGGLvxXm/i4lIilVpREAUi0ijebfSDIVSvWKS7iunpykV
         Ct8w+CsYB9YEejaEAl8JGIwrIumLVpZePDrRFJj5xXeBMop3XFu/XcoA4zadqZHa8+1i
         gQ/RhnCZOLweYsRSaheXg9F/wOpoVX6SQQO4580UNfHkueIOEZMBuYyVxL4/bKA/QzWP
         vDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5kRp6+wZV1IqSqFh++86bvcEQ1KvLXlLFzw/1FVTp/s=;
        b=gDMm/aQoDGm09nuo58/VwRGQ7wssm3R+toDQPvDcKTrvDq+oBuRGJ1dEdfFwaV8kok
         pkrmg4mbEerr2gYkP6hlO7gPpZuMrpfJYAGuS7bc3jJVlkvuktO/tuU8kxyAN1Bhb1GB
         uDFdtCQf3KNL9Ip+bciKCilFIF1DKwWZu3GCa4vhTNFgqahvPEAM/XZdqnr/eLdIYGLO
         fNk8AvQP2SZlzguiw8EbpnstZe8BHzZDZBRr7iF5xXhDF0mSMUIk7F/tyYpmbrvS2LPJ
         Sfi5PiTVryRSQo16ajG0i0n2uhX/ErjcwAgX/VktvfE6zOoBhTS3GJrG4Lq1a2p3AJpU
         8rpg==
X-Gm-Message-State: ACrzQf0FEsFT3hakSW1TAVKcAV0CLS6OD1GF/BBu805x/2pLXrycF3w6
        STml3IDcdtL5yiH5kW/jvQ==
X-Google-Smtp-Source: AMsMyM4/dKAosvd2TaUt6XLPMdm1hZnUkKFJaR0jJ5IKsXTd1RiHwR5aswCA89y5ssxaOW7JH4oJ3g==
X-Received: by 2002:a17:902:bcc4:b0:181:899a:ac9c with SMTP id o4-20020a170902bcc400b00181899aac9cmr5981080pls.124.1666146384720;
        Tue, 18 Oct 2022 19:26:24 -0700 (PDT)
Received: from localhost.localdomain ([106.104.115.142])
        by smtp.gmail.com with ESMTPSA id x185-20020a6263c2000000b00562a526cd2esm9855880pfb.55.2022.10.18.19.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 19:26:24 -0700 (PDT)
From:   chengwei <foxfly.lai.tw@gmail.com>
X-Google-Original-From: chengwei <larry.lai@yunjingtech.com>
To:     lee@kernel.org, broonie@kernel.org, rafael@kernel.org,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        chengwei <larry.lai@yunjingtech.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>
Subject: [PATCH 2/5] regmap: Expose regmap_writeable function to check if a register is writable
Date:   Wed, 19 Oct 2022 10:24:47 +0800
Message-Id: <20221019022450.16851-3-larry.lai@yunjingtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221019022450.16851-1-larry.lai@yunjingtech.com>
References: <20221019022450.16851-1-larry.lai@yunjingtech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose the regmap_writeable function for pinctrl-upboard reference.

Signed-off-by: Nicola Lunghi <nicola.lunghi@emutex.com>
Signed-off-by: chengwei <larry.lai@yunjingtech.com>
---
 drivers/base/regmap/internal.h | 5 -----
 drivers/base/regmap/regmap.c   | 5 +++++
 include/linux/regmap.h         | 6 ++++++
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index da8996e7a1f1..eec477755a5c 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -190,11 +190,6 @@ struct regcache_ops {
 	int (*drop)(struct regmap *map, unsigned int min, unsigned int max);
 };
 
-bool regmap_cached(struct regmap *map, unsigned int reg);
-bool regmap_writeable(struct regmap *map, unsigned int reg);
-bool regmap_readable(struct regmap *map, unsigned int reg);
-bool regmap_volatile(struct regmap *map, unsigned int reg);
-bool regmap_precious(struct regmap *map, unsigned int reg);
 bool regmap_writeable_noinc(struct regmap *map, unsigned int reg);
 bool regmap_readable_noinc(struct regmap *map, unsigned int reg);
 
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index fee221c5008c..182536fcce46 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -100,6 +100,7 @@ bool regmap_writeable(struct regmap *map, unsigned int reg)
 
 	return true;
 }
+EXPORT_SYMBOL_GPL(regmap_writeable);
 
 bool regmap_cached(struct regmap *map, unsigned int reg)
 {
@@ -123,6 +124,7 @@ bool regmap_cached(struct regmap *map, unsigned int reg)
 
 	return true;
 }
+EXPORT_SYMBOL_GPL(regmap_cached);
 
 bool regmap_readable(struct regmap *map, unsigned int reg)
 {
@@ -143,6 +145,7 @@ bool regmap_readable(struct regmap *map, unsigned int reg)
 
 	return true;
 }
+EXPORT_SYMBOL_GPL(regmap_readable);
 
 bool regmap_volatile(struct regmap *map, unsigned int reg)
 {
@@ -160,6 +163,7 @@ bool regmap_volatile(struct regmap *map, unsigned int reg)
 	else
 		return true;
 }
+EXPORT_SYMBOL_GPL(regmap_volatile);
 
 bool regmap_precious(struct regmap *map, unsigned int reg)
 {
@@ -174,6 +178,7 @@ bool regmap_precious(struct regmap *map, unsigned int reg)
 
 	return false;
 }
+EXPORT_SYMBOL_GPL(regmap_precious);
 
 bool regmap_writeable_noinc(struct regmap *map, unsigned int reg)
 {
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 7cf2157134ac..4bfa681805cb 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1225,6 +1225,12 @@ void regcache_mark_dirty(struct regmap *map);
 bool regmap_check_range_table(struct regmap *map, unsigned int reg,
 			      const struct regmap_access_table *table);
 
+bool regmap_cached(struct regmap *map, unsigned int reg);
+bool regmap_writeable(struct regmap *map, unsigned int reg);
+bool regmap_readable(struct regmap *map, unsigned int reg);
+bool regmap_volatile(struct regmap *map, unsigned int reg);
+bool regmap_precious(struct regmap *map, unsigned int reg);
+
 int regmap_register_patch(struct regmap *map, const struct reg_sequence *regs,
 			  int num_regs);
 int regmap_parse_val(struct regmap *map, const void *buf,
-- 
2.17.1

