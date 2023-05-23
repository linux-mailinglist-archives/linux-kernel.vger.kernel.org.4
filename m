Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FBE70D0FD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjEWCRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjEWCRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:17:08 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2628E49;
        Mon, 22 May 2023 19:16:44 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-3318bd82810so755925ab.1;
        Mon, 22 May 2023 19:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684808203; x=1687400203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0NB99lYKRnx+FQmUmcJ1k5C7PBLcbIKJhm9jHT8RwDc=;
        b=hwCrUSAAEVJ9qhd82IuiYCJHoSMMMhsJkiPHoe6M/a6asG7Ygr7txfBNgY7OoSF9ZK
         sgKGL+R+S4gIFGm9tN8igYrhcFvJgxKZXfjixMJaOEjFDNkN+nOiY0TaRsy6Lq1ZlDw0
         irfNqeY/EWrRGUUzdyskNK62WwfWKtidFoqvmtgSVROsAsFftKNv9Dt8eWISYJf8bIiM
         4olnjezwemse5QXT1lLejTEJbVli4gSwV1fGlD7SrOK81LaLWhWIGUL9uQ8DkAjGIVYA
         6QyGQ1OKEM8sTpOvVtH5PHcapU6ukipoq+t83/+dNqGA1r+AEqZPRKLCCjldF1Cgvj0+
         FWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684808203; x=1687400203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0NB99lYKRnx+FQmUmcJ1k5C7PBLcbIKJhm9jHT8RwDc=;
        b=BVCQTEsNEKWgU6pYq+1QLelf4zzNwzfQ71A0G2lEVAIUjN8+CtKL0x8uteww3YQPLQ
         btHAk/dGvaFmTxU3gnwopNxrFvbFF70GLl7i25bDvWrL4UuKSScI63oQwGcmLQ1v6pQh
         4HHmWxtnY9ET6Vj2Je8r2Zx+4A935FBy8wKJIl8zcNVAn1XzrWZVLZusawVTVG5rxWxF
         LUprman5f7bkECOI32b1pyc1otFSsFijfkA5aDssqCVFj4L28oqj3jgLh0/kNde2tlfs
         BsnenoxZk6D5a+fBM2zRorNTe804CmbOD7kSVJMomdl+J14ajmgM75qaCLQs12eSh3Zs
         uRng==
X-Gm-Message-State: AC+VfDzlrmlhwZK8NjPIIqR39MV9ThHr+R0PFRVAyR02ReTponfJJCTP
        gXPpfkcUebJKPgPbFOufoceZ6SCJrUXC/w==
X-Google-Smtp-Source: ACHHUZ6sehwshPL/GGR7VhnPWgP9QpjoGtYJvvM1p/nUUdwEr4yIvJzHsqFxLOY2ah38LSVi9qJajw==
X-Received: by 2002:a92:da8d:0:b0:335:9220:2ec2 with SMTP id u13-20020a92da8d000000b0033592202ec2mr7895806iln.26.1684808203113;
        Mon, 22 May 2023 19:16:43 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id s5-20020a92cc05000000b00326bd11f5d1sm2110237ilp.11.2023.05.22.19.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 19:16:42 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Christian Gromm <christian.gromm@microchip.com>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: most: Replace all non-returning strlcpy with strscpy
Date:   Tue, 23 May 2023 02:16:40 +0000
Message-ID: <20230523021640.2406585-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
MIME-Version: 1.0
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

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 drivers/most/configfs.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/most/configfs.c b/drivers/most/configfs.c
index 27b0c923597f..36d8c917f65f 100644
--- a/drivers/most/configfs.c
+++ b/drivers/most/configfs.c
@@ -204,7 +204,7 @@ static ssize_t mdev_link_device_store(struct config_item *item,
 {
 	struct mdev_link *mdev_link = to_mdev_link(item);
 
-	strlcpy(mdev_link->device, page, sizeof(mdev_link->device));
+	strscpy(mdev_link->device, page, sizeof(mdev_link->device));
 	strim(mdev_link->device);
 	return count;
 }
@@ -219,7 +219,7 @@ static ssize_t mdev_link_channel_store(struct config_item *item,
 {
 	struct mdev_link *mdev_link = to_mdev_link(item);
 
-	strlcpy(mdev_link->channel, page, sizeof(mdev_link->channel));
+	strscpy(mdev_link->channel, page, sizeof(mdev_link->channel));
 	strim(mdev_link->channel);
 	return count;
 }
@@ -234,7 +234,7 @@ static ssize_t mdev_link_comp_store(struct config_item *item,
 {
 	struct mdev_link *mdev_link = to_mdev_link(item);
 
-	strlcpy(mdev_link->comp, page, sizeof(mdev_link->comp));
+	strscpy(mdev_link->comp, page, sizeof(mdev_link->comp));
 	strim(mdev_link->comp);
 	return count;
 }
@@ -250,7 +250,7 @@ static ssize_t mdev_link_comp_params_store(struct config_item *item,
 {
 	struct mdev_link *mdev_link = to_mdev_link(item);
 
-	strlcpy(mdev_link->comp_params, page, sizeof(mdev_link->comp_params));
+	strscpy(mdev_link->comp_params, page, sizeof(mdev_link->comp_params));
 	strim(mdev_link->comp_params);
 	return count;
 }

