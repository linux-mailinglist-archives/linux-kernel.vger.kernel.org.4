Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D8464DCA7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 15:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiLOOBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 09:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiLOOA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 09:00:58 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F462FBE9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 06:00:56 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso1945656wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 06:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BxBZvRx/xvOFj4lrcpiXpuSdy1Po/fIHaot9kODv2aw=;
        b=dKBbCTX0IQXZ4oYPfZbSBlnUNdMqx/4OnYhXaAOzv70H3+H8DHM1z5Kwq9aOULHxbo
         63AMupJm+ejRHYoiGayL7t/u3oAsPpXP7QMJo9ZiSjxeRyGobhuzvV6UaUpxKIl+B/+2
         S2ewYOKORBD8qE76B9utGE6EoSaRB9YEFepTxdDjQifedELbmeRStCVvzjfMsA7ag3XQ
         XTxxbGSNrarhsHUdYLyOrxIuILD03l75c6DQnST5SU5Bg4iOvvNhm4YnPyWmUpQyzR7W
         Txlr/tHaQ032JILT/smSsSAr3dxcG6cuRI9caWc4Zm1K3o8oF7Y+S05w5jWlGtrnZ7Qr
         uFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BxBZvRx/xvOFj4lrcpiXpuSdy1Po/fIHaot9kODv2aw=;
        b=6c25mQpFrBbQxz0hOwecyRaquUHpuRgZ/F/jyKXV2SwPRcuJppJNDNxhWiuKPCxRXE
         fvyzcRZDsEaL33xwEg4I9/b2BlNeVHndUTTArfmuBfiUdZw/hMVRlDMBubR8lGgoz7/K
         fbrfVEF5G6PeVTKXebv3+lJUz8ddN7BaXt7KOadAWt7lgvvMVxAgRwE/f0+BOOZfEp7B
         lwljFXaF0VsNXBwSOSNQTgELxi3vdTG236I+N0kCjEQ7VO9KjkilYnXZnKcVND8iaRTc
         asJBZ/KFiLSmSCIAEGuwV5ZlDR4f9GD8U9pOwzlopi2OAagxWnNYgoYFHc+6O0jQnC0k
         OZ7A==
X-Gm-Message-State: ANoB5pmftjdQ8nIGWX9tl8TmQh9L8xtwHs9XcMZ5DgJzjEPdqvqLVFbZ
        t9EMkBlo4e97BZ1qQbPqzwm7pxttKbI7pw5jq5A=
X-Google-Smtp-Source: AA0mqf5xNtN6eZDQW3BmTkWjfmErU8905CBXIOuwzC0r8E4a3QFcHHsPDNUY+/RU48dE80uNvSQ/ZQ==
X-Received: by 2002:a05:600c:6010:b0:3d1:f496:e25f with SMTP id az16-20020a05600c601000b003d1f496e25fmr21605422wmb.16.1671112855516;
        Thu, 15 Dec 2022 06:00:55 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h5-20020a05600c2ca500b003d1e1f421bfsm6888028wmc.10.2022.12.15.06.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 06:00:55 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, johan@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 0/2] usb: serial: add support for CH348
Date:   Thu, 15 Dec 2022 14:00:43 +0000
Message-Id: <20221215140045.2584886-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

The CH348 is an octo serial to USB adapter.
The following patch adds a driver for supporting it.
Since there is no public datasheet, unfortunatly it remains some magic values.

It was tested with a large range of baud from 1200 to 1500000 and used with
success in one of our kernel CI testlab.

Regards

Changes since v1:
- use a data structure for encoding/decoding messages.
- check if needed endpoints exists
- fix URB leak in ch348_allocate_status_read error case
- test for maximum baud rate as stated by datasheet

Changes since v2:
- specify ch348_rxbuf data length
- Use correct speed_t dwDTERate instead of __le32
- test for maximum baud rate supported according to datasheet
- Use a define for CH348_TX_HDRSIZE

Changes since v3
- Fixed all reported problem from https://lore.kernel.org/lkml/Y5NDwEakGJbmB6+b@Red/T/#mb6234d0427cfdabf412190565e215995a41482dd
  Mostly reworked the endpoint mux to be the same than mx_uport

Corentin Labbe (2):
  usb: serial: add support for CH348
  usb: serial: add myself as maintainer of CH348

 MAINTAINERS                 |   5 +
 drivers/usb/serial/Kconfig  |   9 +
 drivers/usb/serial/Makefile |   1 +
 drivers/usb/serial/ch348.c  | 660 ++++++++++++++++++++++++++++++++++++
 4 files changed, 675 insertions(+)
 create mode 100644 drivers/usb/serial/ch348.c

-- 
2.37.4

