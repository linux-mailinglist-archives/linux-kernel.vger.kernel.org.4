Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60FE6A82B0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjCBMws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjCBMwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:52:47 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5918A4C6DF;
        Thu,  2 Mar 2023 04:52:39 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id ce7so10002768pfb.9;
        Thu, 02 Mar 2023 04:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AQNkj4FZEaKAr7Xb1mpF57p0qLFeWN8rTwWO3+7V3ts=;
        b=HnQ3RH1zw9peuc3kysd22xqeIBQ4jXkwXVFX/PcNPtFq0DCENbMWheQwHXATtxTv6r
         ORACrlAyvnWxlM8MV2ps2dSXQM1kg3noAxuQ4YS6f/j/lrNpyZyhRMY33TgLSAyJqyKg
         V+rKpmcT7wLk0WjjDbatEeP9Nz8c8Qc00JQKDvbjGp5JOkuGaR7cvpJFrpKU0GZ2dGsP
         eo1loY98YuzoPoqesM11UkFVmKB+JwaD69thuyY3PlX6RMljfPPdjWVlyLY/v3aRuH+t
         nhEMq8CPBc/+t5bhh65lqtBexAgsN0qTU4fWPc+8U7qNzzxOQTBqCP+0aG7a069EBCu4
         2xiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQNkj4FZEaKAr7Xb1mpF57p0qLFeWN8rTwWO3+7V3ts=;
        b=KDStWv3RVnAWrmkXwFDtctHu6MAVyWtTNYzhUVP70gmCaCP2p8q0HZVkAhT/RxtuP3
         hjlKWFhSITLbZor+AxARnCqcmbnNwwB/y4ba2/uZ3dXWe3h+FA0fVbtyaZhb+lYxApdu
         7JFHNM4lbAsU31DLNxnUEVitQjHTxckLlg6ds/DOpcLt6TfK3OhhxXKhuSTkE+Y7mkOn
         uXWy13PExjnWhmUQPoldHAMemKvcN9dZP/505Byku6nHkc1TjzQbvgMbZOP4C+4JVHXu
         RUUgjWUFggUNtBeL25Uxym9VPpWOQ7wqDON+UJFFLE2NwC5/15NBbaeXm5wdGS0iIxfq
         NrPQ==
X-Gm-Message-State: AO0yUKXNq0VaaGo5u3mdjjbCCM6JUvHQG0FQbIyJNypFja9WLfN4WhU9
        c6izRL4TMWhVv4IJLMwcaJoUYbmvQYk=
X-Google-Smtp-Source: AK7set/amMytBqrqgVdkO/cUZ5/UrZCZ7Dhee4BXoENaNjgyVHX6VZcvwnjb7X5OltK+PlsLOf1A2w==
X-Received: by 2002:a62:3044:0:b0:5a8:b6ab:49c3 with SMTP id w65-20020a623044000000b005a8b6ab49c3mr1967734pfw.17.1677761558443;
        Thu, 02 Mar 2023 04:52:38 -0800 (PST)
Received: from kelvin-ThinkPad-L14-Gen-1.lan ([223.85.203.147])
        by smtp.gmail.com with ESMTPSA id j7-20020a62e907000000b005aa60d8545esm9791955pfh.61.2023.03.02.04.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 04:52:38 -0800 (PST)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v2 0/5] Devicetree support for Loongson-1 GPIO
Date:   Thu,  2 Mar 2023 20:52:10 +0800
Message-Id: <20230302125215.214014-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Update the driver to add DT support and dt-binding document,
along with other minor changes.

Keguang Zhang (5):
  gpio: loongson1: Convert to SPDX identifier
  gpio: loongson1: Use readl() & writel()
  gpio: loongson1: Introduce ls1x_gpio_chip struct
  gpio: loongson1: Add DT support
  dt-bindings: gpio: Add Loongson-1 GPIO

 .../bindings/gpio/loongson,ls1x-gpio.yaml     | 49 +++++++++++++
 drivers/gpio/gpio-loongson1.c                 | 71 +++++++++++--------
 2 files changed, 92 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/loongson,ls1x-gpio.yaml


base-commit: 4827aae061337251bb91801b316157a78b845ec7
-- 
2.34.1

