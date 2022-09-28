Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35BA5EDF08
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbiI1Onm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234496AbiI1Oni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:43:38 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A39B029E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:43:34 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id f20so17567440edf.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=0lhK/WaZJzrDqynmGvujL92U6EgO6Nfy2zvJKi36w5Y=;
        b=fbayTju5FA5DQvGsDzzqxhRJteJ3rRkcj3W90jN14f4PhRDx5P/83VFH+L5ySVuJFD
         +286u0/Jfhpu24X0qVBFKRuefWL/qFBlEZhux//r86j0k0B21MOhrrv4onZTOnl1nig5
         jNXbeCRMGd7Gn7Ib/CA6u+ZkbV8CWY5WAK1k5bmBtINP8rMIDk0kdnaCaBpyT6yV9inK
         /r3e7hMh4eFOlvcHpwrRbJTrs9PM0+JB81I+irS38vQ9gHjvAAxdrGDVfFxXrCX0/fzy
         CKOWqDnTCc7QxE2L4ugierl0+R2vH7o858DZAYhIvJqK9uUypSsvAKj5MNn7VcPje/EB
         J+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=0lhK/WaZJzrDqynmGvujL92U6EgO6Nfy2zvJKi36w5Y=;
        b=S3glfRyeMCeDPDcpPSfvumlQ+EYHAqrfkgwL1RvZceDsF0KMWkK+k9iWfPGpQ66pe7
         bY9G2H/snvDemmkKtlP0P3K5ygyxQWQjzpDEClEIE4wNtVPsRJQHRp5QXkC/H3n4FK3f
         9QBh4qCE1yKGBt7zXiAgUsixAKkwe8wERsKge0yJ9jHdNQ1R9gWOatHzOCgtt2+oumnS
         nD21jqmaMuOxhGevylsn9Oj08uUWaCYKf/sCZeoCeIduSfHv3cBqXxgD3iL1rGCgh4CN
         k+VAvfRCC7EfQe9Sjm7AWAu2dJlCLQS66Vn+L8XgbenN6s/Mj4XAhv24Qr50dS+BfxR0
         YXJA==
X-Gm-Message-State: ACrzQf3fghD2HxLOPH6qVQshRsvT7/mM1pqVbA4vCFrJg5yYaAOprhoj
        XH74LfAEkpvP27QfFxp4v3s=
X-Google-Smtp-Source: AMsMyM4viEe/fXeonKu7Ri1nrO1nR6wJAOKyOC+mHAy6lwNfECGEd4OgSWAtj6qg1UOpBzBmtJC9Gg==
X-Received: by 2002:a05:6402:ea0:b0:454:38bf:aa3d with SMTP id h32-20020a0564020ea000b0045438bfaa3dmr34263353eda.291.1664376213443;
        Wed, 28 Sep 2022 07:43:33 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb59.dynamic.kabel-deutschland.de. [95.90.187.89])
        by smtp.gmail.com with ESMTPSA id u9-20020a50eac9000000b00456c6b4b777sm3456973edp.69.2022.09.28.07.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:43:32 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/4] staging: r8188eu: remove enum HAL_STATUS
Date:   Wed, 28 Sep 2022 16:43:19 +0200
Message-Id: <20220928144323.13164-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.3
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

This series converts four functions from return type 'enum HAL_STATUS'
to 'int' and finally removes enum HAL_STATUS.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (4):
  staging: r8188eu: convert ODM_ReadAndConfig_MAC_REG_8188E() to int
  staging: r8188eu: convert ODM_ReadAndConfig_RadioA_1T_8188E() to int
  staging: r8188eu: convert ODM_ReadAndConfig_PHY_REG_1T_8188E() to int
  staging: r8188eu: convert ODM_ReadAndConfig_AGC_TAB_1T_8188E() to int

 drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c | 18 ++++++++----------
 .../staging/r8188eu/hal/HalHWImg8188E_MAC.c    |  9 ++++-----
 drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c |  9 ++++-----
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c  |  6 +++---
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c  |  2 +-
 .../staging/r8188eu/include/HalHWImg8188E_BB.h |  4 ++--
 .../r8188eu/include/HalHWImg8188E_MAC.h        |  3 +--
 .../staging/r8188eu/include/HalHWImg8188E_RF.h |  2 +-
 drivers/staging/r8188eu/include/odm_types.h    |  5 -----
 9 files changed, 24 insertions(+), 34 deletions(-)

-- 
2.37.3

