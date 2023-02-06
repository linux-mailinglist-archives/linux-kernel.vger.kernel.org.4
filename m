Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F270E68BE8C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjBFNoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjBFNo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:44:27 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E84723C44
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:44:14 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id g6so2422177wrv.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 05:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmitWArQk6CIBydogs7WRFxwX5Xsu7yBBRQ1KBB+uN0=;
        b=AeZps2uD91V2HVw7gdWzFJ5/F0RvUp5Vz24SBa6MH6nGcQPf6oCLMEaY0LBb5SrQ78
         V0cj6r3cKC8822Vproi7kjo4AFN9MDMrR4IzH+RRRmKsOgZK9IsGVRdbJNIvyOou82sI
         DEKZ3TiAdkWtyYVef6VmyQ0eUsr2aYqwETkXJwK/pgnp8N6WgaKnLgIRmHVm6X+zDOg9
         d19YjAy8u7rzkDyriPYR7kTNSoH4BE2wmJW7JnruPK19BkkYSMO6wgKD9G2v1k5KOTqc
         VWSP13sqtdLh7unQN5HZa0+pFjKlDrS8Ywk2Vq7GxFQ3MZtf+h1QPGlTvrA0qOPxa8l2
         vRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmitWArQk6CIBydogs7WRFxwX5Xsu7yBBRQ1KBB+uN0=;
        b=dSmgRU+vBheVd0klCaDI+tENGpRsakvENyEDLG1wV5Sknv8q7dT+V+JrDcpptP906k
         kpJbLI1gfYgolaczpFuF0dZ5fNmet/4hEid60L7K/r8Y+n+hQFua/Zel/leRAlPE4VTc
         zGqEqRf2s6oszFm4/h6Fyjbkd1KNHaMjGLeRtFp+Cajkz4exaDYDrxIbqhNtd+yISTri
         1VTvchHzOXf7jk+A5cmr7cDIXe6A/tyfkHBH9Wjhzsbd6rDFiuxO/xYkfO1kYeMMYLua
         1MYo/1+La3dipdozgs2wFyGNtke4/ZowPj1dPU/tHX1aDLQt1PGcDSzHwICxH9fVnHix
         xQfg==
X-Gm-Message-State: AO0yUKUru2nVKmRj0Gf0b5vEb/+45GRDRJdYEU8PD2G7LVhQRn44J7mi
        evBvz0qb7zkNtcrkfMufsRT56w==
X-Google-Smtp-Source: AK7set9BI8RYHs5qer7e+3+1sosIzp+aDOxstBhy0zZRkDox+5Oj8NU+iLwRWdyh9I/Ij98+Ve2YFQ==
X-Received: by 2002:adf:e4cc:0:b0:2c3:f026:9082 with SMTP id v12-20020adfe4cc000000b002c3f0269082mr664229wrm.35.1675691052645;
        Mon, 06 Feb 2023 05:44:12 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o15-20020adfa10f000000b002bddaea7a0bsm9008037wro.57.2023.02.06.05.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 05:44:11 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 07/22] nvmem: core: remove spurious white space
Date:   Mon,  6 Feb 2023 13:43:41 +0000
Message-Id: <20230206134356.839737-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206134356.839737-1-srinivas.kandagatla@linaro.org>
References: <20230206134356.839737-1-srinivas.kandagatla@linaro.org>
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

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

Remove a spurious white space in for the ida_alloc() call.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 34ee9d36ee7b..233c6c275031 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -764,7 +764,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (!nvmem)
 		return ERR_PTR(-ENOMEM);
 
-	rval  = ida_alloc(&nvmem_ida, GFP_KERNEL);
+	rval = ida_alloc(&nvmem_ida, GFP_KERNEL);
 	if (rval < 0) {
 		kfree(nvmem);
 		return ERR_PTR(rval);
-- 
2.25.1

