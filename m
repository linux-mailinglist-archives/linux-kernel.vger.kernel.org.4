Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05486BE970
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjCQMiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjCQMiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:38:06 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0069A8617A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 05:37:26 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id eh3so19714719edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 05:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679056645;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ZayqswrbZ5QKKAD9r+P5nbMwyqOYAxRHhSqir5Y47A=;
        b=HBPD3CnSAB/ZPFiN2l3lS+vD3GXGwIyXa+NJzUy4XLbOBqPoXnalzl0SdCHcM68oSB
         ugFPC8w4TXBJVN6oBPVA/OHnF1qttx7eZ/2qV0QujCA5bRKqu/Kf7R7ffb39VgKoUSvD
         vdSntNH+0/E3Yc5TI7++fGS67+j0Hbed0njnveIcwu1rOa+d/ExOcPxl5JupULGwojVW
         vUZTUQgyQlnJZv2w/GHX9XnbBSuVPHP/sRB95mDlVWdYyjxuBHpt1L3p8TK4FkbL4737
         wKID/TYOYMlYdY2A8ChY6TZGuWx1LW/38VcV8BzKz3mtpppAM0MeheCJS0RjfR/41eup
         lXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679056645;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZayqswrbZ5QKKAD9r+P5nbMwyqOYAxRHhSqir5Y47A=;
        b=HUCft3uIvVO4kJhgAshoF2ox67fspWpw4pBz1QJ72jmuzfq+s8/yWHJfizGIQc6EA+
         EPjvEyJBLNn23JAZNoUBCBz4ZVeO+HMUaeNMANR++Gg9GLIMhlGrumFNItD1pjvC19OL
         IKXwViPc6VbGJFIKdtbQ2kCw53/kvbdnbEgJObrB4ucp9G5pv/s0K7PQTfKk5cWCb0Cc
         ioMiy4Uui+ZAyIDUtYn+G0ZkYH7Exz5sp6AXVZ6Y/DheLr0odM4OFP3dsnpGEQgFXix8
         prGUffknTgSmhIrxdLB7STWArdUTSuGYyiv49t7jjJ79o9vbE8X9ESwpamowkmcUpdnb
         VTkQ==
X-Gm-Message-State: AO0yUKUjAz7uTmaF9CBw7b5NmknVlLKUkjqBLKyT5WwKQ6r0oXqkl5Zn
        +K8i+RNbpoAcmeEaQS6pOy4=
X-Google-Smtp-Source: AK7set8SIzE61mtegRU9aGVKdIM5UDvWT/gsPpdG4j/g67fGeWgRuOnADBuRN1Z6LNGXdCN1ZlHcYg==
X-Received: by 2002:a17:906:3f87:b0:922:446b:105a with SMTP id b7-20020a1709063f8700b00922446b105amr2847350ejj.19.1679056645209;
        Fri, 17 Mar 2023 05:37:25 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c5b8:6200:dd0b:20c2:4c96:a825? (dynamic-2a01-0c23-c5b8-6200-dd0b-20c2-4c96-a825.c23.pool.telefonica.de. [2a01:c23:c5b8:6200:dd0b:20c2:4c96:a825])
        by smtp.googlemail.com with ESMTPSA id cd11-20020a170906b34b00b0093009bc5825sm945928ejb.2.2023.03.17.05.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 05:37:24 -0700 (PDT)
Message-ID: <ac3b4356-d4c3-25e4-9bc2-c5b369c676b2@gmail.com>
Date:   Fri, 17 Mar 2023 13:37:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: [PATCH 2/2] soc: amlogic: meson-gx-socinfo: use new
 soc_device_register functionality to populate machine name
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <d846047f-b714-3fd1-d8c6-9f774902fb9f@gmail.com>
In-Reply-To: <d846047f-b714-3fd1-d8c6-9f774902fb9f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new fallback mechanism has been added to soc_device_register that
populates machine with the DT model information if machine isn't set yet.
This allows to remove this code here.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/soc/amlogic/meson-gx-socinfo.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
index 165f75484..6abb73034 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo.c
+++ b/drivers/soc/amlogic/meson-gx-socinfo.c
@@ -174,11 +174,6 @@ static int __init meson_gx_socinfo_init(void)
 		return -ENODEV;
 
 	soc_dev_attr->family = "Amlogic Meson";
-
-	np = of_find_node_by_path("/");
-	of_property_read_string(np, "model", &soc_dev_attr->machine);
-	of_node_put(np);
-
 	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%x:%x - %x:%x",
 					   socinfo_to_major(socinfo),
 					   socinfo_to_minor(socinfo),
-- 
2.39.2


