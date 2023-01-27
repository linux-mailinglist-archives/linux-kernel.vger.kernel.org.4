Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7FE67E308
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjA0LTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbjA0LSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:18:38 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10782820D8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:20 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id z5so4661646wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+69JoOpEaMXCrh8z1bYxjhPx/3CJW01FzjKrt1Ta/U=;
        b=bq4Yra/wSjCRbnHqeu5TbeUTBykjwUT++QFmxnb1ICbgA36XP12uL6eiu42yJft4h5
         xC7FA/9nTRvmRaXAc5Ng9/l1vu+kGd3ZV5DidMIKTogHhNCaHANqQnah3dGGQd+bm6f+
         ix8Wu86oo1middy1AzaLJWYPdT7W7Oco+zJBB0Q8zM42Mg9NRgNA1R8At5ERhl75OAdj
         2Vzed8vcu6wqYkASng4VoXu9utgNRiiuUNrbt7qtifEXFj/UG/JGcmMpLIB6+12eXfb6
         0XzLjgsD/B2orXY8Q7PT4LIdKNuZJQXosHqg070PhTZzC3aPnmjlLXW/sBalk68ki+fA
         XIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+69JoOpEaMXCrh8z1bYxjhPx/3CJW01FzjKrt1Ta/U=;
        b=vywFW1xMIHlmqwxJVpuiXOfLEeFOXPlRT5H8wQQjPjMV8EOaqPB/ZvQ0zLhK0o5wK/
         3pJQoDobv17sy0CqSh4HBfXWpe/rB6pgiYZ0abrRhD2/MT+hj+jvXNzzU8nlKt/LfZSv
         ncq1bGJWYAoAFXVTaTrkiYzlLOgg9c1WJSZwvn8s1eRuxk1rSfK89crIFChboXtuhFhL
         mpJYGM4TuA7b/lbHYG/6LW2Tgnv8+P+QJzU+vVF+Ce2CdTOTRUXyNO7pTZc0SXni7N9A
         sp+MG/fiPGdkfefSLtOp44dfEMoqafwtC5Iy6TX8uKMCIYarBNddbQlbehbdvHERZRr9
         CwXg==
X-Gm-Message-State: AFqh2kon3sc3Njkf273CgsICXR9LMV+P23vSpUKL7GGaqEMTFrIRSTdz
        IhtkMP5e1nClUn8v+k0ewnyUOUjQ9RvyzbL0
X-Google-Smtp-Source: AMrXdXtLUb9VfjtSfAZptlAT7z8GgJz7/G7k1Umfl7gIIgxo++Zk7e9q39X8YCakStVcRDa+Fk9Asw==
X-Received: by 2002:a05:6000:16ce:b0:242:6777:bfa0 with SMTP id h14-20020a05600016ce00b002426777bfa0mr38036594wrf.53.1674818297720;
        Fri, 27 Jan 2023 03:18:17 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm1843314wrr.108.2023.01.27.03.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:18:16 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Colin Ian King <colin.i.king@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 28/37] nvmem: layouts: Fix spelling mistake "platforn" -> "platform"
Date:   Fri, 27 Jan 2023 11:15:56 +0000
Message-Id: <20230127111605.25958-29-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
References: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
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

