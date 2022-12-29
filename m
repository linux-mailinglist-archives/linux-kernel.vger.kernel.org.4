Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA94658A1B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 08:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbiL2Hxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 02:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiL2Hxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 02:53:34 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B95EF585
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 23:53:33 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id k19so4464896pfg.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 23:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wDeSYbJRD5UIxf0kkPf6Les3H3nIVnzcLc/ji7ALnCE=;
        b=qtpzgTHlnAUEX2ly37pMS8tGaRlIXK0hm2KhLHj9n1OgGC9mPJ4R3s1wEEjDXcr7v8
         LH/xO2CKUW7TThMnCXMQEU9Fk5xFelRz6bQcuIWar7ylBvHdnqsKlrLT9D6avGwhi1k3
         LmoOfoEoWvjBIA2cf40UqTdy6hKv1svsnmqN10EGTR7WwHtxWgAwe08tA8Sp5BiuBktj
         2ju9o7VcUAj4/KeelGsnMQNp3IcuNtJuvIASxr7+eJX/yilF8MgvPSYnudnfAm3/5xvt
         i0tWic8Sgt7ZkiBubZUj1ckNt5qyowqTIWpqOgNKZPebk0yxzwrGsJBHf+fMUC3tgzj5
         Y/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDeSYbJRD5UIxf0kkPf6Les3H3nIVnzcLc/ji7ALnCE=;
        b=zhURCT4uDETmXKC9umyxVE8I65Elkdzwr4Eu0Lznt0fVPIiHwQ89a/uAoai5CxP2l3
         yZYT/PM0t1bOnGThzrwPR3Blgzw3BIebU6AmXwP2BRDXTn6bU0yFJa/9hdYnexKz3nHp
         nS1jZmqkzF6U0OFfn9PsTrAB8dc7eVMcoAXivCWzwDLbyl4NCmwWd2RgVR9tU4foCb/9
         Klj6WxsbdNT/6S9XmNoofDL7Al56D5gz8TLA0H1NoLz14DE/xw5wUVZMKNHQcmSCfVUO
         d3uDDc3g6j2/WHEufyL6MSNqkajaf5mqTipkj23FaavLanVr3K7SDHHv1f55CyOpWGtx
         ZVpQ==
X-Gm-Message-State: AFqh2kpZmVKzDkTl5yhcUy2ZYB4Q7hgy3J5Tq05eu6Aqu9J86wi5xx07
        U7DQ/iAu8K+lB3iWLXj2qA0=
X-Google-Smtp-Source: AMrXdXv9sdoL0oUYN50GZYSQ/Q+vg/lYZGOj0iBbbAfLxbLORZ9wpsaC7se50iwwDrJg9KKX5LDS8w==
X-Received: by 2002:a05:6a00:410b:b0:57a:9482:843b with SMTP id bu11-20020a056a00410b00b0057a9482843bmr31812196pfb.5.1672300412939;
        Wed, 28 Dec 2022 23:53:32 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id x24-20020aa78f18000000b0058134d2df41sm6126235pfr.146.2022.12.28.23.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 23:53:32 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] um: vector: Fix memory leak in vector_config
Date:   Thu, 29 Dec 2022 11:53:21 +0400
Message-Id: <20221229075323.1394010-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

kstrdup() return newly allocated copy of the string.
Call kfree() to release the memory when after use.

Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/um/drivers/vector_kern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index ded7c47d2fbe..78f32005dd90 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -765,6 +765,7 @@ static int vector_config(char *str, char **error_out)
 
 	parsed = uml_parse_vector_ifspec(params);
 
+	kfree(params);
 	if (parsed == NULL) {
 		*error_out = "vector_config failed to parse parameters";
 		return -EINVAL;
-- 
2.25.1

