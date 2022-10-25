Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3574C60C7C9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiJYJT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiJYJS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:18:59 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2D016C20F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:12:43 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id b2so10860051eja.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NQGDjtnhvoIMjGlIIUPotnqzX5/+w+VwLHCabOPt+h8=;
        b=EzbDPXnXK+fRRH4bvsRuiyseGP+b7xX1aDuyWi8OlTpBv32jAiLDS0is9eE/zXawOK
         bIquBaSQdNVvot913dxq7RV6IQrvsKiWSVFoie10QkksEUvBRej1YClwTLd03VazDBrh
         8IP/pa7qIrdCrUfKLT8D9EsB0DD0oTVO4eE3T/FOqnlUBy8Dmt2E5pmcInRd49AIZ9w7
         9ZoHmVSBr+90etxEvyz9TjGryVNMGVjtNJU//Ev2JLShMXLf7iCE/4u90f+CjnjxXdwM
         0qb1d33OkfPnyZpgOjvjXQNx1R/jouHoD0X5PS5N52AI3JnhicRHHC+mFopw/4aPOxvu
         yXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQGDjtnhvoIMjGlIIUPotnqzX5/+w+VwLHCabOPt+h8=;
        b=Lny2TbWHPLcGbYFV0OnjCksKZOTDm+qVces1lyy+jGEMtOFvz2+BPTRzLk6Ry5dGwL
         bK/2EKSzXfsJ3ZB2h6m0SS888Gv7KhBXSTQraN2a5v8/z3M/ijSN/XkyBFpu1ytvzqCn
         fs7dVxUMuX2/Yy6Nrzq+IwTyTrHsSy/SKD4NwUOW6NGnI60bkxyy5xb+o/t/aV/OaiKR
         b/veFLbv5n4ohzv/gewbaXAfYsmyZIzGTys47xwRwzo8KXElmLt6eGZ1a+5m36Ht8kSL
         6Tke8kK0j1h0ChiJnvKiYKmtaib9BHQ3Q2pPcfPs3jAST06ewVZEwSWK+BHkjtz+hQxm
         yo2g==
X-Gm-Message-State: ACrzQf3eSa7+5vx3RBwKx8eburgIL9NL0DMch6EumKSTs7df7Xfo6uGx
        gU9TN4em/bWoOsS/kKPgD0I=
X-Google-Smtp-Source: AMsMyM5HqZVdcFc6lJMbR+B8ftG+TpzsZZov4wzeYEgMYSHw2FPPCUqDAU/ksJgFlOWRh6bgwDXYgA==
X-Received: by 2002:a17:907:a40d:b0:78d:9f66:e51f with SMTP id sg13-20020a170907a40d00b0078d9f66e51fmr32425502ejc.654.1666689162453;
        Tue, 25 Oct 2022 02:12:42 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-178.ip.prioritytelecom.net. [217.105.46.178])
        by smtp.gmail.com with ESMTPSA id bo12-20020a170906d04c00b00780f24b797dsm1061953ejb.108.2022.10.25.02.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 02:12:41 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     namcaov@gmail.com, Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] staging: rtl8712: clean up dynamic memory management
Date:   Tue, 25 Oct 2022 11:12:22 +0200
Message-Id: <cover.1666688642.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is fine if memory allocation never fails. However it does not
handle allocation failure well. This can either lead to memory leak, or
unallocated buffers being used.

v2: Add a missing if statement, as noticed by Dan Carpenter

Nam Cao (4):
  Revert "staging: r8712u: Tracking kmemleak false positives."
  staging: rtl8712: check for alloc fail in _r8712_init_recv_priv()
  staging: rtl8712: check for return value of _r8712_init_xmit_priv()
  staging: rtl8712: fix potential memory leak

 drivers/staging/rtl8712/os_intfs.c     | 27 +++++++++++++++++++++-----
 drivers/staging/rtl8712/recv_osdep.h   |  8 ++++----
 drivers/staging/rtl8712/rtl8712_recv.c |  7 ++++---
 drivers/staging/rtl8712/rtl871x_recv.c | 16 ++++++++-------
 4 files changed, 39 insertions(+), 19 deletions(-)

-- 
2.25.1

