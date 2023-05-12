Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AF470050B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240097AbjELKPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240509AbjELKPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:15:38 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C50083DC;
        Fri, 12 May 2023 03:15:23 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f450815d0bso34299125e9.0;
        Fri, 12 May 2023 03:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683886521; x=1686478521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RuCdgK342xaUwQZ9bEdkQrH7w9PMG+n2cBtPbMJhyNs=;
        b=Xj6TOfNNbRUHBoDKz/x5f2lnRt9RCEtAThiGG67jFq60ZH1pHy76jlcaoQF/RjFjn1
         CF+XcpBjIuoncOb39gObCNWiqbxj1SabmnEFuGh1d9WjqdKWQwvZm9fyLkz6YNmsmu1/
         qALou3K0XZwyMjR4DBxcIeHmYCKfeVxcxIOA8kkvQjzgT7La4lf253yejcCPocw1C+NC
         uzzzl6QhXqJE7gv06hEpuvciKylTpTNiMTslco9fobV6EKiu19FV882H+E/7nuSs4h7y
         hk6EAEUHqinRRdELLAJImVCJd+kmD0fbh+9TGCqQDe+tjeElDcgy0IPj0G593W6ahr7x
         3N+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683886521; x=1686478521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RuCdgK342xaUwQZ9bEdkQrH7w9PMG+n2cBtPbMJhyNs=;
        b=RyOMZGzz3RiOdQNYwhzAgwnXPGqmVTxqtejR++HyIK/Rwz08ahWCbNk4LH/OkrYUip
         JXsHf8N32WOIK0fbXPnXGDLkTo0cGdCgpDBoQsroYluCAE3Km0HsSkhvuBCM3rsqu7lX
         NjGGAMGkacX7wCe7zY6EOj40Spa+0x+3vnPkzPTr07EDwOARqylLvB8QkBkCtL1IGzd5
         Up5QGisSsVNTCZWJmWKSDrr0QqTHJIhbtG+ddy+CNNCPxjqN53WulKRTO9TfTeyDvIBy
         pKZE1kTHkNL3vixmfvc4Y7PpIMtdIxXz5C5E09s6Upx1Tjpbu3Czb2zeCyzrJ2mFBw2J
         MRcQ==
X-Gm-Message-State: AC+VfDz3OTg8gjNcRdejn/BoeAwW0H1us+xZiw9CNjbXNqJhh65caUvi
        hfoIqi2FX2qvVqKH3Bg5agd0tIfnjG2Msw==
X-Google-Smtp-Source: ACHHUZ7WTfo0kI8boL1/5KTBFc5GcZeyUf/+fYCLuGrerAEaU0gBoRuOLycwW+wmAv70oKSxlIQMrQ==
X-Received: by 2002:a1c:7712:0:b0:3f4:1dd9:e9e0 with SMTP id t18-20020a1c7712000000b003f41dd9e9e0mr14641577wmi.7.1683886521079;
        Fri, 12 May 2023 03:15:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2f0a:b207:af00::b5e])
        by smtp.gmail.com with ESMTPSA id g14-20020adff3ce000000b00300aee6c9cesm23130059wrp.20.2023.05.12.03.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 03:15:20 -0700 (PDT)
From:   Alexandru Sorodoc <ealex95@gmail.com>
To:     Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandru Sorodoc <ealex95@gmail.com>
Subject: [PATCH] platform/x86: asus-wmi: Ignore WMI events with codes 0x7B, 0xC0
Date:   Fri, 12 May 2023 13:15:17 +0300
Message-Id: <20230512101517.47416-1-ealex95@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
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

On ASUS GU604V the key 0x7B is issued when the charger is connected or
disconnected, and key 0xC0 is issued when an external display is
connected or disconnected.

This commit maps them to KE_IGNORE to slience kernel messages about
unknown keys, such as:

    kernel: asus_wmi: Unknown key code 0x7b

Signed-off-by: Alexandru Sorodoc <ealex95@gmail.com>
---
I'm not sure what those keys events actually mean. I assume they are
some redundant notifications because no laptop functionality seems to
depend on them.

If there is anything I can check or investigate please let me know.

Thanks,
Alex

 drivers/platform/x86/asus-nb-wmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index e2c9a68d12df..fdf7da06af30 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -555,6 +555,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0x71, { KEY_F13 } }, /* General-purpose button */
 	{ KE_IGNORE, 0x79, },  /* Charger type dectection notification */
 	{ KE_KEY, 0x7a, { KEY_ALS_TOGGLE } }, /* Ambient Light Sensor Toggle */
+	{ KE_IGNORE, 0x7B, }, /* Charger connect/disconnect notification */
 	{ KE_KEY, 0x7c, { KEY_MICMUTE } },
 	{ KE_KEY, 0x7D, { KEY_BLUETOOTH } }, /* Bluetooth Enable */
 	{ KE_KEY, 0x7E, { KEY_BLUETOOTH } }, /* Bluetooth Disable */
@@ -584,6 +585,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0xAE, { KEY_FN_F5 } }, /* Fn+F5 fan mode on 2020+ */
 	{ KE_KEY, 0xB3, { KEY_PROG4 } }, /* AURA */
 	{ KE_KEY, 0xB5, { KEY_CALC } },
+	{ KE_IGNORE, 0xC0, }, /* External display connect/disconnect notification */
 	{ KE_KEY, 0xC4, { KEY_KBDILLUMUP } },
 	{ KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
 	{ KE_IGNORE, 0xC6, },  /* Ambient Light Sensor notification */
-- 
2.40.1

