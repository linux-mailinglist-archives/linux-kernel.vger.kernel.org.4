Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6957C62FF23
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 22:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiKRVGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 16:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiKRVGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 16:06:50 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B6D98241
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 13:06:50 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id w3-20020a17090a460300b00218524e8877so7740357pjg.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 13:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gnAsPrVGuvzoHqZVlZd6zNdmEYEJ95+s/mRmpJEA+NA=;
        b=Bu1ONXDoglBy/CFm02D+Z3gcRjHFLorxNl9tvfBxRV9f0AYhPOoTsWvonN9OWHIv+v
         mPKPOUbuSytsxg755KPqezCAqfQ7cK9jyX4w92PdW+LTzVSA8SfJfn5hdnqNgC/dnclv
         ubFbsCjcG2+vcfhIBseJHoVNJHAOpfugbzblE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gnAsPrVGuvzoHqZVlZd6zNdmEYEJ95+s/mRmpJEA+NA=;
        b=hw+/ddakbZCZBLGNfE24BE9LbWUC6or4pdOpYkmlNGfqB16z6alaDzk2apHC9M2dxk
         PeMUEdiFne+Un55uLJmqP+doBxlI9I1+VkfhrxF4OYZQhXlzsbQ5XojzUjGS5J7DZW07
         rOcA3LRd+Y7vEAOPufAFZVi2FPR74FSYYY2UeyavNE2uBOI3txuPsY+dksJx0FMKhLUi
         XiZmmojDjE2mS8s+avFRtT5GoJZpYdwGNjysARF/Zq1qSsu76hPHi+Yhkg5ZxzPKITck
         IblXK8TaMXB4KVJHx17FrBGL6PkNUYzvldjSr3iQ2XFrBkiMY28OKtgn4adUShxAVevM
         6UqA==
X-Gm-Message-State: ANoB5pkGGE2klxXR5IXwk2mHhFC7jdm4ILHEu7vAxxXhSFZJoj9LatxB
        qmucnXPQop0A4/6DVpd8oc0c5Q==
X-Google-Smtp-Source: AA0mqf6r3Tm95SxxS6ArtCRTT4T+OwIk12rF9o1pl5sGWCaJvZHHXe5vIUZ/h74bghrw41sb/gyFhQ==
X-Received: by 2002:a17:903:2144:b0:188:5698:5beb with SMTP id s4-20020a170903214400b0018856985bebmr1119715ple.150.1668805609578;
        Fri, 18 Nov 2022 13:06:49 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q40-20020a17090a17ab00b00212735c8898sm5806748pja.30.2022.11.18.13.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 13:06:48 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Christian Lamparter <chunkeey@googlemail.com>
Cc:     Kees Cook <keescook@chromium.org>, Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] p54: Remove unused struct pda_antenna_gain
Date:   Fri, 18 Nov 2022 13:06:46 -0800
Message-Id: <20221118210639.never.072-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211; h=from:subject:message-id; bh=xE/N7gPBr8pC4RWE4/LtXpIzlGUJNC643Y5HQ4jcdAw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjd/PmJitOcOhYF+kOkfL4S9RGBKFXo38FGTaxIKNh e1EVjb2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY3fz5gAKCRCJcvTf3G3AJowxEA CzSFjacs4k7LCSAK3O45g6EFEe+OrbjoiWiqkX0qvuwJaKY70oEFAqF41Daxf8bdkMmqdWncgV/dW0 vhT4AVeiT0L8lgpD9mfsd3t2WIcb3KMd6VLW3x7hXQlvTeSOpRGInG4FevkLpEUsIy4SPna7ycmRvj f62tMEiIL7MIjwT/pprP2PXhL9kA4zKXh15cvXndeDaX9EGkCMqCciCTrY+szSphZr0431wqxrnPP0 uc78kyKzNDlcWS4V/gN9Ua7wBF/YhGvDayPTLi5u8sy0fo0XHg25wtC1FHZwbnkSAg4i+0gdca2KjO 0gx4b1MFHX6/s8plMDuTzXs1UF+WU5XK5YokMt3Hs2QmzAAyiIA1bIn2nvWQFPO28WhIxZrL4jhtch H8w8Hg0gtIm+aX1gFrUfW5eQYPhaeXXd/8jva/hmuOyZP9RkwRIyaG4ZYs1l7wD7yMlxys6zGqewJo VumVKRtAgLoV0G5n7uXJkzzWcC/V4vTX6ewjnoBM7b8lsaNkLzAVYQ/jvcHalCYAWA9eMrkW8SLZ/S dEAqXU2mUuBFehSGizp06CzFG4ig1rZlEirwWTniz4w4aX+aJfDF9RUZ51V8xNao4KtF11lYymV9oU ul2feGkCPxGlhy/uL1a+vGdxzs7MvvtN/ZwkT5+oDQaTFeUIMw5Akj5jbojw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove struct pda_antenna_gain. It was unused and was using
deprecated 0-length arrays[1].

[1] https://github.com/KSPP/linux/issues/78

Cc: Christian Lamparter <chunkeey@googlemail.com>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/intersil/p54/eeprom.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/wireless/intersil/p54/eeprom.h b/drivers/net/wireless/intersil/p54/eeprom.h
index 1d0aaf54389a..10b6d96aa49e 100644
--- a/drivers/net/wireless/intersil/p54/eeprom.h
+++ b/drivers/net/wireless/intersil/p54/eeprom.h
@@ -107,13 +107,6 @@ struct pda_country {
 	u8 flags;
 } __packed;
 
-struct pda_antenna_gain {
-	struct {
-		u8 gain_5GHz;	/* 0.25 dBi units */
-		u8 gain_2GHz;	/* 0.25 dBi units */
-	} __packed antenna[0];
-} __packed;
-
 struct pda_custom_wrapper {
 	__le16 entries;
 	__le16 entry_size;
-- 
2.34.1

