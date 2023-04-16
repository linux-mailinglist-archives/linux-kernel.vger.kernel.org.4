Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86DE6E3596
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 09:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjDPHTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 03:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjDPHTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 03:19:33 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C062230C6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 00:19:32 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f05f61adbeso5879255e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 00:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681629571; x=1684221571;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g0O0XIvH4c4BlzigY67Qd5l1PmbnHpON5HYPfEl0I6o=;
        b=l96tVkmH6rqdKGLfwHfo4oJWdyRHWk4S2wsULtoPjsL15wlME0iALUOpNyId5USsF7
         4AYrXGAIEGLbAY8hMZco48+Ve5XSxUEmimEhR5nyhjYGgSQVhSeDJ+TUrqP/2HSeV+im
         6BAJSeU1lEq6fpbhas4NFvvQAed+sgH3kl/QJDZ5YXZKg7h9OhrTzhHuEUWSe+RYKp/P
         0+VPPHZ2e469Vyt0wKoQS4C20d2SAxZsogHfvARIHsMBLw2W3J7QpDM/fBrx1ww9tgL5
         wgpBP84pr5R9qLMzaLLkkzjRkk6o92HcjNVDMMssVe8K5zXXP8WZxAhBgVozfOHrRVJp
         VKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681629571; x=1684221571;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0O0XIvH4c4BlzigY67Qd5l1PmbnHpON5HYPfEl0I6o=;
        b=NXdtvKoIcjKOdcWWUTWYBfpr+mrVU8MMnO2elzkDkjG0gNV3BCB3OV80oDa+2fpYZ+
         T38waGnLwYNOAKG/Q6hc8jxQ/zK/nbo8lkjGIduTJzmULZGmkdwRnqdvBfmreIr7g4+8
         3O+jDs+Xeynyb50qEGOH14ORfTd4nhHqcqgCi1eDa1hJphUaCIqO9Jxtzu1FK/h7mudK
         lfowvnFs8pS0FyLppMrakys0ja5WDAXUxwDv7Ywoas7p1QIqXtZYB5tfBA55RRdoZivX
         6acC8DNuqtadsBRIvVGERyOL2G308GCw7cvf2Kfhujgy9qa2/dA5Wx1NdmkjtIVk6UHW
         yDfA==
X-Gm-Message-State: AAQBX9eApqpF7AUkH+DXnI5Fj1z4vQ4QkG8AlrRr6LHiKa91wZHEdZx9
        nUnEVZrriyHf8j4NGYg//fY=
X-Google-Smtp-Source: AKy350bsn31PH4Q/fBL4XCI/dte4Oc0jQMBhU2HtOaiMtVZUQbwrULlIjhx8u/FGKZPeFLYsCjWWKA==
X-Received: by 2002:a05:600c:1c0a:b0:3f0:5a8c:fee4 with SMTP id j10-20020a05600c1c0a00b003f05a8cfee4mr5379324wms.4.1681629571163;
        Sun, 16 Apr 2023 00:19:31 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id o8-20020a05600c378800b003ed2433aa4asm8461793wmr.41.2023.04.16.00.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 00:19:30 -0700 (PDT)
Date:   Sun, 16 Apr 2023 09:19:28 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] staging: rtl8192e: Remove unchanged variables around
 rf_power_state
Message-ID: <cover.1681627603.git.philipp.g.hortmann@gmail.com>
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

Remove unchanged/unused variables and resulting dead code in conjunction
with the state machine of rf_power_state.

Tested with rtl8192e (WLL6130-D99)
Transferred this patch over wlan connection of rtl8192e

Philipp Hortmann (8):
  staging: rtl8192e: Remove unchanged variable RegRfPsLevel
  staging: rtl8192e: Remove unused function rtl92e_disable_nic
  staging: rtl8192e: Remove unused macro RT_SET_PS_LEVEL
  staging: rtl8192e: Remove second initialization of bActuallySet
  staging: rtl8192e: Remove set to true while true of bfirst_after_down
  staging: rtl8192e: Remove unchanged variable chan_forced
  staging: rtl8192e: Remove unchanged variable frame_sync_monitor
  staging: rtl8192e: Remove unchanged variables bfsync_processing and
    more

 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    |  9 +--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  | 20 -----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |  7 --
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    | 80 +++++++------------
 drivers/staging/rtl8192e/rtllib.h             |  2 -
 5 files changed, 32 insertions(+), 86 deletions(-)

-- 
2.40.0

