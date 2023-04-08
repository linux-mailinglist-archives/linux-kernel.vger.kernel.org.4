Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72426DBBC5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 17:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjDHPRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 11:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDHPRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 11:17:44 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40ED6EF99
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 08:17:39 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id m18so1122817plx.5
        for <linux-kernel@vger.kernel.org>; Sat, 08 Apr 2023 08:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680967059;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQF+x/Vrt5/tZDK+Ca2xiyhVaw4/7AwabkDs9XafNQc=;
        b=dC14lwBJk/GvmKFC7kvGBghySJbumZsqhxJkHsNbfHIdpjv0Xt86lURgbw+aAAXMQG
         yRms8Z5RPom7rI0BB5z87qNfneQKqVcwZmWZirzOqVTgtNfiuNr6Gn51fFe94SJ98iAE
         Q83X5yVHZfvR1fLbaVOE2ENlbgieYQHvLYYFFixp0f4KUGVd5cTY4wk7lhdPW3Qb9VFu
         DNK2ZqLsrj9YfNIk2kasvTBgOtYRDgcsbPGqRxh/LoNEL0fv7txT/+svba4GQT2rHuli
         gmWYOGuEySCLn7/RB8UdOufD544Ed5eUE2HHA5ZlHrV2oyAexLPuFDwbVkMUxIdvZVoN
         +94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680967059;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQF+x/Vrt5/tZDK+Ca2xiyhVaw4/7AwabkDs9XafNQc=;
        b=5ZE8gPYUeRX8F7oNYOBSpqSThzv/MdRAVDaBhQUJJGRC5n2uh+fAwjUBK4evYwPZFo
         8Om7S1JEzYTEjWRC8XT5BiR7MIjCfwSleCwhYe7ffmS66t+yzxugblUYTVtyrY6CN/Zw
         92ABHZ/XmRUb+zix0XZoBTeG/XhB+m3GrzPg4W8x+IzXcltSPwKCLhZ2Flxm4Do/dfaF
         vp4yG2kGvKQRF6dSK7Pg0SRIdL9xqzExUCWodxcNG9CZkRZ2EP6s+6K7mL/pwQ4+BVJa
         qo5NcTRWkFn4xotBRe3CDD/tvMK1oB6vZpHn6VCnVUnwsGoXOB1EXTlcy/PtGI2Ajjvy
         pf3w==
X-Gm-Message-State: AAQBX9dEDyQB6yNms7JNy9ZoBctKXZSf7vX6L2CWqmS3vmaKerlEfc1A
        Vrk6W1pC8D5awWBiUE/r5f0=
X-Google-Smtp-Source: AKy350bG6YqzVinTucwUgGmZ63Ih/GZK8PeehuCsMjGbe4D1GIOiz4GhwHMay9/YVl+iTRxY6QJ1Lg==
X-Received: by 2002:a05:6a20:a91f:b0:d5:9216:9182 with SMTP id cd31-20020a056a20a91f00b000d592169182mr2156753pzb.9.1680967058703;
        Sat, 08 Apr 2023 08:17:38 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d006:70ae:79eb:2282:4b7:7161])
        by smtp.gmail.com with ESMTPSA id n3-20020a62e503000000b0062db34242aesm4852557pff.167.2023.04.08.08.17.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Apr 2023 08:17:37 -0700 (PDT)
From:   Srihari S <sriharisat@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Srihari S <sriharisat@gmail.com>
Subject: [PATCH] staging: rtl8172: Add blank lines after declarations
Date:   Sat,  8 Apr 2023 20:46:23 +0530
Message-Id: <1680966983-11609-1-git-send-email-sriharisat@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add blank lines as reported by checkpatch.pl as below

CHECK: Please use a blank line after function/struct/union/enum declarations

Signed-off-by: Srihari S <sriharisat@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_efuse.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8712/rtl8712_efuse.h b/drivers/staging/rtl8712/rtl8712_efuse.h
index 2e1ea9d..7a49740 100644
--- a/drivers/staging/rtl8712/rtl8712_efuse.h
+++ b/drivers/staging/rtl8712/rtl8712_efuse.h
@@ -23,6 +23,7 @@ struct PGPKT_STRUCT {
 	u8 word_en;
 	u8 data[PGPKT_DATA_SIZE];
 };
+
 /*--------------------------------------------------------------------------*/
 u8 r8712_efuse_reg_init(struct _adapter *padapter);
 void r8712_efuse_reg_uninit(struct _adapter *padapter);
-- 
2.7.4

