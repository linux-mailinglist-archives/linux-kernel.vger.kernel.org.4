Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944326E39CD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 17:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjDPP2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 11:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjDPP2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 11:28:31 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C0D1FCE
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 08:28:29 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id v9so28427146pjk.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 08:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681658909; x=1684250909;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7+ik9HPRH9KCB/P60xIoYIrxr9FlO91ORF2/NM2wLU=;
        b=XA0SNk3RGgtkVJMZ31Th930L/FV634DbxkxXdCuA/TxBnGdzSHQ3/KMF7+j5ZXwahJ
         1mzUua/KNylrHliFlry4ftNFUjLgqo4ftoxepxdX4fArB5nTDUg4ww4B98lEmqND9QHw
         5sa0OCWAMDu9TQxRjVDUtncwkDal8rzgQRrlOcB/8F0C3ocQ27w6SVuMSGb7+h4sAPlR
         lLzNDBnS6Vmk43jIVY7wfob2B/23KbrxNfKZrr9R49yClLce6Y1keIvlOCwgN8neR+sq
         LCsJ7LXEUYMrebJ0Kj1wflZIWFUUwo42dUHOh/7qS8M9mlbka822MEPfYPLTRskmHLDu
         U1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681658909; x=1684250909;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G7+ik9HPRH9KCB/P60xIoYIrxr9FlO91ORF2/NM2wLU=;
        b=HKDUaHdOwnWDnSgGPAk2IcqvjtPHD2jaQ7Uj92d+ZGN66FLFbbza/xn7bAdARflKgg
         n09P0UV8c+9IZ7bJa887zE15ZGTXVM5PvOsLdC8iFBoIl7pYKzYxOf8mwNTGhFtplL7m
         aKPtN2nlfcx/6QWSzXtzMWnSbSBryEsaIh+wAmbnHyslhXIjnFNiSIdvyK9lOSODzvNp
         mfbbI6+PmSC7ybxtbuNWx+cfo5NzAYUcq5xO8hbfsWsPZgxv+RIIMqZYAREdDGW2vCsb
         7Woj8F2y7rMmnjZ+U+XuJaIoPf6Yaqx6qF4qZhmYf8RLp5g2B+P6F/cACxJ9X5djvyno
         q8dQ==
X-Gm-Message-State: AAQBX9cV8gjwgXmb7kwopzWuWxGDGsGLJhhb0Fyiu6SJfTYVOYfPrSgI
        f8hKodWRJIMKl3kKimk5YBKKoV/glCi4VQ==
X-Google-Smtp-Source: AKy350YUDNVy34cDJs3zFTTtfAnAbUeT+QkOw+pRbcI2x+ycTM9F5MleJIE+TRSEMvL/pR5rzmyZmw==
X-Received: by 2002:a17:902:e184:b0:1a2:9183:a499 with SMTP id y4-20020a170902e18400b001a29183a499mr8057525pla.34.1681658909165;
        Sun, 16 Apr 2023 08:28:29 -0700 (PDT)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id i6-20020a1709026ac600b001a6930a9ac5sm4868488plt.185.2023.04.16.08.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 08:28:28 -0700 (PDT)
Message-ID: <1d2b9fd2-4a59-cb3b-2fd3-9f6635f3bbf8@gmail.com>
Date:   Mon, 17 Apr 2023 00:28:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Chanwoo Choi <cwchoi00@gmail.com>
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <chanwoo@kernel.org>
Subject: [GIT PULL] extcon next for 6.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-next pull request for v6.4. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Best Regards,
Chanwoo Choi


The following changes since commit 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d:

  Linux 6.3-rc6 (2023-04-09 11:15:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-6.4

for you to fetch changes up to 4e30418def07f8359c7927d5815788043afbb482:

  extcon: Drop unneeded assignments (2023-04-17 00:14:12 +0900)

----------------------------------------------------------------
Update extcon next for v6.4

Detailed description for this pull request:
1. Clean-up extcon core without any behavior changes
- Add extcon_alloc_cables/muex/groups to improve the readability
  of extcon_dev_register.

- Fix kernel doc of property and property capability fields to aovid warnings
  and add missing description of struct extcon_dev.

- Use DECLARE_BITMAP macro and sysfs_emit instead of sprintf

- Use device_match_of_node helper instead of accessing the .of_node

- Use ida_alloc/free to get the unique id for extcon device

2. Update extcon-usbc-tusb320.c to support usb_role_switch and accessory detection
- Add usb_role_switch support on extcon-usbsc-tusb320.

- Add additional accessory detection for audio/debug accessory
  and then pass the deteced accessory information to typec subsystem
  on extcon-usbsc-tusb320.c.

- Add the support of unregistration of typec port on both error handling
  and driver removal step on

3. Update extcon provider drivers (apx288/qcom-spmi-misc/palmas)
- Replace put_device with acpi_dev_put on extcon-axp288.c

- Use platform_get_irq_byname_optional for getting irq of
  usb_id and usb_vbus on extcon-qcom-spmi-misc.c.

- Remove unused of_gpio.h on extcon-palmas.c.

4. Fix the devicetree binding document
- Rename misc node name to 'usb-dect@900' on pm8941-misc.yam

- Fix usb-id and usb_vbus defintion on pm8941-misc.yaml
----------------------------------------------------------------

Alvin Šipraga (3):
      extcon: usbc-tusb320: Unregister typec port on driver removal
      extcon: usbc-tusb320: add accessory detection support
      extcon: usbc-tusb320: add usb_role_switch support

Andy Shevchenko (13):
      extcon: axp288: Replace open coded acpi_dev_put()
      extcon: palmas: Remove unused of_gpio.h
      extcon: Fix kernel doc of property fields to avoid warnings
      extcon: Fix kernel doc of property capability fields to avoid warnings
      extcon: Use DECLARE_BITMAP() to declare bit arrays
      extcon: Use sysfs_emit() to instead of sprintf()
      extcon: Amend kernel documentation of struct extcon_dev
      extcon: Use device_match_of_node() helper
      extcon: Use dev_of_node(dev) instead of dev->of_node
      extcon: Remove dup device name in the message and unneeded error check
      extcon: Use unique number for the extcon device ID
      extcon: Use sizeof(*pointer) instead of sizeof(type)
      extcon: Drop unneeded assignments

Arnd Bergmann (1):
      extcon: usbc-tusb320: add USB_ROLE_SWITCH dependency

Bryan O'Donoghue (2):
      dt-bindings: pm8941-misc: Fix usb_id and usb_vbus definitions
      extcon: qcom-spmi: Switch to platform_get_irq_byname_optional

Bumwoo Lee (4):
      extcon: Remove redundant null checking for class
      extcon: Add extcon_alloc_cables to simplify extcon register function
      extcon: Add extcon_alloc_muex to simplify extcon register function
      extcon: Add extcon_alloc_groups to simplify extcon register function

Luca Weiss (1):
      dt-bindings: pm8941-misc: rename misc node name

 .../bindings/extcon/qcom,pm8941-misc.yaml          |  14 +-
 drivers/extcon/Kconfig                             |   1 +
 drivers/extcon/extcon-axp288.c                     |   2 +-
 drivers/extcon/extcon-palmas.c                     |   1 -
 drivers/extcon/extcon-qcom-spmi-misc.c             |   4 +-
 drivers/extcon/extcon-usbc-tusb320.c               | 153 +++++++--
 drivers/extcon/extcon.c                            | 368 ++++++++++++---------
 drivers/extcon/extcon.h                            |   8 +-
 8 files changed, 354 insertions(+), 197 deletions(-)
