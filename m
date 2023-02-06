Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E4E68BE90
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjBFNpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjBFNoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:44:38 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6D31F499
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:44:18 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id k13so2992106wrh.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 05:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IuNPxuqkDxRzNPOYh07wBpNquE5qEOaWbzlq0xSbE+Y=;
        b=xCwAEYnbhFTOFJsOY4rd0ikFrJ8/HuPSMr83uhELgmmzntGM2wHu6X6/mGXgHUWK5k
         qLW9lyOz09jgQy/4TZ5olQJQIeiSBo7xKq9bfnArXcORqisHukVxGPTc1CG60DWbZT7p
         mw1wJLxssUCyq4NjbgjuVI9JL3uUB7lOb9U0PK+j0DY0KznbgiIMRTSHYxp41is0/KOi
         RoxqIYJsvdA1V+rK48MlXaBbMx404Dmp0XzpKvBM7GpdtG/+yn58v2ADuRzUX4CuB+kj
         SbG/Hsc2+1E3LJm+sQ1Cs+iEzK+XucIU6+5yVzV/INrjlIoLJ5oriWX+Vu83QxkPanUE
         VIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IuNPxuqkDxRzNPOYh07wBpNquE5qEOaWbzlq0xSbE+Y=;
        b=utdmAGXP+xWkbQ1eGtDjBcMyqcKJjZspGxcVCtJ8IjM6+qkHblNUEukNFEt2mCTq79
         iXLHFTGlkLlpwky8O9E+fVVlWiHWB8ZIU0FsNbx21y3LjIG2zAyWJwMNfZf5b2ZnT4R5
         MLQNOIE2EwB0+LKf0P1NcPGfKlM0P5aDYBPrwMffOJ0YMqdik7rnVX82lGyTKOvoRHkc
         EZ3ETUbsd281lUTk6rLzxgV6N3yQSGAO+i4ns6wuCo3f9WjJC4Us1oF7A9F9sdSdZmsh
         QzN35kH8IsuEXE2gvGjLLKAHGGBB064lNdmGVMl2leFfEq+ZilZVXOUkS/PyxGwi79Bs
         3qSw==
X-Gm-Message-State: AO0yUKWwLaSDcDfjHDXh1An7NscgO8GmiJA8bNUw9bBRe4rlOlvtvQnZ
        DjA39xwCNXsfVQ7SjG23tIFxbg==
X-Google-Smtp-Source: AK7set/m5OhVm+B+L023m1F7Td/8NNF7aBp2ECEuvxqiTPOTWm5oNFpcrGyLd79PzuxD69Z+Syl6YQ==
X-Received: by 2002:adf:f7c7:0:b0:2c3:ea78:35be with SMTP id a7-20020adff7c7000000b002c3ea7835bemr1937184wrq.19.1675691057299;
        Mon, 06 Feb 2023 05:44:17 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o15-20020adfa10f000000b002bddaea7a0bsm9008037wro.57.2023.02.06.05.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 05:44:16 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 10/22] of: property: make #.*-cells optional for simple props
Date:   Mon,  6 Feb 2023 13:43:44 +0000
Message-Id: <20230206134356.839737-11-srinivas.kandagatla@linaro.org>
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

From: Michael Walle <michael@walle.cc>

Sometimes, future bindings for phandles will get additional arguments.
Thus the target node of the phandle will need a new #.*-cells property.
To be backwards compatible, this needs to be optional.

Prepare the DEFINE_SIMPLE_PROPS() to handle the cells name as optional.

Signed-off-by: Michael Walle <michael@walle.cc>
Tested-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/of/property.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 134cfc980b70..989e692e0319 100644
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
-- 
2.25.1

