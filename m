Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3E3713911
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 12:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjE1Kwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 06:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjE1Kwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 06:52:40 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4774A4;
        Sun, 28 May 2023 03:52:38 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5147a478c38so3182103a12.0;
        Sun, 28 May 2023 03:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1685271157; x=1687863157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kagxpsAxAgnpED4d6ykd8A3dyeK6pLMNrLu4zz0Uk+k=;
        b=EI9So7gO84YdZaGpdX+nFX2z6xlAmtEE93ciLwPcDTOSXSnQC4zE8CnNgUMmxXMGvE
         BORLnxRT4ePYItjgxChPJMAuVLPgBkfgomvHOpJZgiyMJDMh1y31kpUdtfPYobhnmy88
         Ct9s63x1+8/ut93LnmJfIbm0S5fYjk5XtMfw4woJUIPzfVJH37xoDz84Z9ur23/EKmQn
         gitNL5URO/5zZ1lnoccLKU5KS4GU2v2SMRhzjJZTRTcV4ALXoZ2xNF6LOu0sxf1X3MyA
         TuRgvkLjXmAHGWHb5+cjIKTwCSrrc170SHCIxRhaD1/wlLv+ceegnw802cW+y7BdEw0o
         tKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685271157; x=1687863157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kagxpsAxAgnpED4d6ykd8A3dyeK6pLMNrLu4zz0Uk+k=;
        b=kxqTlDUKk+7xKxQpWwcEBj4ll+BIFP8EhIf927a/J73376/JQ4EVMnVSQAmmO9iffp
         seGefUSA+voVbpD+13HczRjOSkzId2qk24TQMH279fPhdpLX5UyqQpbQnLvq4spVsl3D
         rsXdbkUGpgtPl8+8ML35SFzm0nuPppBCTAX4ku9ED9jlwdStRVljKtokVKA5PQIHJyUa
         DpeqqTS6hFbnraUIaq9Z32O03up4lQUtvTp3vlTrbTo7h1dmN+vF9RgoaxEVuoNy82ED
         WLPve941/8lnFkyGTpi3uwKqo9Ggh0VGeRteWTcPEm5ceTQITULo84lYDc5fVHG7EY9X
         8L6w==
X-Gm-Message-State: AC+VfDwLL+LIFPKTmPnJwludHsrlcVoHfA53xE1kEUIBTTELkIRfU51H
        XxvVDtjeYoc5TbWiN3X9l1EhIp0lJlHGdw==
X-Google-Smtp-Source: ACHHUZ5Vp5SKoLCI0EP1+W+ES1wcGpfttFaHUbZJ5g6PdVuSlK2Mmykws3HAHq4rzFIpuW0TedtiUw==
X-Received: by 2002:a17:907:a40d:b0:968:1102:1fb7 with SMTP id sg13-20020a170907a40d00b0096811021fb7mr7069910ejc.6.1685271156675;
        Sun, 28 May 2023 03:52:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810a:9640:26a8:dc62:904c:418f:4328])
        by smtp.gmail.com with ESMTPSA id j13-20020a170906254d00b0096a6be0b66dsm4494893ejb.208.2023.05.28.03.52.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 28 May 2023 03:52:36 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
X-Google-Original-From: Franziska Naepelt <franziska.naepelt@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        linux-kernel@vger.kernel.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>
Subject: [PATCH] iio: amplifiers: ad8366 Fix whitespace issue
Date:   Sun, 28 May 2023 12:48:02 +0200
Message-Id: <20230528104802.22011-1-franziska.naepelt@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the following checkpatch issue:
- ERROR: space prohibited before that ',' (ctx:WxW)

Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
---
 drivers/iio/amplifiers/ad8366.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index f2c2ea79a07f..8d8c8ea94258 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -281,7 +281,7 @@ static int ad8366_probe(struct spi_device *spi)
 	indio_dev->info = &ad8366_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = ad8366_write(indio_dev, 0 , 0);
+	ret = ad8366_write(indio_dev, 0, 0);
 	if (ret < 0)
 		goto error_disable_reg;
 

base-commit: 44c026a73be8038f03dbdeef028b642880cf1511
-- 
2.39.2 (Apple Git-143)

