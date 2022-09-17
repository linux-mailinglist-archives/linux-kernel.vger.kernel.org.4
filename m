Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BC45BB623
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 06:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiIQEZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 00:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiIQEZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 00:25:01 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7834C637
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 21:24:57 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id 13so24499013ejn.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 21:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date;
        bh=Ih6RViuFYSO4oFrRxwo7eSPDz1/vXHNTppdf5GB0xs4=;
        b=It+WthWhOGrxYwoT6LTHzhnEm8pdt1q2Kxm+nJhCULw4pOXXJ9/lrtOcbmGTWZUB2a
         rMrUDr/a+HqS6ohag1G5Eng4VF9YQs59wFG+QPG3JAkMVluj/GRw8WVBvVAWeEg/kI2p
         dneWnrNZg2CjN5LP/0oGF1bQnF+wzDf4Q+K3qrm3f9oElWxYWNo8oUkBoAjxcLn5sZYb
         GNHei1+VnJ6lEcnfWxLZHt9SoVdICa15E6O3YcWdgnxUAIhC4GEl9raM+A03u1fHREsH
         /GfUGu7f+Q8Amf6ev00HOhZx9W4RsOV/Y+3AXUNJEl7g+ajJPSocGuDe/DbYc3BcetB0
         KYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Ih6RViuFYSO4oFrRxwo7eSPDz1/vXHNTppdf5GB0xs4=;
        b=mQ1qB7Yd6klYN2I6Y7uZnXLm+D8z4Akz95gTal0ath23DI15v037O5ABcnndhTnuB8
         MLY1+hTwRAC55CiJM3tD9EvJt5ZXWVbQU21JE48O0aEVZz1LDghodKYjSAeMFv4Hnptm
         JdVIeWbt2i4bbmEa1SFkExDH190FlBq5IPbcSV+L1DlMj0UgsL78w9nl8gsc0wVs7KTa
         iWz3sLrH4tqaDgioKnIRHDJnw4ySTAU6iirfrALx/O+JuGJB+S2tBETmhjTeMM4G+CqB
         ZGmlxcA2lBNKMRyQ8OBSaFoEB4wUdjhCXNcG3YEtCpy/Gy5XfJ4LsU/Ny4Lzg7T6kPF3
         Ei/Q==
X-Gm-Message-State: ACrzQf1eLPC6EjnGWYXa5d7H7zS6WWrLKRQRG0gHWK0FwjFlGjXP+qYu
        gBLsQOfUJ70rBjqILEuGWTc=
X-Google-Smtp-Source: AMsMyM6/VQ5pkXMFQ3AsThkW5okJI3ndyKJvMjsKJy+hKE3X42BQ1VDKk0a515HqcP9vlCxRi3zagA==
X-Received: by 2002:a17:906:505:b0:73d:b188:17d9 with SMTP id j5-20020a170906050500b0073db18817d9mr5293974eja.97.1663388696346;
        Fri, 16 Sep 2022 21:24:56 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id y17-20020a50ce11000000b0044f2afbb1easm15141717edi.27.2022.09.16.21.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 21:24:55 -0700 (PDT)
Date:   Sat, 17 Sep 2022 06:24:53 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] staging: rtl8192e: Remove ftrace-like logging RT_TRACE
Message-ID: <cover.1663387785.git.philipp.g.hortmann@gmail.com>
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

Remove "Unnecessary ftrace-like logging" as requested by checkpatch. To
keep the logging would make future patches for fixing CamelCase larger.

Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e

Philipp Hortmann (6):
  staging: rtl8192e: Remove ftrace-like logging in r8192E_firmware.c,
    ...
  staging: rtl8192e: Remove ftrace-like logging in r8192E_dev.c
  staging: rtl8192e: Remove ftrace-like logging in r8192E_phy.c
  staging: rtl8192e: Remove ftrace-like logging in rtl_dm.c
  staging: rtl8192e: Remove ftrace-like logging in rtl_ps.c
  staging: rtl8192e: Remove ftrace-like logging in rtl819x_BAProc.c, ...

 .../rtl8192e/rtl8192e/r8190P_rtl8256.c        |   6 -
 .../staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c |   2 -
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 161 +----------------
 .../rtl8192e/rtl8192e/r8192E_firmware.c       |   7 -
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 132 --------------
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c   |  16 --
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    | 165 ------------------
 drivers/staging/rtl8192e/rtl8192e/rtl_pci.c   |   2 -
 drivers/staging/rtl8192e/rtl8192e/rtl_pm.c    |   1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c    |  34 ----
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    |   8 -
 drivers/staging/rtl8192e/rtl819x_BAProc.c     |   5 -
 drivers/staging/rtl8192e/rtllib_debug.h       |   6 -
 drivers/staging/rtl8192e/rtllib_softmac.c     |   8 -
 drivers/staging/rtl8192e/rtllib_softmac_wx.c  |   6 -
 15 files changed, 1 insertion(+), 558 deletions(-)

-- 
2.37.3

