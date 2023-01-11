Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346DD666562
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 22:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjAKVO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 16:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjAKVON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 16:14:13 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0B23F114;
        Wed, 11 Jan 2023 13:14:11 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id qk9so40108320ejc.3;
        Wed, 11 Jan 2023 13:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KWjxzoa+0Z8TK3Nm9GrwoHtq0LtxqCYWK389rFuM4E=;
        b=h+a29CQk521D2NrlQhe/tYo4lGiNT7rWELIhXIO7Ml+NcbO19CqX+KTlJlvWR4kRBu
         aQiESvFQdxrCDULOctz896YF/MGoQ6JWSNtHJ4oDFShpfL7amueB29VWid2ATGYMGksZ
         H+Wn3xPlD7A7EWRkFVHtYKVBtJ3E5SN2+GeoiIq1ujI/gqogRFPZ5y/emD1UlwJayNvp
         XsWH+46BIlp0Pa6mvyiDP5xP2wdQXHtfuGRHvqo1mP5rX/hQsuCL0f2AtVeSxOMJKsa8
         hVOvFwJlwGWAdVtv6fGiRWTvpSM8emluVaT0XtI1FAGRwb36Id2gl9WJP8+c2vnJwGWx
         T1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KWjxzoa+0Z8TK3Nm9GrwoHtq0LtxqCYWK389rFuM4E=;
        b=DJ7ixWnXNTjb0YwQisjH02FDj+emyhf/+dgjKOtuTdUztZLXPVsuXuQnGMROddwIG4
         U6xzS1Bh3/4McUiFJFL/X6jAs3k89Fd9N4RHB6yc/1HHZG72+93+OfaiE4h/Nai6M/Ph
         kT8ie352JsWZIXVmc8yFlift38iXbWNcAwXWoYILAfYIFX10zouu4IIw+JFgoW7rbZCX
         Da45kF3QHhqvhhIyaomOeGL4P0SEL0erEj/QM+YbxyemG8WiwY5NH8snQ6PQMNkIK4lJ
         Ub1m8LazVijnYGAOyJkiA8li8ioJ89LnTMGQ+AFewkrrnMgvPW/gaZQhiLVZSF0X8Roj
         lHTA==
X-Gm-Message-State: AFqh2kolKmSBUO5+kTI+T1KJbVYVHnsMOBSD8URjTB13h5vXOZCXxw19
        lAlLNvIcxIdx0TUszUP3miPt48UFvHE=
X-Google-Smtp-Source: AMrXdXviWXJj85GeCtIXoZKzZUXvd6xK/W7+pVSJsYSAEmdZ/yIUlK9nKM0tvlA2XVXqOD3vnzoNEQ==
X-Received: by 2002:a17:907:6d22:b0:7c1:52c:a960 with SMTP id sa34-20020a1709076d2200b007c1052ca960mr83309019ejc.8.1673471650160;
        Wed, 11 Jan 2023 13:14:10 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-7325-0300-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:7325:300::e63])
        by smtp.googlemail.com with ESMTPSA id l4-20020a056402344400b004822681a671sm6485079edc.37.2023.01.11.13.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 13:14:09 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, neil.armstrong@linaro.org,
        jbrunet@baylibre.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Vyacheslav Bocharov <adeep@lexina.in>
Subject: [PATCH v2 2/6] arm64: dts: meson-gxl: jethub-j80: Fix Bluetooth MAC node name
Date:   Wed, 11 Jan 2023 22:13:46 +0100
Message-Id: <20230111211350.1461860-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111211350.1461860-1-martin.blumenstingl@googlemail.com>
References: <20230111211350.1461860-1-martin.blumenstingl@googlemail.com>
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

Node names should use hyphens instead of underscores to not cause
warnings.

Fixes: abfaae24ecf3 ("arm64: dts: meson-gxl: add support for JetHub H1")
Suggested-by: Vyacheslav Bocharov <adeep@lexina.in>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
changes from v1 -> v2:
- new patch

 .../boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
index 270483e007bc..bb7412070cb2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
@@ -86,7 +86,7 @@ sdio_pwrseq: sdio-pwrseq {
 };
 
 &efuse {
-	bt_mac: bt_mac@6 {
+	bt_mac: bt-mac@6 {
 		reg = <0x6 0x6>;
 	};
 
-- 
2.39.0

