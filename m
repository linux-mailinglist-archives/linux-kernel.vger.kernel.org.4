Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F1765FFB4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 12:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjAFLoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 06:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjAFLoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 06:44:16 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6936A0D6;
        Fri,  6 Jan 2023 03:44:15 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id j17so1630749lfr.3;
        Fri, 06 Jan 2023 03:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=knZj9C7RStQgqCaOUasP2ACocGzxIXf8GlmB4evRoos=;
        b=iHX3gpe8Ci/lB+b400zFYdvkd8bZkA6Ei5NFo3ss+9QhGY7vtDCRymB4Tw8e3LDZhd
         e88Ee14A7xpPRp2Yi2GadnGm0JJPcDmV6B3hn0tElDeqxl1QN17f8+3r1HmQYpkEiwOt
         Y1uaWSdO6vsA5DYzSCMF91vXro89D7VFnxhgSolkChaESga4FJq29NhnUo7Y929yfZx3
         rUXnnj1s3wEheEs2CBza+n9j2G7jr16M8vz7ajYyJybCfPxD2G7qxWrdYgYSZ8Nk8g11
         0PPctCkosqN2ZRfWaacrZ+JBe8LQu+2LQP31Wf9WnC0D0xBU7Iopys+9X7NLRHngWUD5
         ngdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=knZj9C7RStQgqCaOUasP2ACocGzxIXf8GlmB4evRoos=;
        b=cCG3YF4z5KYsv/gQvO4zPSlCG1VJt19m0nmri5VByRt67NRiybZAUZ/lXjRbhunT0d
         7WNwRkmUJ6FQ1NDR4jVXCpWnLWZ0AV/7jJHZX9n/3E0z7M/j3SMR/z6KwJFZSw7FZlSZ
         E3dfajUgfRGy7kvuInAv1BRbKG3M4dzb/XYB0qaNtq7G22nAlLESKjG7Al+MJrLAlNcn
         emeFFYOAo078sMcHF5alQsxN/YJblaVMjE8ZgORlO01zB1Vt2ye1/vg0q8FDSmLrGp22
         +T2ff7pLAwX5KqwL+fy2ymeaWUu7Nj4T8oJjpap6UqVjTPRprTRcb3ferX4H90w552jg
         1Wtw==
X-Gm-Message-State: AFqh2kq+DhCShPN5Zj2IjC9ws1ho9f5DG6vcW3lEnKLrJU8WnYbWYUtz
        bsVtZ+ED8PSsFlkBClACaJU8hHcUZKHu6Q==
X-Google-Smtp-Source: AMrXdXsiRFTd46XSvutc+xReqJnCPDwFIzWm7CRiZpGxWouQyEMQHlddcDKxVUR93HKAah3O7krI3A==
X-Received: by 2002:a05:6512:39d6:b0:4cc:586b:183b with SMTP id k22-20020a05651239d600b004cc586b183bmr2256518lfu.60.1673005453533;
        Fri, 06 Jan 2023 03:44:13 -0800 (PST)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id u3-20020ac258c3000000b004b5872a7003sm129747lfo.98.2023.01.06.03.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 03:44:13 -0800 (PST)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] General Purpose clocks and matisse-wifi backlight
Date:   Fri,  6 Jan 2023 13:44:00 +0200
Message-Id: <20230106114403.275865-1-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This series adds support for general purpose clocks found on MSM8226
and enables ti,lp8556 backlight on matisse-wifi which uses general
purpose clocks with clk-pwm.

Luca Weiss (1):
  pinctrl: qcom: msm8226: Add General Purpose clocks

Matti Lehtimäki (2):
  dt-bindings: pinctrl: msm8226: Add General Purpose clocks
  ARM: dts: qcom: apq8026-samsung-matisse-wifi: Add display backlight

 .../pinctrl/qcom,msm8226-pinctrl.yaml         |  4 +-
 .../dts/qcom-apq8026-samsung-matisse-wifi.dts | 59 +++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-msm8226.c        | 11 +++-
 3 files changed, 70 insertions(+), 4 deletions(-)

-- 
2.34.1

