Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1636AAC11
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 20:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCDTNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 14:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCDTNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 14:13:00 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DBE5250
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 11:12:56 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id i34so23076221eda.7
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 11:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677957175;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wix47mHK0JiUR1csrqiZkjc5mC3uJiOQ3Vzx3f1g+ig=;
        b=PaLIUQwss3xHYhvRzDWUskLnpvLXeTygdlDzzhMD0fbUvkEbsZxG1ek8tl5Fo+Mkdd
         0rHDmkXf3or51oChn+UBtHWrOKY1yz8GbwVrEA1MX0w5EXBHO/mhRTcSRUE4XAg6c5md
         guIz/GDLADsbJrO1MgVFB1lNw+hZk9Sz5O8jwLw9FRftPHohULmhbxFm/GbKKzPQviLp
         RCSlN3Yo/0M4ft4QTb2fIc3PaMZLFhzrMnhH5R4cdjzfRC1D+KhQA2ipQeAA8KvD8j4j
         A53jAsF7SEuaucu8vENeC9dPU8jEPOcdL3B5CGWD0sqJrub95kyzWSbSitKG1SqCzgxb
         4Dsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677957175;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wix47mHK0JiUR1csrqiZkjc5mC3uJiOQ3Vzx3f1g+ig=;
        b=HU6xJbi7Tkqdikmfmca+RCZ3MNpITQDJXQZ2Wxqa8AeLOLxNkOOfIMSlj/Hc1LhbEX
         ubx6M5AGoh58JUl22yoekSTM/cail5C6gBi3smMbsj5nnD8RgM9vNvegLHmRKaXSw63F
         yfhT7BbQ9wO1ehnwut9GuvkheTjw9P2pyHYxK64eKvgb8bWet3m7ztpkpljXk1nHf7cF
         aGsbmC2jqoCXK3F7FdLv+YoWJcPR1CGXOtfhi6X95hqu3q6ECUcwV3+7ITfJK5Kct+oM
         ZrXfyKMCvFjCjSfRjKs1w5gyJqZulpYumJtT1IC4PfPjwEx+tviUuS057pa0DNgpvOSV
         nLIQ==
X-Gm-Message-State: AO0yUKVqRDQSXJCxV+EIgeEhQMogoXSUUkqM1ZauXBjCIh9xPe1FrYlP
        UjvPwasj1Hh2x6WaUwQn3cw=
X-Google-Smtp-Source: AK7set8MCwgrMCv1RkmWlIs/GhUpLqQeTbCzBu7Uq/tSb8/yCCEzHF0heJKlhhgpHYdJvOC1pPrLPg==
X-Received: by 2002:a17:906:3f5d:b0:8b1:94cc:10b1 with SMTP id f29-20020a1709063f5d00b008b194cc10b1mr5417384ejj.7.1677957174699;
        Sat, 04 Mar 2023 11:12:54 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id ot19-20020a170906ccd300b008b9d2da5343sm2338450ejb.210.2023.03.04.11.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 11:12:54 -0800 (PST)
Date:   Sat, 4 Mar 2023 20:12:52 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] staging: rtl8192e: Removing rf_type RF_2T4R from driver
Message-ID: <cover.1677955334.git.philipp.g.hortmann@gmail.com>
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

Removing rf_type RF_2T4R from driver as it is dead code.

First reason:
The following table is used to configure the phy base band:
u32 Rtl8192PciEPHY_REGArray[PHY_REGArrayLengthPciE] = {0x0,};
A valid array has at least two columns.

Second reason:
According to a list of devices from wiki the seven shown devices do only support
MIMO config: 1x2:2 in phy modes b,g,n. The only rf chip that is used is RTL8256.

Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e

This patch series requires the patches:
"[PATCH] staging: rtl8192e: Change filename r8192E_hwimg.x to table.x"
"[PATCH] staging: rtl8192e: Remove call_usermodehelper starting RadioPower.sh"
"[PATCH] staging: rtl8192e: Remove function ..dm_check_ac_dc_power calling a script"

Philipp Hortmann (2):
  staging: rtl8192e: Remove empty Array Rtl8192PciEPHY_REGArray
  staging: rtl8192e: Remove conditions for RF_2T4R

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |   3 +-
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    |  26 +----
 .../staging/rtl8192e/rtl8192e/r8192E_phy.h    |   2 -
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    | 109 ++++--------------
 drivers/staging/rtl8192e/rtl8192e/table.c     |   2 -
 drivers/staging/rtl8192e/rtl8192e/table.h     |   2 -
 drivers/staging/rtl8192e/rtllib.h             |   1 -
 7 files changed, 26 insertions(+), 119 deletions(-)

-- 
2.39.2

