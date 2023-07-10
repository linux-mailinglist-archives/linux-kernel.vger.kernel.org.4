Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C9374CA30
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 05:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjGJDGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 23:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjGJDGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 23:06:34 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97B2F4;
        Sun,  9 Jul 2023 20:06:30 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-78654448524so106913639f.2;
        Sun, 09 Jul 2023 20:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688958390; x=1691550390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tzyqXosdnDO68LtdH9MXWVaSATpoziQrNIP/nKesUIU=;
        b=ZgjBUwWkJkWTLTgZjnUl36bz4hxN+A/JDp2vGU5E8dlQ/+FtHwSQ4j5JH9bVccfcQx
         u/PQyu6P3cwxEXMM5oGk/aLjfuPLPTzvekiafWvtjc3mEpZW7Zppqrab3eslKKDccOlL
         b+xn9eO7dXiVFL6jpvp3S96xBPsrPU2fK/7qNE0+gK4Yr5osxV/R5pxBzyXnDlZ+BZvd
         tfmSVqcutKhiici1jMwMD4RmZik4S11EOfxtYlzBDKfjDpHy0Es4QygPcUi8+ayZoFX5
         ULk6pjSUo36zNQphYyUAKZOMZ/9H/gzUMJyTjvred3eAhUfqPQ6n8ghcYf81hSkjGjbI
         4awg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688958390; x=1691550390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tzyqXosdnDO68LtdH9MXWVaSATpoziQrNIP/nKesUIU=;
        b=LHXy7eeEShiu9tJnGvFWNMNPdSQRRh+KRkbOSaQnN5/e1HrT51Ge7sN0Eb3h5wcsLx
         GzyjiCS/pLk+aJU598OOw3YlsnuBEhuL4W93SjVp3bU986mC13LrF9B022Vms+bDq93n
         y/L1IUsL8FAJdvtzVApJVLEgkK2MOa7hFDULncQBeuBS1oDS2D35MUckCT7enl4uynlM
         L6SLoRg/3wwHnwYpgLXyp2kRucxcpQFPaRwjOoH+UWOfzw6cvDuGu5+tOneiCMUntkvA
         iP11sszoZAdfuCsU5qF3U6f9c5z3c88pEFw2qLZZg1yj6ccqOhhbm2qz1vWNmV/XcGWu
         cE7g==
X-Gm-Message-State: ABy/qLYvlGZvNvuhH83fMcsHF3LSjlmw3H8v8KkUgdNkWtuxaz4JtEPs
        FeocMIK43IMQ/Kbcg7Urqd8=
X-Google-Smtp-Source: APBJJlE8CT21Yy9HxFydGW3qQDl6rJ1NBWg0JbeZFSqKmqU4woX9tlMfu/gL47Aw5RG60sJwrhDwNw==
X-Received: by 2002:a6b:7b49:0:b0:780:bf50:32ce with SMTP id m9-20020a6b7b49000000b00780bf5032cemr11185666iop.19.1688958389884;
        Sun, 09 Jul 2023 20:06:29 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id s11-20020a5eaa0b000000b00785cd25010esm3318732ioe.11.2023.07.09.20.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 20:06:29 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@kernel.org>
Subject: [PATCH] wifi: mwifiex: Replace strlcpy with strscpy
Date:   Mon, 10 Jul 2023 03:06:25 +0000
Message-ID: <20230710030625.812707-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().

Direct replacement is safe here since return value of -errno
is used to check for truncation instead of sizeof(dest).

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 drivers/net/wireless/marvell/mwifiex/main.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index 1cd9d20cca16..8d3c4bcf9c89 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -725,9 +725,8 @@ static int mwifiex_init_hw_fw(struct mwifiex_adapter *adapter,
 	 * manufacturing mode is enabled
 	 */
 	if (mfg_mode) {
-		if (strlcpy(adapter->fw_name, MFG_FIRMWARE,
-			    sizeof(adapter->fw_name)) >=
-			    sizeof(adapter->fw_name)) {
+		if (strscpy(adapter->fw_name, MFG_FIRMWARE,
+			    sizeof(adapter->fw_name)) < 0) {
 			pr_err("%s: fw_name too long!\n", __func__);
 			return -1;
 		}
-- 
2.41.0.255.g8b1d071c50-goog


