Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1986D4F99
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjDCRxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjDCRxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:53:47 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5686B10CA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 10:53:28 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-545cb3c9898so491795017b3.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 10:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680544407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pd9Jdz3B1SV91h6NLZvrdVDwNVrNDtan+IBMNGupTQk=;
        b=Nj/jSV5bFvROgzKaoQxJbRMDMPB/iOtB0mLhe6Fa2/TjnB4hIQEMQtr9s0d/RtJciF
         nMX2IiNeVWbRtdG3aHvgRso36213IyjwzHVoray3wALsCs2d2KPljjcDxaysgvJ1bXJZ
         oMssqjXjwLs2jYDTzcphwKc8l0eGsujrnXVjEb4xqLif+8IfkU+fIzSa4tuZv3/oge66
         ynZcEXjlNA6m2hk7EoBl+Bh2aJj7uD9omuK+onAxS07PdA1v5UOdH2WQ1CGA3Qa0ct+x
         zyBxAv2bAX182Zx947+M3FwLTjPFcYgK9HO2g3ZOHUHADHe310vEJ1rd+sU8Dq5ESjn9
         PEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680544407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pd9Jdz3B1SV91h6NLZvrdVDwNVrNDtan+IBMNGupTQk=;
        b=V/rGHTYdTjZGec+MioRNNxBGr+QQt1wiCkC7E2vmIH3lRfKgD0kgbG+id62vWvRkmf
         zp6vt9EH00rA/XF9vl8ubaBjjEarF0301yn3JTQoA1P6SlQF5DPa3QkC42G1N94tTYQ1
         kYg6NgjqPfbcohhLX23LEODpm2DzY8yhlzCSgdcNpujwqDFmgn+tftzuMu/mGrwvsHM9
         ZlCMcM4pDpM4ehgGwjdBRuHHR5F66xa6v97ooTJCTn0J93l/320eNgc4dJ/2zGCRG/GQ
         bprQzXYRYeB1gD/9YXf49DlLZlUkRNtDwz2yKDjVhmIGukJgjQQViUNIub8gaOP1Y/rr
         seyw==
X-Gm-Message-State: AAQBX9cVeZC/SImt9G83zTFZZkubu864WEhxZlJ/ybrSWE54xwpxftL3
        FSnA6Tb01ew2qsNLPE8S8L2rXu+hZuJrzxaygotaQg==
X-Google-Smtp-Source: AKy350bE6Me58iqO2ykQwLIpoVILHI34G1RRebNmeh8kvxw548+F69sj8/NDQKgV7FupUfIwZ8TjnA==
X-Received: by 2002:a81:4b91:0:b0:538:47b2:c45c with SMTP id y139-20020a814b91000000b0053847b2c45cmr19235930ywa.8.1680544407337;
        Mon, 03 Apr 2023 10:53:27 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id z135-20020a814c8d000000b00545a08184adsm2661663ywa.61.2023.04.03.10.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:53:26 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 0/2] Fix possible deadlocks for i8255 GPIO drivers
Date:   Mon,  3 Apr 2023 13:53:12 -0400
Message-Id: <cover.1680543810.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 104-dio-48e and 104-idi-48 drivers leverage regmap-irq to handle
IRQ. The default regmap locking utilizes spinlocks but this can result
in deadlocks for IRQ chips when running -rt kernels [0]. Enable
use_raw_spinlock for the regmap_config of these drivers to prevent such.

[0] https://lore.kernel.org/all/1466065537-82027-1-git-send-email-mika.westerberg@linux.intel.com/

William Breathitt Gray (2):
  gpio: 104-dio-48e: Enable use_raw_spinlock for dio48e_regmap_config
  gpio: 104-idi-48: Enable use_raw_spinlock for idi48_regmap_config

 drivers/gpio/gpio-104-dio-48e.c | 1 +
 drivers/gpio/gpio-104-idi-48.c  | 1 +
 2 files changed, 2 insertions(+)


base-commit: d49765b5f4320a402fbc4ed5edfd73d87640f27c
-- 
2.39.2

