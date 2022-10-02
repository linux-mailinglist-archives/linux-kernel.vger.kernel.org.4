Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74FA5F2398
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 16:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJBOf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 10:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJBOfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 10:35:55 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894B526AE1
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 07:35:54 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a26so17658786ejc.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 07:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=bc5eiXxNF6lAuSNI8nCdi3lf1DQ5k+XIN3ee4g+RQ7o=;
        b=fVoHSgG5614hcdqS185DfH52igj/BcOJSSQ0enSfLX42LacIpTQWU8rPW50NqLE0io
         PTYSH7sCOA+E4D9r+1srs+HsCCZTMi8Y32KswLCwoDhstW0RjAmwk3RvIcGM3/3XClEu
         GGzKrnBGP7T9II+jEvaU31NoHSQ4jMz+S9Rveesyu9RInqmph8fLsm5aVWzZf+rTXDjl
         exJZ4WLanG8CR6v5+CGpMBKBHURSEHjEP7Hfc1Iwc6cS2q7IA1d/ZcVCgeuxluF3WPK3
         Lliw5sHW1q9uQ9Tj/ghBr484EXLsLh3MYlzaWxvjzc7dznlDCLrDkCRJqEdNi+6F1lCl
         PQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=bc5eiXxNF6lAuSNI8nCdi3lf1DQ5k+XIN3ee4g+RQ7o=;
        b=UkPtK6DRAPQxQAjCorjZr0SsrwGzGWMumfHLYvwPJOJ1uZ7lxiDNL+V3B6HMjbaHwj
         aDijOtzuXVuiemJ7P6V0JNmzjSSiHclhzVc8JJohs6XsM/CXmYqfIl/qPUO+7JLshET3
         DfKLwP7m3GSNKyAxHqsgSV3LzybBXRz1n6TAr17MmfLaXb421lPmeWfdoPcMwyJ4IVP/
         SbDWWEUCUycGh73oCd/NQCsjX5ZwE83sbeNTgm6RgpxfqM9xSV7AxMNkYTBrS2f+Ke6l
         fEMEyqnhBMU3d3CH39oN4dKpVLTgtJQmQBNCxh8i/IBTFnPypYD6Hejv/ln0y/fvR3CB
         AtVw==
X-Gm-Message-State: ACrzQf0tja2dwz3MBrHn9W1q8wVtsTmYuxpEOs+emChrfviYky1nSUEj
        WJVOXQ8BT165UqbztvnWPpo=
X-Google-Smtp-Source: AMsMyM5IOqGjIuKeoADZ6+lyLE1jB++RQhqZJarLSc4VeOzyyxevvrALA0SeJ3G4J1Hma0+p1X1+UQ==
X-Received: by 2002:a17:906:4fd1:b0:787:434f:d755 with SMTP id i17-20020a1709064fd100b00787434fd755mr12224992ejw.356.1664721353151;
        Sun, 02 Oct 2022 07:35:53 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb59.dynamic.kabel-deutschland.de. [95.90.187.89])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906301100b00731582babcasm4082334ejz.71.2022.10.02.07.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 07:35:52 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/2] staging: r8188eu: convert two functions to void
Date:   Sun,  2 Oct 2022 16:35:42 +0200
Message-Id: <20221002143544.7974-1-straube.linux@gmail.com>
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

This series converts two functions return type from u8 to void as
part of getting rid of _FAIL / _SUCCESS.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (2):
  staging: r8188eu: convert rtw_reset_drv_sw() to void
  staging: r8188eu: convert rtw_free_drv_sw() to void

 drivers/staging/r8188eu/include/osdep_intf.h | 4 ++--
 drivers/staging/r8188eu/os_dep/os_intfs.c    | 8 ++------
 2 files changed, 4 insertions(+), 8 deletions(-)

-- 
2.37.3

