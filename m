Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451946D6A88
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbjDDRZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236227AbjDDRYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:24:08 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C934655B4
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:23:20 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id ek18so133640288edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFCSoVeAEvW5gqvvfyLsUBPVai0I20mD5NqsmqyKO4g=;
        b=mVyLnmuqaNREuo9+slU9EpCW4KbVi+jpmRzd6bfeMDD4VX6qlkaxaDd0bwZSka5vvm
         JR1FXxPwVzg4HhVd7cgVm64FcE6Znq+fNlRrGCw6pun4B4qnhYy0EzQZRfH7ARx/0+Rx
         4j7tbMi0D7WrOfELszxamwDTPwtEmoCywcncKakPK4qYjZLID7kKaUZneHyIxrbhKeEd
         D25qPg8DBmoLVxFDIiPvPrs1kGss4Px4YVjfphzvl9wZyfrTQkdRo6b79/Kx53L65ESH
         JzjUuh0uXUcjtYyvNviSaojDqcOfDHvulJf+NBOr5rkIU1XiiKYagtqoil/nBD6KTtus
         Pk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFCSoVeAEvW5gqvvfyLsUBPVai0I20mD5NqsmqyKO4g=;
        b=b27aGtY5BxP+TL5n1hyfofv1A1+1zxi9oLwD0t8eCBa2n0k4lItn2YNZJhghh0p7jN
         8aMJSpWp5MZ4zZgy0zAyOZ+72Wejyrch2mnuxUjnbi7jhdaSrlPpEBBjEcww54Sz0goE
         XmL7zAKmReqxurbcydhrYKlbLf0inL3jN7xP3AVdWbCWszDwwlQKpbNLk0JgtEj12TeQ
         gu8LdvQMSmoZDHC9M96MX1RVjItPj/l0m5xdzJtJ0JJ9UwalNdCKwHXPC6CBn7e4u8be
         PDuJCVY/SEv4c1PQiV+TAMMQebv7B8v2or2/cgND/ohiL+bxJ3HAs+6XnEXLKUPcq/E8
         OIiA==
X-Gm-Message-State: AAQBX9cJ7Sd6otsoGZb7fXh22rwwjBxjJ4DeG5xnTsx4LB6Fk9TgWZyQ
        rSqZoB1BeaB+7jtqIw/bBByqAQ==
X-Google-Smtp-Source: AKy350Z3dEzSmhm63+DEj4K065hahnDk2jWcYnRWk2BngeT47M+vGcI4GKSb2gYg5f5Ad+ukzVm5bw==
X-Received: by 2002:a17:906:2b49:b0:939:e928:5323 with SMTP id b9-20020a1709062b4900b00939e9285323mr243457ejg.54.1680628995937;
        Tue, 04 Apr 2023 10:23:15 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:23:15 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 39/40] nvmem: layouts: onie-tlv: Drop wrong module alias
Date:   Tue,  4 Apr 2023 18:21:47 +0100
Message-Id: <20230404172148.82422-40-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

The MODULE_ALIAS macro is misused here as it carries the
description. There is currently no relevant alias to provide so let's
just drop it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/layouts/onie-tlv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvmem/layouts/onie-tlv.c b/drivers/nvmem/layouts/onie-tlv.c
index 661093de33b4..59fc87ccfcff 100644
--- a/drivers/nvmem/layouts/onie-tlv.c
+++ b/drivers/nvmem/layouts/onie-tlv.c
@@ -242,4 +242,3 @@ module_nvmem_layout_driver(onie_tlv_layout);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Miquel Raynal <miquel.raynal@bootlin.com>");
 MODULE_DESCRIPTION("NVMEM layout driver for Onie TLV table parsing");
-MODULE_ALIAS("NVMEM layout driver for Onie TLV table parsing");
-- 
2.25.1

