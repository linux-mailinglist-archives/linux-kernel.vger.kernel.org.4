Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D2769C28F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 21:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjBSUyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 15:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjBSUyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 15:54:11 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D321815B;
        Sun, 19 Feb 2023 12:54:11 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id m18so416571ild.0;
        Sun, 19 Feb 2023 12:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KYu3XNuTwS0jlSFZX19fhfeoSUZg41Uo8IwgBlc1qCo=;
        b=pY20O+nYakJEzqa78dbNrx3+5Wv9ARX/dMPHSCLYRLAhdg9UA3EMrKIWCpMVPXnH6C
         VcO+qcYjw+6caXt+ajoqmam42Otx3BFoAeUUMKrszkLnCzCCi4fioDxpffHvTMZ4eSyd
         CvCxmq3mzIrJLnqJV1pQFhMipabBkPHYy0M0prrwTYkJq/QCajDRCEnBy6PUF+96fkdd
         2zwmCHKDS9PuZaNCpeqLbnwCHzWva9ddOJDNNWso7s9Zf/moIaionm2chiShuRmK1Hhb
         2uYkuZIN4NupMZ2tl5h+NlcTktMKwDOBl9BnYsrvDsJ+MEKYLPQaxPv26qrs2Jvk+zsI
         j0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYu3XNuTwS0jlSFZX19fhfeoSUZg41Uo8IwgBlc1qCo=;
        b=eaZYiY1HS7vBcfS9rzR7CgOCEYq4GbBTW7E0WBzF8kEzDqjYH5FFtGeHXakWRc8lAX
         STYIjKeHdUbUhm7RylbfkVbaw51lLXrVvk+PK7A701VfrnZPczbuGZFcNvmWY+qvUo51
         bm6ch1kJPOkvWYmW/5JnozYTp9Rkz/5xKo2332tDdJ6YH6R+76s/SZmmq69rTqhqep5g
         5/b00eVPc0ChiDTEWyXhBcPXJDtzbT6rWzebB/spq4eiPHrD5kLWAQMairFS5TrFHxNc
         iVhNbbw2QtDrFHmmbOfqZEd1kY2PnSnv0KKEnv00AW+1+rC3nO/GFzVK4dptN3L/muQk
         e9YA==
X-Gm-Message-State: AO0yUKUiYgEcHkPqopjlH4NV2QVUnubMSmgXnlIO8U+uj8SI1yWzwJMc
        shp+knmezKHTzFhnSBgcVhZZVkrEW4A/Wg==
X-Google-Smtp-Source: AK7set8zCxo6BcCM+omE1aMry+pa+DhlU9QvQl6qKollNHoBf0LNiqDOQfH1ziKEC5QhS0GCU2QJTw==
X-Received: by 2002:a92:260a:0:b0:315:7a34:227 with SMTP id n10-20020a92260a000000b003157a340227mr149839ile.32.1676840049940;
        Sun, 19 Feb 2023 12:54:09 -0800 (PST)
Received: from localhost.localdomain ([76.71.25.91])
        by smtp.gmail.com with ESMTPSA id g13-20020a05663811cd00b003a7c47efde0sm3540372jas.11.2023.02.19.12.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 12:54:09 -0800 (PST)
From:   Mohammad Mahfooz <mohammadmahfoozpersonal@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mohammad Mahfooz <mohammadmahfoozpersonal@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Alexander Vorwerk <alexander.vorwerk@stud.uni-goettingen.de>,
        linux-serial@vger.kernel.org
Subject: [PATCH] serial: jsm: Use min_t instead of min
Date:   Sun, 19 Feb 2023 15:53:14 -0500
Message-Id: <20230219205316.3499-1-mohammadmahfoozpersonal@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Use min_t instead of min to cut down n further if needed.

Signed-off-by: Mohammad Mahfooz <mohammadmahfoozpersonal@gmail.com>
---
 drivers/tty/serial/jsm/jsm_neo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
index 0c78f66276cd..4cce1e423b06 100644
--- a/drivers/tty/serial/jsm/jsm_neo.c
+++ b/drivers/tty/serial/jsm/jsm_neo.c
@@ -350,7 +350,7 @@ static void neo_copy_data_from_uart_to_queue(struct jsm_channel *ch)
 		 * IBM pSeries platform.
 		 * 15 bytes max appears to be the magic number.
 		 */
-		n = min((u32) n, (u32) 12);
+		n = min_t(u32, n, 12);
 
 		/*
 		 * Since we are grabbing the linestatus register, which
-- 
2.34.1

