Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB36607E6B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 20:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiJUSwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 14:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJUSwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 14:52:06 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8728E262041;
        Fri, 21 Oct 2022 11:52:05 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id y10so2417308qvo.11;
        Fri, 21 Oct 2022 11:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BnWyADamElALE/43IWNmOweYeikenj2QejCBLf0v8Ko=;
        b=XtmXuucEOz2pwLYsT6JGG+XOhBcKEZZd/0aHcV1CSGHD3WDF4eeyV4vlTWg1Cw/Ya5
         mTxekXhpgYQP4uqgzfxcq8dMM8Y6zKkOpOBJktbLhMiS5PAIid32fziTS0Nh1cyB7zWl
         /o7mHvWUQmwkt8wshPrb+LWB3JjabuQUlBfnIpfEnWvypvlDbNJGhUfGNBp11zJGNFHR
         KuNY1nwGTsGc2RP/HlC0pDy7yEVjMX0GFRgzSmemYnl93f1k0Nl0zE/gIMEqjGV+h/Ip
         1q5PIE/FHLvr4AxBrgUqWYtduv+gB0K4fYkH4bWePpxcChd+LNbGUxgeTH63+6GYGnBz
         E4Xg==
X-Gm-Message-State: ACrzQf2MiAUsAtYhgtSPGwGxqmU/V3HZL7N6Y371MQgsmVtuiMXOOOex
        NgnxtDiafuiCcjdxKPtwixygZQfrfjM5ZxsC9M4ALidHfaE=
X-Google-Smtp-Source: AMsMyM46QkzjLRKNcuePDrLXsGsYl3oZeG3YTlXf0s35s5jfaGromdfI675olSDMgkfItqBrBfDw8/VSjs+7hgrqa0Q=
X-Received: by 2002:ad4:5cee:0:b0:4ba:54bb:2d10 with SMTP id
 iv14-20020ad45cee000000b004ba54bb2d10mr6018318qvb.15.1666378324616; Fri, 21
 Oct 2022 11:52:04 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 Oct 2022 20:51:53 +0200
Message-ID: <CAJZ5v0hFewGmAWyvPWWO8Fd6w05p05U_vLMsi-5ryFU5wbB6BA@mail.gmail.com>
Subject: [GIT PULL] Thermal control fix for v6.1-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.1-rc2

with top-most commit 4bb7f6c2781e46fc5bd00475a66df2ea30ef330d

 thermal: intel_powerclamp: Use first online CPU as control_cpu

on top of commit aa512c115a09d9133dcb09466e39f93f99a82fdb

 Merge tag 'thermal-6.1-rc1-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive a thermal control fix for 6.1-rc2.

This fixes the control CPU selection in the intel_powerclamp thermal
driver.

Thanks!


---------------

Rafael J. Wysocki (1):
      thermal: intel_powerclamp: Use first online CPU as control_cpu

---------------

 drivers/thermal/intel/intel_powerclamp.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)
