Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C965970C2C2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbjEVPxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbjEVPxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:53:41 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26497110;
        Mon, 22 May 2023 08:53:35 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-3313fe59a61so15238615ab.0;
        Mon, 22 May 2023 08:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684770814; x=1687362814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GcASE1OrQyQi7q41P2SNchLMQc2DgftSxURxly3Px4M=;
        b=NB4tWHOjxmpjqH1CavStoHfHO7gwuRZAoxBoRJ1E77Kjapa/DvQ2f3G50SC2sEyA0v
         E3SHK90R8Jh4Bqsvbzudu/ufN9eGMDq8jaUjs/jfryNSvLFZfdJ34axmzRExKCLFocnb
         2hyXX536tpiSEK9nfyyZVbWky6Ta4VVNjhusop+i3pXs0s/bhgv2yJeYpSQE2mMiWgNd
         SoldQsemhEvJNDeyuk0F0uPU4hu8Qb0+zbrZPpP7ZyM+snhYQGDtDC7q016J6Prp29DQ
         U4hvFTRUQ5BKMU1pN2ZTLHsSQj7sm9d1+9Cy3sM2x4D8m1e5DBXo/lbVaIk/X22E7omc
         nZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684770814; x=1687362814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GcASE1OrQyQi7q41P2SNchLMQc2DgftSxURxly3Px4M=;
        b=S4ULbuN6kFZSxVUF9beDzZdPUTRAtzd0442fhOGmBFIPJNPrqa884y+C6WXoWnE9dm
         /BYcqmYS+i9J1Y/JensuhcdQV3ILUN9XIW1gNfmMYVrETocW7y06OKrK5NrEvcmW+xKs
         XCiT2F9e2LBzhSpt4AS5CRF5kN7Kfy7d10zLTK53JL9x0XNV39CC46gj3cHEpKENfDnF
         9C+w9ywYjXefz39f21XRdFhsKCQwdJhH5hsYCdn5f3hWZkgo3VQ/v0yvA0gNHWk69C/1
         ms8DuO/WBLfyPJjcSY3AhWo+qEoGoIsXCbmBoR6U7PtzeoLPMkt95p011nme3jn6O+za
         KNpA==
X-Gm-Message-State: AC+VfDzGzX9epSb/DmIwFFvbzEo57lry2A6YlAGal0Gv/z+rvtiy9JH2
        c5+wlrN8B1INPYBu5aA7TQs=
X-Google-Smtp-Source: ACHHUZ7ooSC2UtbAlM8vlneO+IMFO5YP+L0irn37IABBL9D6o/vm+eTQElmw15bt80zcMfBWO5nZ4w==
X-Received: by 2002:a92:da8b:0:b0:33a:6a9:6568 with SMTP id u11-20020a92da8b000000b0033a06a96568mr2007278iln.30.1684770814344;
        Mon, 22 May 2023 08:53:34 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id cn6-20020a0566383a0600b004141ce991aesm1787491jab.179.2023.05.22.08.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 08:53:33 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH] drm/sun4i: hdmi: Replace all non-returning strlcpy with strscpy
Date:   Mon, 22 May 2023 15:53:31 +0000
Message-ID: <20230522155331.2336966-1-azeemshaikh38@gmail.com>
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
 drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c
index c7d7e9fff91c..d1a65a921f5a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c
@@ -304,7 +304,7 @@ int sun4i_hdmi_i2c_create(struct device *dev, struct sun4i_hdmi *hdmi)
 	adap->owner = THIS_MODULE;
 	adap->class = I2C_CLASS_DDC;
 	adap->algo = &sun4i_hdmi_i2c_algorithm;
-	strlcpy(adap->name, "sun4i_hdmi_i2c adapter", sizeof(adap->name));
+	strscpy(adap->name, "sun4i_hdmi_i2c adapter", sizeof(adap->name));
 	i2c_set_adapdata(adap, hdmi);
 
 	ret = i2c_add_adapter(adap);

