Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8087E6717DC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjARJgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjARJZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:25:14 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F4A45BEC
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:50:35 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o17-20020a05600c511100b003db021ef437so930760wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WGnlSH0SRyckF8ae5/tZ3vtNeisnG6vENlB7WvbiSWQ=;
        b=fP5wJZQO6BvVLC1KkzeqPIXruPM4+Th4K53H3+GnUEZ37DOhuJl6vIfUSjzzm+tP1V
         tVyHlXSXvfWFJ0t89OgNx0+rVD5lSgHDSjyML2UWl0LrqCWQWtQe/Wozi1BzfSug+cGE
         e6YGilmaDcDSQQGjzAId33OCMqRtWqaPdrC8NagLgK8bhbfUHbmqbH0Rd3C4yAY1gpqt
         ZgICKIk2rP3Xcx8ivj4093FJnKTyDUnIe4qPNoIOhZVyG/5QKF9Tlv1YFmNqFK7y2UGB
         ovwqBVn4p9RmgyTNPTUwuXvDIbBFshefP9/BpYWD8NVr11AyHsgVmnR0P6bBwcWcaS14
         I7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WGnlSH0SRyckF8ae5/tZ3vtNeisnG6vENlB7WvbiSWQ=;
        b=WxZj/qco7AJo/YgalNsIheyT/Fk18/Nr5Brg/F72eV1TeYwgFZQ/u0vzdK+X+n5jgn
         fKn1H982cilBWlyJHT8FUVyII3dE3S+N6wzoyQfoKsYX71uRdwXU/yr6v4gY+f5Qo0xV
         X+SNh2Vgt2QbwqRIPCQP+gMiczK2nREg2t+yamk8rk+u0u8zh59v9xnb/sfjMbWk/hKi
         uGtdF6XJUdKYCcTigpo6LorKQRXYxcyDE8SxjvvxRAu54niJ0FZInv6BqSsDavffjg8b
         UbjAvp50+RDP1vG4OnQoV+a/gfQKL8sun8af9mNQ+6hitIrYOWWmbQWCE7DhbYtR1aFF
         w+yQ==
X-Gm-Message-State: AFqh2kolbT/ojnjJhKPcd/qN1/ftZR+R4x6grd6f0bcExsdH3TRxNIZI
        Apd0wGv5H/W+dvGCEGJS7YCuiWHxP9puSMi+
X-Google-Smtp-Source: AMrXdXsG79NhdZYRbhqS8wahhXGpzhaUiTvum7PYkfYe7a7HovQ27eVFSvABCqBk6UqG7md2PCAPLQ==
X-Received: by 2002:a05:600c:3583:b0:3d9:719a:8f7d with SMTP id p3-20020a05600c358300b003d9719a8f7dmr5708218wmq.35.1674031833858;
        Wed, 18 Jan 2023 00:50:33 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ay22-20020a05600c1e1600b003dafbd859a6sm1272231wmb.43.2023.01.18.00.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 00:50:33 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/2] arm64: defconfig: enable modules for Qualcomm
 SM8550-MTP display
Date:   Wed, 18 Jan 2023 09:50:30 +0100
Message-Id: <20230110-topic-sm8550-disp-defconfig-v3-0-11b558f7ff5d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANayx2MC/52OsQ6DIBRFf6VhLg2gptqp/9F0QHzoSxQIKKkx/
 nvBqR269E333uGct5EAHiGQ22kjHiIGtCaV4nwiapCmB4pd6kQwUTDOGZ2tQ0XDVFcVox0GRzvQ
 yhqNfU4a8rGKk0RoZQDaemnUkBhmGcc0Og8aX4fy8Ux9wDBbvx4fRJ7XH7LFhdmDnA7rKNcPceS
 U0aYpuapZXWjO7iMa6e3F+p5kSRR/gkUCK9G0zZWXqq70F3jf9zcI6bSPQQEAAA==
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the SM8550 DISPCC and Visionox VTDR6130 panel drivers as module
to enable display on the SM8550 MTP device.

To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

---
Changes in v3:
- Add konrad acked-by on patch 2
- Link to v2: https://lore.kernel.org/r/20230110-topic-sm8550-upstream-display-defconfig-v2-0-c29b9714c85f@linaro.org

Changes in v2:
- build SM8550 DISPCC as module as asked by Bjorn
- Link to v1: https://lore.kernel.org/r/20230110-topic-sm8550-upstream-display-defconfig-v1-0-9941c8083f10@linaro.org

---
Neil Armstrong (2):
      arm64: defconfig: enable SM8550 DISPCC clock driver
      arm64: defconfig: enable Visionox VTDR6130 DSI Panel driver

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)
---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230110-topic-sm8550-disp-defconfig-deffeeeee051

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
