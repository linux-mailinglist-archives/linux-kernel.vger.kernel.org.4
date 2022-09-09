Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD98C5B3BA7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbiIIPQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiIIPQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:16:18 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CA51451DC
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 08:16:11 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id w8so3204862lft.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 08:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=NUa3V8LEZ2/vDPoZ3wTXU0JCjw5IK+/h0qXIj+ixXts=;
        b=a7qBUwihziETQrL53Oy5msDh5lUbMPy/QjR7otB9c8m6nhptuhNxdYBJOxQlaP2eCg
         6zBOOtrFsr6VmX2fBJOatYS6fR+zDD+7wkfMagpqCBYXY/LKrazuI0O5Nl+D5HSaYFOg
         xJjaynjUCssmoMMUsJfIQu412Cp2EsUeJJFCiF9LhjyeXApL9yD1HP8TTHNzkQhX3Gw1
         t9IHi3+ZC5rfByIedRqouGbcKO3T2GJxL7ky9tth7zd6dwWDAiPBoEdQihPbpH/L8jA2
         H6Bh7iXAXzMegQzstgeVbAVextLad3hgUF7D5mpDROJZni7gXUwhm1C+dgaFVsaAuwbJ
         DXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=NUa3V8LEZ2/vDPoZ3wTXU0JCjw5IK+/h0qXIj+ixXts=;
        b=rILpxabfZ4lZK/bFsBhF2BsJM8JxH3wq4/Xi8dd9LU/7zt+DCX+Ah2KeDwUM3U+0ej
         q7aOZKrBJ1pfTa8eAZlSIA6H47M3BIYDDtr2aJk7ivdKtQeQtpN0JZU9Sb4g+2THW46l
         a8tU89hSkqe4Wi5TOHSCxMXPFDF3zjqx1gP0V9B98Cbnb7CMkzn//b290YDSxxqFrL3G
         Mh/IUusFWf8UBCcOt9tHpMEw2tGbkWZ1+z0vSTzmOTC9jt2h0lsRYbo6c889KYEBJXrv
         7htEaoKYTjvW1SpWfhgd1wKSIsJJVoUkPZAGHPytU3P1O+k6LsJHV3Gr1YRjJgZb5lMK
         mY0Q==
X-Gm-Message-State: ACgBeo2dRitiTQlyht6/CqJjUNkyomnqiIqm1hUm2/J+Q5ZLShITZFVc
        k6ptbXzQuq2q8Uv3GJ4Me6cxKA==
X-Google-Smtp-Source: AA6agR7v3BDcGAoPMFNRMOvrkFPYNQRBRmlEmUWVN3rQwS8Eb81UspLe2vlpgEFNc23LuS2zvoQQMg==
X-Received: by 2002:a05:6512:681:b0:489:d509:e076 with SMTP id t1-20020a056512068100b00489d509e076mr5084997lfe.618.1662736569815;
        Fri, 09 Sep 2022 08:16:09 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id i17-20020a2ea371000000b0025d5eb5dde7sm107674ljn.104.2022.09.09.08.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 08:16:09 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] pinctrl: samsung: for v6.1
Date:   Fri,  9 Sep 2022 17:16:05 +0200
Message-Id: <20220909151605.821685-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git tags/samsung-pinctrl-6.1

for you to fetch changes up to 9d9292576810d0b36897718c24dfbc1a2835314b:

  dt-bindings: pinctrl: samsung: deprecate header with register constants (2022-08-19 16:54:10 +0300)

----------------------------------------------------------------
Samsung pinctrl drivers changes for v6.1

1. Minor fix in order of initializing pinctrl driver - GPIOs should be
   configured before registering gpiolib.
2. Final steps to deprecated bindings headers with register constants.
   The constants were moved to include files in DTS directories, because
   these are not suitable for bindings.  Remove final references and
   mark binding header as deprecated to warn any users.

----------------------------------------------------------------
Krzysztof Kozlowski (2):
      dt-bindings: pinctrl: samsung: stop using bindings header with constants
      dt-bindings: pinctrl: samsung: deprecate header with register constants

Saravana Kannan (1):
      pinctrl: samsung: Finish initializing the gpios before registering them

 .../bindings/pinctrl/samsung,pinctrl-pins-cfg.yaml |  1 -
 .../bindings/pinctrl/samsung,pinctrl.yaml          | 63 ++++++++++------------
 drivers/pinctrl/samsung/pinctrl-samsung.c          |  8 +--
 include/dt-bindings/pinctrl/samsung.h              |  7 +++
 4 files changed, 38 insertions(+), 41 deletions(-)
