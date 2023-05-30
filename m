Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF2B71638B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjE3OSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjE3OR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:17:57 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BDE12D;
        Tue, 30 May 2023 07:17:19 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51494659d49so5109836a12.3;
        Tue, 30 May 2023 07:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685456237; x=1688048237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZI6N7rpTTulbByVXfKdZOIC7A9MiWqLIoC8OTG2ppM=;
        b=SLtlmn0TqZSDxqhH7aQIjRwsci638QIzvnyE3KxBrB6UPtgm1C1NSYtKRxFJxsbyX6
         Wm7YlxKYJmaZdvv/49fkrCxzD3vJ7X7O6iuc3a26lnpuwIi3KOuabJs3kZ7xn8cDRb6m
         Ko9/xmZngxsNWT8nyP4agXiMRATCiQLjmE8CYuCa5EDCDmqn+AKzbwt4Mq9GR1Dw1Q/Q
         tqutGr1kxpYdAUdJZmcjheuwu8YEol1n3CvS7MHk+zMHwfcwkgE4ANKRVz1mVUOYFcj5
         ogkYkmG9kVW/JhUVsnMM0WxzCzii4Lzdy/J/MH9I2MSWBrcHr+QI6VcbYszbIWNEMpYf
         q3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685456237; x=1688048237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZI6N7rpTTulbByVXfKdZOIC7A9MiWqLIoC8OTG2ppM=;
        b=JorBJBmTBZ5/HxAGPzf3f1MDZmnrM8H9ikLq2vszeWuN4wiRxdYbhngcYdH+vd1r9Z
         04ay09QmxdX6fugo+33uI/dajrCM00ZrHRoKTA8eU3tYqqmtj5DqJQSomO21u3+x3LSc
         rDMNelbIGdT+fIb9HiiBrkaPnEi7bYOtgc8h961SB2qsJTAB0TiV5s+S9ALmaRCgtz09
         a8qTJnRV3t/eK7O0l1u0sTCgAk2epWqnKMJyV5naGudsRr7qvVnfKwrZ5J/eNK1LHQh+
         RyqeVxYGo8DL3LmkGdLE+eOdoPGhrJtg/4pjMLDOPVY+i6B5EV3q7a2+xRr/bapMDKD7
         48ew==
X-Gm-Message-State: AC+VfDypBdLegfmsVSSb62MTdJ836QmbV7NVTMfZJoJI56D8Cqm7dl4X
        wgrbTW10zCYZ+X1eAJQ1ZlQ=
X-Google-Smtp-Source: ACHHUZ4Kzsw/Pdj9Xsu6+IR+SEPckrPQrAxo3/SarlmPVFQkrJFFv4Nbe7sLhcXCzrcSLNJjanqpYA==
X-Received: by 2002:a17:907:7e8c:b0:96f:d8a9:d045 with SMTP id qb12-20020a1709077e8c00b0096fd8a9d045mr2621016ejc.59.1685456237517;
        Tue, 30 May 2023 07:17:17 -0700 (PDT)
Received: from wslxew193.ultratronik.de (p200300c78700c900796a998533c043af.dip0.t-ipconnect.de. [2003:c7:8700:c900:796a:9985:33c0:43af])
        by smtp.gmail.com with ESMTPSA id n20-20020a170906089400b0094e96e46cc0sm7354359eje.69.2023.05.30.07.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 07:17:17 -0700 (PDT)
From:   Boerge Struempfel <boerge.struempfel@gmail.com>
Cc:     boerge.struempfel@gmail.com, bstruempfel@ultratronik.de,
        andy.shevchenko@gmail.com, festevam@gmail.com,
        amit.kumar-mahapatra@amd.com, broonie@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/5] spi: spidev: add two new spi mode bits
Date:   Tue, 30 May 2023 16:16:39 +0200
Message-Id: <20230530141641.1155691-4-boerge.struempfel@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530141641.1155691-1-boerge.struempfel@gmail.com>
References: <20230530141641.1155691-1-boerge.struempfel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow userspace to set SPI_MOSI_IDLE_LOW and the SPI_3WIRE_HIZ mode bit
using the SPI_IOC_WR_MODE32 ioctl.

Signed-off-by: Boerge Struempfel <boerge.struempfel@gmail.com>
---
 drivers/spi/spidev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 39d94c850839..c8b938e0f342 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -64,7 +64,8 @@ static_assert(N_SPI_MINORS > 0 && N_SPI_MINORS <= 256);
 				| SPI_NO_CS | SPI_READY | SPI_TX_DUAL \
 				| SPI_TX_QUAD | SPI_TX_OCTAL | SPI_RX_DUAL \
 				| SPI_RX_QUAD | SPI_RX_OCTAL \
-				| SPI_RX_CPHA_FLIP)
+				| SPI_RX_CPHA_FLIP | SPI_3WIRE_HIZ \
+				| SPI_MOSI_IDLE_LOW)
 
 struct spidev_data {
 	dev_t			devt;
-- 
2.40.1

