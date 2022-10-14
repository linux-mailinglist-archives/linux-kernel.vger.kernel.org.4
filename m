Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EFC5FE63F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 02:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiJNAUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 20:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiJNAUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 20:20:14 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C404316D;
        Thu, 13 Oct 2022 17:19:47 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id b79so2572774iof.5;
        Thu, 13 Oct 2022 17:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3AMzfQVn5/7lBdhsiiw7qcfMcMHO7OrRK+ejqLQydQ=;
        b=p0+P2JJK82phqlb+rTmEe/hRjzYi+0c+j1w1ZXvpHR802l3HZxj8ZouxOthEYlg/0Y
         FbRpmV0SIoQyCyXUffs0BZRRcNiMdMaqGbGbJJnLkk8MuuZUI4LTh5TWC8ki490tF9eG
         /whR975ZYMBb/zEK/PE633bVwpMuIL2gfHxadz3HvUgpjWftZvRS2U5+5lNP6GKPNXVr
         X8Dju2wjqTPDi1UAN0WIaJref0IpN6hj2RUWNsXMoAhMhnpmTw6Y2C053Gk3peT8m/GU
         pjUC1Gxjbdm1gn0SBNSofQjml0tpY07T4k6QjpTU3FhH5Eg+H+uxUJ3RgRC1oFNTJnhN
         526g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3AMzfQVn5/7lBdhsiiw7qcfMcMHO7OrRK+ejqLQydQ=;
        b=eBCuveCDsfouQEsXMxccqmxN1HGKo45D/pKp4SDis1dihL0YRXiTPKINDRCp4szV3t
         D0Nm9rOG9MrlfImpJIKbd21mPZsHXRaIvqFAC+Z2cM70jycK30f1t3WMaQDxlUJlna0E
         amhvlH8t4GyJxRJCXh9XU4qbscKGhv2FrCBXNUTpNyws+A/VhYphBbpzdfUZgOpdfVZ+
         efxwH+YigupLWIQel/Xjdv64E2JV+07LHbGTFpbJGXYZS+JbjBwf4EJLXXQCEDJy30M3
         xZ+wGYB56AZNlz54FGQJKxxhob0EOnBMUHPzA85tjQzL0H/GPGW7ww0qnwy/oObD6jAR
         N1eA==
X-Gm-Message-State: ACrzQf2Rw/4sK8ADJKCsjcYQIgrtEfU6xvyVibX/PxwW7mUnctFqTCKP
        8a08odoiuz0GrgI4nVMXQbSXLRHazHuXxA==
X-Google-Smtp-Source: AMsMyM73GvM98J4Hdv/Jnbgu6dTLnHKdNnAN7h7AxVhwOaYMF1kNIrlTokzutyqnfhU9p+BG6xT5oQ==
X-Received: by 2002:a05:6602:164c:b0:684:a65f:c23 with SMTP id y12-20020a056602164c00b00684a65f0c23mr1119949iow.162.1665706785342;
        Thu, 13 Oct 2022 17:19:45 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::3fc2])
        by smtp.gmail.com with UTF8SMTPSA id g14-20020a05660226ce00b006a129b10229sm410936ioo.31.2022.10.13.17.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 17:19:44 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 2/3] pinctrl: qcom: do not reinitialize gpio valid mask
Date:   Thu, 13 Oct 2022 20:19:33 -0400
Message-Id: <20221014001934.4995-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221014001934.4995-1-mailingradian@gmail.com>
References: <20221014001934.4995-1-mailingradian@gmail.com>
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

It may be necessary for some devices to specify reserved gpios in the
device-specific DTS, in addition to the reserved gpios common to all
devices with a given SoC. Remove this bitmap_fill() call so that the
settings applied to the gpio valid mask by DTS are not overridden by
the driver's reserved gpios.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index a2abfe987ab1..c5c9e588fb13 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -687,9 +687,8 @@ static int msm_gpio_init_valid_mask(struct gpio_chip *gc,
 	const int *reserved = pctrl->soc->reserved_gpios;
 	u16 *tmp;
 
-	/* Driver provided reserved list overrides DT and ACPI */
+	/* Remove driver-provided reserved GPIOs from valid_mask */
 	if (reserved) {
-		bitmap_fill(valid_mask, ngpios);
 		for (i = 0; reserved[i] >= 0; i++) {
 			if (i >= ngpios || reserved[i] >= ngpios) {
 				dev_err(pctrl->dev, "invalid list of reserved GPIOs\n");
-- 
2.38.0

