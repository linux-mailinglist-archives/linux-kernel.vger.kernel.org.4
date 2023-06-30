Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77571743648
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 09:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjF3H57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 03:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjF3H5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 03:57:50 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66D5170B;
        Fri, 30 Jun 2023 00:57:47 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3128fcd58f3so1793221f8f.1;
        Fri, 30 Jun 2023 00:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688111866; x=1690703866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f1oSNH4YpSoAOwVpPwfuADPnn2NfW9arFUVTEKiYWyk=;
        b=N2XMCwCaALKOeVzeJrSaYu76zsmgVhOIJtjJ0zALu4joYaFV7WzJwCu/HxsORpmEl7
         d1Q0+l8RSQ1cU9R27ej7HtotppJnZtRtHUZXOr5hPPqgVdayy6pM1L/lKjtJWWRj6QV1
         wbtOEkixbqNEDRvcLAcNHr9dzpuPreTMVSdJXemFejz8e0Nr3YiImjzGn5qv0B2VdSk/
         eytpoHVN462AzVpOGYw6jN+8JCaatgC4d1ypMm+zEzysAQNBiR5+LVrumI6oN8BGOyaf
         M5uarZG37vhzcAQJARRlvqP6ehgGt7HW56XAKJgmBMn7p2hTQywiSeK8MOM//4NyXaJ8
         Dbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688111866; x=1690703866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f1oSNH4YpSoAOwVpPwfuADPnn2NfW9arFUVTEKiYWyk=;
        b=QFtGJhv7YN5R/mcx5TzvKADfOWU1R741Kn62JTF8AxhTucWNVcZhz6BmiNlAWI5p45
         ssHAQ7S8am06/GL8GMt4fyu/44zFf98KtHTFSKY1D9WIM31FcRIDTqmPBXZpn5pBWc95
         8fAUIuKnXcq3kk+o9zol0fZb9ExOXA1wkJJVyW/rwhJLiQ7GSDRAuuthOmsockGz0hFz
         vA5QPlHPROVpSNl+R2Palao9xPWCglk8tvrc6nwIsNO2H1BNx4/HcRFXSmxAIbq6TMSg
         J0FIuyUKVR2Tg9BdU5HSjk9QRvOmceQs1ZvEQ8lFHZCWVughcQqn/9d+y0E2y+iYVPd7
         cJNg==
X-Gm-Message-State: ABy/qLZUVnjyhexKAVJMxyA7qvw5Wbcie4y9mxlTp5Tl0gDq3Mb9/gRX
        52s7fR0WP5prwFN0dEZ21uI=
X-Google-Smtp-Source: APBJJlFFxTx9HwQcewwPwSSgJgYcbVqcwRReJ86o0te0HJC6qB3e+yiRKb0fAh3zjLuzaUf0HG4dWw==
X-Received: by 2002:adf:fa88:0:b0:313:ec90:ac23 with SMTP id h8-20020adffa88000000b00313ec90ac23mr1436840wrr.13.1688111865928;
        Fri, 30 Jun 2023 00:57:45 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id a11-20020a056000050b00b003110dc7f408sm17808031wrf.41.2023.06.30.00.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 00:57:45 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] media: wl128x: Fix spelling mistake "Transfered" -> "Transferred"
Date:   Fri, 30 Jun 2023 08:57:44 +0100
Message-Id: <20230630075744.15444-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in a fmdbg message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/radio/wl128x/fmdrv_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/radio/wl128x/fmdrv_common.c b/drivers/media/radio/wl128x/fmdrv_common.c
index b31b7ed60bbe..ca6f09e58e62 100644
--- a/drivers/media/radio/wl128x/fmdrv_common.c
+++ b/drivers/media/radio/wl128x/fmdrv_common.c
@@ -1282,7 +1282,7 @@ static int fm_download_firmware(struct fmdev *fmdev, const u8 *fw_name)
 		fw_data += (sizeof(struct bts_action) + (action->size));
 		fw_len -= (sizeof(struct bts_action) + (action->size));
 	}
-	fmdbg("Transfered only %d of %d bytes of the firmware to chip\n", fw_entry->size - fw_len, fw_entry->size);
+	fmdbg("Transferred only %d of %d bytes of the firmware to chip\n", fw_entry->size - fw_len, fw_entry->size);
 rel_fw:
 	release_firmware(fw_entry);
 	clear_bit(FM_FW_DW_INPROGRESS, &fmdev->flag);
-- 
2.39.2

