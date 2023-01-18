Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6866728D7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjART6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjART6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:58:38 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98948599B4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:58:36 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id z5so34039314wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/9i/P6wayINNICAhvV/JZZb5FqUILI5LAs0XOioF63Q=;
        b=IOTThF0itOEtNzl4ahK8ePzeU8XRm2NHECau68KYsrRMwjaNFqHjRCJFwBt4/ME+EM
         XFbzS7PoCYe8YGXlbsaTeZCsU/HczFOPP7udGomhwRsUjxAOr/qyxidtWu68Wi+MS/jV
         6zmKIZ2RBw87xeroabirvR1Yfx2oe6osYw0XEufKEcVdZuQdBvz2BhRmTyN2t2D94pQd
         vyjUCV/Zs4DlVmPYxaaObPHB0VQpmRABKEMo9jK8mFKigRciORIUWaQQIHc+aoRRAJb5
         SgMxUhZ8Gfz6ypkwhYbj1t4dwvHf+mJ7shbKRX2bsOF2PKhbujg3msKrxY5bv/NmOVbl
         7kbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/9i/P6wayINNICAhvV/JZZb5FqUILI5LAs0XOioF63Q=;
        b=zfg1gX1wHrCrjp5YN8hcvb66SfJ1QI4B/tu6CpCAzXyPXQE+eJv6jC3XBdpbI3SmsG
         /dAPZjnHfMiWX8iZkobvNcOcJYMsk7/d2UA+Nem3VLGzw6nHY7SDFJO5vjn8Lm6YvPgV
         rrUrBY/dzVyImV5qgnryAyt1vjCG91x1dnhJeNKkn9zujC6q8nZjwWKx8GypJ0vA5INB
         9ltqW5YIbFff9u00b/2Wj1CLH1Uz5Nt9wmPUykoFHCb12abyS1mE5KEFzkOJVZbeVQkW
         Pcj87OhLB1FFWAux32tU9EMCppbBvkHGEmN+Wn1hG8/OsOjcW5yZ91ilYLqZrZfuiYTi
         6OtA==
X-Gm-Message-State: AFqh2kojBoIwkHGPDBUTDo4Pe1WKEsDmo5byp4zwkFt0hRUsQvCy1YcU
        OLYnRVE/RViaIJNB/ZvCTHUlIg4/xeY=
X-Google-Smtp-Source: AMrXdXsyS56wvGROlXOHm7rmw3KF+Avru9KBY2gi55xLLmxZ8vqsDIVAVXZQD/k5KzoXbooS/K8N4Q==
X-Received: by 2002:a05:6000:a0b:b0:2bd:c6ce:7bf8 with SMTP id co11-20020a0560000a0b00b002bdc6ce7bf8mr1557471wrb.5.1674071915131;
        Wed, 18 Jan 2023 11:58:35 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id b11-20020a05600018ab00b002be2279f100sm6006229wri.96.2023.01.18.11.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 11:58:34 -0800 (PST)
Date:   Wed, 18 Jan 2023 20:58:32 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] staging: rtl8192e: Rename or remove CamelCase variables
 from r8192_priv
Message-ID: <cover.1674071236.git.philipp.g.hortmann@gmail.com>
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

Rename or remove variables to avoid CamelCase which is not accepted by
checkpatch.

Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e

Philipp Hortmann (9):
  staging: rtl8192e: Rename LongRetryL.., ShortRetryL.. and
    ReceiveConfig
  staging: rtl8192e: Rename LastRxDescTSF, LoopbackMode and pFirmware
  staging: rtl8192e: Rename PHYRegDef, CurrentChannelBW and CustomerID
  staging: rtl8192e: Remove unused variable SifsTime
  staging: rtl8192e: Remove unused variable framesyncC34
  staging: rtl8192e: Remove unused variable PwrDomainProtect
  staging: rtl8192e: Remove unused variable H2CTxCmdSeq
  staging: rtl8192e: Remove unused variable RF_C_TxPwDiff
  staging: rtl8192e: Remove unused variable DM_Type

 .../rtl8192e/rtl8192e/r8190P_rtl8256.c        |   4 +-
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  70 ++++---
 .../rtl8192e/rtl8192e/r8192E_firmware.c       |   4 +-
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 192 +++++++++---------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |  12 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |  26 +--
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    |  38 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h    |   2 -
 8 files changed, 165 insertions(+), 183 deletions(-)

-- 
2.39.0

