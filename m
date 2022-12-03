Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2E36418E3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiLCUZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiLCUY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:24:27 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DB91EC74;
        Sat,  3 Dec 2022 12:23:39 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m19so5926355wms.5;
        Sat, 03 Dec 2022 12:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoA34bqEZjRu4E0ep4uC+eC6OuqLa9/6w768Dcdm9MY=;
        b=XJZofP72mBmvGm7sd6DGSdOc8QdtLFwcUyrew+c4SDRoCphT8qyRvSVXlZRowu3+lL
         sNew/YOk+b/JnbNag8RSAF2Vra/rPy5giw7NNBIjI8R4r9yRynAQ4jdn8QFpeiNt/WqW
         sRFVLgKuya1nh7EN9L4Cv4sdBh0qxDylw8q2VXMdC47Lt4WgTKnyGkD4YkB3Dm3l5Ed2
         RzMXyghK55Xxq9cSSR0V/4D7FP/9W37lUBFqZ33OBnkHIPO0Go/VKg3mXeNchb8y98Ea
         frwJtJPh45Q9gME+V5kvipn4kYOLBqHoLzLE6Fou6lqAqHPyiSL8xmQfBS1QNvrUOn51
         wiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoA34bqEZjRu4E0ep4uC+eC6OuqLa9/6w768Dcdm9MY=;
        b=W5W3mwrDMxV/5PB2R9bP6Qu2ceq0JyKdgtqIMFbZzjCYE+6+d1US3Auuw6QXhKNwiG
         15N9rQXbcKvia3zPJtYVTwlZoU2KRouyS6FMmlhSBrV9CfvdHTXoyYioii7YTGGBiBjR
         3aNoGiNMxnB3ftAJWHJ5FPeqbsGbis9+xP70xtyHugtL9xUH7miEC+CYD+fQthmSx4pl
         oqxzpu7PntRzb1mJO9iP/7B6rtyPCemagNNjlzn/tSqb8UUge32hX3KUWXD0O0fxzUFR
         mOt2Y1OjzxsMUpw2kA8fY6eR2AJrlaSLxXaMkvJVtgCik0KWPYNvurkXgUpZqCJ05IxD
         BJOg==
X-Gm-Message-State: ANoB5plD58yuQAbCKcglthFNf/mkKdBCM1xwCg98bon70gxXXbOpNrKI
        R2xzw/K13LaWaNXEjhPyPMc1EAJ+h3g=
X-Google-Smtp-Source: AA0mqf7I+bCR/5EL+immDyRLMaGJK7BsKtsJhp1TSVZHe2N4wgUiKUAX6cgONnotU5J9YVYxCYc9nQ==
X-Received: by 2002:a05:600c:4f44:b0:3b4:7a99:b22c with SMTP id m4-20020a05600c4f4400b003b47a99b22cmr18395260wmq.11.1670099018801;
        Sat, 03 Dec 2022 12:23:38 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:38 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 26/41] semop.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:23:02 +0100
Message-Id: <20221203202317.252789-27-alx@kernel.org>
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
 man2/semop.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man2/semop.2 b/man2/semop.2
index ebe37a55c..ad184829e 100644
--- a/man2/semop.2
+++ b/man2/semop.2
@@ -24,7 +24,7 @@ .SH SYNOPSIS
 .PP
 .BI "int semop(int " semid ", struct sembuf *" sops ", size_t " nsops );
 .BI "int semtimedop(int " semid ", struct sembuf *" sops ", size_t " nsops ,
-.BI "               const struct timespec *" timeout );
+.BI "               const struct timespec *_Nullable " timeout );
 .fi
 .PP
 .RS -4
-- 
2.38.1

