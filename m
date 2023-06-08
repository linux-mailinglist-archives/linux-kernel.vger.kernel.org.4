Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DB67284FD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbjFHQb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbjFHQbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:31:08 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBE02119
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:31:07 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5149429c944so1472386a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 09:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686241865; x=1688833865;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FuC7NSHnCjOPABSYc7BMbW74QWv84w5gPSWpqKs1P3g=;
        b=aNNyAbTqj3IEtixMqMg+vLI37ql4/0Acm5DTZwIVLAsTl75k6dQ1SmDigYhQyWMe+4
         kv8STcPKEhQ/eKeljkyP5gMJqrpUNcA1ZV22qv/pKVdWNepsQP0b4YIgOCJ9/nFEI3v3
         yJp2X3xDiG/Qfh/9y30lpl8xi0SV8LzrKgtKS8FZbDPZkDRQ7kfpqqm1TtgYXHIyPOij
         45TSLPZ2nYlpojs18oErPwQg/iP8zPc+jII1NcC1iZO4zVuPpFkRc+zitkkk8VBg7uvQ
         7p50g0b7aH0eyKMck+wRxrTxMci9kY47b1U73PqqP6BxdHnib0UIX/J1YcboiFYYj6Pg
         Apsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686241865; x=1688833865;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FuC7NSHnCjOPABSYc7BMbW74QWv84w5gPSWpqKs1P3g=;
        b=dnqSLYGv2Cp9C7wiI0KF7iyDaDVJqmVd1KTYbu9swTJicctTwxon3bzqtNB+NjrtL2
         klliN+GgD1QIVlSs9y+7ZfP5b8QKm4uKSfyG3KROM/mzTEWYiXfjfHnCjxIQ/dDLK01T
         IKYtpXsj0AFjdQ/XVww5EJX8KUjuSwF+gbzXcCj/zZYxmj4Sv6iyyNxEu41JUMpwr/qL
         hO2aAj2Twmh7DYXGTNekdcvn9i3JD2i6nyCsTtC89yCdsCrUoywoWGzSU7ijm+IQZow+
         99D5HX1aEhlZicwRjVjLvM2Fgxyy579nK0ToRJHw1K0/07myggu71cPdk1h+JYU6WsZl
         yuYg==
X-Gm-Message-State: AC+VfDySl37xKi8vsW1Y2ySk+w8npqd8ULNp6QRZoTEC3Pato3WTAzCO
        vLcNN9EidWwz9vNbxI+INpQ=
X-Google-Smtp-Source: ACHHUZ7DyU8f3R8jgsuvsuJAD1m2ESx11xvhon/3qlB8Ls1/utZvujvvZ18ia9yuMt56eXMMwEU18g==
X-Received: by 2002:a17:907:9445:b0:974:5c2f:65cc with SMTP id dl5-20020a170907944500b009745c2f65ccmr209318ejc.67.1686241865494;
        Thu, 08 Jun 2023 09:31:05 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id k19-20020a170906129300b0097381fe7aaasm29029ejb.180.2023.06.08.09.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 09:31:05 -0700 (PDT)
Message-ID: <c21a0de8-f8f6-a8f9-417b-eca99dc8b55b@gmail.com>
Date:   Thu, 8 Jun 2023 18:31:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 5/5] mtd: nand: add support for the Sandisk SDTNQGAMA chip
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
References: <19bf714a-43f9-c30a-8197-91aaaf4a6e5d@gmail.com>
Content-Language: en-US
In-Reply-To: <19bf714a-43f9-c30a-8197-91aaaf4a6e5d@gmail.com>
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

Signed-off-by: Paweł Jarosz <paweljarosz3691@gmail.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/mtd/nand/raw/nand_ids.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_ids.c b/drivers/mtd/nand/raw/nand_ids.c
index dacc5529b..53c4118de 100644
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

