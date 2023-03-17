Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDF56BF180
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 20:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjCQTNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 15:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjCQTNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 15:13:17 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7883AF284
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:13:10 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id y4so24319039edo.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679080389; x=1681672389;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ix8EQksndO3G3brsWn9BU0CTLTfP5xpCqjBQ9yJVdY=;
        b=B1mdA0JH64t5QhGvLvDrtnfJvORC9uLmdmydjnERPB7xs/U4pR5qHCv2POdBoVELqQ
         Rmvwfc+HMNJw3i6ZcKXYCwLv20uV0S4+Mhs9QQImCuKBoSDzterC23zFdp0UMgdt8YuP
         LRSVm/sJreoDtM+sZx/JLygJoBWXVEelLsWDXC65apndx1Lo3mrq+/Tedr0yK/Bkpsfh
         d90yIgqb6X6IdDuZtn8ljO4Kh1BX1cqLsPRHuU2VStLV6LKJfgFfLpHftzyalVe4ZLBR
         jpT6s1Xi/Su58ToooUITzmgpbkJemAfq/EX5ZDu6SlWO3i4OX6qo+Ebqz9vLnbwjTx4/
         sNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679080389; x=1681672389;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ix8EQksndO3G3brsWn9BU0CTLTfP5xpCqjBQ9yJVdY=;
        b=3M/Rk//6PYR3mzJlWZ8+/LzA8l3kOWXvEqS12b/b2hqbfTA4IDFLMS6ifrykY4G4rg
         dSfdAmHBBE419CAPyAb6LfSAEDJiK96eeD0pBZwjerQQhzOeollvhwgUOzaSOChcLaD0
         zvg8RyqYHWX9Hg+94nG6Izj6URyPudQSO4+RprTuFjb0fzqD9ejInRGX+IxcDNNXmlFs
         viiI6PiU19myZg2Jsea2rOI1sAB6IfXu3T7NrR97iXplP139S3EIToUUm+ptEcBt4eEk
         Wc1Ju6vc/mAz8xvE91xh0XQka1ApIZ9N1JWo4WRqhjhAZca6h8BYLJKx6mDg+9Oe++YB
         zKuw==
X-Gm-Message-State: AO0yUKU28JxjowtLg8pf0s6TEGyY6v2LU04/JJg5UIpenJk6nERMmbse
        bcTccd+Q2VQwSma3DRPEoCk=
X-Google-Smtp-Source: AK7set+gWa5eeFkY2zUcgbbRx6eYyuas/RIcin5VhhKog9qGovRvXaqosB6h8Slx/lPp184235v+6w==
X-Received: by 2002:a17:906:213:b0:931:5145:c51f with SMTP id 19-20020a170906021300b009315145c51fmr4772714ejd.4.1679080389158;
        Fri, 17 Mar 2023 12:13:09 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id k19-20020a1709063fd300b00928de86245fsm1276913ejj.135.2023.03.17.12.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 12:13:08 -0700 (PDT)
Date:   Fri, 17 Mar 2023 20:13:06 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] staging: rtl8192e: Replace macros in r8192E_phy.h
Message-ID: <cover.1679077522.git.philipp.g.hortmann@gmail.com>
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

Remove unused variable or macro or replace custom macro with standard
kernel macro or function.

Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e

Philipp Hortmann (9):
  staging: rtl8192e: Remove unused variable rtl819XAGCTAB_Array
  staging: rtl8192e: Remove double defined constants bMaskBytex and
    bMask..
  staging: rtl8192e: Replace macro skb_tail_pointer_rsl with standard f.
  staging: rtl8192e: Remove unused macro queue_delayed_work_rsl and
    queu..
  staging: rtl8192e: Replace macro INIT_DELAYED_WORK_RSL with standard
    m.
  staging: rtl8192e: Replace macro INIT_WORK_RSL with standard macro
  staging: rtl8192e: Replace macro container_of_work_rsl with standard
    f.
  staging: rtl8192e: Replace macro iwe_stream_add_event_rsl with
    standard f.
  staging: rtl8192e: Replace macro iwe_stream_add_point_rsl with
    standard f.

 .../staging/rtl8192e/rtl8192e/r8192E_phy.h    | 10 -----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  | 38 +++++++----------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    |  3 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c    |  3 +-
 drivers/staging/rtl8192e/rtllib.h             | 15 -------
 drivers/staging/rtl8192e/rtllib_softmac.c     | 23 ++++------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c  |  3 +-
 drivers/staging/rtl8192e/rtllib_wx.c          | 42 +++++++------------
 8 files changed, 41 insertions(+), 96 deletions(-)

-- 
2.39.2

