Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5CC675D48
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjATTCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjATTCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:02:24 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D497EF1;
        Fri, 20 Jan 2023 11:02:23 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id h10so995546ilq.6;
        Fri, 20 Jan 2023 11:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ty2vaSJYfWXnQKh12ga3jGSjJvuvI1UeShBRy78Xdwc=;
        b=LTAzPNF1017FDGxs/KdhLIXruwcqk2UsjeXOJIy8s75ZAc5J7k3/GLf01h+Tsv00j/
         0UsHrctRRg+9Ze95HIOjiC4z9Owz5fYyMRbRq6VWNLKOfPsh0TQx8Mwc4cGeX5iejDl7
         BUO32yalPHzhWBI9casVX99GKgCkHF2ZdzQjvqggU8ZLKghPyua9P+bqttA7fU9aeP/X
         A3bqvwusl9Qqgj+n+g4I8yUT0oAfDVe4DNPSWI5qnMTJMW2106m+u8kVcSahQgeJKOlj
         N5nUaMi0rOKsCSGw/SVCsarbxrc+eNXVZ6MdUfEf9i4H9nmQiKWjKnHubbZHakEnedsD
         YhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ty2vaSJYfWXnQKh12ga3jGSjJvuvI1UeShBRy78Xdwc=;
        b=osOa4rXR8WXvd1YqmjeAIFizuM/Zk4eVW6qU/BMuRlPsArz1YeHnac8CQySdKNXW4A
         rFKnwTeI7RLCp8mcv7Z8IVUHawDTjc7JmPSU+5MMt+2QQIj5aj+9qQ6DljRCpzFfGnyD
         Bpdpc7c+d3+ldM212adtSf6v1XXUWYRKUguG5bsO0o28ZMBSgkPUHnqg6V9OmqaMmfLK
         mn7akWzEQ8ASqe1RCZwqaBB9r/HI1zAg1fcO+Y+lbVt1SMEndWIO6TTVpkK8SaTVAwQa
         GOfXVh+geqCp4q6u09Z+IuqR9Cw4ZTrG+muXCKIy7hZxJhwwoCITiwy0JF6i80pg/zKT
         KSBQ==
X-Gm-Message-State: AFqh2kqZIestd81DRJz37mN1dzg1Wk24Vp3R8Yicy9z38APiaAvKguVN
        8al0OMnVpSRhvSBy55AAigk=
X-Google-Smtp-Source: AMrXdXs48lIUewWmFTrNsHJylp/Udxwp1xJjJEgnT45MF2U0HBDUPW7ITZmIlb5ul73oolOW5Q8xdg==
X-Received: by 2002:a05:6e02:1562:b0:30f:3736:25ab with SMTP id k2-20020a056e02156200b0030f373625abmr8463067ilu.28.1674241342553;
        Fri, 20 Jan 2023 11:02:22 -0800 (PST)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y13-20020a37f60d000000b006fa2b1c3c1esm10379806qkj.58.2023.01.20.11.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 11:02:22 -0800 (PST)
From:   Doug Berger <opendmb@gmail.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH 0/6] rtc: brcmstb-waketimer: add RTC alarm irq
Date:   Fri, 20 Jan 2023 11:01:41 -0800
Message-Id: <20230120190147.718976-1-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Support is added for an interrupt that can be triggered from the
brcmstb-waketimer hardware while the system is awake.

This interrupt allows the driver to pass the rtctest selftest.

Doug Berger (6):
  rtc: brcmstb-waketimer: introduce WKTMR_ALARM_EVENT flag
  rtc: brcmstb-waketimer: non-functional code changes
  rtc: brcmstb-waketimer: compensate for lack of wktmr disable
  rtc: brcmstb-waketimer: rename irq to wake_irq
  dt-bindings: rtc: brcm,brcmstb-waketimer: add alarm interrupt
  rtc: brcmstb-waketimer: allow use as non-wake alarm

 .../bindings/rtc/brcm,brcmstb-waketimer.yaml  |  22 ++-
 drivers/rtc/rtc-brcmstb-waketimer.c           | 152 +++++++++++++-----
 2 files changed, 130 insertions(+), 44 deletions(-)

-- 
2.25.1

