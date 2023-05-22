Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3602C70CAE7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbjEVUZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbjEVUYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:24:47 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4670AA;
        Mon, 22 May 2023 13:24:46 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-510ede0f20aso69451a12.3;
        Mon, 22 May 2023 13:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684787085; x=1687379085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdunJDSmoSLBIk6JekhzE8DQlhwFeDOnRUZB4WxVElo=;
        b=s0QA8JPXTS6T3XQNZZKmMsezG7EApz4ZJ/XaiKuytpnf6V9iPtM6vD7x91sMZBTL6N
         lsL4fcY6fDufBeaGuKpobHG64CWh2pROMDHQMM1PG8XKV1o8U3ex2T98Qex2wa2G8PpT
         jrdmHF8Em8XP5TBkE5plQuPJVRjdF465oF6lI4zpuc5or/BfmtkIFqttCzUEJnmIGMQ5
         WBtdV+8e2BkPUAN+6fvnLHqGmm/JyuoSdvIaFFPjHTCkFKJO+WVh7C8jsDX4vEJqFgVK
         CPhTowYRryLlEVsMqrjJt0gt3778V0EaCiDu85yUl+6YR8inyYUxNrt92slnSPpHm2r0
         uRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684787085; x=1687379085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdunJDSmoSLBIk6JekhzE8DQlhwFeDOnRUZB4WxVElo=;
        b=MD/nfwf/egBNtyibCq00cpXtNX5F0OyTr162/cXM8o7SoQ5GalV3lygFm1DQtZYEem
         etqCtwdBx68QpA1vgGrOpHG4d1bqPb8MW90hn+FDm9d/FL+MnBmKAWsH885gW0jMLMGm
         SrdgeTTAxHCLUM/GUBkvTSSscF8EVar+J6Cmr5uAxxwYyvAhJm8ri7ypsOWDj3FQQjVh
         yjci0hNQocRpXL5EaRYuHHMfqK5q+Qqw983dgmxLXDa7pzfyKTaY1YpTef6kK6WUGwHu
         buRGqF2p0vhWL/N7y0/t71gFuVn1pRIWxYPQTaDaYQoOZNn0NiJRzs33L7U4fQ47tFb/
         Jyog==
X-Gm-Message-State: AC+VfDwJWeAPaolAl5nhj5mvjWL7wpzyWFZ5P4W4xco3sw6Upq0svST2
        UCmqIDbrEtlGftfIknagXlAD//epRnE=
X-Google-Smtp-Source: ACHHUZ6/5oKV8yPFa6+sd2j1tfR8qC5kBsKS7GUJ9VCeeh52KgHIVf40gsE+QgONgbpDRR+BPxvejA==
X-Received: by 2002:aa7:c6ca:0:b0:50d:b16d:d21 with SMTP id b10-20020aa7c6ca000000b0050db16d0d21mr9509933eds.3.1684787084760;
        Mon, 22 May 2023 13:24:44 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c459-f400-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c459:f400::e63])
        by smtp.googlemail.com with ESMTPSA id v2-20020a056402184200b0050d56dffc93sm3265031edy.12.2023.05.22.13.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:24:44 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-wireless@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, kvalo@kernel.org, tony0620emma@gmail.com,
        Peter Robinson <pbrobinson@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>, jernej.skrabec@gmail.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH wireless-next v2 3/4] mmc: sdio: Add/rename SDIO ID of the RTL8723DS SDIO wifi cards
Date:   Mon, 22 May 2023 22:24:24 +0200
Message-Id: <20230522202425.1827005-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522202425.1827005-1-martin.blumenstingl@googlemail.com>
References: <20230522202425.1827005-1-martin.blumenstingl@googlemail.com>
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

RTL8723DS comes in two variant and each of them has their own SDIO ID:
- 0xd723 can connect two antennas. The WiFi part is still 1x1 so the
  second antenna can be dedicated to Bluetooth
- 0xd724 can only connect one antenna so it's shared between WiFi and
  Bluetooth

Add a new entry for the single antenna RTL8723DS (0xd724) which can be
found on the MangoPi MQ-Quad. Also rename the existing RTL8723DS entry
(0xd723) so it's name reflects that it's the variant with support for
two antennas.

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
Changes since v1:
- added Ping-Ke's Reviewed-by (thank you!)


 include/linux/mmc/sdio_ids.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index c653accdc7fd..7fada7a714fe 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -121,7 +121,8 @@
 #define SDIO_DEVICE_ID_REALTEK_RTW8822BS	0xb822
 #define SDIO_DEVICE_ID_REALTEK_RTW8821CS	0xc821
 #define SDIO_DEVICE_ID_REALTEK_RTW8822CS	0xc822
-#define SDIO_DEVICE_ID_REALTEK_RTW8723DS	0xd723
+#define SDIO_DEVICE_ID_REALTEK_RTW8723DS_2ANT	0xd723
+#define SDIO_DEVICE_ID_REALTEK_RTW8723DS_1ANT	0xd724
 #define SDIO_DEVICE_ID_REALTEK_RTW8821DS	0xd821
 
 #define SDIO_VENDOR_ID_SIANO			0x039a
-- 
2.40.1

