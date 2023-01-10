Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E81663E84
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjAJKr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238148AbjAJKq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:46:58 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF03161315
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 02:46:53 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id qk9so27495156ejc.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 02:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EIA0Ch7czkrAOIXKFtyyregwgaXUOan8Cxs57O/xO7w=;
        b=d1u+lR+Um/rMc3+k5qC82G+/28nfRvbGzGMD0KvMysuQUeL17UqUIQ312jKurJxt0x
         DWzbccuWkrP96LTn5X1A16YAGVh7G5G/ttNC+SnptCF/JqW/JTBrkdSZDAB63GosZtlH
         n9psb4G0EKeqRJgk1IrBMx4AeJj03sWrxOM25u23kAlMMh0naTHi/VuXRUHUxylxlg3P
         E0c8hQmlrAgY+GvHneSNOf1atK23xNWzpZJMpGz1wKZ3rKBEs44FIJGRJCnhZ0el8ohO
         6/BcaheNYFl4ZMjyz6xe03lpY0EZBBI+e9xL9anKqJErBvzmyPnnjJ/ZltgxzXats3f1
         JsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EIA0Ch7czkrAOIXKFtyyregwgaXUOan8Cxs57O/xO7w=;
        b=U9V62N2rngWfUhSksn6aLLuRBBRhc+cXBW/qbEAajQ7r/sb7AZTC114qT7ZLjbya7B
         4cPi6yk/x54wCqNISZE8k4sZNUZqWUQwJUsRiQgkgTUT9HdDb1d5kIMurvLbTexX77gF
         evnYz+vD8bSVZbFohss/7SeiyaInkkc5v6eq74I5rNiic1IqSJFYoGmlSHBSZypWFmfX
         MMJqYYHKIWz07z45rINRiAjzJ6GZV61xQhqQ3/Z45zR4hYdrhYMl8MXZJ8CfPOKRN/Iw
         80tf3JywN7IU5XdjlmFOSGgeeRHRAG4ccHn4vrBpyjYIdZ0Qel1FXRQaoffrIq80IkQK
         YtOA==
X-Gm-Message-State: AFqh2koQOYEIlhy2+DF59Bns/iWFW83csPeoI3k3s1M4SndbxiHUejOj
        3HhMF08bP2EegM6dMwSKJWM=
X-Google-Smtp-Source: AMrXdXscjTqcAgZUAUdYqOMmodnd+/UXytLrIMYLI4LYh2H2cwhU0Nh9StfQwyDwx/TT0379/4ZJwg==
X-Received: by 2002:a17:906:65a:b0:7c1:7045:1a53 with SMTP id t26-20020a170906065a00b007c170451a53mr53297446ejb.15.1673347612294;
        Tue, 10 Jan 2023 02:46:52 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id pv7-20020a170907208700b0085214114218sm1175023ejb.185.2023.01.10.02.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 02:46:51 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] nvmem: core: fix nvmem_layout_get_match_data()
Date:   Tue, 10 Jan 2023 11:46:45 +0100
Message-Id: <20230110104645.11705-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This function was trying to match wrong OF node (parent device's)
against an of_match_table. It was always returning NULL.

Make it match layout's OF node against layout's of_match_table.

Fixes: f5709a684a0a ("nvmem: core: introduce NVMEM layouts")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/nvmem/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index d112bb1328c1..1f05f0a50d86 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -825,8 +825,10 @@ const void *nvmem_layout_get_match_data(struct nvmem_device *nvmem,
 					struct nvmem_layout *layout)
 {
 	const struct of_device_id *match;
+	struct device_node *layout_np;
 
-	match = of_match_node(layout->of_match_table, nvmem->dev.of_node);
+	layout_np = of_nvmem_layout_get_container(nvmem);
+	match = of_match_node(layout->of_match_table, layout_np);
 
 	return match ? match->data : NULL;
 }
-- 
2.34.1

