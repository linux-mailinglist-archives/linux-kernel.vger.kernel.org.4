Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7287729B3C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjFINPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241268AbjFINOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:14:50 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A045D30D6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 06:14:43 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56991d8e2b0so22073117b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 06:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686316483; x=1688908483;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aKoNJvbX86CFgK5ftRlV2RMaFwZxhmASgVaU7V7z5dM=;
        b=1Pd8BvtZ+WUn7Z94hUyQiLfhZuEgt2ba/oiDJHBbX9L+3P3DYWxpWFUgc+EDE+AXmq
         1pCTd78sH/OYDzgz0Iqgm203DnP2xFpe0r+fKv/iUXUDGp3pWtq1txrTyFuCFSEJq1dr
         hWKaM/GGvBd24N6SiJk2FU9TPiNgc4bho3mPH3dglNz5jvvvPZw2fq7VF788LQk3SgWp
         8F3c2xWbks4CIlW3ioJ05Ox8wsrzyZ861/LzFB/koh78Ubwj33Ux1G0s5owOHR7mehtU
         rHS3cWSy3ObXaNBnB4lNFJn1RJOdemnGni6ZfKaS02+ii9LBhNH6o07pyAoi7UAo1A/F
         jluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686316483; x=1688908483;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aKoNJvbX86CFgK5ftRlV2RMaFwZxhmASgVaU7V7z5dM=;
        b=DXfzZ5TSUZK3+CAsuofY1FAxi1T038VROpSIudRBAZz/RuBNKOshlAlYsWPVXkPzpU
         gaEkAgGTji2n7lqdnWuhqbji3LVaewZ2O44FYZZiTMLwPKfe6p/l/Oe1aaLLNVoTpO04
         oOZMtRpWLWKL5X/eu3nG6BhPwpprAG0L7Vi/9k/QcivZGPPtLpoaOmaAfkkadTl5EtO1
         eouQyy1lNqHrr9kZXfUBNM7EVOBjgegVv+kwT6x67laXMGRG6BiQ7yrJtSnfMGc1xf4H
         elsK0yXRJg9+zOBPL4gk4NRkuAQThEv7B6X02Urq1xaf295qDY+PMbjjc2xrD2qKOamD
         O1fQ==
X-Gm-Message-State: AC+VfDz45V3Ri5vomxLM0BKFOJQyN3NhfJpJK396HDVacgUlCtiNM0B2
        9+5MfBPEqyV3n2zH9Vl1MSG1MvcCvWNDXCi6i8hOYfMiA4OyzotAoQiIbD6eIXP5Sq1Ec3+jjX8
        2OAhRX5CtU6CclcyR9EsRpinTib1HbcrrluNRdI0fwaeDw3L7JldYbVJsskUrja9XM7p/aAxZxv
        NABlGp
X-Google-Smtp-Source: ACHHUZ65eW0Cvt/Lr23wH9gM+PvvQydufdN0BRWa+5YgTD+GyN1nlQ08wwssJTCpGLP9opj8dC6pAs/nCqY+mBOR
X-Received: from jordy-spec.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:f2f])
 (user=jordyzomer job=sendgmr) by 2002:a05:6902:34c:b0:bad:14ac:f22e with SMTP
 id e12-20020a056902034c00b00bad14acf22emr410056ybs.5.1686316482832; Fri, 09
 Jun 2023 06:14:42 -0700 (PDT)
Date:   Fri,  9 Jun 2023 13:13:55 +0000
In-Reply-To: <20230609131355.71130-1-jordyzomer@google.com>
Mime-Version: 1.0
References: <20230609131355.71130-1-jordyzomer@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230609131355.71130-2-jordyzomer@google.com>
Subject: [PATCH 1/1] cdrom: Fix spectre-v1 gadget
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
 drivers/cdrom/cdrom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 416f723a2dbb..3c349bc0a269 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -233,6 +233,7 @@
 
 -------------------------------------------------------------------------*/
 
+#include "asm/barrier.h"
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #define REVISION "Revision: 3.20"
@@ -2329,6 +2330,8 @@ static int cdrom_ioctl_media_changed(struct cdrom_device_info *cdi,
 	if (arg >= cdi->capacity)
 		return -EINVAL;
 
+	arg = array_index_mask_nospec(arg, cdi->capacity);
+
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
-- 
2.41.0.162.gfafddb0af9-goog

