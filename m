Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD5772C946
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239406AbjFLPEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239186AbjFLPER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:04:17 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7280B199E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:03:55 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9788faaca2dso746879766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686582233; x=1689174233;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b5dvgiuwu58z2RBXdkqKsBTMg+eHX490cp2iBeNipXs=;
        b=oyw5FcG95RMH8gBZPimMuo8K1RUozZQd0fP+vIEKp9XdRHQjIeXucA7M7HcnfFBWeR
         obL1xrP/WSVuSzcn8sqgEd/DYrTjrYR0xUXJyzZCGoXkekxkkcigqaGYAnGm1+eei7dd
         4JVdqYbq56KJ+fxGRK3R00jKH2ShpQRs6CBKpNYFl0pNczf09s1keyYDi9zhuQTRP4kB
         Yw1W6qDIIu6mABprgil2J7o4dBaxMg+t6YSyDjT+YVwK+mtwSQAse2FajC6VZRWZHKOO
         Cyldiel5U3c6g3BfT47+swlDyPA7NlC3P5WyZP3wZg8zLkxXtbTQZvOvMiVeHLRdKjCO
         pZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686582233; x=1689174233;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b5dvgiuwu58z2RBXdkqKsBTMg+eHX490cp2iBeNipXs=;
        b=X4jNRKdz51sqsrPxmYMIHKmyn1D2NHWn76tMwfHlz4L8KVUNH9/p1qfS2NnLArJKO9
         ko8KghUTebUIxnZSrM6U2RaOBpu4duCbQ5w2F2PQjCPMI036h9qohvvYffEIUbhvdSwD
         uk2omJLmfbDmAMBJlOJ40eKk7reLOuwgjfiO2fp2sqBULyDY6wZhYAsi4rho9gpJPxKx
         ZuySahnuFblKnYb3RRhb4n7VyAIyonG720ltzsnwSDvCjKY7aFIpmptJ/MoWR7gFSwdK
         THUgg6tBTnYxGa0cC+k+JNREoJenMI4nTpvrvW1j/DB8NLMWMApzX+yS9sOxQEJgBAU6
         YB4w==
X-Gm-Message-State: AC+VfDxf3Rbb7+p0HsONlMEuVWKbBL9ZVsoN/JwMv991x9wM6z+87A3f
        sJTJpe3rDQZye8bMH4PjGjo=
X-Google-Smtp-Source: ACHHUZ6Y8U1kRtrGOzG5Ib4y5z1rRbsqGlhyiWIqgbv1DlOcUMV+/wrK4Syva0l88PDG+OBz0PHfPQ==
X-Received: by 2002:a17:907:320e:b0:978:acec:36c0 with SMTP id xg14-20020a170907320e00b00978acec36c0mr9473330ejb.9.1686582233549;
        Mon, 12 Jun 2023 08:03:53 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id o20-20020a170906601400b00977d3fb2a7dsm5298309ejj.76.2023.06.12.08.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 08:03:53 -0700 (PDT)
Message-ID: <8b5303a0-fb1b-ee05-c2e6-bbd2d9c06cb9@gmail.com>
Date:   Mon, 12 Jun 2023 17:03:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 5/5] mtd: nand: add support for the Sandisk SDTNQGAMA chip
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
References: <11e16c3b-6f7b-a6a9-b0ed-b7ac0cd703e3@gmail.com>
Content-Language: en-US
In-Reply-To: <11e16c3b-6f7b-a6a9-b0ed-b7ac0cd703e3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sandisk SDTNQGAMA is a 8GB size, 3.3V 8 bit chip with 16KB page size,
1KB write size and 40 bit ecc support

Co-developed-by: Paweł Jarosz <paweljarosz3691@gmail.com>
Signed-off-by: Paweł Jarosz <paweljarosz3691@gmail.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/mtd/nand/raw/nand_ids.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_ids.c b/drivers/mtd/nand/raw/nand_ids.c
index 1a89ed796..650351c62 100644
--- a/drivers/mtd/nand/raw/nand_ids.c
+++ b/drivers/mtd/nand/raw/nand_ids.c
@@ -44,6 +44,9 @@ struct nand_flash_dev nand_flash_ids[] = {
 	{"TC58NVG6D2 64G 3.3V 8-bit",
 		{ .id = {0x98, 0xde, 0x94, 0x82, 0x76, 0x56, 0x04, 0x20} },
 		  SZ_8K, SZ_8K, SZ_2M, 0, 8, 640, NAND_ECC_INFO(40, SZ_1K) },
+	{"SDTNQGAMA 64G 3.3V 8-bit",
+		{ .id = {0x45, 0xde, 0x94, 0x93, 0x76, 0x57} },
+		  SZ_16K, SZ_8K, SZ_4M, 0, 6, 1280, NAND_ECC_INFO(40, SZ_1K) },
 	{"SDTNRGAMA 64G 3.3V 8-bit",
 		{ .id = {0x45, 0xde, 0x94, 0x93, 0x76, 0x50} },
 		  SZ_16K, SZ_8K, SZ_4M, 0, 6, 1280, NAND_ECC_INFO(40, SZ_1K) },
--
2.30.2

