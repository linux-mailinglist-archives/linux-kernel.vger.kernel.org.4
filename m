Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A728068BA2F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjBFKa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjBFK3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:29:40 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57D222DCC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:28:50 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id bg26so8311714wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+69JoOpEaMXCrh8z1bYxjhPx/3CJW01FzjKrt1Ta/U=;
        b=lKd8a6zJfcZD6MCQXiRB3KOCNxIZmbAKRcdqIWJIsz74F2W8067bQI+eLevBGS7FKl
         cFjJjJpOlq70ikrpUx6JiZlC8vpFrWUJqy1iF4zt1vcZfUDqmqPM8zS6kSiorkKvtU9l
         tVo4hs7TIMygVPUCaK03N7jSsveysoGdxMgKphdOdKcSgi1T6+RTU80aXJHUNTqKIccK
         qpvG6lXgwzYKNB3s8cC8+fm/GbIq37xPEV583TpbvCnwWcNPCaOdrquekTjZvVeUUx5q
         iDCCuE0+0q54+bX9p6rhiDc75ZI7SJrDJV8jBALjee/A6EZWXU6oSihRljiECYvuE2HR
         15IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+69JoOpEaMXCrh8z1bYxjhPx/3CJW01FzjKrt1Ta/U=;
        b=kOrkygaCyomwGvhInM9fbgKkB7+wGupWC4NtsENluoZTkL1fo964tDAn9nm11HzCEu
         uk3/CEDh7sTItYq3azJ4gh2fCfkpyA4L6acTh/3IJD8KcbmTyC47HrAcu10+ZIsxp9HX
         UQde+0Rzf2wLgu0YdK0H5hntd+byaC7qaKYL/31Lmc7EzNHDaJ+ofx5lKWlmqL5/U7HK
         ieUzYXFYmm0eOD/DDujz5O2ZIHvVcX+T6+EinT1geFg77lUZsh3AqFYMReO0S18bIfop
         r5cfrM6J44oYJ59AIlpa3RbSaCtbSnOD2Y4ANK88GsPZZ7irKxIlUVEAIol81juhWlUO
         TyUw==
X-Gm-Message-State: AO0yUKXdYqh7Nf2sWH4Fc8cXNqvbN0sW6YDKA1RcluV9XnZMm0oLi0+4
        /nwvj0BQAvAh25v6d24i08YeriJ83IH2aaZW
X-Google-Smtp-Source: AK7set+Wd6f2qUN14TQ9eTwMYfVDMVGK7kDUI1P56ObVFxDcnsrIC9XqBLtAAegDoaGK5SaUmoX52Q==
X-Received: by 2002:a05:600c:34d5:b0:3dc:506e:6559 with SMTP id d21-20020a05600c34d500b003dc506e6559mr18539182wmq.37.1675679328825;
        Mon, 06 Feb 2023 02:28:48 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:48 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Colin Ian King <colin.i.king@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 28/37] nvmem: layouts: Fix spelling mistake "platforn" -> "platform"
Date:   Mon,  6 Feb 2023 10:27:50 +0000
Message-Id: <20230206102759.669838-29-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
References: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.i.king@gmail.com>

There is a spelling mistake in the literal string. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/layouts/onie-tlv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/layouts/onie-tlv.c b/drivers/nvmem/layouts/onie-tlv.c
index 074c7c700845..767f39fff717 100644
--- a/drivers/nvmem/layouts/onie-tlv.c
+++ b/drivers/nvmem/layouts/onie-tlv.c
@@ -48,7 +48,7 @@ static const char *onie_tlv_cell_name(u8 type)
 	case 0x27:
 		return "label-revision";
 	case 0x28:
-		return "platforn-name";
+		return "platform-name";
 	case 0x29:
 		return "onie-version";
 	case 0x2A:
-- 
2.25.1

