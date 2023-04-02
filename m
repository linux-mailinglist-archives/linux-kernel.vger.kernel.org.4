Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DB06D37D4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 14:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjDBM3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 08:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDBM3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 08:29:07 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE03E1B6
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 05:29:06 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l12so26638712wrm.10
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 05:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680438545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KuUlpAuMuhV9A7Ol8z+aU98hs8SWlHqvB5/lhugn4Hk=;
        b=T9C2x6tLoLpcxgjAt71Z1h1HV2OyyO+4KCC4rZwqZHTOS0EFN2sAY9SstJJOpPxZMh
         2ES8ZtcnnGdX9ErXt9XZQYpgxFKHGi/NVu4VeNYO65TSbECD3oCOGiy2hV7lC4iM7NCi
         zrB68IVghSucVU3mVASoDP2ry0w8rAkEK7rYvQwp/kbYzo39v3ZU7Hl3KHngMMHRepd7
         ctIdpqh8Pt4zxH9iIbE5Tay4GTj2mieSnizJbqerMZ7wUT86inViLk72TCK0BO+C6e9k
         OhfFsvKaat9f+cg+y1KZlWO8ixy8GeCdX/BMJ9QlA+vQrHnl2GlFLZCvx45QsnuvRR1c
         dlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680438545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KuUlpAuMuhV9A7Ol8z+aU98hs8SWlHqvB5/lhugn4Hk=;
        b=ze+leT19Tcs2spLvFgcq7fpEUyKCCo1Xkf08lmwbg5RzjUEsX5FYtix+pcPcr4xM/W
         6F8bz5GmQB4NJw8FLZXbEMMY2XqyrltSUdgVe7R3sfsvpiGDvCnA+8OqdiXVMQqknmR+
         YlbXLVo0DKOOtIJvXPvp0zvHu58nlg89N3gkCr/CdvvfaOT4l1JEGqESVSRwLCitlCOa
         eDEJlpjP2j8F7iWtaWWlV2iWS7mpUsA5weQuaMI3WItH0/cfaTjtLuGN5pT3alCClmXT
         kTWSxv/98ZNc2xnpM5G6nCBloOyxUYmd5JxccNdFuDbqHSShrmIUcro8znQuXr2C3MR2
         lWMg==
X-Gm-Message-State: AAQBX9fkyglrkZEiHB6UpBDe2urbQqpLwaUVoRLhaNq6az1oePz0YUSZ
        lRLZygb30+9aNq0NOX+XzBU=
X-Google-Smtp-Source: AKy350Zt2LHhRlwXRTSDoWEQjQ4BvMtwoMbyN+POOrEFbySFdw8LOMlkl9O0bDOvllagr3j4Dwnt7Q==
X-Received: by 2002:adf:df11:0:b0:2e4:e6b3:78ca with SMTP id y17-20020adfdf11000000b002e4e6b378camr8297688wrl.70.1680438544676;
        Sun, 02 Apr 2023 05:29:04 -0700 (PDT)
Received: from arch.localdomain ([2a0c:5a82:e403:1200:d6da:3a66:5cd6:7fe8])
        by smtp.googlemail.com with ESMTPSA id d7-20020adfe2c7000000b002d419f661d6sm7202530wrj.82.2023.04.02.05.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 05:29:04 -0700 (PDT)
From:   Angel Alberto Carretero <angelalbertoc.r@gmail.com>
To:     "Bryan O'Donoghue" <pure.logic@nexus-software.ie>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Angel Alberto Carretero <angelalbertoc.r@gmail.com>
Subject: [PATCH] staging: greybus: loopback: fix up checkpath macro do while error.
Date:   Sun,  2 Apr 2023 14:25:51 +0200
Message-Id: <20230402122550.70682-1-angelalbertoc.r@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap macro in a do-while statement.

Signed-off-by: Angel Alberto Carretero <angelalbertoc.r@gmail.com>
---
 drivers/staging/greybus/loopback.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
index d7b39f3bb652..371809770ed0 100644
--- a/drivers/staging/greybus/loopback.c
+++ b/drivers/staging/greybus/loopback.c
@@ -162,9 +162,11 @@ static ssize_t name##_avg_show(struct device *dev,		\
 static DEVICE_ATTR_RO(name##_avg)
 
 #define gb_loopback_stats_attrs(field)				\
-	gb_loopback_ro_stats_attr(field, min, u);		\
-	gb_loopback_ro_stats_attr(field, max, u);		\
-	gb_loopback_ro_avg_attr(field)
+	do {		\
+		gb_loopback_ro_stats_attr(field, min, u);		\
+		gb_loopback_ro_stats_attr(field, max, u);		\
+		gb_loopback_ro_avg_attr(field);		\
+	} while (0)
 
 #define gb_loopback_attr(field, type)					\
 static ssize_t field##_show(struct device *dev,				\
-- 
2.40.0

