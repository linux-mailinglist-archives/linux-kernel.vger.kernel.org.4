Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3818564B733
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbiLMOVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbiLMOU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:20:57 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF83215A2D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:20:56 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id j16so11903769qtv.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6lesIgjAu1xgDp+ShUjiLJxty9FzCAQ1j98A0vqJEc=;
        b=Dc/Pe8J2sAXrJRW+yyb2BMJkXtmUutIMlVrNxhKhnpr/yx54j5dAlYIe5VA0cHPP8X
         fqIBqDNwGmxjC9Lvv3lXJaed2hy0R+vd6CJFX8+zujidhe3cRI6/UX3TJFkzBCXDV6an
         W31PhOhrfuYMT1KnNVoeFoPhmCuwdat4P6VuZNj9R2r3aQVKDemMxApkx8w/VlsjdGyi
         o/mTjYVO8VSKfj3LRY2TtlRr1+ZNvs5dmvhHf9KLgo+9AFcAADhx1ZnrlO43LkwaBd2F
         TzakhaOzk0oJ/oToOMNeTGUaDoGiSNXt/G5DBhLOj4p+VFY16NPqsLugykVC/XPnlH/F
         Naag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X6lesIgjAu1xgDp+ShUjiLJxty9FzCAQ1j98A0vqJEc=;
        b=vSwON5OMKX43WN4ffQM6jfWWTRoU76b6JvDM5iTNjSkg0wgPlNLi0dvukI/cf+QYgD
         wySs4VgjQXSQHPGj82RqmccmOyn87Tmg5AucMDyqtc0xI2ugi630IPIS2Q71YImNxER2
         /1aM7amAVXg0GaPXZb6UiVqCfI8xPeVmiCgpC+bzchOz3AfmWj2o1YyPI1+gY+T0I1z9
         2egZWHWv5fNLwUT+ULEQl2Xaj8D3dOHimfciHSdzY/ev3H/WZdKjYMSriuAZegi3xx2g
         bDcT3DtLUVV3noCTQVqqZ58gaSyCEbA8SNgk9rn8vNI6WGb2OszbUqgesIH0be1FKg4A
         cgVg==
X-Gm-Message-State: ANoB5pkGbg8LnRvDdxNA5eHBf2JxOh0HxCj4hMx68tWENhm8aid/h4WN
        0+bZ4GX7v2VemaZUwv1oAw==
X-Google-Smtp-Source: AA0mqf7zxpijmfwKu/PUl7a79qNumAvGnlnON+RbpJ4/d2prEWmqk7MZyX33zM0CxFbnZ3hQCmXgZg==
X-Received: by 2002:a05:622a:598f:b0:3a5:108b:4c0a with SMTP id gb15-20020a05622a598f00b003a5108b4c0amr28698353qtb.49.1670941255804;
        Tue, 13 Dec 2022 06:20:55 -0800 (PST)
Received: from serve.minyard.net ([47.184.139.94])
        by smtp.gmail.com with ESMTPSA id cr27-20020a05622a429b00b003a81eef14efsm1865812qtb.45.2022.12.13.06.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 06:20:55 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:4140:42e6:4d9b:dde])
        by serve.minyard.net (Postfix) with ESMTPSA id DBF521800C0;
        Tue, 13 Dec 2022 14:20:53 +0000 (UTC)
Date:   Tue, 13 Dec 2022 08:20:52 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Subject: [GIT PULL] IPMI bug fixes and additions for 6.2
Message-ID: <Y5iKRKVS+o7I3OL3@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.2-1

for you to fetch changes up to c6f613e5f35b0e2154d5ca12f0e8e0be0c19be9a:

  ipmi/watchdog: use strscpy() to instead of strncpy() (2022-12-05 06:50:09 -0600)

----------------------------------------------------------------
Small fixes, a new SSIF i2c BMC-side interface

This includes a number of small fixes, as usual.

It also includes a new driver for doing the i2c (SSIF) interface
BMC-side, pretty much completing the BMC side interfaces.

----------------------------------------------------------------
Andrew Jeffery (1):
      ipmi: kcs: Poll OBF briefly to reduce OBE latency

Bo Liu (1):
      ipmi: Fix some kernel-doc warnings

Christophe JAILLET (1):
      ipmi/watchdog: Include <linux/kstrtox.h> when appropriate

Corey Minyard (1):
      ipmi:ssif: Increase the message retry time

Dan Carpenter (1):
      ipmi: fix use after free in _ipmi_destroy_user()

Quan Nguyen (3):
      ipmi: ssif_bmc: Add SSIF BMC driver
      bindings: ipmi: Add binding for SSIF BMC driver
      ipmi: ssif_bmc: Use EPOLLIN instead of POLLIN

Uwe Kleine-König (1):
      ipmi: ssif_bmc: Convert to i2c's .probe_new()

Zhang Yuchen (3):
      ipmi: fix long wait in unload when IPMI disconnect
      ipmi: fix memleak when unload ipmi driver
      ipmi: fix msg stack when IPMI is disconnected

yang.yang29@zte.com.cn (1):
      ipmi/watchdog: use strscpy() to instead of strncpy()

 .../devicetree/bindings/ipmi/ssif-bmc.yaml         |  38 +
 drivers/char/ipmi/Kconfig                          |  10 +
 drivers/char/ipmi/Makefile                         |   1 +
 drivers/char/ipmi/ipmi_kcs_sm.c                    |  16 +-
 drivers/char/ipmi/ipmi_msghandler.c                |  14 +-
 drivers/char/ipmi/ipmi_si_intf.c                   |  27 +-
 drivers/char/ipmi/ipmi_ssif.c                      |   2 +-
 drivers/char/ipmi/ipmi_watchdog.c                  |   4 +-
 drivers/char/ipmi/kcs_bmc_aspeed.c                 |  24 +-
 drivers/char/ipmi/ssif_bmc.c                       | 873 +++++++++++++++++++++
 include/uapi/linux/ipmi_ssif_bmc.h                 |  18 +
 11 files changed, 1004 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ipmi/ssif-bmc.yaml
 create mode 100644 drivers/char/ipmi/ssif_bmc.c
 create mode 100644 include/uapi/linux/ipmi_ssif_bmc.h

