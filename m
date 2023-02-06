Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BA568BA38
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjBFKas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjBFK3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:29:46 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37CC227BD
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:28:58 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o36so8301468wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsRQP+UczZ0/DRSX+VGLQsS8dvXU3ie3PVfmFaU+thA=;
        b=lbPST2WdebG00GJVUncDY8gS73pbhZ0ieJI3PqdIXtcYeA5NLkh9/CJRriA6Q1EvE1
         birAJLPiBnn0FMvJE3mdgx9YQl67UgvgZ0+Av59P9VUSw4iO0yqMalry7+uO81QtunRe
         My2v38O0YVv/pM+0tH0P0+HXhM1oHim+ypPU/TjqQX+BisRIf00Q3AUZKQ6/fm3404+B
         xEW5w9TQAT9pLYvopCPyEsDHSP9ju5piP4NigB6PHELlHp6PZxip6SIOpLRXwXpNH+lf
         Io18DSyQmkmtX87Gm4cVUl1NyZy/qTkSWhIe6EptLKNyLgVX7DbQT3r7ZjYzIf9DbUrn
         66JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GsRQP+UczZ0/DRSX+VGLQsS8dvXU3ie3PVfmFaU+thA=;
        b=5qPrjrqpl8GJf5dqGOJ0bpBwu4/9c71kDCRSjmShKw3g6V1KFiMx56vuGm3rg9bOVG
         I2Nf1SqZkr7C9ajMq3EWY9n75mVBTNFlTjuVMRutZNvE/vimJFflONOwZNjgIQZ+sK1Y
         5UyGsiLz+EqQbn/hIivVC4o3YrQvXrpzYMmzeucMN7sMp/uI51h+zBMH0gAL2qbbkdim
         sKgk5FlYR2rXIGHdHEpHQik7+/dLDDFCH4axA43zYgkbOJXtr73qAu6+kaGbUIa6omp8
         z/+CTOuc7BqjoTOjwFVJlWb0LwbU86Wu6g1QoZAK2ZJGiVa0B6moQUDpvzTx981KObUZ
         g2aw==
X-Gm-Message-State: AO0yUKUgpIJAhVpzkm1HxvzMVH27cqR75zCl8GMHzJ5g+sEhYhqQ/L74
        f659dz95Mrlm5iBrYyc4bUyh3g==
X-Google-Smtp-Source: AK7set/B6iTbOYCK8flUdFIXHPj0mTjHNfmaimt/do8yz+zx3Lev86g9OZ6Ci97KpRSUIcF5afMPjA==
X-Received: by 2002:a05:600c:3545:b0:3df:ea9a:21c7 with SMTP id i5-20020a05600c354500b003dfea9a21c7mr10182051wmq.33.1675679336333;
        Mon, 06 Feb 2023 02:28:56 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:55 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 34/37] of: property: fix #nvmem-cell-cells parsing
Date:   Mon,  6 Feb 2023 10:27:56 +0000
Message-Id: <20230206102759.669838-35-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
References: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
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

Commit a80b3e6fb414 ("of: property: make #.*-cells optional for simple
props") claims to make the cells-name property optional for simple
properties, but changed the code for the wrong property, i.e. for
DEFINE_SUFFIX_PROP(). Fix that.

Fixes: a80b3e6fb414 ("of: property: make #.*-cells optional for simple props")
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

