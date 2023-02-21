Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1302169DAE3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 08:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbjBUHD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 02:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbjBUHDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 02:03:18 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD48E144AE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:03:07 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bp25so4570687lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lPYFEzkWt45w45KoW6C4RDWljtvSD6NfX3uQqoyfGo0=;
        b=PiEaUTyKR+BZV1KdOYGaOo0Uih1cIbaC9Lzaa5cF1VTZPWQp523PuApZ5xP3Gr8xjl
         XEv87JwBL02FqisWBLvEd6ltv2bVAzwJPrKkVo4YABKyqaSYIvQyNWJj/vAPz5dara9M
         /flcqnOCtP7fksSbz5LD4Y3B2c9BukcHkOQw+irxTStuFYXlcS5e6G+cnALknEX8/aev
         gHrZol9o5+b0cOuWyl/zEYK7V9TJvVqGNNmc55dpxbE6wv2TTAQEkjPZayUGaEDFOTjb
         Z9Zx+mMYLz/xPeJTLpmblhvolK5bKElXYxCQshoRvR4592QaFGyYbOLnvm3N/8YuhmKk
         pG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lPYFEzkWt45w45KoW6C4RDWljtvSD6NfX3uQqoyfGo0=;
        b=2UmAW4/8+x4ksmGYKOxP45QPrZMs06acaJt7YkQ6DEzHiDHdLkUjKYbOCw3Gp+LVvF
         qInjiF8egug0gzCFGWG+1JOUXpPdW+xUUp832B+2D0HOCmZo5V8ns9MnF9VgI9vOPp6m
         +WAMqe6i91XSwB/1Yo3hQDymN+CK64eGmw3m7jJYVJqxNLNcQwqHpG/Bavp9+XWIFzfj
         BI+2jVoS7fX/byeaVJ5orWcnMCNYle+2O5eKSQ3Wd1RAsJlBdu1s2vyJWV3h3GpcbJTL
         5zNl0x/B3F+bukivdjsgTYYwZsZiUXhzGZoATytN7SFfOtgO3Aq2ccsHxAtpRbnTDmTT
         TC+g==
X-Gm-Message-State: AO0yUKVvnPnc3jr1vH7RQQctqzAtW2mO7zV+BSOVX+SEj2uPBSHh6+sa
        iVZvZUevZVrsMpY4spP2XdihMw==
X-Google-Smtp-Source: AK7set9mpDbHCk/AdCr+GQzVcUK6fnXr6VHd1TUSH9y7g/NxXBzMWCsg3GVkxAh76WxtgoJ6TmI2xA==
X-Received: by 2002:ac2:5308:0:b0:4dc:8366:2ea0 with SMTP id c8-20020ac25308000000b004dc83662ea0mr968795lfh.5.1676962985988;
        Mon, 20 Feb 2023 23:03:05 -0800 (PST)
Received: from localhost (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id q6-20020a19a406000000b004cc800b1f2csm642432lfc.238.2023.02.20.23.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 23:03:05 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH] selftests: ir: add config file
Date:   Tue, 21 Feb 2023 08:03:01 +0100
Message-Id: <20230221070301.1323044-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building and running the subsuite 'ir' of kselftest, shows the
following issues:
 ir_loopback: module rc-loopback is not found in /lib/modules/6.2.0-rc8-next-20230220 [SKIP]

By creating a config file with RC_LOOPBACK=m, LIRC=y and a few
IR_*DECODER=m in the selftests/ir/ directory the tests pass.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/ir/config | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 tools/testing/selftests/ir/config

diff --git a/tools/testing/selftests/ir/config b/tools/testing/selftests/ir/config
new file mode 100644
index 000000000000..a6031914fa3d
--- /dev/null
+++ b/tools/testing/selftests/ir/config
@@ -0,0 +1,13 @@
+CONFIG_LIRC=y
+CONFIG_IR_IMON_DECODER=m
+CONFIG_IR_JVC_DECODER=m
+CONFIG_IR_MCE_KBD_DECODER=m
+CONFIG_IR_NEC_DECODER=m
+CONFIG_IR_RC5_DECODER=m
+CONFIG_IR_RC6_DECODER=m
+CONFIG_IR_RCMM_DECODER=m
+CONFIG_IR_SANYO_DECODER=m
+CONFIG_IR_SHARP_DECODER=m
+CONFIG_IR_SONY_DECODER=m
+CONFIG_IR_XMP_DECODER=m
+CONFIG_RC_LOOPBACK=m
-- 
2.39.1

