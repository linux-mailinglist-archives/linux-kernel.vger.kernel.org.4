Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEDC5B5A87
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 14:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiILMyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 08:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiILMx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 08:53:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5C938698;
        Mon, 12 Sep 2022 05:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662987224;
        bh=95JIk+nlCdCOT/oR0LRrrmD4ccWWrV8jyvKWVBS9DT4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Vb4Yq7CPnawXCxXbOj45oBr1eKauq2ddERPPxYrzElUMoREjAct1LSttpABT0AMSr
         vSPYJ9Z88uzI8DmBV4Qqas0A4QV7WEeIxrSSQZSVz9I77UysUd4hhBGWg0352XzWga
         iYtbG/Sn7XIWG4Yo6j+/F6gpj0WLxcIfYN3HbCrw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N8GQy-1pT6nA2ASG-014Ebo; Mon, 12 Sep 2022 14:53:44 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, hmh@hmh.eng.br,
        matan@svgalib.org, corentin.chary@gmail.com, jeremy@system76.com,
        productdev@system76.com, platform-driver-x86@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] platform/x86: dell: Add new dell-wmi-ddv driver
Date:   Mon, 12 Sep 2022 14:53:37 +0200
Message-Id: <20220912125342.7395-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q2Fl1nJ8G/jxhgS7uLyaRurElsMZWilswTbSWp73FjyQXX/Pmhf
 0YvZVJWLmShpKvTUyvgjzv/U0qF7IiT7oJXe0uN7BWWtJRSGjsHE4Ub+1dFU7XO0wqasHd7
 s07F9D3E/y6oBWZDNU7J2OEwBNneMhsdWoibETmRWVnuA64enondcCAgkctuwX+BhHcUDY4
 73yHz5Vai5RCRnUcNgRHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p7YrqshLByU=:FuaodLwb78ccs7+/QdD/xX
 jBApjhdFa84ZrkHQX6K+gm3DYjIdSJ5wWtCYv4DNa3V8CWdH71a8qlCkfmr0qzxfwkMfOdZQR
 QbAcJe/qZDeP9yjRh/4NwfgmGyLK7bgkBaG83i3bA9C4O7RUvtPht5TeaZmEf5H/kq+KTBeKu
 5zDJDeZLqgbT/wxh4rbw+AfGFdsi8EarTJndoRJomg2z9fi+qcHHEt8n5Qm5eJcZdvm0S2d+E
 KFdan3Y64IBG7p5si0Qd4AItN0Z7z0WljEGVvoPU9xg/C1VPwc4dUdHN6w5qwPScK4eMveA9+
 pR6OPgQQrxtpTOmX2UK0+V5Vt9boNobceJRyu7710gU8A/Q97HM69qN+rk4JwVyuddY8rlilG
 pL+tiJtnsGotEtags4PgdXs7RfXrS7IYi8cdTv1ihqBF44Hy50kXEI0S/nmcv8gmIrF3+1D+/
 XvkGdO59kY66aeNj7WxvEVBGWsfzt9xHfVuj3BZ5wUcVRsEIxFNXwIJLofE/7Te1aH6e5a+jo
 g0aAoCi6DJq4fwyqgtl+oefLcBXTNhfVTsLpQO9YRqDRuNwSBt5e8tGuTDNfn5hSfUVM9FiKn
 QCBi4okWftVtxArWxI8ySSjohrFSUOnTV7zU+ZCJRTW4mn9ROMcV7f1uMYjvAkzeshA1jdPq2
 6DCyc75Zhs20XfhsgClepyOHregte8baMsU/t6v5FwT+nbut/o7xNveOWGxhbLt0Bo/xh/Ovk
 bmW8IDuL73B8YdXfpqBQXt0x8u96YdH+Z8mxI+kulL2SqCJa+wnt1E4xfaEXXIMRUOHdP7cdu
 H2fxD10AYtQmnXtWYZbnddXBV+BX7glCAqzcm+Ym0n4NLUthvg9Ns08xQI9snovXgg2xG1PXj
 7eiJkBiI1t4UBPpDfmXlYTU1tC6lRJuJoA6Pb67akmje9pEsqsqcisVbhr+ubMEdUZ+9eGIN0
 sBLaurUpnu9b3mKDZW/tWQFJl+He4MoolnqHTbPot86ZUc+XRvTN5hQamzmrARb7AF+rkdhR7
 VMxo9Lxy2RCpCIWl/O0/zAQF3XC9khIITtA7acrvJR/MNZakTULXWbIGtsPJildwqi3cnCyVn
 kvxoxJh5zqPSJR3duA0DCw1X3k37hHyZdxFJC/RrhX7bt/QmhJ3Jdad1SNidDoUMinbsLaqHI
 vI0Cvym3NEqgMCygwGhtPnXN4b
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a new driver for a WMI interface found in
many newer Dell machines. This interface allows to read battery
properties like temperature and the ePPID (Dell-specific), while
also providing fan and thermal sensor information.

The interface does support multiple batteries which are indetified
by an "index", which appears to be the batteries ACPI UID. Since
the interface also appears to omit any bounts checking of the
index, the ACPI battery hook mechanism is used to discover batteries.

Since the information returned when querying fan/thermal sensor
information is currently unknown, a debugfs entry is created to
allow for easier reverse engineering. The interface is likely
to be replaced by a proper hwmon interface in the future.

Since the driver can potentially be instantiated mutplie times,
the ACPI battery hook mechanism had to be extended.

The first two patches allow that battery hooks are not unloaded
if they return an error when a battery was added, so that they
can safely return -ENODEV.

The next two patches extend the battery hook mechanism to better
support drivers which can be instantiated mupltible times.

The last patch finally adds the new driver. It was called
dell-wmi-ddv since the interface is called "DDV" by Dell software,
likely meaning "Dell Data Vault".

The driver was tested, together with the changes made to the
ACPI battery driver, on a Dell Inspiron 3505. Other drivers
already using the battery hook mechanism where changed as well,
but could only be compile-tested due to missing hardware.

Armin Wolf (5):
  ACPI: battery: Do not unload battery hooks on single error
  ACPI: battery: Simplify battery_hook_unregister()
  ACPI: battery: Allow battery hooks to be registered multiple times.
  ACPI: battery: Allow for passing data to battery hooks.
  platform/x86: dell: Add new dell-wmi-ddv driver

 .../ABI/testing/debugfs-dell-wmi-ddv          |  21 +
 .../ABI/testing/sysfs-platform-dell-wmi-ddv   |  16 +
 MAINTAINERS                                   |   7 +
 drivers/acpi/battery.c                        |  59 ++-
 drivers/platform/x86/asus-wmi.c               |  20 +-
 drivers/platform/x86/dell/Kconfig             |  13 +
 drivers/platform/x86/dell/Makefile            |   1 +
 drivers/platform/x86/dell/dell-wmi-ddv.c      | 365 ++++++++++++++++++
 drivers/platform/x86/huawei-wmi.c             |  15 +-
 drivers/platform/x86/lg-laptop.c              |  14 +-
 drivers/platform/x86/system76_acpi.c          |  22 +-
 drivers/platform/x86/thinkpad_acpi.c          |  15 +-
 drivers/platform/x86/wmi.c                    |   1 +
 include/acpi/battery.h                        |  12 +-
 14 files changed, 504 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-dell-wmi-ddv
 create mode 100644 Documentation/ABI/testing/sysfs-platform-dell-wmi-ddv
 create mode 100644 drivers/platform/x86/dell/dell-wmi-ddv.c

=2D-
2.30.2

