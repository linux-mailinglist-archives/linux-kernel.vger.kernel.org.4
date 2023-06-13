Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1528972EDCD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 23:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239863AbjFMVVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 17:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjFMVVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:21:10 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB236129
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:21:09 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-97668583210so3748066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686691268; x=1689283268;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YD94vOp+VeZ4x56jPA7n1R/f7iEhDVnQp4dgxqoTLC0=;
        b=maAo6QrORoNrVat7yzcWUR6fp3xFXYHuromco3f1O85GNQz0XcDsVTOS5LJi9+0XvE
         HXEQT7BadwX6Fn7CYhwFB6iF+MccboFdqtnCKflfzcqj4DQjDI82UmMAJxsGC1rzrz72
         a7+1QWOKleODvJ3fcENOryX39Ju8PqS0jl94/3VrhDB9ID9dpvHsWEThIfQeNDJ4AWBV
         WoQ7XpxJejoIU7UBsnmYoX4beuw/kkZF2Gc3YnG28/afe8Vk6NYbhQn6I3zn27ABIoje
         leqWoflfKjwjXwqraDiYXEFGaP6oUWWMG1GUoYqrqZ9ZsJvQyT2MfdfJaJtSY95SbAht
         Ufaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686691268; x=1689283268;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YD94vOp+VeZ4x56jPA7n1R/f7iEhDVnQp4dgxqoTLC0=;
        b=dfUj56rGIuaDg/u8DJdVzEYfZtbOmqtkRBc5JVNbz72R7pU5XdlDPrLU3nHIuD9ctx
         LXK2JvaWCv4FJmMmMK3+QSwD1R0bPbN7Z7jDyIfC8O+yAztrLjl7r7+FPyBjQwu9gIGg
         eVFK3GAt0YjI8cdmd8wfaZ02gNTAm5lBUFzNBGrC8lYnXZwg60kGuURBtRp4UxNMJXG+
         rUAcIDnzA9DMADJ1zPX4xYwsq6xdL/QaROXhKWMysFPqz+8WZH8dNiTT1RPmJNag3Fz+
         bgFrYR3RVZlJf6dc3/KZ9zPA4zMOA8O9SHLLkG7gjhqIwujmknReO0HyfIl7mUnWsmt0
         1b4A==
X-Gm-Message-State: AC+VfDxSK6JGB0oMPGCNY1Plh/6zycajLzCqk5vFKQOGSa64ov/AVOp1
        BrrcgJq5ZlSUBjXEO8t4tW4=
X-Google-Smtp-Source: ACHHUZ77VWB5N68nFFmF78x9lgJLVYVTIBt6Q//KTTPeWKubrYbQaEBDsb4UO/KKop9jXks7g7AOjA==
X-Received: by 2002:a17:906:db03:b0:974:1f0e:ec2d with SMTP id xj3-20020a170906db0300b009741f0eec2dmr13859467ejb.15.1686691268034;
        Tue, 13 Jun 2023 14:21:08 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id x7-20020a170906298700b00965b2d3968csm7229520eje.84.2023.06.13.14.21.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 14:21:07 -0700 (PDT)
Message-ID: <98811c98-4681-6ddc-8287-bd9b77559c51@gmail.com>
Date:   Tue, 13 Jun 2023 23:21:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 2/2] mtd: rawnand: add support for the Sandisk SDTNQGAMA
 chip
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <aaf4580a-a368-8f70-c9c4-21b5ed4dd599@gmail.com>
Content-Language: en-US
In-Reply-To: <aaf4580a-a368-8f70-c9c4-21b5ed4dd599@gmail.com>
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

Changed V3:
  Separate serie
  Change prefixes
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

