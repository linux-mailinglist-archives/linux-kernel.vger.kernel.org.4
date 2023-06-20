Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486C573636C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 08:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjFTGNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 02:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjFTGNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 02:13:07 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A607AC6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 23:13:05 -0700 (PDT)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 04869423EC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1687241581;
        bh=9wIeiW1ZFsba/KXCWD2PyQ1wr/96tQbFZf3Edkh0XnI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=XNMOL5G9XfhvvZEQhn0g7g0XAPI9nAIu9t4w85D11Co3Zn8I/mLSN5MUgiFeYdKLh
         rOp6FZaFa4N7vnABf5lgjVDR8mzeAdIM0lp8VYxBmn1ch0h01N294KrQS8oQigfoSu
         GVzW0wOKt3pskwzDVts/WkaBPmFXlMNmYbTETRw13Arh7Fd0ZJFK4CMbwkVi4ScyEn
         /wq3QjZ5T5L5lkfIDPog3j38S98ii4pa0g/iPubxdipJDWpyWd2EnsYgo4cuoaHcIq
         u8sEnfUxSzRmM9GAhHuxTO1iQcMP7S6eaDu1XhOV165dPO2OoMGmca5J4Esg2EOkTC
         gOj8Ht2ptFDpA==
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30fb1f3c30aso1506028f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 23:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687241577; x=1689833577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wIeiW1ZFsba/KXCWD2PyQ1wr/96tQbFZf3Edkh0XnI=;
        b=XOfLLgrqxaTNwHjig0ZdpcL3oMP+JKl992fzI+qU8PL6t+i4YryZyeDfdt9r/iTO4C
         wK+b0yXbUlZ1RL5VW9sPkFcd/anMhtoj4lD7iNU/LT3Wp87jJ1VjiwDF/5kvw+UFcxXY
         A608e+KoVYdpMdZGO/xJDdyIWCVCa1RlCYpEjbEjpccwwvbK4FnUYg0LmH++WCeQAKrv
         8P75gxR+qBDKjT/i4DWjsCNXs4Ld8SiSCWtDaJFEbuzxCaTUcWnZUzRe9RCaZZ1TTezQ
         UEsSELlDaS8aacq52hbMEPzzNA8SxA0G7aaBEWhii/fOD9D8qv9GQH+Z8Ek735YimhVl
         joCQ==
X-Gm-Message-State: AC+VfDxRnWhFRN8YFJMY2X9GOVpzf5DgifYd/Qw6GeQSpBBSOtXDIeK6
        mtwIsx0qj73MqtpvGJRdDGp0vTdECmcmAYIH4+CVmYHRSUR5cG3gYmWeAjveO5603Ok+RwB24hJ
        MWvjr9NmTOpUladXOr0Mh3VsIzGaCP9ABptRBk3L9eQ==
X-Received: by 2002:a5d:5642:0:b0:311:13e6:6504 with SMTP id j2-20020a5d5642000000b0031113e66504mr7172945wrw.47.1687241577594;
        Mon, 19 Jun 2023 23:12:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ53VbcjaaSaVOP7ZfF1U8PlZ6CnaKfIspgMD4HVg9YmI8nsBXcQDmAFnqzTcFArMw2i9VXRcA==
X-Received: by 2002:a5d:5642:0:b0:311:13e6:6504 with SMTP id j2-20020a5d5642000000b0031113e66504mr7172930wrw.47.1687241577282;
        Mon, 19 Jun 2023 23:12:57 -0700 (PDT)
Received: from localhost ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id y10-20020adff6ca000000b0030f9c3219aasm1163729wrp.47.2023.06.19.23.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 23:12:56 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     rfoss@kernel.org
Cc:     Laurent.pinchart@ideasonboard.com, airlied@gmail.com,
        andrzej.hajda@intel.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, jernej.skrabec@gmail.com,
        jonas@kwiboo.se, juerg.haefliger@canonical.com,
        linux-kernel@vger.kernel.org, neil.armstrong@linaro.org
Subject: [PATCH v2] drm/bridge: lt9611uxc: Add MODULE_FIRMWARE macro
Date:   Tue, 20 Jun 2023 08:12:54 +0200
Message-Id: <20230620061254.1210248-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <CAN6tsi4jdDD20DY5sKL+ALC_Mk2UHRArOrQnjzKoyF30QZi8jw@mail.gmail.com>
References: <CAN6tsi4jdDD20DY5sKL+ALC_Mk2UHRArOrQnjzKoyF30QZi8jw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module loads firmware so add a MODULE_FIRMWARE macro to provide that
information via modinfo.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
---
v2:
  - Introduce FW_FILE macro
  - Add Rob's r-b
---
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index 2a57e804ea02..22c84d29c2bc 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -28,6 +28,8 @@
 #define EDID_BLOCK_SIZE	128
 #define EDID_NUM_BLOCKS	2
 
+#define FW_FILE "lt9611uxc_fw.bin"
+
 struct lt9611uxc {
 	struct device *dev;
 	struct drm_bridge bridge;
@@ -754,7 +756,7 @@ static int lt9611uxc_firmware_update(struct lt9611uxc *lt9611uxc)
 		REG_SEQ0(0x805a, 0x00),
 	};
 
-	ret = request_firmware(&fw, "lt9611uxc_fw.bin", lt9611uxc->dev);
+	ret = request_firmware(&fw, FW_FILE, lt9611uxc->dev);
 	if (ret < 0)
 		return ret;
 
@@ -1019,3 +1021,5 @@ module_i2c_driver(lt9611uxc_driver);
 
 MODULE_AUTHOR("Dmitry Baryshkov <dmitry.baryshkov@linaro.org>");
 MODULE_LICENSE("GPL v2");
+
+MODULE_FIRMWARE(FW_FILE);
-- 
2.37.2

