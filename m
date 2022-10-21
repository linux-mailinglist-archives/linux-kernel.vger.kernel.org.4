Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F154607111
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 09:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiJUHa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 03:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiJUHau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 03:30:50 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AAA21F951;
        Fri, 21 Oct 2022 00:30:48 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id h185so1811099pgc.10;
        Fri, 21 Oct 2022 00:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cA0JuBcMGJcSgHH3GujJWpGTkEiW9E55Zi7SMvV9234=;
        b=BrnObNRKZwd5rs7Sf1T5Z9/GYg8E7MKhCX0cAkPgwS0B9xXxV9ogNGpbnXH9GAAOv5
         qOyIY4ftukfxVxFpqdhzSs5/AsifL4MQHumR9rsmlT72Y/YVP/tFPsZiPqisP9LOufwg
         jd7rLv907DZwWH59Qbh60LBwiKhg3VahjohIuUsHe1kwy4DnMoeEgNqGYrmkuBnGUjxm
         vcXVaS1JomPEg4Yfflch7v2j1NYRcDHdE/NTnopEGO/t5GnF6yHRwfLKO5Cg0A/Pfj9R
         0loMmhSmFdc8yc51IKpUqroGqP1Uv5Ckn6iL/h9SpbSdoYjAPw4ns1qt6nm2UKBptiV1
         T1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cA0JuBcMGJcSgHH3GujJWpGTkEiW9E55Zi7SMvV9234=;
        b=3k/MwSl6UxplqGaA7z+GYPMkRq3HBp4Jj5AIFJky5/mLISIpoNGaW0CaVsuiNc+89q
         Mck47aao4EqdhbXdzzyy240GzRjdRqdn74cIHdwY6i0sCqxo27fjjoKRH16NCf1GnZIl
         dEAVjkP/5hNVTQGgcKC9vVdq3Ter6ol4CgTy0VaSP23P7BPV+5DFGNc2msgrDE7sTJY2
         Y6Wjd3LXo9P5N6zvglHHSL9nzRzHYfL9x3DIwdfstb+5H2Q2SydpBofh0uEtv/aZK3tB
         70Hzt5/ItWlh94GT1QId1u6Xj0j8zRIA21l8E8kRpbymG3vg8Bpm4W+ZrQUWHuXBRjAJ
         Qxtg==
X-Gm-Message-State: ACrzQf1R9IrqquujmDcD8JPngp9HXT3s7mrjjA0mAn6n9BbDhRZP6leh
        zckd9Res/eaaX1D9DQEXLeE=
X-Google-Smtp-Source: AMsMyM6o2yiqJQIjkQHFbVPMj4tu1xPLeexzbZxzUFPWtcAj15gLFKafSX8RpMThdU8AvRYNElm5Xg==
X-Received: by 2002:a62:1dcc:0:b0:567:6e2c:4810 with SMTP id d195-20020a621dcc000000b005676e2c4810mr14416183pfd.44.1666337448421;
        Fri, 21 Oct 2022 00:30:48 -0700 (PDT)
Received: from xm06403pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id d4-20020a62f804000000b005628a30a500sm14531929pfh.41.2022.10.21.00.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 00:30:48 -0700 (PDT)
From:   Wenchao Chen <wenchao.chen666@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, axboe@kernel.dk, avri.altman@wdc.com,
        kch@nvidia.com
Cc:     CLoehle@hyperstone.com, vincent.whitchurch@axis.com,
        bigeasy@linutronix.de, s.shtylyov@omp.ru,
        michael@allwinnertech.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, megoo.tang@gmail.com,
        lzx.stg@gmail.com
Subject: [PATCH V2 1/2] mmc: block: Support Host to control FUA
Date:   Fri, 21 Oct 2022 15:30:24 +0800
Message-Id: <20221021073025.18831-2-wenchao.chen666@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221021073025.18831-1-wenchao.chen666@gmail.com>
References: <20221021073025.18831-1-wenchao.chen666@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenchao Chen <wenchao.chen@unisoc.com>

This patch introduces host->fua_disable for MMC host controller.
The host can turn off FUA to improve performance.

Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
---
V1 -> V2
Address Chaitanyak's suggestions
Address Avri's suggestions
---
 drivers/mmc/core/block.c | 3 ++-
 include/linux/mmc/host.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 54cd009aee50..333e819e077a 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2490,7 +2490,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	    ((card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||
 	     card->ext_csd.rel_sectors)) {
 		md->flags |= MMC_BLK_REL_WR;
-		fua_enabled = true;
+		if (!card->host->fua_disable)
+			fua_enabled = true;
 		cache_enabled = true;
 	}
 	if (mmc_cache_enabled(card->host))
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 8fdd3cf971a3..16a5bee3eeae 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -517,6 +517,9 @@ struct mmc_host {
 	struct blk_crypto_profile crypto_profile;
 #endif
 
+	/* Host FUA support */
+	bool			fua_disable;
+
 	/* Host Software Queue support */
 	bool			hsq_enabled;
 
-- 
2.17.1

