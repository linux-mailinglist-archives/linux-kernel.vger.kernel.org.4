Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E056769AF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 22:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjAUVox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 16:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjAUVow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 16:44:52 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C1D2684D
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 13:44:50 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id g10so6469657wmo.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 13:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7JMz8jZOn4WuQGzxI1nWAGOXEamTbnJyR7XirPT2J+E=;
        b=ldKvwFSrCl7hVwFot4l5iBMpc1sshkOnBhWyjZ8uXc2xtYz0k7xSrk/+QPZbUQ3PE1
         simOTXey3Y/l2mb34EGSIXdOEBMAYIPHNSYR7yYcV/tbzw+Ue8jNUJCal2qM6fHvxkl7
         F4EI6iiCNSeKo5NmIdPVOPtO4R1ldVF2wZUaYdF8nYQdwfpxq7DVMnaY7AfQtJAbBvfd
         9gKr5mO3uEFn6/IjL2kID+8WL4UZ4NhqJMu44W7BOx39bF5hJ54mKcpa7GJBKt30kFnS
         +gCwkroVuwTHyo8a6PDy7poR1ZHGn9oeT35lNasLH0tW8Heg76/KwNk4iylHCQKhCFS+
         xQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7JMz8jZOn4WuQGzxI1nWAGOXEamTbnJyR7XirPT2J+E=;
        b=Wd+vsNYZFbT+GCPox4eBW748E6aMZLMyP4Hjb+HZouXYRSjDL1qpO2x9Yt1QmI948H
         Ip4c4fUFgKOG305hqY8FHsB+eEfVUMFnBBDyLkNN8F8xRox4mp5eb66Lc1m/wfHzRl8t
         AaUzFQU436Xsx7FI6vJx4PocvDDu4k22fF3m+ogz4UK/dfbOm2JhKARZ68IcoOM+SgxI
         sHo4GWvDsjPtT/sFtSjSFO40d/PAJt+ZUfFDQogxoPXsNs5dzqnS5kWmxIgkIozfXKoc
         6juFVkeBk3hdVHjNyXKIvALXRf+L+N/CwmBw6Rgagk5ag8QrfwA8UyqvoPyNi34S6N2u
         twgQ==
X-Gm-Message-State: AFqh2kqo3JCr+RsIPuQhSb9I+0lw70xrBggP9o66DyIy5uzIX2U0SbYJ
        3dhxAPr4y54eXBy5PEU2gHqZwDfDUtM=
X-Google-Smtp-Source: AMrXdXuoH5txVOd/TjaR7XaiRSnW9Faj8rj8sRmdFETP1CNLIVrTZOkdrcOHYn7j0l1HHz8u94bRmg==
X-Received: by 2002:a05:600c:5120:b0:3db:21b8:5f53 with SMTP id o32-20020a05600c512000b003db21b85f53mr2772897wms.1.1674337489431;
        Sat, 21 Jan 2023 13:44:49 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id h11-20020a05600c314b00b003db2e3f2c7csm8820956wmo.0.2023.01.21.13.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 13:44:48 -0800 (PST)
Date:   Sat, 21 Jan 2023 22:44:46 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] staging: rtl8192e: Rename CamelCase variables and remove
 one from rtl_core.h
Message-ID: <cover.1674336211.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variables to avoid CamelCase which is not accepted by checkpatch.
Remove unused variable.

Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e

Can only be applied after the patch series from 20.01.2023.

Philipp Hortmann (3):
  staging: rtl8192e: Remove unused variable bfirst_init
  staging: rtl8192e: Rename eeprom_CustomerID, SwChnlStage and
    SwChnlStep
  staging: rtl8192e: Rename btxpower_trackin.., Slide_Beaco.. and
    Slide_B..

 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 16 ++++++++--------
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c |  8 ++++----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   |  6 ------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   | 13 ++++++-------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c     | 10 +++++-----
 5 files changed, 23 insertions(+), 30 deletions(-)

-- 
2.39.0

