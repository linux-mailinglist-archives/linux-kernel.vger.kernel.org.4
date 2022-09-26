Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56C95EAEC1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiIZR4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiIZRze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:55:34 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DF761731
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:32:50 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z2so10052108edi.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=czNq/wdzwKqMnN7AWANCg6E2ckeA0Bn9PlwJV/1m2J8=;
        b=CpoumwMF7v9NlYEo+5acV9Mv7ILoX/7xo3wlW7VFAi4YKf1V2wYukgx26Bu8WAGpDO
         aBMY/VdBnscCGV205g/t0tD1sXt+DLo/WD9PEcLjKsmhIdaoOOv79XMJdOkDLqBaMnty
         /dj5n9umncSUgSDNBLKKLah0xYmoKuy75H6bCmPL2s6m8XNpHRtsmo9m9vBuk9a29qmf
         g19cIeqfpdofmYI5hv+3gbNBwK4iD1i8aCHS0in+th+7gDm8uLetGQo+mkXxI1Szbm1z
         7XQvXCu3J3iLjYpyQDKtcBYdoHr3gNUbBGe4DR5llleI68OGKr8ejpAmwdmBvtoN8wDx
         o6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=czNq/wdzwKqMnN7AWANCg6E2ckeA0Bn9PlwJV/1m2J8=;
        b=z5DzAMLPMB1S4cZYsaNe5swzPRatY1hqUXlLtCoRNQtnrJo7xDmQtazQsxp2Z21tVo
         d2Vbsmf/aztOU4/znvUIMD0XceoQ09eYMlYtENuvqEFhtymbtNTb/7Y6c2nK789izrPy
         67SfNPjtCmYrKKfV71MBPVnqTlBnttg5B8n+QtEVxGDggLsFCemZIkTux5i7lTLUycbp
         /yNoqXVHXtqQnL0V7KrS1/YtqxJz3WI7XlXtoGMnrkS0Glgh3FT508a3T5pYuCo3YPFX
         LoD96NITcUn1ifh8yx1HEuohVWKMiI830TBcrIKS7ljsEtwEDpANVaiTbCPJRbu98spW
         N0Vg==
X-Gm-Message-State: ACrzQf14yyHOy+CqGfu9KRz6J1JjpxvoUdGKDbHJI/YTyopNEdnBvcDx
        pZwl7PCsff0SMrjX8nALWcw0gRTZhMg=
X-Google-Smtp-Source: AMsMyM42ylEsTk3jaOh/XaMiGsMugt2TS1DFTNtUpMqmgjgktaic2g4oWINFx6ZfvU1/6cS3cuKqDg==
X-Received: by 2002:aa7:c78d:0:b0:454:fe1d:8eb1 with SMTP id n13-20020aa7c78d000000b00454fe1d8eb1mr23485082eds.59.1664213569566;
        Mon, 26 Sep 2022 10:32:49 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb59.dynamic.kabel-deutschland.de. [95.90.187.89])
        by smtp.gmail.com with ESMTPSA id y4-20020a1709060a8400b00782667df018sm6554617ejf.54.2022.09.26.10.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 10:32:49 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/3] staging: r8188eu: remove odm_RegConfig8188E.c
Date:   Mon, 26 Sep 2022 19:32:40 +0200
Message-Id: <20220926173243.8767-1-straube.linux@gmail.com>
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

This series removes hal/odm_RegConfig8188E.c and its header
odm_RegConfig8188E.h by making the functions defined in that file
static.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (3):
  staging: r8188eu: make odm_ConfigMAC_8188E() static
  staging: r8188eu: make odm_ConfigRF_RadioA_8188E() static
  staging: r8188eu: remove hal/odm_RegConfig8188E.c

 drivers/staging/r8188eu/Makefile              |  1 -
 .../staging/r8188eu/hal/HalHWImg8188E_BB.c    | 50 +++++++++++
 .../staging/r8188eu/hal/HalHWImg8188E_MAC.c   |  5 ++
 .../staging/r8188eu/hal/HalHWImg8188E_RF.c    | 30 +++++++
 .../staging/r8188eu/hal/odm_RegConfig8188E.c  | 89 -------------------
 .../r8188eu/include/odm_RegConfig8188E.h      | 21 -----
 .../staging/r8188eu/include/rtl8188e_hal.h    |  1 -
 7 files changed, 85 insertions(+), 112 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
 delete mode 100644 drivers/staging/r8188eu/include/odm_RegConfig8188E.h

-- 
2.37.3

