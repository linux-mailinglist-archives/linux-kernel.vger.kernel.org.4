Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931A15F1B79
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 11:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJAJk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 05:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJAJk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 05:40:26 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762843C8EB
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 02:40:22 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id c30so8805596edn.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 02:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date;
        bh=ETJVbLfrYhX3YxSoT9eLhG/lzYMnFZKSAgMNf1s1J/M=;
        b=Ad+rWkCs5M1qWq2V0bJJoXrdu3xvcK8tel4seiyX28agWoxn5kW8i3evbKAuUaWT60
         q1Zccf19s3zp1a2Zn1KE38Lrb7YKc0vqFW5aMD6zIks5XDzt9tlg4uKExqwnNmvQyyg7
         g2cy4vofjNnZCSUI/BvNnwMa6iJShoVu7337/toBOJ+S/PQEETWK/r15bdQCX0VTBete
         GpOFoITINOFdNDh4qIspui1cwiDcwBWcW6ZSJRkRQ+L9YknCnq/TwVRw+AA03p+Cc6yp
         uTTrsIkeejgiDRGgg+J9xak3lSqpIHJv6D6RPkUFdqrFQeJX5JgnrkOc3jhgm3IG9ukh
         m6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ETJVbLfrYhX3YxSoT9eLhG/lzYMnFZKSAgMNf1s1J/M=;
        b=jTFnI6dzX0f/swWgpVQotRDOu7Q3p37U7tpVreX8KWHvTlH/KcQSc/7bQyI6PQm5jY
         BH8AcL48t5xMs1PCPPRMqFhmyw8KpF+rvT4XzbzJ36QTDadBAsYNqKMlo9AQe18DdfvB
         mpjy5d/BZdNdyPy5+yGp06rgP/E/bms72AM0oyFKzcAyv3nlPropYcbKMtKOkmYOODi7
         33Bdn6UkxyNP6DL1VKt2NjrW974tkuYbWjFQDeGFIrhPlXumzWDexyhJ2cnz8GEOL7VK
         HQxvZj2l2ap2StXWYljr2szlg0PCP6p9YdeXUkBOolSWXNWJbLdJBAN1gcCINoI63Iko
         b1YA==
X-Gm-Message-State: ACrzQf0xW2P1EoHhoRl5KbNGSpCtbbebYTZuycGzaNbzXoJpeIhuYEzo
        UiHmQSEHHStByi4AdhIPhEU=
X-Google-Smtp-Source: AMsMyM4KDWZiQhxQcwmK8kgSBhakvNBOtpcQN5hjg1hksR34Dmjzll+AFm+6Z46wQmqPiup28OZ+/Q==
X-Received: by 2002:a50:fc0a:0:b0:458:73c0:7e04 with SMTP id i10-20020a50fc0a000000b0045873c07e04mr6698418edr.270.1664617220803;
        Sat, 01 Oct 2022 02:40:20 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id lb9-20020a170907784900b0073ddd36ba8csm2466309ejc.145.2022.10.01.02.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 02:40:20 -0700 (PDT)
Date:   Sat, 1 Oct 2022 11:40:18 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] staging: rtl8192e: Remove unused and unchanged
 variables in rtl_ps.c
Message-ID: <cover.1664616227.git.philipp.g.hortmann@gmail.com>
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

Remove unchanged and unused CamelCase variables that lead to dead code.

Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e

Philipp Hortmann (10):
  staging: rtl8192e: Remove unchanged variable bFwCtrlLPS
  staging: rtl8192e: Remove unchanged variable bInactivePs
  staging: rtl8192e: Remove unused variable bIPSModeBackup
  staging: rtl8192e: Remove unused variable bInPowerSaveMode
  staging: rtl8192e: Remove unused variable isRFOff
  staging: rtl8192e: Remove unchanged variable RegRfOff
  staging: rtl8192e: Remove unchanged variable bDisableNormalResetCheck
  staging: rtl8192e: Remove unused variable bForcedSilentReset
  staging: rtl8192e: Remove unused variable ScanDelay
  staging: rtl8192e: Remove unused variable bDriverIsGoingToUnload

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  8 +--
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    |  1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c   | 18 +++---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  | 20 +-----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |  9 ---
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c    | 61 +++++++------------
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    | 48 +++++++--------
 drivers/staging/rtl8192e/rtllib.h             |  6 --
 8 files changed, 55 insertions(+), 116 deletions(-)

-- 
2.37.3

