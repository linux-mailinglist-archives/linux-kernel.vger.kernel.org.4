Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD58E72C29B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbjFLLMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236745AbjFLLMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:12:14 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DE64491
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:01:14 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bacd408046cso6315626276.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686567654; x=1689159654;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vrffFIflVwj3iZ+X66V28jAT+UhtEyNmsUk1C8j7Lso=;
        b=7yfLE6ekqah/BETX2ejMRMU2HbxV+1ZKcTluxq1DmcKbbDcbnGGdVLqdUTvDqm24Ps
         jnPNtbmrm0WmOKyryH2cAteq3HcpL+ZVGXWX0XGs1BDHRXBf7rWUm/rp02EOYHMR8/Ul
         Wzh0iE9doj+UPTtGcEzPoBlfmX/GKwKUos6zTdE0lGNBWJvjW/JRgNoXLQsXZNRZd3Kk
         g5EdhuLvdBfPDDAGiCxtGqgmN4bgE71rjvmRD6ZO4JfPC8lsXoMGx8rEpk2n6mKw7LCX
         IHJGAJUeR/KaaM7YCfDh6ddekBLuIhfi1wHiPQgaiJRdMMapnIsl8/9Mhx94G/khcbpt
         x/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686567654; x=1689159654;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vrffFIflVwj3iZ+X66V28jAT+UhtEyNmsUk1C8j7Lso=;
        b=axuw53g0f+zdHoHklfNkrpO7pI8zEev1dCeYHFOjOG5G1D3Lbc7zehhXerG930ivpP
         l8LO9u6nmEtRjW1NUoDdi3cHvI9sRc+O5GNxsfqefeUc31ROEeGHHgopqJKi7JDlQ+8X
         Ohhm3akJTSqYFE235Bnw7YS1UmwyMh2AjAzHKErbAIebY0LgbEGsVHARKzdWdDyqbQen
         czBieausZrfcOa3NIqCE+7RV1JMsXol9AIvtH1u14vt5Pxv0iUlnTo9yWYnDYB1+0Rot
         TMlvawurU2/wcEXw8hOZJrx6Kpe2DjX7v6I1C0w0wu2VowWtciK3cGPkYtTRAE0WEpyH
         TmGg==
X-Gm-Message-State: AC+VfDwZ3HFvBM/WClLWjRrbowLHDNnpYrTUgmdavbb4c7H7KBrXdEGM
        gcShr1Vqcq6Xq2DWa3g5uzPgtWyW1klOLenmO8juWJwrFcCu+S0hJLT+vMQxbEhTf8iPIMX9OKR
        0rGaFA2eJE3LJQFJ2dUIvaFZIys8aI1T3WsM4pP4gdeVUhTVjlvlkb0Zkajw07mfr87DsgIrf7n
        U6y+K8
X-Google-Smtp-Source: ACHHUZ5iSyB8OtDSmroULERNqS2J7iqvH+Z26zaoqRVFY4fcLIrlmcFQyV1IM49Lvy0ibAO0X44n3rDM5Rq0N9qM
X-Received: from jordy-spec.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:f2f])
 (user=jordyzomer job=sendgmr) by 2002:a5b:7c4:0:b0:bc5:2869:d735 with SMTP id
 t4-20020a5b07c4000000b00bc52869d735mr3201011ybq.13.1686567653910; Mon, 12 Jun
 2023 04:00:53 -0700 (PDT)
Date:   Mon, 12 Jun 2023 11:00:40 +0000
In-Reply-To: <20230612110040.849318-1-jordyzomer@google.com>
Mime-Version: 1.0
References: <20230612110040.849318-1-jordyzomer@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230612110040.849318-2-jordyzomer@google.com>
Subject: [PATCH v2 1/1] cdrom: Fix spectre-v1 gadget
From:   Jordy Zomer <jordyzomer@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     phil@philpotter.co.uk, Jordy Zomer <jordyzomer@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a spectre-v1 gadget in cdrom.
The gadget could be triggered by,
 speculatviely bypassing the cdi->capacity check.

Signed-off-by: Jordy Zomer <jordyzomer@google.com>
---
 drivers/cdrom/cdrom.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 416f723a2dbb..ecf2b458c108 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -264,6 +264,7 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/nospec.h>
 #include <linux/slab.h> 
 #include <linux/cdrom.h>
 #include <linux/sysctl.h>
@@ -2329,6 +2330,9 @@ static int cdrom_ioctl_media_changed(struct cdrom_device_info *cdi,
 	if (arg >= cdi->capacity)
 		return -EINVAL;
 
+	/* Prevent arg from speculatively bypassing the length check */
+	barrier_nospec();
+
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
-- 
2.41.0.162.gfafddb0af9-goog

