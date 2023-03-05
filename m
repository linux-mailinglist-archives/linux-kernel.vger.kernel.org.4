Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0C16AB2F9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 23:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjCEWct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 17:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCEWcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 17:32:47 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB16C12BC9
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 14:32:46 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id i34so31313052eda.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 14:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678055565;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FkLezU1h/3L/ss9ve9w6OXWpd2aWbqNzCprM55jaH+g=;
        b=dSfz1NxECbm8siUO8cR8Ynt621uP/tsNl17IZ0CgauYV+0xMW7s6ofY9uQdCjeOnoU
         mtN+xZ+7gpDcS7mX7yIpn6ljatOA/nP8kvlcf3DTYLCGeUnIOzyWGb216yYEqXOcKLof
         M6+nlbl+JduR94upm9bSMml9lnW5llBDkofZ2zCuDDnLOesb6Q2jW8vymmh5LkgDZ0uA
         HbRsOWCcLmlC0vRjl2qpkM0IL957Q10/scFX7vW720FsTfZ6K8Io9IJBJPH9v0pwN2hW
         p8BFJE/TS7sx3ly3hsTmventbt1yc3oJ1Yb78m4Hp/Ou5j80pLcsr4m/PD3QCI17VQG0
         msFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678055565;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FkLezU1h/3L/ss9ve9w6OXWpd2aWbqNzCprM55jaH+g=;
        b=dAkhKtnKtIILeeaEbmeda46R7hS8ltkNHaCmz0BXAyhBAP7GqXkn2LV2xCvtCHGatQ
         SA90/ZXhmXs/Jg6YN1gvaK1htkR77xhwzE1/mJGwYAxd/VFsOtp2+V0dkx90iIpSPrWF
         hcb09BIcQ7vXz6n/5Bkz/nS6SOKWW+pDtDk40Bh9Bv9vv258gGNh/vttULGHKKrsJoto
         wOdE08Y/vmKtQRrLFa7mHrTVTad+qMzcAPAfOZkuZe9IePmLU9laGX9DGNfQisG8s/jl
         y7ofmObchLJC2ZMNlfptBupQgBXkMZ7vXFnu/sn6SSj+pVOb3wsXImVkkx0ntO9KvlVl
         nCUQ==
X-Gm-Message-State: AO0yUKUBTAEbeUGcYkuj8kYJU5RD3JpWClUFCjOuOXfboNy0bjjvEpaq
        fvObbOtmq+eLegEG5PKB8SkTYRCi52c=
X-Google-Smtp-Source: AK7set8pgpXNMQLaADSjKZjVv8BuoPNNSRqNT/NfcrrIikujbynBEGzUUVOlqf6qyk7CmQi8xfaYKw==
X-Received: by 2002:a17:906:c1:b0:8dd:76d5:dbc with SMTP id 1-20020a17090600c100b008dd76d50dbcmr7180280eji.0.1678055565084;
        Sun, 05 Mar 2023 14:32:45 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id rp21-20020a170906d97500b008de50990fa7sm3695056ejb.21.2023.03.05.14.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 14:32:44 -0800 (PST)
Date:   Sun, 5 Mar 2023 23:32:42 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] staging: rtl8192e: Removing empty arrays ..RadioC_A..
 and ..ERadioD_A..
Message-ID: <cover.1678051460.git.philipp.g.hortmann@gmail.com>
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

Rtl8192PciERadioC_Array and Rtl8192PciERadioD_Array contain only two
values set to 0. Reviewing the other Arrays in table.c and looking into
other realtek drivers (rtl8192se and rtl8192ee) this arrays are not
containing valid data.

Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e

This patch series requires the patches:
"[PATCH 0/2] staging: rtl8192e: Removing rf_type RF_2T4R from driver"
"[PATCH] staging: rtl8192e: Change filename r8192E_hwimg.x to table.x"
"[PATCH] staging: rtl8192e: Remove call_usermodehelper starting RadioPower.sh"
"[PATCH] staging: rtl8192e: Remove function ..dm_check_ac_dc_power calling a script"

Philipp Hortmann (2):
  staging: rtl8192e: Remove empty Array Rtl8192PciERadioC_Array
  staging: rtl8192e: Remove empty Array Rtl8192PciERadioD_Array

 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 24 -------------------
 .../staging/rtl8192e/rtl8192e/r8192E_phy.h    |  4 ----
 drivers/staging/rtl8192e/rtl8192e/table.c     |  6 -----
 drivers/staging/rtl8192e/rtl8192e/table.h     |  4 ----
 4 files changed, 38 deletions(-)

-- 
2.39.2

