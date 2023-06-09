Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FDC728DBD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 04:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237963AbjFICXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 22:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjFICW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 22:22:57 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E1B273D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 19:22:55 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-39aa8a055e0so262178b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 19:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686277373; x=1688869373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KXK7JovcIS9AEnwlQeZVXpP6ImBMvB54Qtj7t2A/A00=;
        b=JEb/nBXlabKHiK5t5YZZypFaHWeJlhRnoHuVs7k1qqYbIM1L/ILjJayxZaLcWtQy/F
         /zM43IT6530q53uWBcD+F5SNeYvl6lye+JZgrnzfRZYCLu25lWF26iQSQ9t4zU3pQuWz
         67CmzuupHGc8q3zZfEfgNnXeruPD6moh4zoYk2/zZdcGTfkdhpN5qNzlrwV5O22/lH+6
         th76lq1FNCViy+8vK1aSr38m6w5/6e9hP3eIhA2/OldB+EjwrZx4pS/ZPQN3n1iRIV2/
         ioyWrUCIlpXJJiB+EiscUPF8GYTWqcb9OOyYUdf+bx3i8V3nKOK2HQaB0p1dIzdf0g3L
         IG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686277373; x=1688869373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KXK7JovcIS9AEnwlQeZVXpP6ImBMvB54Qtj7t2A/A00=;
        b=Ap2xJRPEGBIJDfl2YaKs2ErLHCeuDKE/rYw1x7DufsO5BOGcKG1jJjt6X7jn/Db9i3
         z+gf021vOfNYTMf/g4OkvZrHj+bNLt9UXuHNLfEUw10kxTUdhGYDX3iXes+eaIslTF5+
         gxiSuRcDbyf0sh8aX4Nmq/bXt5kh2J6S+jFOrY6H9gojqulo8ju3qeNzx4fNSLWLNRHl
         riPgJ9JpeoD96sp/fQS018ERl8+//ZvgwhBueoQw4ctUk02XUWAKdb5qcU0AuGHXHYBU
         e2IRCV/qPzLVG7gzhU9PrJ08xk1AIfZQmG8rRS/vsBXSUcq+Zz5OL5Q3DREzjMnkrBlW
         2ifw==
X-Gm-Message-State: AC+VfDxzlMHOT6Zt8g0YTA8PQoyHb9M/2AaLn1fCuK7d87K3fxmzP4sZ
        oZZR+JflRVEW6umMXzXXs1LPi0RRuks=
X-Google-Smtp-Source: ACHHUZ5CC4Sb5UkHUu+ZCm3N27/Ud+AHPwQTpJ3tWO6OFa+6NobNRj4JpbXu54GjQ8QGui/mtxYNAg==
X-Received: by 2002:a05:6808:7c9:b0:38e:d739:6f3f with SMTP id f9-20020a05680807c900b0038ed7396f3fmr218573oij.56.1686277373475;
        Thu, 08 Jun 2023 19:22:53 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:3aa3:2af1:e3f1:5039])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709027b9600b001ac95be5081sm2014846pll.307.2023.06.08.19.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 19:22:52 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 0/5] xtensa: clean up platform interface
Date:   Thu,  8 Jun 2023 19:22:35 -0700
Message-Id: <20230609022240.1694244-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series drops platform_* interfaces that lost their meaning or got a
different standard implementation and cleans up existing users and
default definitions.

Max Filippov (5):
  xtensa: xt2000: drop empty platform_init
  xtensa: drop platform_heartbeat
  xtensa: drop platform_restart
  xtensa: drop platform_halt and platform_power_off
  xtensa: clean up default platform functions

 arch/xtensa/include/asm/platform.h   | 20 ------------
 arch/xtensa/kernel/platform.c        | 29 +++++++++--------
 arch/xtensa/kernel/setup.c           | 22 ++++++++++---
 arch/xtensa/kernel/time.c            |  4 ---
 arch/xtensa/platforms/iss/setup.c    | 24 ++++++++------
 arch/xtensa/platforms/xt2000/setup.c | 48 ++++++++++++++--------------
 arch/xtensa/platforms/xtfpga/setup.c | 34 +++++++++++++-------
 7 files changed, 94 insertions(+), 87 deletions(-)

-- 
2.30.2

