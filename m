Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521E15B3BF8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbiIIPcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbiIIPbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:31:50 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D3B14858F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 08:31:12 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id u18so3296359lfo.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 08:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+mAqJOgM8Ae7l6t9jqHU0zRO0K/U2EOlnDRdwAzG1bY=;
        b=B9bEZR+j7kRa6FIs825QyyfDUIAZ+ohPsf3dItiLcCo8ldqMOYLx9mZiWNDpE2AlYJ
         f/VNQ68PNKBo35iao/6ZvZ8BJZAgRFatR06O1KiU8EzagLSwueVGBhlAGiw3hAQ/1/Iq
         mxy+LtknzAjFZ/wOHC8ahHjok4envr3wCgHVfLIXH2/uGudiNHb9FoffXRNrT0rQ9VFB
         6ogCHDaLJW6pv9YASpliIuSW6KTb2jsJA3zfQmaDtPZHcYvlSLe6aoE9IVL4xr6t+GGb
         kjC4fo2m6yls4YXB4PAeQht6VtxCYG4ANGTLdbmjT12wymnK/0O+qVbYWe6QsSn0Y3N3
         CWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+mAqJOgM8Ae7l6t9jqHU0zRO0K/U2EOlnDRdwAzG1bY=;
        b=2xVHnn12/Tz9LOKVC/kHsQUdBqVBPTlmCq+ocuTMML1ErLaFlNmXAUYwT/k8VYM7gC
         3WEOG5FyNxtRS8dSxZawUmBPMViQqSNKr74/JW2qiQqmroUMXgw+Mxz70fOAPDQlvzS2
         srU8nIWsvOZw2Qo32iFYhkxsGFn9DAUQuFLjvTgeEmOb9FV61Zhqc1JebKFrZaflZ5/e
         cnaQJzTHEF99j2zD87fx1ZJ/2twcncJ1xjrOsoEyj3WerWhA3nNaMS1O9Lrsi8+u8hzM
         7r0kNPpQ4lFm0BVtSEJzKJToZ0FTLRb8QDygv0BfaQ1A13xT86ZYbAZus0RKGgC6KnTt
         4JKg==
X-Gm-Message-State: ACgBeo2Ids9jaEqFv6FAGNzGTBefI/t51fN/VunZYao9usS+SD4E1qWf
        XVvVQmMer52mHhbTA+1cXWxYMQ==
X-Google-Smtp-Source: AA6agR54woyzOPP4GJVG8gcbyG903ZIhHAHadHE2YriQY9jB67GC0diYbnI+NB4qlUollAbzWY9APQ==
X-Received: by 2002:a05:6512:168d:b0:491:3206:b63 with SMTP id bu13-20020a056512168d00b0049132060b63mr4384111lfb.149.1662737445845;
        Fri, 09 Sep 2022 08:30:45 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 6-20020a05651c00c600b0026ac3fedd20sm117314ljr.86.2022.09.09.08.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 08:30:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 2/4] memory: drivers for v6.1
Date:   Fri,  9 Sep 2022 17:30:35 +0200
Message-Id: <20220909153037.824092-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220909153037.824092-1-krzysztof.kozlowski@linaro.org>
References: <20220909153037.824092-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-6.1

for you to fetch changes up to 9f8fb8032febf594914999c33493c682eaf138cb:

  dt-bindings: memory: mediatek,smi: Update condition for mt8195 smi node (2022-08-16 12:21:14 +0300)

----------------------------------------------------------------
Memory controller drivers for v6.1

1. Fix OF node refcount leaks in pl353-smc and generic of_memory code.
2. Add support for FPGA DFL EMIF revision 1.
3. Update bindings for Mediatek SMI mt8195.

----------------------------------------------------------------
Debarati Biswas (1):
      memory: dfl-emif: Update the dfl emif driver support revision 1

Liang He (3):
      memory: pl353-smc: Fix refcount leak bug in pl353_smc_probe()
      memory: of: Fix refcount leak bug in of_get_ddr_timings()
      memory: of: Fix refcount leak bug in of_lpddr3_get_ddr_timings()

Tinghan Shen (1):
      dt-bindings: memory: mediatek,smi: Update condition for mt8195 smi node

 .../memory-controllers/mediatek,smi-common.yaml    | 11 +++-
 drivers/memory/dfl-emif.c                          | 62 ++++++++++++++++++++--
 drivers/memory/of_memory.c                         |  2 +
 drivers/memory/pl353-smc.c                         |  1 +
 4 files changed, 70 insertions(+), 6 deletions(-)
