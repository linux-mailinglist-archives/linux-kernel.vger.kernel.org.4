Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552E06ED7EC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 00:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjDXWad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 18:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjDXWaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:30:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0855F61B3;
        Mon, 24 Apr 2023 15:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682375389; i=w_armin@gmx.de;
        bh=acj7MjZssQd6iVJtWK9G4mZt4XTGSOZZ6U7g33Agxrc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=PBfY6K/IqJ15g6IEF24HH+VQKVu0Smlie9233P7abZlCuMsD98yhjtHsrsCYZUp4o
         MD7LUx4c7jA5pIRlH+oGU/C8fBjTXhvzgNl1BSsJUWHykMgATj5NeaIeg61Y9HBMpt
         d2iXG+pHLcrIBKokhe4UhDFUcSTWd0bggKeaoNmGoxLAKVDSX1qip+YqhIZ7va7Cui
         XaTpomlndPc5wtn5gc19L+jMjw/Nv3f+2O931siC/k2BZeb0lVE+a2aueAXX47JNX4
         3aN/rVZRjMMlr1zFkaHV8P9COsuPEQuidVJpWaCvREAhbJgmQP/91RhVDDbDEwMIY+
         x7WWle1t4B3NA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M3DNt-1pruhU1NmP-003fuD; Tue, 25 Apr 2023 00:29:49 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org, rdunlap@infradead.org
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] platform/x86: wmi: Add subsystem documentation
Date:   Tue, 25 Apr 2023 00:29:35 +0200
Message-Id: <20230424222939.208137-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bCiOkL9kSiizjHyxEVl+fhG2Do4FjhanHynhIPahm4cxFRkVQh4
 gmjvc1pC2ofyc8LjqiMusLebOPNUWdfV7IGiJVnxtdfCkoNZWvtvjWHsv1nP3PSuVgt4FJM
 k0m4XyZ4TRzC7nKq3ECXSKq3KTtdwn/GHGCb5u8ehb1gPwOqplNY16wi63wXbtMk5rjZT7T
 +lemoG4nuuPuRP0Nsn2fA==
UI-OutboundReport: notjunk:1;M01:P0:kHRGcxxyzKQ=;sqSHSbGA6xtxoyjd+PfqCGBglyG
 dzM64Jz/SJhm8EJ4HVU2GJwKcjy8qOMU3Prumt9MbCbHpapIIqWqarZBj1X2EJFr8wKiumUGe
 ttHiakBza/1wdK5xc+arz1Z38Wp3QlnFC2iDBgwX7nrP3TVvApD7TIcumIzq5u+GG75JQNMxX
 aV4XJDOBcjgV0XEB94gK9/bIZXsO161XUSb2pmz+NjIRGkxH7bHLs3WOPnX124yuGg2jZvFZC
 13jZ1/K2U9u4/DzBja/N3TgcWPLr6BFLXqJ00espIlTi+bYgNawjzEgpMNeBzvEB3Drw5NLw7
 DPVarZx63CL84t+maKFJowhvrBPXAr2TVeeWMA4mIRQvwa9lMwggZj6HCYVXf0u2mMMPR67TU
 HN8jTy0IYac4wNwFpBYSPhekchefAIEuHARLqFt5wQb5Ak0iVB9Qhhdjws46ENbonYkg5MMbh
 ustNHTUsTyxsOGbYFTskFleUz5JBuvddakblXpLfu1cHkACKaLYK7vADt3xtoKBXkDexu2mml
 Qz7lAhXzbqDAsxjdGo/IYnwlFQLyNLREXKTUm/Z54VxAMyRFkz9M957+3mLFOxUEniGKdL8OX
 B8F1Q2vZiaf6/DE5DO3iohRfbQahOEUFOk3QEZR/vM4hCYV5H76eQ02zD6GQKS6CsLayR3DTq
 4lMW+nmKCYMbVc71Zny/2inYGpLXkFx0KDZh8bMvWBFy4kGtrKjOtJWI64YBxIbscrsohqa0b
 Fy+rruVUb4MeK30/wkGXOF9/9uM+vmIjq34k0jMz6o/Sg05z4r7d6FnMyMK2G54jviyc3in7g
 iMBtUiqmto6j0X6H+CMnwKkiGEjRzMo/q6LyRoBc6SkhwbW3ccY6D92ama2/Ec1v6d5zNWZIR
 Htrz1L7OrYjfcZYqWRXSLcyshEh/C6iXF2rwuQ2vZLoSoDv2IsIUfCOju+mz63Mz7SgyzGim4
 uRk7mjK8/CDTFz+c4gwAP4K9NLc=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there is no recent documentation available for writing WMI
drivers using the modern bus-based interface. This leads to developers
using the deprecated GUID-based interface when developing new drivers,
causing issues with notification handling when multiple WMI devices sharin=
g
the same notification ID are present. There is also no way for WMI
drivers to add device specific documentation at the moment.
Add documentation for the WMI subsystem to solve those issues. The
device specific documentation currently onyl include documentation for
the wmi-bmof driver, but more is expected to follow.
=2D--
Changes in v2:
- spelling fixes
- tell readers that MOF means Managed Object Format
- 80-cloumn limit

Armin Wolf (4):
  platform/x86: wmi: Add kernel doc comments
  platform/x86: wmi: Mark GUID-based WMI interface as deprecated
  platform/x86: wmi: Add documentation
  platform/x86: wmi: Add device specific documentation

 .../ABI/stable/sysfs-platform-wmi-bmof        |  7 ++
 Documentation/driver-api/index.rst            |  1 +
 Documentation/driver-api/wmi.rst              | 21 ++++
 Documentation/subsystem-apis.rst              |  1 +
 Documentation/wmi/acpi-interface.rst          | 96 +++++++++++++++++++
 Documentation/wmi/devices/index.rst           | 22 +++++
 Documentation/wmi/devices/wmi-bmof.rst        | 25 +++++
 Documentation/wmi/index.rst                   | 19 ++++
 MAINTAINERS                                   |  9 ++
 drivers/platform/x86/Kconfig                  |  4 +-
 drivers/platform/x86/wmi.c                    | 63 +++++++++---
 include/linux/wmi.h                           | 41 +++++++-
 12 files changed, 289 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-platform-wmi-bmof
 create mode 100644 Documentation/driver-api/wmi.rst
 create mode 100644 Documentation/wmi/acpi-interface.rst
 create mode 100644 Documentation/wmi/devices/index.rst
 create mode 100644 Documentation/wmi/devices/wmi-bmof.rst
 create mode 100644 Documentation/wmi/index.rst

=2D-
2.30.2

