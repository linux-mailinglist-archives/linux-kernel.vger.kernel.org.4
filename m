Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430727018FA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 20:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjEMSIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 14:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237195AbjEMSIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 14:08:38 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDF540ED
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 11:08:37 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bcd46bf47so2545186a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 11:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684001316; x=1686593316;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0/Ioy8XlRnjB8ru+h/B/Hj91TYAz5qdB/2jxU9JJT48=;
        b=S/ki23hiafepWJHtrUUN1PiZ/5CBuliXK5EwGjgpfkjpcFectnHMxX1k6ZEdmwd+lD
         YvsI5FoTatP69I3wWzpTGgPZVbBwnsjftnVsHVUFjMJMy4wTxY50os8GJJ+WkmdFg8em
         /iud1Yk2QVko9FVA3RRB1AyW3JcIx3TFo+Sutr3PW9rM0AaZMNynHGUxRIpXYZKDc1UP
         Lj7aFAgiLTL+pzmjIKnshWQPYxO4NNPZO8DkdDqxg0taxELjYvs9cphfBnS3P1NWNjbJ
         hNF/HuBCgPY6ZFijhvqgjyzsnp1cVOS9EWPHNysFuQBIXpWudOVZf9HTk8oEzCoVueKm
         9e8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684001316; x=1686593316;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0/Ioy8XlRnjB8ru+h/B/Hj91TYAz5qdB/2jxU9JJT48=;
        b=Xui57ODVR7erqgrpLZQPtUqnGO0xuUvmsYhyjf5ptADnlacFdH8ggjTtl0yNInbtX6
         JZtHSD28sSZVrUQ5/PnHxYXyI+sH74rHVJr6z91avuJSWBQFq1OS2MRkI5uMW7ffOWbu
         RChG+3kP6oZBv2yrOkEKItk020NcNduzmm/TiZRu2K1AUYVIwtBfvmUvesREUAc214qB
         jgwW2ozatIinIUD+TnUL94hO75XcLi4oteRMrteyaQPdhfsKk7vMJ+zWtsWefgy59ZWL
         bq0LZk6gk3Zah24nNMgJYcsIx+Bo9yaKy/T+YkybwdnMiLrANGsuEno7QzcGn2pQYNik
         2pdQ==
X-Gm-Message-State: AC+VfDy9LjawKYkPmrQad3dwQeZkOTwVRU49ts2ei49IVIehT4z624PI
        L9IyyxMRU2fpv6zfKxHm13J65yiegZE=
X-Google-Smtp-Source: ACHHUZ7wiMuttM7PWHLFpY+5haQzYJEPOFF/cVLbyQn1A/6kh6P80JhMvIHYk17ZD0LVpQ7vysJ9KA==
X-Received: by 2002:a05:6402:510c:b0:50d:a9bb:356c with SMTP id m12-20020a056402510c00b0050da9bb356cmr18787278edd.0.1684001315602;
        Sat, 13 May 2023 11:08:35 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935e01.dip0.t-ipconnect.de. [87.147.94.1])
        by smtp.gmail.com with ESMTPSA id hg14-20020a1709072cce00b009662de1937dsm7006316ejc.131.2023.05.13.11.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 11:08:35 -0700 (PDT)
Date:   Sat, 13 May 2023 20:08:33 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] staging: rtl8192e: Remove undefined functions like
 data_hard_stop
Message-ID: <cover.1683960684.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove functions that are declared but not defined.

Tested with rtl8192e (WLL6130-D99)
Transferred this patch over wlan connection of rtl8192e

Philipp Hortmann (9):
  staging: rtl8192e: Remove undefined function data_hard_stop
  staging: rtl8192e: Remove undefined function data_hard_resume
  staging: rtl8192e: Remove functions rtllib_start_hw_scan and stop
  staging: rtl8192e: Remove undefined function reset_port
  staging: rtl8192e: Remove undefined function hard_start_xmit
  staging: rtl8192e: Remove undefined function set_security
  staging: rtl8192e: Remove undefined function SetFwCmdHandler
  staging: rtl8192e: Remove undefined function
    UpdateBeaconInterruptHandler
  staging: rtl8192e: Remove undefined function LedControlHandler

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  4 --
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  | 29 ---------
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c    | 13 +---
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    |  4 --
 drivers/staging/rtl8192e/rtllib.h             | 29 ---------
 drivers/staging/rtl8192e/rtllib_softmac.c     | 60 ++-----------------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c  | 13 +---
 drivers/staging/rtl8192e/rtllib_tx.c          |  8 +--
 drivers/staging/rtl8192e/rtllib_wx.c          | 25 --------
 9 files changed, 9 insertions(+), 176 deletions(-)

-- 
2.40.1

