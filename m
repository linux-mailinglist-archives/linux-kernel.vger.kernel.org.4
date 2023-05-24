Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E865E70F912
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 16:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbjEXOsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 10:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjEXOsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 10:48:30 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20987130;
        Wed, 24 May 2023 07:48:28 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-76c5558ba95so32047939f.1;
        Wed, 24 May 2023 07:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684939707; x=1687531707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fXem3yKXOihJJdx17tUBQkjwgvhxr2WQLiz8jXaVkhE=;
        b=FlMIwTim4LKgFxNH+zhsenhJP4RenIiD00DuPobzZ27zTWHuvDDRdkoGECsDn4pA96
         rkU1L103lIgwpF6y43ixGXnqBUUuIprszE9K+CKXdIQWIfRVutaWNL1MgscqT4Ebumsl
         W6rPW03pey7/xLqD9DxGYOy3tLc3ChnBm19L48mzT9aIrJCrW/VYL1W8LfRH6uPXwCZQ
         luv2DwDSGJYi1JKn6Wzwpyn3tYFfjYdJ/t8VSBqCEvO3w1hNuHMBNPswH0ieG9a2JQRi
         TUfrb6eUmrdziGVOnlIYXB/7chtRC7Pq/4K7+JFXFInkLgax0x2fJhoKmNmKdeOWzmul
         Q6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684939707; x=1687531707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXem3yKXOihJJdx17tUBQkjwgvhxr2WQLiz8jXaVkhE=;
        b=PHOwvtng37BpTMehbTyD9v6LROvhyMrECkASOhcFmCnh6E+PSpi14I4yN6GcrHHyfL
         PVnEvAnzWiVEWNKqsPNiL9wTywuJvtf5FfSg5ZTYSEx29o3twTKo5z7xg+4/M1BixmC3
         Blkmb7vDESnvMr6bizqXEjOV2KimEKmmZ14YHw9jMpngxyv3HedtlLYjMn4mJg9f6qBf
         IQkDMa5tyu35y6fZ41wXtVgmWDmL4/jUXkLklVExb03YKnuHwmPh4maDq3OLVy/vsUXn
         6GMAYWoL53RcW4hIMgSIbBWArEIDRi67jDT1qkAWV7/ySisCwPQ5TLVmL7VhEAVXOjOE
         K3yA==
X-Gm-Message-State: AC+VfDwfA+V1UKosug2zPInDGyDKvPs77g9ZBeEdqmdqkXypQmgJh2cb
        inTxAMo13mQ5bSoDYu1IS0m0U6e4yYRAZA==
X-Google-Smtp-Source: ACHHUZ7JrqUKTCOM6ub887EdDypsGhllvk8ADf8XHgpBckkrWx13A81YEYd+2AW3oPp9iVKGhBTZ0A==
X-Received: by 2002:a6b:750c:0:b0:760:ed78:a252 with SMTP id l12-20020a6b750c000000b00760ed78a252mr11717592ioh.9.1684939707197;
        Wed, 24 May 2023 07:48:27 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id r22-20020a6bd916000000b0076efc7f0dd4sm3398910ioc.42.2023.05.24.07.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 07:48:26 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Subject: [PATCH v2] leds: as3645a: Replace strlcpy with strscpy
Date:   Wed, 24 May 2023 14:48:23 +0000
Message-ID: <20230524144824.2360607-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
MIME-Version: 1.0
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

Part of a tree-wide effort to remove deprecated strlcpy()[1] and replace
it with strscpy()[2]. No return values were used, so direct replacement
is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
v1: https://lore.kernel.org/all/20230523021150.2406032-1-azeemshaikh38@gmail.com/

Changes in v2:
 - Updated subject and commit log.
 
 drivers/leds/flash/leds-as3645a.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/flash/leds-as3645a.c b/drivers/leds/flash/leds-as3645a.c
index bb2249771acb..7dc574b18f5f 100644
--- a/drivers/leds/flash/leds-as3645a.c
+++ b/drivers/leds/flash/leds-as3645a.c
@@ -651,8 +651,8 @@ static int as3645a_v4l2_setup(struct as3645a *flash)
 		},
 	};
 
-	strlcpy(cfg.dev_name, led->dev->kobj.name, sizeof(cfg.dev_name));
-	strlcpy(cfgind.dev_name, flash->iled_cdev.dev->kobj.name,
+	strscpy(cfg.dev_name, led->dev->kobj.name, sizeof(cfg.dev_name));
+	strscpy(cfgind.dev_name, flash->iled_cdev.dev->kobj.name,
 		sizeof(cfgind.dev_name));
 
 	flash->vf = v4l2_flash_init(
-- 
2.40.1.698.g37aff9b760-goog


