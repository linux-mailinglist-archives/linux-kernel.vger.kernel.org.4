Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602115ED7ED
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbiI1Ig7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiI1Ig4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:36:56 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165589E88B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:36:52 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id f20so16310960edf.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=MB9scqqPsTa03Eqh0VWt1ExIoMmVWG8R3CoCktXXkVk=;
        b=HqpHZZsSDgBv6P3rScAj7s6USz230THVM0x9s6S+CO4s5FUyVrdCSLzj1tUaLRZS3G
         BPWlEAUTvvtCEcm1vPqXGiCzHaLi36+jlrhdXsVAp1VPCGAaYAZjgHNVj4XgN67Unyo9
         lTe+EogYJZ2adCBHJSViLRT7lvWZe3ILJLyzA4CdV5hk/u3p8kdkG7y0an23r1i2ujyS
         +ZYiXli71sqHkQBBj7GEps/iQv/t89S4M3q/ZvMPJkWhIRraO6zQBJkOKGwNAlT2KNos
         tFnpjCC0hmHp8xMoSxd/Kj85+qQ5RTqSHFLfcQSbOhWSphhX5RLReIHrUS/Z995x0yIu
         W9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=MB9scqqPsTa03Eqh0VWt1ExIoMmVWG8R3CoCktXXkVk=;
        b=7SI0RRjtfpzJRzQheEi6OARuv+p1RFdx0oEx1XW/qM2ZwwnzPYhgPogWh/SDp3iMUP
         /GKugY2ooA/W2p9WfIXh5hOZDK7ysclo9N8H2VypHUzWlOHJEODhhKzmAHkrBd2HFvlr
         CjIocMa2n+voBpWI9PR1yaa8Lc+cNPyn7ESuE0vGt8QdMhp0Fu6P3nsxfEQ+BacRg/Pw
         D0+gz3vgQnwAhgV/rDOvpUAaNjuDoZQcPbUCh5Whnnw7Ci6+n+DCM/4DeeI2/kiWyYUm
         P2A9VR1Pb72JbHSPJKhE3Y9riASHyhdtFpTGzWZjRWM1jIaQoiroCqEnTQhzFI37l8Hw
         nAnQ==
X-Gm-Message-State: ACrzQf3aFflj2EZsH8WYYhE5a9pBY3574Yw4DJrEulEbXZAZn/9TPfZ9
        ucDVJmREafhLvIJBykl96cc=
X-Google-Smtp-Source: AMsMyM4606UTICcNA9cVDyDNLoh9tSLeD3uVYYCvEY93tCTgZlmlNLqpvFtfBiJvbgYt87SCGYkd9w==
X-Received: by 2002:a05:6402:84c:b0:451:a99b:f74a with SMTP id b12-20020a056402084c00b00451a99bf74amr32511912edz.100.1664354209959;
        Wed, 28 Sep 2022 01:36:49 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb59.dynamic.kabel-deutschland.de. [95.90.187.89])
        by smtp.gmail.com with ESMTPSA id gy23-20020a170906f25700b00730b3bdd8d7sm2024526ejb.179.2022.09.28.01.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:36:49 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/2] staging: r8188eu: remove two wrappers
Date:   Wed, 28 Sep 2022 10:36:39 +0200
Message-Id: <20220928083641.8275-1-straube.linux@gmail.com>
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

This series removes two nested wrappers around the function
phy_RF6052_Config_ParaFile().

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (2):
  staging: r8188eu: remove PHY_RF6052_Config8188E()
  staging: r8188eu: remove PHY_RFConfig8188E()

 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c    |  9 ---------
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c    | 13 +------------
 drivers/staging/r8188eu/hal/usb_halinit.c        |  2 +-
 drivers/staging/r8188eu/include/Hal8188EPhyCfg.h |  1 -
 drivers/staging/r8188eu/include/rtl8188e_rf.h    |  2 +-
 5 files changed, 3 insertions(+), 24 deletions(-)

-- 
2.37.3

