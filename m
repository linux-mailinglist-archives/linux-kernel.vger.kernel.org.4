Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9AC6418CC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiLCUYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiLCUXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:23:31 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3F51DA48;
        Sat,  3 Dec 2022 12:23:30 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id bs21so12958795wrb.4;
        Sat, 03 Dec 2022 12:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdamdvptz+udrfzE7wjC+J8D4zMtqngP6gzigrPTw2w=;
        b=ivMIluM2PGw/q4qM67rAco6vZPFi8A8En8vqkL6iSDYmzlQAudRmRkZti+DvRcOYW5
         aQNd37J+uYe6Oh///X52Ru+hqNxWfclTWr0rZ+W+7a/VO2r3bZJqA89MnApqyEdLyJMg
         jUQ5fOeWY5dO8XNbihWgZeZEp8gIJFQk1WRdXDzlEq/VnPPZ6wL+5yhCROlvyyOhNB8X
         GzU28FZid6c99cCO/kP37dPHl4xZWqAX6FHyh6NAWvcVT6ff+XzSzq+Y/CAVYtClq0g/
         RfHs+1D3mBq3uV6oR+XybKG8FcmiwkQud5C9XVZBko7g0zJmQQrp14rp+PolaNeAZhOL
         0OIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdamdvptz+udrfzE7wjC+J8D4zMtqngP6gzigrPTw2w=;
        b=SGBGCqY0WtNQCmtTO1ipwyQgsnt4Pd99TfIqWw5Y51nRJDZcskeVN/m4Ejb13n1pM1
         5dymM8JDM3rb2g5Q2w2u8NK5T9G0OvnCbGRyXT71aKPUUKInQYaRJsEXRVWtnWmKB8vP
         fVVLKHB9BYdAYd1IqJSUjqkZsAWEut81Cm7Uil9PJO3BfbZpFXIZWnofhI/o6dQ2VQLU
         QACY+AMZVjXfG5vHX500ifA5YY6YelN6Mr2EGbGXPhtZWjZHDEIc/GZ/zdLRdct4pjgX
         BjoitEVJ7f0FBWMKVQg9ckZjZmB8pM+HmuLMFrwbYEUgca2v6/Ppbwnw2uOvncjdh0pZ
         6UGA==
X-Gm-Message-State: ANoB5pn+Cvo2Lw3Oqgua8kamclHzJ+RlkuZgkfujzA+NOM05rqICcaYp
        KLXANeqdY0MxZWgLDPH/IjnNIRwtTIk=
X-Google-Smtp-Source: AA0mqf5gWljg1lk7tgd/uJbzwtxRZK5D+43frV86xXsyxZdYe5P9GWUlGigIW5bwY9z9A/PE/n8lGA==
X-Received: by 2002:a5d:46d0:0:b0:242:91c:a12f with SMTP id g16-20020a5d46d0000000b00242091ca12fmr23577007wrs.524.1670099008600;
        Sat, 03 Dec 2022 12:23:28 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:28 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/41] getcpu.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:22:48 +0100
Message-Id: <20221203202317.252789-13-alx@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221203202317.252789-1-alx@kernel.org>
References: <20221203202317.252789-1-alx@kernel.org>
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

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 man2/getcpu.2 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/man2/getcpu.2 b/man2/getcpu.2
index 0e7293105..32a5e926d 100644
--- a/man2/getcpu.2
+++ b/man2/getcpu.2
@@ -20,7 +20,8 @@ .SH SYNOPSIS
 .BR "#define _GNU_SOURCE" "             /* See feature_test_macros(7) */"
 .B #include <sched.h>
 .PP
-.BI "int getcpu(unsigned int *" cpu ", unsigned int *" node );
+.BI "int getcpu(unsigned int *_Nullable " cpu ", \
+unsigned int *_Nullable " node );
 .fi
 .SH DESCRIPTION
 The
-- 
2.38.1

