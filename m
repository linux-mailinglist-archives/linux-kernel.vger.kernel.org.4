Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF946B5B45
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjCKLnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjCKLnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:43:12 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0F6196BD;
        Sat, 11 Mar 2023 03:43:08 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id g10so2019686eda.1;
        Sat, 11 Mar 2023 03:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678534986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mULnghyNJnZxFvPP0TSkUJByh26mvIxUqvGvaqhURFQ=;
        b=oYcx3S26706sIf8axRV0CrFa84wmfoCEyo1MVNSnnDvjGLVUv0T/AGMLEUe8auA6gd
         hJl2jADYXKEsuyOTMickvqEGOSO0XV0M+4vpUjoXOiwQI03QpjCFwEXDEea4LVdjoc8i
         5PdWzNPb3wzkKP9FFCngLJoObd26QiHhEhdKBJKw53bq6dbu/PnBlK+TCeG3M1EaeTm6
         VQfgAqULY9xTgLuL82u1z22IB78ukMxQ+a+Zy3JQSd9ngueDDBnOlEWV95Y4nP0ykou8
         Y6WTBoiS2MyMlfsBdx/7upguet5SkSEVcGNRCVjVUurR7RZeBkO6+v1isAa8WZPLZK7I
         dWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678534986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mULnghyNJnZxFvPP0TSkUJByh26mvIxUqvGvaqhURFQ=;
        b=3pj0vZQrOeqV88lfGZZhzCkZAxNm3dE0UJqrkIqyoZpIogHnX2NzdJfan2LAV7/8qP
         nIc/o/OBd7WrhzPjNe23ySmRMNYGsO4hFEuFtS6/Nv94c8JwcvDTpdszuJY3++bpxTTZ
         NcVwOWRfLPzRh8F/WrkXlnO4yncDv+6iAr9UFD6KRR/wU+Xl6Cj4rP2b6tC9NICS+sZj
         bJLQ8JZozGS9K2X2rr/FDwvq+r/EH61A7hi0Za2tUpPsI1eGwUNUAISATgxcK1ZJWWvT
         FoIAfIsY813yM/8NjWHA+ACHA3Hcw3Y9vNoU6b4uun3HXQhwC3gDgMeRYdh3TPwClpBU
         xWkA==
X-Gm-Message-State: AO0yUKVz639oRRoJktTbsnniZ7/LicqnlUz/hBe2hZX6heXJmIvG77gZ
        WcfL4YH2Hyc66z5PNeA47w==
X-Google-Smtp-Source: AK7set+bvKiaOF4wano2KlCfgMwTZ2D6TQjJU5gXumZC0XjGCLh2HOKNOcSVhc9te8tWN5KK6Q7fWQ==
X-Received: by 2002:a05:6402:716:b0:4ab:554:37ea with SMTP id w22-20020a056402071600b004ab055437eamr26223736edx.4.1678534986609;
        Sat, 11 Mar 2023 03:43:06 -0800 (PST)
Received: from localhost.localdomain ([46.53.248.97])
        by smtp.gmail.com with ESMTPSA id x101-20020a50baee000000b004aeeb476c5bsm1088440ede.24.2023.03.11.03.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:43:06 -0800 (PST)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     masahiroy@kernel.org
Cc:     adobriyan@gmail.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] menuconfig: reclaim horizontal space
Date:   Sat, 11 Mar 2023 14:42:47 +0300
Message-Id: <20230311114248.36587-2-adobriyan@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230311114248.36587-1-adobriyan@gmail.com>
References: <20230311114248.36587-1-adobriyan@gmail.com>
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

Draw the menu box from position (0, 2) so that there is less unused
space available. Horizontal is not _really_ important but on small
terminals maybe it is.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 scripts/kconfig/lxdialog/menubox.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/kconfig/lxdialog/menubox.c b/scripts/kconfig/lxdialog/menubox.c
index 5c3addad89b0..5eb67c04821f 100644
--- a/scripts/kconfig/lxdialog/menubox.c
+++ b/scripts/kconfig/lxdialog/menubox.c
@@ -184,7 +184,6 @@ int dialog_menu(const char *title, const char *prompt,
 		return -ERRDISPLAYTOOSMALL;
 
 	height -= 4;
-	width  -= 5;
 	menu_height = height - 10;
 
 	max_choice = MIN(menu_height, item_count());
-- 
2.39.2

