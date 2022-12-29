Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82321658F07
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 17:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbiL2Q0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 11:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbiL2QZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 11:25:35 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5CD13DD3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:25:34 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id qk9so46089450ejc.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9PoCL0xlGBCqJ9wbeAI7D5ytAkpqEbAMxiagz0hFqcA=;
        b=Rj7VveSd+eEjPteO/mcjJqlcMjyYq2rpoyEYFhjYWmpGFoMOw3krYN41SepGMT2RJ6
         i0p8yp9tln8b0zdoD8plG/eRaD/VM0I4vtcpId89ozGC3Dn7KRQXDmOuVv6zRkw+LDWE
         PqMj83NI/gmPLBGS0Vki/MitUMGIbvhNJdCQqKDywikLa3RCSIIyMO9hgfPmIu4ArTov
         yXafpt6F2egKk1R2+TfEl/idWJehoVkzF8v6RXMTS/H7dUeCWfR1rHRWzxZP/ehtKSPF
         BdiFrm1ul3L2rOZ5528MH2NvQ98j8kF6cVEhNk/N7e96zAa4khCtwfQY3KClEG7LohsQ
         0zKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9PoCL0xlGBCqJ9wbeAI7D5ytAkpqEbAMxiagz0hFqcA=;
        b=dSqfkBscnB8Pt1hGj4eJl7ezmn7iUlFuayu88j6fZZXm+QatGYngW3hpoBOFRY/R9D
         f15hAIsuBadnNOesoECEWZ6ze2ORPizDTxGbFGC/jtAFS73ted6Ea2Ovt19KKH43kU8+
         dKgaRmgu1+IR5TOdgWzpnbCYuaCwkyRS61rNzGk8JBuo85J/WZCNkoBQmECa05HCzYWH
         oaOIudy7ajIJ0/t/RYFqnpL45eXHS3N1Ro1Z7PRFx8Xml0aJFtGmj6ME1QKS0ebtGzUB
         xIiljso3mjeKk+4j0K6bFxOvepVWzFdKXpUzQZxG0xvISV5NAUM5S/qZRyzVwuzZiAf6
         QeFA==
X-Gm-Message-State: AFqh2ko1YSGGjvM8XJfzGCMWfdqTP5E9vqwv9Z1BuJnG5Yr/eyKWUCEF
        G6asfriu40mFi8tbnJAq134=
X-Google-Smtp-Source: AMrXdXuxYXVZQnKkUGs0BuIFiexSiqju4BEwueACbXfb5H47PRFgp4em1oIuCDGNlmx5XQ5Ouqn2Vw==
X-Received: by 2002:a17:907:8a20:b0:7c1:27c:2530 with SMTP id sc32-20020a1709078a2000b007c1027c2530mr7179266ejc.3.1672331133050;
        Thu, 29 Dec 2022 08:25:33 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id o11-20020a170906768b00b0077b523d309asm8689342ejm.185.2022.12.29.08.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 08:25:32 -0800 (PST)
Date:   Thu, 29 Dec 2022 17:25:29 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] staging: rtl8192e: Rename variables from r8192_priv
 start with ChannelPlan
Message-ID: <cover.1672330343.git.philipp.g.hortmann@gmail.com>
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

