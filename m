Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343A45ECEE1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbiI0Ups (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbiI0Upo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:45:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3EF6AA28;
        Tue, 27 Sep 2022 13:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664311525;
        bh=g00gTC8uiJd4+HQmwY/X5XAQpW+K8YH6Th4LUw/wOZc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=CFJynzop0CYlSN35TJaYYZcp/W9E5tRUF491DTDYsgNHl+rfrBwepHFsIKjJD3Rev
         gAfVOEU520T47Z9CCzvqo8awtG7fE99WJsVXS/+Zg8kwfO6bX0C/MV+wO/kTvooMZd
         uo7PQmGEt8yH+zqonNYtC5+gE2pEqg4EptB0T6CY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N5GDv-1pM8pc0O29-011Cza; Tue, 27 Sep 2022 22:45:25 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, hmh@hmh.eng.br,
        matan@svgalib.org, corentin.chary@gmail.com, jeremy@system76.com,
        productdev@system76.com, mario.limonciello@amd.com,
        pobrn@protonmail.com, coproscefalo@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] platform/x86: dell: Add new dell-wmi-ddv driver
Date:   Tue, 27 Sep 2022 22:45:19 +0200
Message-Id: <20220927204521.601887-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KzhWpbnWktfitIk8P9GXEYUxilNeEsMbxCQOJVDEZuhtG2Wi+SU
 OyYlYiWH/HJstvWNF7PJuYohwNwa2XhaFdOTSZh8b8TYQH+aBataIlWzm+75PpOqZXqOKZf
 4qzT1CU86OxB0h6lvcWXaiqnyzPF+TFBye5+3A/PNzL5IcuM28arx0prxxprvrQhSa79wI7
 GlRMv/7DtxV1YPJ48QBuw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MikoliPZkXs=:UOEAoeNzdyU17gr4lKqxMN
 St/jjd+gTwuaEYIcjc46xNH3n/hh55eJqC8w9nb8CCXqk+WBIx4QMH2AtDLwRlnsMpBHWDaZ4
 y730Lwu9Q+9phEqk38M505Uvp8JFJ72IY+5a0HrPMAP8UHhbzPoC4rGdPl7G6w6k2E1TTFm5Y
 lqjxEdEQQ/2RiS0jjy2/EWP4WxcBqL/a8OM2NtFPw4+7dRousyIRzh0cvneMrArXfCGInnRkd
 WE+H4CgtqKEBF8ECORV5yf56dxfKlByi29OUrMyfYhqAZW/3xDfqzwNht0h7pSOPGWQQbmSML
 d91ocQfyvSycx62ONjHKZhdrwIf6tVQ7qDNkPIsW3K1ISCsWM058YQqzQ4lhPUbIzSt3wlQI9
 codVgoTKs1OoUTQEQL1j9aYjcEaGpqfw4h5z01cMjOQRrlr+22hNC39u9GkUllysDIxsv/9sk
 krQlLCqidqAdFIxFCoSs4Iuo3NG8r++SDc9cdLi5iIHmOK3hbdYE2WoBXPYh0xlT45VGuEmL0
 arAMNQehHbP6HFLjV/ENQOYo8JRqA50FobJTcoA/wXVNAsN4Ar1nXa88KyDkX8Zchuo2hBgye
 47wbjz7j5tjrg40E+w3l7L6Fft/97htl5UB5UKmn53ofu/qDVLb9FytBMWu3ZQ7cO+3O/sY5Z
 jeN6s7XgMMBDIYGXKU6ov6re2AOdYrVNOYXRPw41J66JTwpK+jJUeyyBNPT2D4ArstI7Fky51
 Ejakkj1t1qmzHQ7HblJxUmxIbmvrrBMCOEB7bjE2azyhSgZgOpWyniYZL2/2dxnVmAil0gR3o
 LpdJRgZ2ngBNY74TcrpzWJmOp9yM+uc68JLnj2SLxZrO7K4A1NMPwUN4iMZf4PoPJPgNtvSKi
 z6KE3y70B+NhbqVsY6OSDxLQuLXxb72zY7HOHlmYm059GUzPiZs8CUAHnPnlTkYT41v/ism31
 WuLA//c/YFmXyY9AD4XNCRM0Po+WvCtAww5YiqNZnqiLX/U++nypGat5YcXwyhYbsvKbkwvDg
 s/b+5tH2PqmVOXRMKuAa4svQctwtHMlnGtLiN+SW2403oRiKlcNi5JcxzJwTsRAaxY0OSLNpM
 MsI41k1CbrRlYJXjNI5nMwomwTc6J4QMYluJWrg6SKEK2iIeiB8fOKOOmG7l5RC/gZHBU/ziY
 /6wj7f/zuTfTrQuALZNFV45nge
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_H2,RCVD_IN_MSPIKE_ZBI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a new driver for a WMI interface found in
many newer Dell machines. This interface allows to read battery
properties like temperature and the ePPID (Dell-specific), while
also providing fan and thermal sensor information.

The interface does support multiple batteries which are indentified
by an "index", which appears to be the battery ACPI UID. Since
the interface also appears to omit any bounts checking of the
index, the ACPI battery hook mechanism is used to discover batteries.

Since the information returned when querying fan/thermal sensor
information is currently unknown, a debugfs entry is created to
allow for easier reverse engineering. The interface is likely
to be replaced by a proper hwmon interface in the future.

Since the driver can potentially be instantiated multiple times,
the ACPI battery hook mechanism had to be extended.

The first patch passes a pointer to the battery hook to the
hook callbacks, so that they can access instance-specific data
with container_of().

The second patch finally adds the new driver. It was called
dell-wmi-ddv since the interface is called "DDV" by Dell software,
likely meaning "Dell Data Vault".

The driver was tested, together with the changes made to the
ACPI battery driver, on a Dell Inspiron 3505. Other drivers
already using the battery hook mechanism where changed as well,
but could only be compile-tested due to missing hardware.

=2D--
Changes in v2:
- Significantly lower the amount of changes being made to the
acpi battery driver
- drop unnecessary ABI description of the temp attribute
- return 0 when a unsupported battery is found to avoid being
unloaded

Armin Wolf (2):
  ACPI: battery: Pass battery hook pointer to hook callbacks
  platform/x86: dell: Add new dell-wmi-ddv driver

 .../ABI/testing/debugfs-dell-wmi-ddv          |  21 +
 .../ABI/testing/sysfs-platform-dell-wmi-ddv   |   7 +
 MAINTAINERS                                   |   7 +
 drivers/acpi/battery.c                        |   8 +-
 drivers/platform/x86/asus-wmi.c               |   4 +-
 drivers/platform/x86/dell/Kconfig             |  13 +
 drivers/platform/x86/dell/Makefile            |   1 +
 drivers/platform/x86/dell/dell-wmi-ddv.c      | 361 ++++++++++++++++++
 drivers/platform/x86/huawei-wmi.c             |   4 +-
 drivers/platform/x86/lg-laptop.c              |   4 +-
 drivers/platform/x86/system76_acpi.c          |   4 +-
 drivers/platform/x86/thinkpad_acpi.c          |   4 +-
 drivers/platform/x86/toshiba_acpi.c           |   4 +-
 drivers/platform/x86/wmi.c                    |   1 +
 include/acpi/battery.h                        |   4 +-
 15 files changed, 429 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-dell-wmi-ddv
 create mode 100644 Documentation/ABI/testing/sysfs-platform-dell-wmi-ddv
 create mode 100644 drivers/platform/x86/dell/dell-wmi-ddv.c

=2D-
2.30.2

