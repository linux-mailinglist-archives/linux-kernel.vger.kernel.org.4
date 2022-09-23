Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170F65E82AA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 21:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbiIWTr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 15:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbiIWTrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 15:47:49 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCFE12EDBF;
        Fri, 23 Sep 2022 12:47:47 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id u132so1088924pfc.6;
        Fri, 23 Sep 2022 12:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=DO6nah4yVA5+JPZBNm4fAwSKmX1/HsdS5q9wlevQQFo=;
        b=E80649AYkMcSdcAceqdNIgFNs7OVCndbieNeb4tdnO+tDdoGgS2eVtZACqqFYag5B7
         Sc48ChMuN51L3mbU83KBQsdbVfBA+WY8tP5qAKY9LjCoq4qcuiVtLJVs65V8r0RtJ8KC
         FlHFNxqhLkHnihZP5rnru66Llvef+Ut/cF/m9E47d7RTgQwiMh1Uo4llwYx3jdW/fvQE
         SeyyUOIAG/B1hZ/FEIter5YtnmU+K8zdLvmB2ytClDzSC40IfBj3D3RnxNe+rvPxFTqP
         JkGM0MfG+HzFwwpbh4eLNB9hT4SRY9N+IU+HdUJbiqufT8UZXIEADhSTlVT2RWZn1SSA
         K/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DO6nah4yVA5+JPZBNm4fAwSKmX1/HsdS5q9wlevQQFo=;
        b=xRzJ/29VOr1yU5wzpqRo/v2JHnmsk8+6KbafaRsy8TBoGBm9WU44EAaHZ2FWwTOJBk
         qh+qlpehVqTomTo3KGJQOwhIaxHQLhNs45K+qJYs8Wnzl07T3tuGSJLBX45tTCCxHjFp
         vMw4coXIBcYDlzfY8DbwkaKXmfimeib+V+0teK6d90GIcWdj25vIPmOLaqkEmIzbzXYi
         iw2DaYDd9Zur1Nrdzxp0a4l7/Z3N4Dn8vOgYROdhTch/tYm3QzKJmfvt7K/xe4AwCaol
         YEPUEYAtzDtoN1dR6oOsWLyowyf2OJF381ExHeTygQHByaTxm4e+mW5JVwIjq9+o0ow1
         k0tg==
X-Gm-Message-State: ACrzQf1zi7gcxJuIs4NqFYaYO6OIjXYHIhACWOwkPTEhOSg8HJBrH/IU
        7hd5L6sAqnRopIkXcByVtb0=
X-Google-Smtp-Source: AMsMyM5jr6W45nG0ti4UHqzUQpqznTTn+4bzKqgajLbnJkp1K9WP9xXvP5FeSAGPGoUWq7F3y+bV8Q==
X-Received: by 2002:a63:3348:0:b0:439:db24:8b02 with SMTP id z69-20020a633348000000b00439db248b02mr8891864pgz.425.1663962467029;
        Fri, 23 Sep 2022 12:47:47 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:8b46:be3c:2c54:68a5])
        by smtp.gmail.com with ESMTPSA id e7-20020a170902784700b001753cb9893csm6405187pln.187.2022.09.23.12.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 12:47:46 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] Input: imx_keypad - add missing linux/input.h include
Date:   Fri, 23 Sep 2022 12:47:37 -0700
Message-Id: <20220923194738.927408-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220923194738.927408-1-dmitry.torokhov@gmail.com>
References: <20220923194738.927408-1-dmitry.torokhov@gmail.com>
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

We are going to clean up matrix_keymap.h from unnecessary includes,
so the driver needs to include API that it uses directly.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/imx_keypad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index ae9303848571..e15a93619e82 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -7,6 +7,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/input.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-- 
2.37.3.998.g577e59143f-goog

