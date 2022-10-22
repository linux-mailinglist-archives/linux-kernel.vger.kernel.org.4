Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2936560904F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 00:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiJVWyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 18:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJVWx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 18:53:58 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDEC7C314
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 15:53:57 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id y80so5106629iof.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 15:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fkBjXmjpVErd1A8NZM/nAamr74W5y1SArrL9q2opXZE=;
        b=M1ZGxE8l9LkhRBl+GYdUiTyjtJvI6Y57g7N9pJi/WGeXq8xrs5ZPB0in/UCy8lkFgA
         UlhT740D3RSHZ/zzUuDqPl9mb2SPg/JDRLKNCZ0T0Gtq8dkWS8lE4pxLLd+DQRMfWyS0
         KDhH0I+UJhCZc+Opkw98CIUi7rpd3yD9Lej8dRmnNW22gpKti7OQNsKWJjxNFaN0rOTJ
         xpeyqNsknsjSC6rM3CeaV4CBD+g/8zPUWn/OlctSFN7YubN4iUUssl4B4hLmECaoI421
         M/s7vUi21RMTXkcbfZCyK9gvQEx8jmNVvJIxY4KxywtPd5uGAz7C8nzX4vQxiuaBsZfY
         NYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkBjXmjpVErd1A8NZM/nAamr74W5y1SArrL9q2opXZE=;
        b=2qNZ7k4TQlLmDbXEQ0wMtuOjLf+3F+Gc5xUglGATjw0YDqdKGsi51qh6X0MNWK5l5A
         +8lLVbcdHSAHGHa0XaOySyWikcLESqMh0zZnsy5cVjcd+QwqfddZFjy/HbZdtcLozzDW
         jeIyv5pYnLCQTLqKFX1gpoWDe6hnX06WhS9OFCNLy9rJeXSiXX6eR0JYVGPv/Lf9tShm
         zMDHM1cJWgFbYCyASTrdtatCJ5LriMELMEEc870DEV/XCo5NHnK6ag5n4mAmDC1hsMKp
         o+rzV6IUKgNZ8P/3dgLvGLMfqt5OK1GuKtf5TG/V/8kMXLPUfLID6x7Ob/9BgIGaADgq
         //Ig==
X-Gm-Message-State: ACrzQf0cradkRqVxf2P1m4MMojrSHO9zzZ9jRYJPSqW3/0+9F/AmtIoZ
        ykvRRwkFgCIjTKNJFOA+bFAElKObsfk=
X-Google-Smtp-Source: AMsMyM6POBDF4tk0alpgBpS86Rf6xRNbOoBLpeg8gxx9giPrv69c959MY8vBXr60DS3RICLGidqdHw==
X-Received: by 2002:a05:6602:2ccf:b0:6bc:d52f:a323 with SMTP id j15-20020a0566022ccf00b006bcd52fa323mr17338505iow.152.1666479236703;
        Sat, 22 Oct 2022 15:53:56 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y19-20020a056e02119300b002ffcf2e2e05sm534189ili.58.2022.10.22.15.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 15:53:56 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org
Cc:     Jim Cromie <jim.cromie@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 0/2] vmlinux.lds.h tweaks
Date:   Sat, 22 Oct 2022 16:53:48 -0600
Message-Id: <20221022225351.1406492-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.3
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

hi Greg,

These 2 patches are "no functional change", but they are a simple step
towards de-duplicating the repetitive columms in the __dyndbg section.

For a DYNAMIC_DEBUG=y kernel with 5k pr_debugs/drm.debugs, the
footprint reduction should be ~100 KiB

Jim Cromie (2):
  vmlinux.lds.h: add BOUNDED_SECTION* macros
  vmlinux.lds.h: place optional header space in BOUNDED_SECTION

 include/asm-generic/vmlinux.lds.h | 221 +++++++++++-------------------
 1 file changed, 81 insertions(+), 140 deletions(-)

CC: Suren Baghdasaryan <surenb@google.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

-- 
2.37.3
