Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040BB607DCF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 19:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiJURoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 13:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiJURoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 13:44:01 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3583B269096;
        Fri, 21 Oct 2022 10:43:55 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so2529793wmb.3;
        Fri, 21 Oct 2022 10:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NEU8OndF59kbblXG+hQ+BOg2go0yv8KTNGgCVDuvgDM=;
        b=l2zjzMuDlZJxiUXAq/qm2EIu5Vy3ixqsFB8S4piAb9a59VZm+MueK9dnMC5OkrcKcK
         OFE7HmsgpfJyWglUAKJteDL3seJuBmMZr7rgwilcXmld4xrxhAwAmk+fSLode2a/TA2X
         37ycOcPc5TrRX3GXZfG0jflNMe6AjVMzYnbHpnwMommSN2XzPBT2ExZxVhjVI19nKHwj
         6nA6yYGlzrpTlZrCdlyir9Ythq0Rv4myRiHPVet4yEsTBQACJsjLV65UclxB54xLl9oy
         zND5yc924M9Fh+67ZS6ZRpzlVgs84yJuXZaKof05xh3m0hFJaTcnN3rKyWzU42vqaQy5
         pqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NEU8OndF59kbblXG+hQ+BOg2go0yv8KTNGgCVDuvgDM=;
        b=kyw/JX+as9aE72cPrQw0UbdUF5x00YHRD0sIPkDCnRSz/pL77AaOsx27ODKBZZ3yz3
         jmWJFL+SUwWyMUFgeZe17D3WZmZ5wQwVHH1kcTgHbVrktKHPoViEWEertaG30dm361M3
         aGsmXgvgOez9xPq9uZK/zp4+MRQOD9xGd2rKfjLG/XgtEhpTjhKJQcJQOvsHhhyI0CIT
         Nz5zJJ6dn/21bLQBOxPUIvFeeFxzlwJrgdGT01fDWjAsWdHqKvR822Biq9jxOCXtmNcx
         BwT0tn0KVQCaVGtjUuwYO8oTL40Q/lstfSG5+hk1j7gJiPpwzbsf1givBtsN0b2Wtp/i
         WRdw==
X-Gm-Message-State: ACrzQf29OfAAJ/WAOMLCIi5103Wa2dJhKzvDb2WgQuNg3gtT7ZUN0Vyp
        4nrJ8jq7X0JGkG3tMsj4om4=
X-Google-Smtp-Source: AMsMyM6yiTDm+02FP3z+iQlsbay9XXQvuxmsQ+eHIDzc3K3wViQo25S1QExdZDw170PICbRhDio5YA==
X-Received: by 2002:a05:600c:4451:b0:3c6:fb65:24cb with SMTP id v17-20020a05600c445100b003c6fb6524cbmr16192541wmn.144.1666374233622;
        Fri, 21 Oct 2022 10:43:53 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m8-20020adfe0c8000000b0022efc4322a9sm19481040wri.10.2022.10.21.10.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 10:43:53 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [media] radio: Remove variable p
Date:   Fri, 21 Oct 2022 18:43:52 +0100
Message-Id: <20221021174352.28290-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable p being deccremented but it is never referenced,
it is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/radio/radio-terratec.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/media/radio/radio-terratec.c b/drivers/media/radio/radio-terratec.c
index 8b8ce2b46a55..621bb8523271 100644
--- a/drivers/media/radio/radio-terratec.c
+++ b/drivers/media/radio/radio-terratec.c
@@ -82,7 +82,6 @@ static int terratec_s_mute_volume(struct radio_isa_card *isa, bool mute, int vol
 static int terratec_s_frequency(struct radio_isa_card *isa, u32 freq)
 {
 	int i;
-	int p;
 	int temp;
 	long rest;
 	unsigned char buffer[25];		/* we have to bit shift 25 registers */
@@ -93,7 +92,6 @@ static int terratec_s_frequency(struct radio_isa_card *isa, u32 freq)
 	rest = freq * 10 + 10700;	/* I once had understood what is going on here */
 					/* maybe some wise guy (friedhelm?) can comment this stuff */
 	i = 13;
-	p = 10;
 	temp = 102400;
 	while (rest != 0) {
 		if (rest % temp  == rest)
@@ -103,7 +101,6 @@ static int terratec_s_frequency(struct radio_isa_card *isa, u32 freq)
 			rest = rest - temp;
 		}
 		i--;
-		p--;
 		temp = temp / 2;
 	}
 
-- 
2.37.3

