Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5826C67E311
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjA0LUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjA0LTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:19:07 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C910A5FCD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:31 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id m7so4654260wru.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXKbP5NdGEvdDzS4EdNjsMISDWT6wb0Ca2B6UKqLyAI=;
        b=KLq7j8rnRZyCaSxJc+7nQ10iM7RqhzmV75gnzBiJCpTv1atcf53fawxP5J4U+5MUvX
         9JFNPq9jQn45FNm8HktXu4bi0k0ZpnY/GwB8iTNeBZVALhI1c6j0AYtOcIKswlSa034M
         fsfYhAuhg5fZ5Edt+6hVrA5ZghW538PWY9EOvwBq7Iw7v1URwNvW3iWJXt1+swiibKSy
         Qv5D75sgY2OvpRc02DmWkR5TT97MsD3tYIUQa5MGeEZe3z6ZdUGHGGqawcQah9XBr9gz
         TygwvtdWrvl+DGC1x3vfjOfCkxBqfU7JhpbY8YQV1BmW45qGRtMWy1NW1ANrRxe6eRRh
         w9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXKbP5NdGEvdDzS4EdNjsMISDWT6wb0Ca2B6UKqLyAI=;
        b=mP7B5umLqIDJdQrsBHF4llrDJi5WQ4WjGAWDsoR/VWoUbwChKmCY0oETdBczhMUoRp
         x71EPuM+05J7QVn6UZ8LbAE6I17TnBrEaSqNYCxR8g2ZWq8NHYLfLVUAQB3GADUgK+wU
         TJjNnW/PLJT2FhhCJQCxCAjMGBPwdqfsv0pUNsZqeWa795544Bg/MeaF2Q14IfFHhTFo
         Vo6aOljNCtdgK0BmHu3BhU7AetjIxxCA4TmsIvpp2dT8hrKtO2UQsDCztfWFm7200JiA
         19zo13PFczTsrKqk8yw+LmhL2yPF46LLvk7rg4fqfIjmF4P/YPTYfqVz/T3d8NTBzxfF
         5+7w==
X-Gm-Message-State: AO0yUKUfIpEYodB3s3PPxDU4R8vfA2wSt2e97ekTsbas5LN7tdqsCUC2
        jYBwSA2PAdF0H3eVVog0UUS4cg==
X-Google-Smtp-Source: AK7set8PgjIV7ZWxl3gPzFus2Eli5dE09aotpWYwGptomemtfnB4zNsyDoLEIfYz7I1AfIaDnAA95w==
X-Received: by 2002:adf:a1dc:0:b0:2bf:b4ca:6bac with SMTP id v28-20020adfa1dc000000b002bfb4ca6bacmr9237448wrv.59.1674818305849;
        Fri, 27 Jan 2023 03:18:25 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm1843314wrr.108.2023.01.27.03.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:18:25 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 34/37] of: property: fix #nvmem-cell-cells parsing
Date:   Fri, 27 Jan 2023 11:16:02 +0000
Message-Id: <20230127111605.25958-35-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
References: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

Commit 6a80b3e6fb41 ("of: property: make #.*-cells optional for simple
props") claims to make the cells-name property optional for simple
properties, but changed the code for the wrong property, i.e. for
DEFINE_SUFFIX_PROP(). Fix that.

Fixes: 6a80b3e6fb41 ("of: property: make #.*-cells optional for simple props")
Reported-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Michael Walle <michael@walle.cc>
Acked-by: Rob Herring <robh@kernel.org>
Tested-by: Robert Marko <robimarko@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/of/property.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 8d9ba20a8f90..95b838185b2f 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1202,8 +1202,8 @@ static struct device_node *parse_prop_cells(struct device_node *np,
 	if (strcmp(prop_name, list_name))
 		return NULL;
 
-	if (of_parse_phandle_with_args(np, list_name, cells_name, index,
-				       &sup_args))
+	if (__of_parse_phandle_with_args(np, list_name, cells_name, 0, index,
+					 &sup_args))
 		return NULL;
 
 	return sup_args.np;
@@ -1256,8 +1256,8 @@ static struct device_node *parse_suffix_prop_cells(struct device_node *np,
 	if (strcmp_suffix(prop_name, suffix))
 		return NULL;
 
-	if (__of_parse_phandle_with_args(np, prop_name, cells_name, 0, index,
-					 &sup_args))
+	if (of_parse_phandle_with_args(np, prop_name, cells_name, index,
+				       &sup_args))
 		return NULL;
 
 	return sup_args.np;
-- 
2.25.1

