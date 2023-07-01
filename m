Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B057448D7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 14:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjGAMT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 08:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGAMT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 08:19:57 -0400
X-Greylist: delayed 611 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 01 Jul 2023 05:19:53 PDT
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74133C05;
        Sat,  1 Jul 2023 05:19:53 -0700 (PDT)
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
        by relay02-mors.netcup.net (Postfix) with ESMTPS id 4QtWFn6bmmz43Fq;
        Sat,  1 Jul 2023 14:09:33 +0200 (CEST)
Authentication-Results: relay02-mors.netcup.net; dkim=permerror (bad message/signature format)
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
        by relay02-mors.netcup.net (Postfix) with ESMTPS id 4QtWFn6BrQz7wMf;
        Sat,  1 Jul 2023 14:09:33 +0200 (CEST)
Received: from mxe217.netcup.net (unknown [10.243.12.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by policy02-mors.netcup.net (Postfix) with ESMTPS id 4QtWFn1lCHz8sZN;
        Sat,  1 Jul 2023 14:09:33 +0200 (CEST)
Received: from thinkpad.fritz.box (p5dccec2e.dip0.t-ipconnect.de [93.204.236.46])
        by mxe217.netcup.net (Postfix) with ESMTPSA id 5FB6781510;
        Sat,  1 Jul 2023 14:09:21 +0200 (CEST)
From:   Julius Zint <julius@zint.sh>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Julius Zint <julius@zint.sh>
Subject: [PATCH 0/1] Backlight driver for the Apple Studio Display
Date:   Sat,  1 Jul 2023 14:08:02 +0200
Message-ID: <20230701120806.11812-1-julius@zint.sh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5FB6781510
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: YFEmzM2+SWjZm4RjqPhIGUYNOBYO3NqIk4q8mJG+
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have been using and testing this as a DKMS for 6 months now without
any known issues. It bothers me, that it needs to be part of the
initramfs instead of just working out of the box. Maybe someone else
here knows, how to tell the USB HID driver, that this is not a HID device
and it should keep its fingers from it.

Julius Zint (1):
  backlight: apple_bl_usb: Add Apple Studio Display support

 drivers/video/backlight/Kconfig        |   8 +
 drivers/video/backlight/Makefile       |   1 +
 drivers/video/backlight/apple_bl_usb.c | 264 +++++++++++++++++++++++++
 3 files changed, 273 insertions(+)
 create mode 100644 drivers/video/backlight/apple_bl_usb.c

-- 
2.41.0

