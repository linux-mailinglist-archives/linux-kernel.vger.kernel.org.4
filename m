Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F79167A54D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbjAXWDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjAXWDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:03:01 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13FDE054
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:03:00 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id y1so10785134wru.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h5xdmH8zlirHZvICJzGt4pGii8srq455Z/ItOrzAZQg=;
        b=aHNklJ0HIJQwu4SkMQYfXjiHPeRgQXwJVpitL13qVMTnqYZ+vXHFQxnznYsfM81crp
         HSi5+TIPAWqjgZ1hcyzaXDmKx8g4TybXtmEWZSp0pYZ2HvGiVkeBUSiOwP6L5ZkfA3gl
         f6Bm0a0fSK3R593lmWhG+EBmXU6lc1O1ZZmj4KvjezIDwS2MzrRS6EsKEv8ovlWLU6eV
         /KtVIP4qgMPRhUlHyuK+lZW5fWYTsJUYcAtB87No0R2M0r0K2C4EqtVEgLrawk/3xXXM
         NXXeW7pKvhTW6HHeU/ML/2WCLecM3MmZm5Zqfh13+Dce7hbrlDjOZGXA/UD+n2Yie0ZL
         qPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h5xdmH8zlirHZvICJzGt4pGii8srq455Z/ItOrzAZQg=;
        b=Tqx440uW/axOglw3a90DfTpTdE1nb15s6mwe6cQpqJrvSfi/dn0hugpfhxdO2zuDMB
         1MhXs1CVYnwBcCmK0oe4vkZyqVqNbPGvm5X7HO6eaJk1WlFDj+ofq4TSVNy8H3e6/9i/
         YJ2jqEDdBwUlRu8PsHCcsDfZP37MHSRrqn1BPlOpynXAvEsF0c8tEPM1wKf9G1b6SlJC
         LVw2tO5nZj84GF84GJ8mwNhMOcZLJU+NvJ6OnZjbbIZuyj+LfoGdqZ74iR8TJsM+shWk
         kqZB3xhb1clXfzMBqVHGIEvpWKWklIr0jOTy88PzxyP5VNpnN2dNIiJIXcduaUQu5oJL
         GWRA==
X-Gm-Message-State: AO0yUKXO2XpycapWJLWBPBuGNKU7oCmHNrcbMeq8/1SbJ60VjzEuif0T
        YXQIDGMeC2giV6Fm66WiVYM=
X-Google-Smtp-Source: AK7set921/XwPrntnbplCcgKatUjdrG/tZQLt1MFSBg5TKP1SHI7hfy9vi341iOoUkdCQixGIxKLCQ==
X-Received: by 2002:adf:d239:0:b0:2bf:b2fe:a2c4 with SMTP id k25-20020adfd239000000b002bfb2fea2c4mr408061wrh.7.1674597779150;
        Tue, 24 Jan 2023 14:02:59 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id c14-20020adffb0e000000b002b6bcc0b64dsm2897164wrr.4.2023.01.24.14.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 14:02:58 -0800 (PST)
Date:   Tue, 24 Jan 2023 23:02:56 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] staging: rtl8192e: Remove unused variables from struct
 rt_stats
Message-ID: <cover.1674596722.git.philipp.g.hortmann@gmail.com>
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

Remove unused variables from struct rt_stats.

Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e

Philipp Hortmann (11):
  staging: rtl8192e: Remove unused variables rxrdu and rxok
  staging: rtl8192e: Remove unused variables rxdatacrcerr and
    rxmgmtcrcerr
  staging: rtl8192e: Remove unused variables rxcrcerrmin and friends
  staging: rtl8192e: Remove unused variables numpacket.. and
    received_pre..
  staging: rtl8192e: Remove unused variables numqry_..
  staging: rtl8192e: Remove unused variables num_proc.., recei.. and
    rxov..
  staging: rtl8192e: Remove unused variables rxint, ints and shints
  staging: rtl8192e: Remove unused variables txov.., txbeokint and
    txbkokint
  staging: rtl8192e: Remove unused variables txviok.., txvook.. and
    txbea..
  staging: rtl8192e: Remove unused variables txbeac.., txman.. and
    txcmdp..
  staging: rtl8192e: Remove unused variables txbytes.., txbyt.. and
    signa..

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 25 -----------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  | 44 ++-----------------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  | 31 -------------
 3 files changed, 4 insertions(+), 96 deletions(-)

-- 
2.39.1

