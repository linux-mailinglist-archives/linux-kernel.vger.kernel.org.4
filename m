Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA3B609055
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 00:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJVW4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 18:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiJVW4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 18:56:43 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8558883F17
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 15:56:41 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id o13so3476415ilc.7
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 15:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jM5meo0ZGZ7KJu4pnBNKRi5tHBVhOfktKQt8N819UHU=;
        b=adnVfAeGxOj0UswBzcj1+5i/PyYahRvmFbir6YJQTWn5ocQ/nw3rgXNRdBwk2RFcGC
         oEpq4Oj9tRr4HVV8xlv46a/LtzWA5y6IeO4FlfwQPeXVMpkzmmQ0HMqUuoWd+DulQhKS
         EZNvWz5Pf8o4qa3AjG9kJbErg1+ac8Fy0RgNBuiDza0/Sv2hylLhSJRwPbozt9Av+UD4
         f82wU/bIz1BaSPhkujYHYqWpLKN36QKuwTRkddP5nXlviMLOu2Tw+FN93aLsuqhpVfWi
         wdKsOjS+Wn8vZ9zJ495k5SqSN0KxbyJyBMMHPT5luHgn/ACpgkiY2wE5HEy3OiUhBqAq
         BHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jM5meo0ZGZ7KJu4pnBNKRi5tHBVhOfktKQt8N819UHU=;
        b=3Kv7dYs7zh886BOXLX6Zov/sAoAx0pdK5Als9AuGIWCVYupeURAsi1qGoj0/lYOURr
         vcGgCFDXG+S+3+M6qjxn4TCHIDVf2wz8s9SLsuFRBSSVsDOj2aR7VpMDITzcD56Y8FiO
         t2ER/qZ6nAnRFIhF2agU11LKtWhutRzkiSPpWeRam1Mb3jyyc5NAH7eEkzxFZhrY/rRN
         XnVJ3EbeFPMsG0dutENzOIaKsqUh4R/Cn5SqTzZtP0711Chfx4Zfk4kvE2htUBLn9iy3
         1+igncp2TvyO1FBJZ/g9Pp4Rqt5wRh3z9FYQ1Xw5e12yomD7HvFqz0p4yLtpAe/gonMA
         DmSA==
X-Gm-Message-State: ACrzQf3YF181LcFZBPD86+Ulq2Hnjz9iAC3hqfQYs2DjKNFeRUw9tZ6o
        24IdCUbXo3ncRC3VnVEf011xVyIw1aw=
X-Google-Smtp-Source: AMsMyM6uvZ6t9Z1zxm5n22mJFmSKwhdqnfGlEB8VY7aoK2hrUqGldIaBkANLE2GMDbA4EI76FgdEjg==
X-Received: by 2002:a05:6e02:1ba3:b0:2fa:3547:477a with SMTP id n3-20020a056e021ba300b002fa3547477amr18811281ili.34.1666479399788;
        Sat, 22 Oct 2022 15:56:39 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id o9-20020a927309000000b002fc323a2902sm2492267ilc.62.2022.10.22.15.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 15:56:39 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org
Cc:     Jim Cromie <jim.cromie@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 0/2] RESEND vmlinux.lds.h tweaks
Date:   Sat, 22 Oct 2022 16:56:35 -0600
Message-Id: <20221022225637.1406715-1-jim.cromie@gmail.com>
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

this time w/o the stale patch 2.

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
