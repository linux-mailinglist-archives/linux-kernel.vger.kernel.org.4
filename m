Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2585E64B6A8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 14:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbiLMN6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 08:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbiLMN6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 08:58:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB5215709
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 05:57:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D017B81189
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 13:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD4CC433D2;
        Tue, 13 Dec 2022 13:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670939876;
        bh=yLfnYoDZzHQyg8p0dHJ6WkylKVsUbBZToOb3KMPjx1c=;
        h=Date:From:To:cc:Subject:From;
        b=NlUZxWt3LmOQktL04vEE8W+TyL75RmnFfsjO3NLfTbjwMwZ3y4u8jluHKbJhw3kP2
         TS0tr0ztB5oW8RJgRFnybcDnQPKoaVQ36gEi9yNNbdioVS85hZNwTFaBcbHhzpEI6b
         hR/YsI+ExLSoTdUzLqvQwByNQYYsKZy+vkyc5MLf+1vWsyZrTm1T9v7HDBWtrPnIcE
         +lZihoagSepbcjfacj43OLJ5UN+KF/4lylYhyZXV2OdIDnf8IO0/baj0o/925y0ITI
         2V8eqLz29WUVXH9PnePty4GsdAm7xmtw4Nxb44JazjdRswf9R4tHcuDPhtgrWqzCV6
         WDnTdLnHSmd3g==
Date:   Tue, 13 Dec 2022 14:57:56 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID for 6.2
Message-ID: <nycvar.YFH.7.76.2212131449310.9000@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2022121301

to receive HID subsystem queue for 6.2. You might notice that HID-BPF is 
not included in this pile, despite it having been present in for-next for 
quite some time.
This was dropped due to the dependency on error injection framework and is 
being reworked for 6.3.

Highlights:

=====
- iio support for the MCP2221 HID driver (Matt Ranostay)
- support for more than one hinge sensor in hid-sensor-custom (Yauhen 
  Kharuzhy)
- PS DualShock 4 controller support (Roderick Colenbrander)
- XP-PEN Deco LW support (José Expósito)
- other assorted code cleanups and device ID/quirk addtions
=====

Thanks.

----------------------------------------------------------------
Aditya Garg (1):
      HID: apple: Swap Control and Command keys on Apple keyboards

Andreas Bergmeier (1):
      HID: logitech HID++: Send SwID in GetProtocolVersion

Colin Ian King (1):
      HID: intel-ish-hid: ishtp: remove variable rb_count

Dmitry Torokhov (1):
      HID: i2c: let RMI devices decide what constitutes wakeup event

Jiri Kosina (1):
      HID: mcp2221: fix usage of tmp variable in mcp2221_raw_event()

Joshua Jun (1):
      HID: wiimote: Add support for the DJ Hero turntable

José Expósito (3):
      HID: input: do not query XP-PEN Deco LW battery
      HID: uclogic: Add support for XP-PEN Deco LW
      HID: uclogic: Standardize test name prefix

Kerem Karabay (2):
      HID: apple: fix key translations where multiple quirks attempt to translate the same key
      HID: apple: enable APPLE_ISO_TILDE_QUIRK for the keyboards of Macs with the T2 chip

Marcus Folkesson (3):
      HID: hid-sensor-custom: set fixed size for custom attributes
      HID: hid-alps: use default remove for hid device
      HID: hid-elan: use default remove for hid device

Matt Ranostay (5):
      HID: mcp2221: switch i2c registration to devm functions
      HID: mcp2221: change 'select GPIOLIB' to imply
      HID: mcp2221: add ADC/DAC support via iio subsystem
      HID: mcp2221: fix 'cast to restricted __le16' sparse warnings
      HID: mcp2221: correct undefined references when CONFIG_GPIOLIB isn't defined

Michael Zaidman (13):
      HID: ft260: ft260_xfer_status routine cleanup
      HID: ft260: improve i2c write performance
      HID: ft260: support i2c writes larger than HID report size
      HID: ft260: support i2c reads greater than HID report size
      HID: ft260: improve i2c large reads performance
      HID: ft260: do not populate /dev/hidraw device
      HID: ft260: skip unexpected HID input reports
      HID: ft260: remove SMBus Quick command support
      HID: ft260: missed NACK from big i2c read
      HID: ft260: wake up device from power saving mode
      HID: ft260: fix a NULL pointer dereference in ft260_i2c_write
      HID: ft260: missed NACK from busy device
      HID: ft260: fix 'cast to restricted' kernel CI bot warnings

Paulo Miguel Almeida (2):
      HID: hyperv: Replace one-element array with flexible-array member
      HID: hyperv: remove unused struct synthhid_msg

Roderick Colenbrander (15):
      HID: playstation: initial DualShock4 USB support.
      HID: playstation: report DualShock4 hardware and firmware version.
      HID: playstation: add DualShock4 battery support.
      HID: playstation: add DualShock4 touchpad support.
      HID: playstation: add DualShock4 accelerometer and gyroscope support.
      HID: playstation: Add DualShock4 rumble support.
      HID: playstation: make LED brightness adjustable in ps_led_register.
      HID: playstation: support DualShock4 lightbar.
      HID: playstation: support DualShock4 lightbar blink.
      HID: playstation: add option to ignore CRC in ps_get_report.
      HID: playstation: add DualShock4 bluetooth support.
      HID: playstation: set default DualShock4 BT poll interval to 4ms.
      HID: playstation: add DualShock4 dongle support.
      HID: playstation: fix DualShock4 bluetooth memory corruption bug.
      HID: playstation: fix DualShock4 bluetooth CRC endian issue.

Stephen Kitt (1):
      HID: i2c: use simple i2c probe

Yauhen Kharuzhy (1):
      HID: hid-sensor-custom: Allow more than one hinge angle sensor

 drivers/hid/Kconfig                      |    3 +-
 drivers/hid/hid-alps.c                   |    6 -
 drivers/hid/hid-apple.c                  |  141 ++++-----
 drivers/hid/hid-elan.c                   |    6 -
 drivers/hid/hid-ft260.c                  |  325 +++++++++++---------
 drivers/hid/hid-hyperv.c                 |   31 +-
 drivers/hid/hid-input.c                  |    6 +
 drivers/hid/hid-logitech-hidpp.c         |    2 +-
 drivers/hid/hid-mcp2221.c                |  313 +++++++++++++++++--
 drivers/hid/hid-playstation.c            | 1136 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/hid/hid-rmi.c                    |    2 +
 drivers/hid/hid-sensor-custom.c          |    4 +-
 drivers/hid/hid-uclogic-params-test.c    |    4 +-
 drivers/hid/hid-uclogic-params.c         |   73 +++++
 drivers/hid/hid-uclogic-rdesc-test.c     |    4 +-
 drivers/hid/hid-uclogic-rdesc.c          |   34 +++
 drivers/hid/hid-uclogic-rdesc.h          |    7 +
 drivers/hid/hid-wiimote-core.c           |    7 +
 drivers/hid/hid-wiimote-modules.c        |  225 ++++++++++++++
 drivers/hid/hid-wiimote.h                |    1 +
 drivers/hid/i2c-hid/i2c-hid-core.c       |    3 +-
 drivers/hid/i2c-hid/i2c-hid-of-elan.c    |    5 +-
 drivers/hid/i2c-hid/i2c-hid-of-goodix.c  |    5 +-
 drivers/hid/i2c-hid/i2c-hid-of.c         |    5 +-
 drivers/hid/intel-ish-hid/ishtp/client.c |    3 -
 25 files changed, 2056 insertions(+), 295 deletions(-)

-- 
Jiri Kosina
SUSE Labs

