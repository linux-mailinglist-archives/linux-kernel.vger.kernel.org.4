Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4480E6E3925
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 16:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjDPOUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 10:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjDPOUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 10:20:07 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713311FD7;
        Sun, 16 Apr 2023 07:20:05 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id k65-20020a17090a3ec700b00247131783f7so7781187pjc.0;
        Sun, 16 Apr 2023 07:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681654804; x=1684246804;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4TgnNEoBah6B/QEXaI/SM5ndXxlrgcoQuLMrISQz5A=;
        b=TOR7wRBgSqrjNJsMBhzCKa/81an3WjBzUXYgnVf4RLksORrWrX+5wTUDsLAs4T0FJ2
         L6yulwfIGDt2RxchY5kDv/dDcpnl5ew70vm39IAX9E/115fpc1L4vqgL5M5rIqixrgAP
         m/LjZjC3kGvEbt//Exls0gnClrO2z/iUeRQrhO6ja+YvyV4yvQFLjgQkqs7rALOt9qyj
         EBq2CYLCl/u2pqlFBBwYh64A18F+XZrRzt/z0rSzbGEqlk7mT4vA8YWyrjy/+n2KnUrf
         f5hcrtEk3jy294qAaT81DvPY9NxJcDNKvcPvKvgv4ZlXp1+UTCtS9I1CFJ5EYiRCKRTM
         RF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681654804; x=1684246804;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v4TgnNEoBah6B/QEXaI/SM5ndXxlrgcoQuLMrISQz5A=;
        b=CTyf9nLOZm3tOcezalvVsdzU1EGJRHeAiR0A7Ok193Lo3D4UTu0AOuP+MEoOLExys3
         zt6b/JqUJ1xtN57lg3NdfvTc8Qlxu9JiLOGAiKKvKprdOUH825VaI8GqZRHoz3UGA8Js
         lZd+52x1kE+3/76+ZiyXBOsVgcoH4HeLoR5h6ijlg0bwBdb8R9rDuvLgM77CAyIjh8zJ
         bep0Tuf44+yP9RW6ubbqSuSS+QOovGbRxMXwyW9ZZk/UMU/Y8q/8KZhbfZ7s19oi5/Cd
         kaplpQiIuOp+9ygoDIjaznSsA713m4MI90V3hn1uPSlnQYK8a0P5vUap8zXNkxMlQV4V
         0wvQ==
X-Gm-Message-State: AAQBX9eV4igYtM8IklkUFd3PbIRprIKUN55o0lgkRL1MxiqQ3Ut0aeZO
        0Nay4Y8hFpVEP7N0Xq4iWnY=
X-Google-Smtp-Source: AKy350aenpfJBkfuk2e84QkjKG/HnAo8E6pcvUpY6jrE0iOsGbKXgVZPhQbfwd9m5OnQQAY+yo4UJQ==
X-Received: by 2002:a17:902:c408:b0:1a6:6685:7bbf with SMTP id k8-20020a170902c40800b001a666857bbfmr12450631plk.57.1681654803989;
        Sun, 16 Apr 2023 07:20:03 -0700 (PDT)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id w4-20020a1709029a8400b001a69e002c7esm4089701plp.178.2023.04.16.07.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 07:20:03 -0700 (PDT)
Message-ID: <43723ee9-f786-b423-b2ce-f4c549581d49@gmail.com>
Date:   Sun, 16 Apr 2023 23:20:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Chanwoo Choi <cwchoi00@gmail.com>
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Subject: [GIT PULL] devfreq next for 6.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Rafael,

This is devfreq-next pull request for v6.4. I add detailed description of
this pull request on the following tag. Please pull devfreq with
following updates.

Best Regards,
Chanwoo Choi


The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-6.4

for you to fetch changes up to 376b1446153ca67e7028e6b9555d9b17477f568b:

  PM / devfreq: exynos-ppmu: Use devm_platform_get_and_ioremap_resource() (2023-04-04 00:09:32 +0900)

----------------------------------------------------------------
Update devfreq next for v6.4

Detailed description for this pull request:
1. Remove unneeded SRCU selection in Kconfig because it's always set from
devfreq core.

2. Fix minor updates of devfreq drivers
- Drop of_match_ptr macro from exynos-bus.c because this driver is always using
the DT table for driver probe.
- Use the preferred of_property_present instead of the low-level of_get_property
on exynos-bus.c
- Use devm_platform_get_and_ioream_resource on exyno-ppmu.c
----------------------------------------------------------------

Krzysztof Kozlowski (1):
      PM / devfreq: exyos-bus: drop of_match_ptr for ID table

Paul E. McKenney (1):
      PM / devfreq: Remove "select SRCU"

Rob Herring (1):
      PM / devfreq: exynos: Use of_property_present() for testing DT property presence

Yang Li (1):
      PM / devfreq: exynos-ppmu: Use devm_platform_get_and_ioremap_resource()

 drivers/devfreq/Kconfig             | 1 -
 drivers/devfreq/event/exynos-ppmu.c | 3 +--
 drivers/devfreq/exynos-bus.c        | 4 ++--
 3 files changed, 3 insertions(+), 5 deletions(-)
