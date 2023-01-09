Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6305E662FED
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbjAITIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjAITIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:08:20 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B707918B3E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:08:19 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id i15so14056904edf.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 11:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jT0Oz+3cAXi9MsBWfMsEAGfcOwY189DZFhtGxbqiu6k=;
        b=i74hD6c0B4mxb2STWM/PpEPCub6GaziRLOYPHLIoa2zbv2PpwPLtN01V7ElTf171HW
         T8IIR+xM7X2+gmmrVHG2zU8YpngBo+ob1KufO7mJP/Z42YILUyGQcKHS9uTwxPRGCIT/
         QGDCVLGKyWN3fDLo1QMrPl2zatm5EzXK4+7Zr9eHmHVXVzBm6gBpJ1vHa5TjTs2pECBn
         QrRTtO9t0SpobLVZCzF7JKjku15b+nyNersKNW32qtGUr/ha9sEYKgoXoph+pRhDQ5cj
         80BY+LOhy5TUjVjbkjb5AJUY50o0dmcOFKMz04QYQIfnaVHewDwM3mGEaijBazjvMvvM
         qOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jT0Oz+3cAXi9MsBWfMsEAGfcOwY189DZFhtGxbqiu6k=;
        b=Uae4PjSGJpBHmocrjA2dBJnm6YHBcuewLqZPX+sPEbOCI4uU6E7hWG/oZiAktC6Fb3
         PjTimAMZnqvLsks4ymLDyF0/L+ZuRDqWUdSI6JcTq2eKMhhciLE9zlnWUIxoRdOMv76y
         2ZCCXNEPIevzUSpTuygwF27auAtNcd5Av2gW4eiLdqhc+TkoKHmkUDWnJlfOkGcv7Nix
         84LVKcfNdQkYLDZZyLd0w23nYgILSNGI9vyD80XTqwLDU3l/yf8F1BdjN0UWjdBlN6v2
         TuSQlUlkEyK0DuF399IUPdu7O6YvUpwSrj4ntOmi2cc1KHeA7r6VQFCuHZHVH7++uw2L
         2tUQ==
X-Gm-Message-State: AFqh2kpOS95uj9WT2Vde+uRQ5W6nmU+gI7pnfeck//VSb1MOkTbSbMkO
        t9WOAwf5SHd8bM9A/aQ2cwP53MuTohE=
X-Google-Smtp-Source: AMrXdXswuPq44IMreZvlfHay82vYyAUa7RxeKhJFOvI28aJakPgWh6URDQQ3l21lPgjn98EmEXX0hg==
X-Received: by 2002:a05:6402:3603:b0:460:21e2:749a with SMTP id el3-20020a056402360300b0046021e2749amr13780038edb.3.1673291298223;
        Mon, 09 Jan 2023 11:08:18 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id bt16-20020a0564020a5000b00482e0c55e2bsm4048389edb.93.2023.01.09.11.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 11:08:17 -0800 (PST)
Date:   Mon, 9 Jan 2023 20:08:15 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] staging: rtl8192e: Rename variables from r8192_priv
 start with ChannelPlan
Message-ID: <cover.1673290428.git.philipp.g.hortmann@gmail.com>
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

Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e
---
V1 -> V2: In patch "Rename TSSI_13dBm, Pwr_Track and NumTotalRFPath"
          Changed TSSI_13dBm to tssi_13dBm instead of tssi_13dbm

Philipp Hortmann (7):
  staging: rtl8192e: Rename ChannelPlan, eeprom_ChannelPlan and CckPwEnl
  staging: rtl8192e: Rename TSSI_13dBm, Pwr_Track and NumTotalRFPath
  staging: rtl8192e: Rename CCKPresentAtt...
  staging: rtl8192e: Rename TxPowerLevelCCK...
  staging: rtl8192e: Rename TxPowerLevelOFDM24G...
  staging: rtl8192e: Rename MCSTxPowerL.., LegacyHTTxPowe.. and
    AntennaTx..
  staging: rtl8192e: Rename SetRFPowerSta.., RfReg0Value and
    bTXPowerDa..

 .../rtl8192e/rtl8192e/r8190P_rtl8256.c        |  14 +--
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  78 +++++++-------
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 100 +++++++++---------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |  10 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |  42 ++++----
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    |  30 +++---
 6 files changed, 137 insertions(+), 137 deletions(-)

-- 
2.39.0

