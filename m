Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A47666E92
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjALJqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbjALJpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:45:13 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1461DF35
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:42:49 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id g19-20020a05600c4ed300b003d9eb1dbc0aso11567649wmq.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=APTONcXVy6mFL8XiR1Brj8xVb3XOo1bNikIcdrPlIXo=;
        b=ux82gskbANvqzU550c4Z9IdtTLTjSds8gy8LmG/FTb+rsp/xSsNJGQfJZJ53Kc+lht
         mprfd356FcXQaY2geji9M0jYKKMes/hXk+fNyoXii0xotUnCna3BpZznwV9X/KgNKZuy
         IBXn1+srGRNmOPVOtTRApVcjLUp14MHT7FxjilYPhutbtYCqUbbtxoJa/yV4tSIrKfiP
         IJqUK38WyMpGweVMvf9D5ZO8cGM8X3gyqBnu7vdprT4VLbnqVxWG5F4KO9lMkFZNXQC3
         +cUZSmMlbvvQp8YEyoov7kOU13ymwmqHBZA/rsQ3fuexOWOA7HqFG7CTI2xHreD8N/Wp
         xA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=APTONcXVy6mFL8XiR1Brj8xVb3XOo1bNikIcdrPlIXo=;
        b=D77w/Fh8UWVUcULwlg3Zc13isvPBru9epCLkK1VtJ9d1R3t4wWT4xWh0zGZLVl8UsF
         1ZGBlQMOOMjwbYC0204wMfZ3lSntYlvUL1bTxSzQHqWOp/s7AFzMjms5w3G6kJmsEQL3
         3IIWAt0gWMCsoFrPHLehfm+B7qJP9X0P4V5nlr2nEH+xmKmTZjIXe0YNiJwaOpistV9P
         F1mF3A7qrVMEHLwUxcf2vMPl5MZjyVKfYJ1bd1qhVTirX5t4ElppCWU1PrRkg3uDF+vk
         rC3m8LvXkIXdZAKLRysT1KRy8pyR610oQmp1Vm115dMPiAJbJ7UKJZjSBy7TUz7OJibj
         k/og==
X-Gm-Message-State: AFqh2kqWOjjSthjJNvzHZ9+1CigaowqhXYMLtuhc9CrCysE/vTUFG1jW
        0VfPq35IFqDSbhFbHv2g1+PeqdjELX3y5FS7
X-Google-Smtp-Source: AMrXdXsh0LaYn6p44zgaXlmjSPvY9d1ph54VA1Rmgm59igIox8+71XmTRkNh3mKKjODZ+rg1VCCZLQ==
X-Received: by 2002:a05:600c:4fd4:b0:3d3:4877:e556 with SMTP id o20-20020a05600c4fd400b003d34877e556mr57244794wmq.29.1673516568318;
        Thu, 12 Jan 2023 01:42:48 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l14-20020a05600c4f0e00b003d96c811d6dsm28047649wmq.30.2023.01.12.01.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 01:42:47 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/2] arm64: defconfig: enable modules for Qualcomm
 SM8550-MTP display
Date:   Thu, 12 Jan 2023 10:42:45 +0100
Message-Id: <20230110-topic-sm8550-upstream-display-defconfig-v2-0-c29b9714c85f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABXWv2MC/5WOQQ6DIBREr9Kw7m8+WhPtqvdoXCB+9CcIBNTUG
 O9e9Aad1bxZzMwuEkWmJF63XURaObF3GYr7TehRuYGA+8yiwKJEKRFmH1hDmuqqQlhCmiOpCXpO
 waoNejLaO8PD6QydwkqK3NapRNBF5fSY+9xibQ5DJMPfa/7TZh45zT5u15tVnun/w6sEhKZ5Sl1
 jXRqJb8tORf/wcRDtcRw/V8i0a/QAAAA=
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
change-id: 20230110-topic-sm8550-upstream-display-defconfig-deffeeeee051

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
