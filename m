Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CFB70CAE6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbjEVUZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjEVUYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:24:47 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A99BB;
        Mon, 22 May 2023 13:24:45 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-510f3db1cd8so99733a12.1;
        Mon, 22 May 2023 13:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684787084; x=1687379084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZGCTlLrXWFIDYlutHVZ0bE/uJZ2Fq2/cbrXrnGexP8=;
        b=N1ZZuZ9Zt+B3kQX7r5WxLxwJZu2Z6tL6FL2IaRxCRVfQbfkc4bZX4w0DQrVDsocSn3
         i82/91wWs2bqVYdDTRjlKPVDs2Y7tYU0ETmK+Hu40Ov0AWB+t5qnvLEuqEfknQFJBQi6
         g8I1jiHJXGwdYBqtzCGsdanNJLKGIu3E3AXcbmdMVrbdMumS9nkp6uekmlNssupfoDAi
         1vSRo9FEsHTeo2blxqZcZGOwT/NG7Umae3mJGVX+rUpT/SS4fjH5Yn9x2q1TjA2eh2xq
         z7p7zaryHIUhMMTIx1oQucrSQtYkpe+RuzzrxWHvk3nA9sSVn5ET9TuKvyygHEfOgLKB
         oA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684787084; x=1687379084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ZGCTlLrXWFIDYlutHVZ0bE/uJZ2Fq2/cbrXrnGexP8=;
        b=IF3JsGpXv2m/OGx7+7WoMMgVoRuUvhxFTOGxhcw6HwgNB02NWgFOTDigpF3v+lJFDQ
         qeol4CntROGnkuA8D5EoVh8XlWN3jk1GkMN5c7eW7w50ZxJn2ometY9/jgFLFL7tgnvl
         hU5346mn4yYc4eWpnup+ytEY2HFmBRau5xR4R9fNt6EH/vaEw0OKtDe+Md3XfRH6nrMv
         ogLI4tF6/a9Veoub0lwW6aH8U1OL4iPinYWUUiLM1/dC6P6hXJF7GLNwEKVkPzkd8TJ8
         ZX7pec2Rs1DurVNTxl60hKgUrTiC6pXgFffGYyQyU/kmU/cb88APtt5YOWU1D8dgWryt
         GeNw==
X-Gm-Message-State: AC+VfDxDzjeNdDhoZVunAAjDK4Mmh28dr5uRvLMyEo5t0kaVLtKXiJqr
        LhcV/VXFZivKddrNvjUUmeIh/Ovlr20=
X-Google-Smtp-Source: ACHHUZ5V8cuTMX52dL47WsMM2bsTa3a0CkLyCnBmQ4pHMMXF/Aq4weovKXICRfiKsG1u1NnrViQWyg==
X-Received: by 2002:a05:6402:357:b0:50d:682d:d431 with SMTP id r23-20020a056402035700b0050d682dd431mr10052288edw.16.1684787083988;
        Mon, 22 May 2023 13:24:43 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c459-f400-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c459:f400::e63])
        by smtp.googlemail.com with ESMTPSA id v2-20020a056402184200b0050d56dffc93sm3265031edy.12.2023.05.22.13.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:24:43 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-wireless@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, kvalo@kernel.org, tony0620emma@gmail.com,
        Peter Robinson <pbrobinson@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>, jernej.skrabec@gmail.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH wireless-next v2 2/4] wifi: rtw88: rtw8723d: Implement RTL8723DS (SDIO) efuse parsing
Date:   Mon, 22 May 2023 22:24:23 +0200
Message-Id: <20230522202425.1827005-3-martin.blumenstingl@googlemail.com>
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

The efuse of the SDIO RTL8723DS chip has only one known member: the mac
address is at offset 0x11a. Add a struct rtw8723ds_efuse describing this
and use it for copying the mac address when the SDIO bus is used.

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
Changes since v1:
- added Ping-Ke's Reviewed-by (thank you!)


 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 9 +++++++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.h | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 06e7454c9ca6..cadf66f4e854 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -216,6 +216,12 @@ static void rtw8723du_efuse_parsing(struct rtw_efuse *efuse,
 	ether_addr_copy(efuse->addr, map->u.mac_addr);
 }
 
+static void rtw8723ds_efuse_parsing(struct rtw_efuse *efuse,
+				    struct rtw8723d_efuse *map)
+{
+	ether_addr_copy(efuse->addr, map->s.mac_addr);
+}
+
 static int rtw8723d_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
 {
 	struct rtw_efuse *efuse = &rtwdev->efuse;
@@ -248,6 +254,9 @@ static int rtw8723d_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
 	case RTW_HCI_TYPE_USB:
 		rtw8723du_efuse_parsing(efuse, map);
 		break;
+	case RTW_HCI_TYPE_SDIO:
+		rtw8723ds_efuse_parsing(efuse, map);
+		break;
 	default:
 		/* unsupported now */
 		return -ENOTSUPP;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.h b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
index a356318a5c15..3642a2c7f80c 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
@@ -49,6 +49,11 @@ struct rtw8723du_efuse {
 	u8 mac_addr[ETH_ALEN];          /* 0x107 */
 };
 
+struct rtw8723ds_efuse {
+	u8 res4[0x4a];			/* 0xd0 */
+	u8 mac_addr[ETH_ALEN];		/* 0x11a */
+};
+
 struct rtw8723d_efuse {
 	__le16 rtl_id;
 	u8 rsvd[2];
@@ -80,6 +85,7 @@ struct rtw8723d_efuse {
 	union {
 		struct rtw8723de_efuse e;
 		struct rtw8723du_efuse u;
+		struct rtw8723ds_efuse s;
 	};
 };
 
-- 
2.40.1

