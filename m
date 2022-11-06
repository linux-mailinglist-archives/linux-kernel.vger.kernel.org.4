Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01F961E0DC
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 09:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiKFIb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 03:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiKFIbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 03:31:24 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBDDBC0A
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 01:31:22 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id z26so8089390pff.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 01:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QVmSnXt2cQp/FGtsTIfuWxTO1qzExefIA3nhCwOwGEM=;
        b=TO0EsbJtWRFqDgIWJq/In23egRIvivDjs3i7F5P2C3YDuEA3NEftvGxLYjNcNk2Kmy
         Re8NU/fyCfZ89E7yFVUuxbXm6/MNJWWHXzlXSTnUhLc43bMR6SGfGoQppKD3jGTysTbN
         z/MZqJevuVzCLTvHfFJdNPwIP76jL5iOQ+8Cx4QEBN2SnzATSaEQwoGcFMUMa1xOblF5
         mx3Xlj9rJfxmuV66loHKPTzVMXZAyPEVFEC8g+xaTFCfX3TS4PsH9NOMrPlxJgzWKHpV
         0yRYkIGCW9+LObbJCuEkXW1ln+zVj4ki3UZZLv1llAqdzqPTRsxjazu2nWU1FzeSM0fi
         QRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QVmSnXt2cQp/FGtsTIfuWxTO1qzExefIA3nhCwOwGEM=;
        b=TpLnOz3w0Wq9Nw8gMXTu1O4mHuw4ZArQneZHicmRxv/TI7jGxm/n/Dxr9lVFr7hLSc
         SQpPd8/F9J5SX8tAeFMOmEeGEWOnaTBSJGNmV6TZiEz+wXKORPGfH2xoxBgcX+zJ1o7/
         r9cvnupF//zAMlPjjDkrO/MIZHOWwg4JAIvid+tdhuEsKL5Byq9+ihkkyw4nPMNqOcq+
         xnPW1NZImXoSWA0mzFxJfio+Nsml7DiHHdnObbg0HlrmihIW/mvs2Bnu1Np0hzLgUQx9
         Rq1Y/pAx5A4JMtgzAOV2y6csvzLcgzD9V3qzxFWgZrON4I5QGMlUWbDVVN7qBniDvM6A
         BxVg==
X-Gm-Message-State: ACrzQf1tHIyOfzSCGFN+28zhWI/glpeInwNCPUEkryLXl7QxGelmmjVR
        zKSrksW9TWXnRiefPxU+8lKaTWdfdXmJfb4G
X-Google-Smtp-Source: AMsMyM7xW3vyHDXGjWfbVETA+rdoG4p6NKnLwUfKFXjm/xk+clR4UzgxIlx7+oHsNdKKQsoOsGNrsA==
X-Received: by 2002:a63:215f:0:b0:46f:c464:a054 with SMTP id s31-20020a63215f000000b0046fc464a054mr29083875pgm.420.1667723482154;
        Sun, 06 Nov 2022 01:31:22 -0700 (PDT)
Received: from jacob-Ubuntu (126.224.215.218.sta.wbroadband.net.au. [218.215.224.126])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709027c0a00b00186b8752a78sm2790487pll.80.2022.11.06.01.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 01:31:21 -0700 (PDT)
From:   Jacob Bai <jacob.bai.au@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] staging: rtl8192e: trivial code cleanup patches 
Date:   Sun,  6 Nov 2022 19:31:15 +1100
Message-Id: <cover.1667723306.git.jacob.bai.au@gmail.com>
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

Changes in v4:
	1. missing vision number in the v3

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

