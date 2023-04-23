Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044FF6EC32F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 01:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjDWXzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 19:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDWXzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 19:55:44 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE32710E7;
        Sun, 23 Apr 2023 16:55:42 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a814fe0ddeso43789715ad.2;
        Sun, 23 Apr 2023 16:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682294142; x=1684886142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K4dhQ+Vl6Yr6TY/lKeJ/u29Yt2u4QfMPU7QYP0YhBF4=;
        b=kBnTUBlb7sGxwyjR1OH8Jx27X+Q1mvH/36hGFIFPXF1hmT3KNsN+sfKZ7Ru77xZlmr
         3jqvLqrOUNCPBW9+kjYZ7JFPmXzna4OL+UkJ2kQy+iHQhdB8fY/D3x94kTDVPVNJUgKz
         WNXtdkISWY0QQ0/zOogHhBj8XoM6qPMEYYMi8TVk0YOWRtRYILotJY+WRpXeXICs7Alw
         Hbft9YX5umH16E+TM5O4Dm04fjdJMBVRhtivof7Yy0Si1ID0Qz5MGRrsMUtYqRkceM+q
         6LPl0KT6t0Jr2D11oQP2Rgy95Kw44UX8Cdp91K0YTEYHNzjrTocEqRenoDnZDwiRvz7Q
         iSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682294142; x=1684886142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K4dhQ+Vl6Yr6TY/lKeJ/u29Yt2u4QfMPU7QYP0YhBF4=;
        b=gEyUFdJ6ENg3ZNcYqDz6qw+qvOFksKRjKOz2+zAr+f+XLjQ9loNinQs4lJBwLdrQJq
         zOgYoqr0nN4SQ7ph4fkmeFRI0iP0dJdbUMPJIXFWw3uqh8arKoUJOPi6b0sd4PsIu3VN
         C9G2VSCVA+24gwJB1xOqNCSBnMQ15jwR+ZcU+Jg0Ppg/aVu6yKJvcHSy2vl81qObnm6c
         Q/8YRV17/dOKvnv9f55N/Ie1n2vHr4GdiLaq7PBAzHIyTm7u+iGEy6j4SgFi2X+xfk+4
         izjtlNJOZd6pV5PyzgSuG4VVLoZZNzECi/nNelRsBDZ6gChyVCDGwPkdV3elXewDVuah
         IFtw==
X-Gm-Message-State: AAQBX9eq2h6ENBGPVjK2bowoZrxZxqUeJl/5olgFgSyDDtYzbYrKZCJ5
        iT3jWDlySwAFmDBqlQ1/QeOKx82Cv4cNpHRk
X-Google-Smtp-Source: AKy350Zo1nTCfznS7N7Qhb8HC8hGXv/LcFgMoxOYO5hc4WT2P0Ru1biDigHBppS3dZDCNV7aHq5dgg==
X-Received: by 2002:a17:902:b097:b0:1a6:6b30:2b3b with SMTP id p23-20020a170902b09700b001a66b302b3bmr11509075plr.64.1682294141783;
        Sun, 23 Apr 2023 16:55:41 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm5458314pls.253.2023.04.23.16.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 16:55:41 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: engine - Fix typo in struct crypto_engine_op doc
Date:   Mon, 24 Apr 2023 07:55:31 +0800
Message-Id: <20230423235532.2729539-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

There is a redundant underscore in prepare_request. Remove it.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 include/crypto/engine.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/crypto/engine.h b/include/crypto/engine.h
index ae133e98d813..b9e76ed4085b 100644
--- a/include/crypto/engine.h
+++ b/include/crypto/engine.h
@@ -78,7 +78,7 @@ struct crypto_engine {
 
 /*
  * struct crypto_engine_op - crypto hardware engine operations
- * @prepare__request: do some prepare if need before handle the current request
+ * @prepare_request: do some prepare if need before handle the current request
  * @unprepare_request: undo any work done by prepare_request()
  * @do_one_request: do encryption for current request
  */
-- 
2.39.2

