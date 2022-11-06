Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F3761E01A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 04:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiKFDNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 23:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKFDNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 23:13:47 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A091D60FF
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 20:13:45 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id b21so8257551plc.9
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 20:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GlryiTuhWGpYZ55w8aKcxwdOIFsmDboEh+8If5PMp54=;
        b=M+7//DBspHtFga2JTwlMmTCv7yBpINTaAknyJ3Z9YY0YnNCPRI2PYANVL0smCYFGfF
         4qCNQrXvsyBKQ5hqRLcJGzfiwffO3xmohgEvKhV0lwaHvcoYQx3/JzW2tlsnja+zLTxy
         uTe5hjQTBGcARsSknr+LAPt8UIfmY6Cg3v6nEEq0btSiW8rzBEb0GF/7CvpIoiIeSlqP
         CqUqf7sd7sSDJdxtznekAQoG8jIaE7qT5+SueLOGQMcV0Z9GUpK1nKiK2n2qyb3IikfG
         K2wZuIkURZ5SdkGtFfKcrFugArIJGKfusVMDv6RrYbFZ12Y4/+X3lgsA0l9GNmn0XXNA
         Fu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GlryiTuhWGpYZ55w8aKcxwdOIFsmDboEh+8If5PMp54=;
        b=ajRHpm1BJnQ5qStcwyahzQikM48VB5YsnxpnqwtQHNpT4sl/bPs3pT0CGJ3DLYIvyT
         61EQ7S1QSMXEh2LuiNzPGl9GMKD2HE0IhwXrUXT12lzxOIxzx977Ddp/yBsLLBoaVg5T
         gGumsIlEiKez/y7zkjaDdxuaWCdWFDcbF9NpLaMZndb15WRWmmaFINr6EKbMWta6YoPh
         AhBm7/OJevGrbKzTe+KJZJATNwmhl7fG/G1jS1UVtnPojwxtgdY9rX+gicIWBV/r/C7O
         gwCjrM4WyO5HEgn2DAP6ghFFTbXU+YWKXZEgWVHK0bQR8biIdczPWU4Hf8SLbpD1pKYp
         B9FQ==
X-Gm-Message-State: ACrzQf1LNpZu+iobN92dGYjy541nW7hWiRWTkfCuzrQEnU8wmefbryro
        Slsww4THQMJu8WQJsMCWhMwpPB6Rsh6Rfzjx
X-Google-Smtp-Source: AMsMyM5XeDR3a8cToBiG0H/ubNRQvJErSnLzD/K/PNz7FLpBKxPhxGCgPn5Y6/IsuTNoOVdn07SXtA==
X-Received: by 2002:a17:90a:cb03:b0:214:219:b2b9 with SMTP id z3-20020a17090acb0300b002140219b2b9mr30506867pjt.191.1667704424857;
        Sat, 05 Nov 2022 20:13:44 -0700 (PDT)
Received: from jacob-Ubuntu (126.224.215.218.sta.wbroadband.net.au. [218.215.224.126])
        by smtp.gmail.com with ESMTPSA id h3-20020a63df43000000b0046fd180640asm1876817pgj.24.2022.11.05.20.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 20:13:44 -0700 (PDT)
From:   Jacob Bai <jacob.bai.au@gmail.com>
To:     joe@perches.com, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] staging: rtl8192e: trivial code cleanup patches 
Date:   Sun,  6 Nov 2022 14:13:37 +1100
Message-Id: <cover.1667704057.git.jacob.bai.au@gmail.com>
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

Rename few variables and source files to make it align with other
rtlwifi drivers.
The patches are required to be applied in sequence.

Changes in v3:
	1.Patch 3: use ARRAY_SIZE() to replace macros, feedback from
joe@perches.com

Changes in v2:
	1. Patch 2: modify r8192E_firmware.c to include table.h instead of
r8192E_hwimg.h.

Jacob Bai (3):
  staging: rtl8192e: rename tables in r8192e_hwimg.c
  staging: rtl8192e: rename r8192E_hwimg.c/h to table.c/h
  staging: rtl8192e: replace macro defines with ARRAY_SIZE

 drivers/staging/rtl8192e/rtl8192e/Makefile    |  2 +-
 .../rtl8192e/rtl8192e/r8192E_firmware.c       |  2 +-
 .../staging/rtl8192e/rtl8192e/r8192E_hwimg.h  | 33 ------------
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 54 +++++++++----------
 .../staging/rtl8192e/rtl8192e/r8192E_phy.h    | 20 -------
 .../rtl8192e/{r8192E_hwimg.c => table.c}      | 34 +++++++-----
 drivers/staging/rtl8192e/rtl8192e/table.h     | 33 ++++++++++++
 7 files changed, 84 insertions(+), 94 deletions(-)
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_hwimg.h
 rename drivers/staging/rtl8192e/rtl8192e/{r8192E_hwimg.c => table.c} (91%)
 create mode 100644 drivers/staging/rtl8192e/rtl8192e/table.h

-- 
2.34.1

