Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388D45F25D5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 00:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJBWBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 18:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJBWBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 18:01:47 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38FC275C4;
        Sun,  2 Oct 2022 15:01:46 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id g2so5730617qkk.1;
        Sun, 02 Oct 2022 15:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=tqsBFgL9+rd3um/EuGk7s1FFr8uOtiz3PWtets2qQ/o=;
        b=MWAoPcamZ4v1KwEokdoQoCumbY9YK2ov0rfoIKs9kOsjbI8q5CyIZWgpwXh/Uxdvwz
         94WbqhOxEYDQbucWJ/PmpXt4B+Mf6DBvfkmGIXJ4/Ba9fD2yKAej6DHJfcsRS/H0GzzW
         o5jqrJwJOq+oQNeTakT1rMRHzEACvoHWdMPaiibuX7ojAAZg1MeVem26yix3Um+mBcvj
         6cQsSw6N3nYgVVlJChNddL2wBYzT66LurEa7J3IWsNRSlf4o+aYlwY4fQ+KhXDpMKF8k
         ftmBjVMo1N8NZUdUuHpmqd7Dd7TNXM1P6/at1m3tfibeOKLvDKRNJ5pqJBKTEzeriu0A
         5gtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=tqsBFgL9+rd3um/EuGk7s1FFr8uOtiz3PWtets2qQ/o=;
        b=f6IDQJnH6l/VYaN2qyG6KeF5QknrFzEfabGfYdhVhrVTA1KICg6IEAPYmjMq07G2dP
         YELor/N7qk2zsYZFOMwAKN/Og1a6o/faPpfBRdZzX2CbF2LMvBm8gQ1YV8FxJF2EfWlZ
         lsjml982QzQ6B9MutaJVABL5vFHXPZ9R/+TS5/5sboQj077if69XhvJBZzLoItIdXuPN
         FtLeEPdjU2HpKyyPn8TqIuvO1b33N/Jsq2jiq0MSbW0aeTVXVyBdlRo206dkpOfI8Ow8
         UxLs//pi21jmvXqFW+XRuY+bNrGUbAcrEVuAVV4HQUzrb5J6sBVJuOQQneNwbcxj8RCg
         su8Q==
X-Gm-Message-State: ACrzQf0FV1yqXSZ9FQrNMzufKndUMORGXewZJGO1GB3UlwP3rY/Zc9JS
        FreNTvbM/RbVTIra/heIMJc=
X-Google-Smtp-Source: AMsMyM7PM+agn6xUv7vCM09UxnYAxHxdJRopGyXQ64rHhiw8sqryFwEN9pG3x+Osq65EXEYFLjwLKw==
X-Received: by 2002:a05:620a:e81:b0:6cb:d90d:3021 with SMTP id w1-20020a05620a0e8100b006cbd90d3021mr12264061qkm.435.1664748105816;
        Sun, 02 Oct 2022 15:01:45 -0700 (PDT)
Received: from localhost.localdomain ([200.87.153.193])
        by smtp.googlemail.com with ESMTPSA id y3-20020ac81283000000b0035a6b89412bsm7821046qti.46.2022.10.02.15.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 15:01:45 -0700 (PDT)
From:   Henry Castro <hcvcastro@gmail.com>
To:     thunderbird2k@gmail.com
Cc:     Henry Castro <hcvcastro@gmail.com>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drivers: hid: warn feature report 0x81
Date:   Sun,  2 Oct 2022 18:01:26 -0400
Message-Id: <20221002220126.18849-1-hcvcastro@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, my PS DualShock 4, does not support
the feature 0x81 to get the MAC address. Instead,
use a unique hash to fake a MAC address, so I can
use DS4 to play Retroarch :)

Signed-off-by: Henry Castro <hcvcastro@gmail.com>
---
 drivers/hid/hid-sony.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 656caa07b25f..e3e9c58887cf 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2641,13 +2641,14 @@ static int sony_check_add(struct sony_sc *sc)
 				HID_REQ_GET_REPORT);
 
 		if (ret != DS4_FEATURE_REPORT_0x81_SIZE) {
-			hid_err(sc->hdev, "failed to retrieve feature report 0x81 with the DualShock 4 MAC address\n");
-			ret = ret < 0 ? ret : -EINVAL;
-			goto out_free;
+			uint32_t hash = full_name_hash(NULL, dev_name(&sc->hdev->dev),
+						       strlen(dev_name(&sc->hdev->dev)));
+			hid_warn(sc->hdev, "failed to retrieve feature report 0x81 with the DualShock 4 MAC address\n");
+			memcpy(sc->mac_address, &hash, sizeof(hash));
+		} else {
+			memcpy(sc->mac_address, &buf[1], sizeof(sc->mac_address));
 		}
 
-		memcpy(sc->mac_address, &buf[1], sizeof(sc->mac_address));
-
 		snprintf(sc->hdev->uniq, sizeof(sc->hdev->uniq),
 			 "%pMR", sc->mac_address);
 	} else if ((sc->quirks & SIXAXIS_CONTROLLER_USB) ||
-- 
2.20.1

