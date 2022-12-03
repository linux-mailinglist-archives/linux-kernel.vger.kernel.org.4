Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF87D6418F0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiLCUZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiLCUYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:24:37 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BD01F2F9;
        Sat,  3 Dec 2022 12:23:44 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h10so3415543wrx.3;
        Sat, 03 Dec 2022 12:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Up5dQTTsoBnpPkus/RnPpyOv/wcTdYY1/9hyjLc4Nb8=;
        b=X+6aIRGERVfHRg1mgBTDPtiEhf0rOxEg9hSC6rK1xLzO1FBj8vcm89TWyGwY6jmiKg
         YHBFB3HQipq3vxD9BkZZUy+ziqUuMAM8XreUrsmf84EUFK+AnLrnJzxZZ0q8aXvORA4m
         EGd0KYhJiINKGqNWiEZwelIy73Z41aH5VES4POJTE+Aws0NV1g3Ch/HyC4a2W6/WUNuU
         sjrYayLXnt8e5aQ1RFojsmUfBbGZ175iqoJQD1SgjxqaGGldRzvkPNz3i3mRdOdw4UKN
         bhV8Q/JCTLeD9ZSDyHPCN/ZE0JK6xbE0ABEXMea0PMPZ0qvEX4gZh/4VvUlZfO/UPchS
         ayrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Up5dQTTsoBnpPkus/RnPpyOv/wcTdYY1/9hyjLc4Nb8=;
        b=ARE6a6iC7NM37WtpaDuxTQEsotu8wFHxxSLrKj/vyZl7BS5KDgaE1yb+3m9XrjsH3t
         fKhNLtkaQtMbGcPAXiXZdEJDVm6xV5/c/nDn3MGbqKenuE14HgQKdmX+FzLwdVfFXbIF
         pNLs1HUjRJe0A90F6+xDQsFKcRdNGJ7sOatB0EghkBqLKn8w5m6dB8WB6IdyxiaXIL2S
         iHdDWb+i6lbN81KPBgMwYD+5hxmyMGGVhbM3nTkLQg+KwyJwlKayAKgNuMYQuTqlh103
         Uc+LhM406fseNikTdsgl+ElUrty2lepB0T6VI0o+lLF/7Il/IZxQ6KzL1Feo7VP/m0zR
         Stww==
X-Gm-Message-State: ANoB5pm0yPsHntvbdglcIZ78fJgjuh2nNkTB8TnSONVRAd6Zr1AlwlS/
        uTjmT5J8WaafqZu84R+tetdA1IQClIc=
X-Google-Smtp-Source: AA0mqf78bkTzvsovMvdMREnA4zcdWPNNfLg9VmWYTXOY9hddFT9UIOXIlYeJKnzI82s3ztn3k9BtSQ==
X-Received: by 2002:a5d:4d4e:0:b0:242:c59:b979 with SMTP id a14-20020a5d4d4e000000b002420c59b979mr22228797wru.707.1670099024603;
        Sat, 03 Dec 2022 12:23:44 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:44 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 34/41] time.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:23:10 +0100
Message-Id: <20221203202317.252789-35-alx@kernel.org>
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
 man2/time.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man2/time.2 b/man2/time.2
index e9a09ba9b..2be79cf78 100644
--- a/man2/time.2
+++ b/man2/time.2
@@ -16,7 +16,7 @@ .SH SYNOPSIS
 .nf
 .B #include <time.h>
 .PP
-.BI "time_t time(time_t *" tloc );
+.BI "time_t time(time_t *_Nullable " tloc );
 .fi
 .SH DESCRIPTION
 .BR time ()
-- 
2.38.1

