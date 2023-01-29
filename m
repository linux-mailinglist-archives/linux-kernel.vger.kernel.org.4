Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2017C67FFA3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 15:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjA2O6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 09:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjA2O55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 09:57:57 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D757CBBAE
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 06:57:55 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso6526960wmq.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 06:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x3PIUhJJ2Js3C/6tt+mresOOSKw7x85c+zFM2rE/u0U=;
        b=RcByp6Rs2We/gmOWyyrEZ+IXSaGFAeaQ/6SSTYW8z4OzUszNPVJZBd0XetBD+gv9+J
         PnkF4igZXVKQTRrtpjunOnbo7vzys6/OGwtuS8i1+rXUDAVCHzcJ3+km5yUc+LduIlG9
         h+jlOxNsvjz46Sr4bmV9uRBbaM/HUBeoLi3Xeslsozi1XTvQ6wurNDQlsGXJpgXo8RPS
         L8cseUhE0LDuv7wVcDwP5jHl+QEspL5zTbUGKdRGYYyRi+yYH9HmtlJm2FsIzuy3yhJh
         YsIM9um85wfZGFPPBrQLENpieiSeDapuXq2RmZWZuvGGX9fUYWtHJHkbsM+tG4VBZS6s
         bqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3PIUhJJ2Js3C/6tt+mresOOSKw7x85c+zFM2rE/u0U=;
        b=320IcZlFJYy/dZsegJJhDbbDeLOsnDEUcWIaiR/MUfmyc4l1lOXd1vBv61sJ3TH9PZ
         WYw1XBdSd6dxCKOw6Xfk3zOqb7KrcK+U3Tb/dYSbAvsaJKmZ0RVNVtSys/iL316ortov
         6YWG+5cK76Qn6Az84rNSGn+QSMyXzKj1U83CTJEB4TIqPsmaQaRtfElW4Iawp9+HqKfl
         06zwLO8gdiXe22TdesoZF2iNXwSFf4bUeF8lOXFG6qiL+6zUVwTFZdy7a1xZrZ+OEYq1
         3ferj4hoZ2qSmxrba+m6G4TYSJaKXp+Zm+qfGABn7MtgHxcYiOQBWBeQ4MO69IEznymk
         PRag==
X-Gm-Message-State: AFqh2kqD5gOvnOwFhFZyNX9etigMtmurOpkQ4RhepE0FhZk02mztd839
        6zenu3vo/5fNRPDcG5Z0/1k=
X-Google-Smtp-Source: AMrXdXsjVQh845slkNhByBaBVfoXw7J2mQdc6Pv+qb6C/k15/nHz1+lutQpeeBQWVaaaLPFoYiMf2g==
X-Received: by 2002:a05:600c:3ba9:b0:3d2:231a:cb30 with SMTP id n41-20020a05600c3ba900b003d2231acb30mr10352358wms.3.1675004274089;
        Sun, 29 Jan 2023 06:57:54 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id s15-20020a05600c384f00b003d9de0c39fasm15567434wmr.36.2023.01.29.06.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 06:57:53 -0800 (PST)
Date:   Sun, 29 Jan 2023 15:57:51 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] staging: rtl8192e: Remove unused constants and
 variables from r8192E_hw.h
Message-ID: <cover.1675003608.git.philipp.g.hortmann@gmail.com>
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

Remove unused constants and variables from r8192E_hw.h 
Fix checkpatch issues as CamelCase and missing spaces.
Remove dead code.

Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e

Philipp Hortmann (10):
  staging: rtl8192e: Rename TxBBGainTab.., CCKTxBBGainTab.. and
    RT_CID_81..
  staging: rtl8192e: Rename sCrcLng
  staging: rtl8192e: Remove unused variable rxSNRdB
  staging: rtl8192e: Remove unused constants from enum rt_customer_id
  staging: rtl8192e: Rename BaseBand_Config_PHY_REG and
    BaseBand_Config_AGC_TAB
  staging: rtl8192e: Remove unused constants at beginning of r8192E_hw.h
  staging: rtl8192e: Remove unused constants in _RTL8192Pci_HW
  staging: rtl8192e: Remove used constants MSR_LINK_SH.. and
    MSR_LINK_N..
  staging: rtl8192e: Rename _RTL8192Pci_HW, MXDMA2_NoLimit and TPPoll
  staging: rtl8192e: Rename TPPoll_CQ, AcmHwCtrl and AcmHw_BeqEn

 .../rtl8192e/rtl8192e/r8190P_rtl8256.c        |   2 +-
 .../staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c |   2 +-
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  43 ++--
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h | 204 +-----------------
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    |  16 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |   4 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |  31 +--
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    |  30 +--
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h    |   6 +-
 9 files changed, 60 insertions(+), 278 deletions(-)

-- 
2.39.1

