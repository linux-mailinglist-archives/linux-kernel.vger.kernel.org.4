Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FC061A3D8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 23:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiKDWEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 18:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiKDWEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 18:04:40 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5E7B864
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 15:04:38 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-13c2cfd1126so6969207fac.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 15:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALGhbLG8IZq1W8PcaxhXQ3scDMznxgngbZP1/w11AsU=;
        b=VZ/Hk9G3u5pceeCziYhHioqASZpJNC6bwgM/0iajEfVr9GofRXC9QdOxQOsNTAeTuA
         vKJ+1aOvuGGQittItBjFIWEzo+I8JsQIgKlk6n5nseRgmLwHhJDpw5Zn0XDN1+bBxp/s
         M1EHxwSvHmwdaKe5uEnZq8mfZdQns8ummi3tqD8bLI/cuEPXjyMY883ONbQzuR5i4pU5
         2GNffofd6iUxbXL6YpzWzRMG+GKifesz2ZKm7wPPpdHGQTbc1E4NUvEMvmninn+X//GQ
         f+5Q21UJm0ue1HSLIkeGSpT53PKDO0J3Scn7d864m8qShBdfdIUmkVRfgkT8dMoMQt8C
         A3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALGhbLG8IZq1W8PcaxhXQ3scDMznxgngbZP1/w11AsU=;
        b=z63cXtolfOd0/T8rw1vtZX4x2ywSHUr8rTOJy9ImxBFBr6KjQuCj+CEPlxiQDbzW8a
         GjEtqQIQrtuTnIa6qOxUeTiKhXnfbWkDtCQ07NmpbG1fhLOgqLdB+29J6iMa7OYXa+lK
         cLQmv67FkWrZfnxSJNgPTlJSwMG/oGV7HpSXGtWvKzx8hFAHCttaGY+HuFh/ob66JPcD
         X8k3EM5o3OKgIwDJ7XOLj+ciZyRje6WouX90uI+x2yivgMycluEkwdSxV14E7Bnaw5AO
         mumY8PPkn5OTDKwt7r18yfQIVMqTrRGSjOY4TplcfnDobDO3iZWzS40iiFQgQAkfwwMu
         5vfw==
X-Gm-Message-State: ACrzQf03hCgeYfxQR5g9EiQCy7Sgiw9N5AWyxhgdW0igCcnyF7DRZsuf
        JZ/GScbnLVVzaVlFa01DsKHtZGq0WN+XDYcd
X-Google-Smtp-Source: AMsMyM5giw3BuJ8bmMJV4n8qLpGdhP4KGHdhrB1i5B+9G4KAWnj9wui4NDYnf6EwsDSuZzzqP0jiPg==
X-Received: by 2002:a05:6870:8319:b0:13b:1dbe:1943 with SMTP id p25-20020a056870831900b0013b1dbe1943mr22331595oae.243.1667599477799;
        Fri, 04 Nov 2022 15:04:37 -0700 (PDT)
Received: from antonio-Lenovo-Legion-5-15IMH05H.multilaserwifi.com.br ([45.163.246.212])
        by smtp.googlemail.com with ESMTPSA id n18-20020a056870a45200b00130e66a7644sm98623oal.25.2022.11.04.15.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 15:04:37 -0700 (PDT)
From:   Antonio Gomes <antoniospg100@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     antoniospg100@gmail.com, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH v3] drm/nouveau: Add support to control backlight using bl_power for nva3.
Date:   Fri,  4 Nov 2022 19:04:23 -0300
Message-Id: <20221104220424.41164-1-antoniospg100@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031163211.13228-1-antoniospg100@gmail.com>
References: <20221031163211.13228-1-antoniospg100@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: antoniospg <antoniospg100@gmail.com>

Summary:

* Add support to turn on/off backlight when changing values in bl_power
  file. This is achieved by using function backlight_get_brightness()
  in nva3_set_intensity to get current brightness.

Test plan:

* Turn off:
echo 1 > /sys/class/backlight/nv_backlight/bl_power

* Turn on:
echo 0 > /sys/class/backlight/nv_backlight/bl_power

Signed-off-by: antoniospg <antoniospg100@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_backlight.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/nouveau/nouveau_backlight.c
index a2141d3d9b1d..5c82f5189b79 100644
--- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
+++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
@@ -263,7 +263,11 @@ nva3_set_intensity(struct backlight_device *bd)
 	u32 div, val;
 
 	div = nvif_rd32(device, NV50_PDISP_SOR_PWM_DIV(or));
-	val = (bd->props.brightness * div) / 100;
+
+	val = backlight_get_brightness(bd);
+	if (val)
+		val = (val * div) / 100;
+
 	if (div) {
 		nvif_wr32(device, NV50_PDISP_SOR_PWM_CTL(or),
 			  val |
-- 
2.25.1

