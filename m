Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEC96E9FF2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 01:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbjDTXcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 19:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjDTXcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 19:32:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64279172A;
        Thu, 20 Apr 2023 16:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682033549; i=w_armin@gmx.de;
        bh=NGlN7WhKpCXC32UorWAt3fK4hRHpP3AFfPfRXp8ykXk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=rzPvR6LVsGc7av6bFcK6y4RpNJz5+JHjZnhmT5+o8xg9i30zl/Be7M9it45Sat+MA
         r9RAEAEbYNsBqtAZYt4q91szzdSeMUSyS6ngxqtosizg5PizGfDXhEvYBmNIVYYZbR
         8O7I8Y+R5QNZ7TDDBfwDiNi9Jdg2MgRlyR0EirBsOjaaH6ZsZJJakvXZI+o4IvIPy9
         F7bCCpr+3lTpO4WaCFE0ec1aRl0t2Xg5Ps5bfwkO957FkaXVSm4DsN3EBNh33GMGOX
         cm/ceC/JRNKS26xh/eIByTVbcboYecXudz29mtIu1ufnSkgvHhIvLqBkja/p96uOOK
         rDknXJ6XlYmwA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MC34h-1q1UfY1hIj-00CNlD; Fri, 21 Apr 2023 01:32:29 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] platform/x86: wmi: Add subsystem documentation
Date:   Fri, 21 Apr 2023 01:32:22 +0200
Message-Id: <20230420233226.14561-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VosZo3WIQjkYCBzzJ6OwPTI8whtbxtKrvTXnqoF79ThWaP/+Yo5
 OHewk3zzr1J4/T+8rfBDT8jZGvOmpyRVMxk2AdJzK2l3dlDakB8N+tjO/T7wRB3tHHxA+Au
 mUaic5TJ9c3R0qmvkVGHypY+/yvyCwVebCX+ncdEi/iAD5xhTt7kuMl7yznI4RxpXChyVBc
 oLFa7UWXup+mJKdV6Ku+Q==
UI-OutboundReport: notjunk:1;M01:P0:qEjxGZMQOQs=;mmH3Zu9IknHgqH+NfH/F7iwTmjC
 O7YipxZZmRiAK235ISk2+jLTkKURfNUD+P6FzaqbVtvzU1rIjO09/rFTGhjei8/wwlih73P/B
 v6aTE9WAect+yBLLfRhl0dVzERaco0YBGEJUgXhyNQhY1vAsVxd6tRwwH0fbAt1Z6ab5BFAx/
 ne7pTYmLqvJ4jLs3FbK/1beEyMpXKVuLs1zAI24ksIhdteSsOuMxZEQZSBLdmt03kGOp29UXg
 cqJoP1fsf/92ovoPTfj3ecyqRtA6rH1PgDLJD5clnBv2RqnTfpMNGuW/+G3eKBRjJC8dDjIqo
 qXxtK/REi+qMTI5XqixYzRzPLCXCiouOwqZdpZjT6lJoNvqvN7oiOnazNmHaHYB+0ufmHzQGK
 95vQWEXjuDdbZtyHh4aem3hP7OA/dINN2854kEpdgO0TzeDUNeHO7QilkeqQJn8/qrzUdg9xB
 OrIAvXIi3lCrlWiXP6NGOFylLdDjqooz97gHVNbEhI4470B4ufFLPWJvhrGdvGKGcedolkbDC
 m8nblw6RFHDToKYhQtWPCHnTBJ/z5qWSyinuHkza1yiaZXB7pRXqsw11S6gBsBhpghLzqoGBh
 JVW8RVoyjauMUKmHuaipDTf7o4ns+6+STv4uxspDXo3B7HeW/Yum5Dmw7CXGj+LzD/IbDaQLy
 pNHfI0maimK4SabNzCJR23dacYeNGZAqP9jVhxRxJZER0WumVqIepTDgl4rXWjRfhkrTspxYM
 VBnJGj0N0SP4pxeO0pwkWpKm2I34VYIYqS8jGmmQrqwsFDsfjFpaE7wD6lQA08Qu2HDAAHXBP
 +iNTuqD+WmK9QITpypspj1q9Bz2/MEo7iIVOqwVMUdYbe6+NabkYheSOMVCXOuampU1cBB5V8
 82uMW44n9v7SPKGwBe2u+hw5ynWIVTq6CS/ScW2t/Aampd/o3MFOHEBkzGTeQqOYi6yhOrXK0
 KMgbuAXVjJ6/jOKXCM4bdj94cQo=
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

Armin Wolf (4):
  platform/x86: wmi: Add kernel doc comments
  platform/x86: wmi: Mark GUID-based WMI interface as deprecated
  platform/x86: wmi: Add documentation
  platform/x86: wmi: Add device specific documentation

 .../ABI/stable/sysfs-platform-wmi-bmof        |  7 ++
 Documentation/driver-api/index.rst            |  1 +
 Documentation/driver-api/wmi.rst              | 19 ++++
 Documentation/subsystem-apis.rst              |  1 +
 Documentation/wmi/acpi-interface.rst          | 86 +++++++++++++++++++
 Documentation/wmi/devices/index.rst           | 22 +++++
 Documentation/wmi/devices/wmi-bmof.rst        | 22 +++++
 Documentation/wmi/index.rst                   | 19 ++++
 MAINTAINERS                                   |  9 ++
 drivers/platform/x86/wmi.c                    | 63 ++++++++++----
 include/linux/wmi.h                           | 41 ++++++++-
 11 files changed, 272 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-platform-wmi-bmof
 create mode 100644 Documentation/driver-api/wmi.rst
 create mode 100644 Documentation/wmi/acpi-interface.rst
 create mode 100644 Documentation/wmi/devices/index.rst
 create mode 100644 Documentation/wmi/devices/wmi-bmof.rst
 create mode 100644 Documentation/wmi/index.rst

=2D-
2.30.2

