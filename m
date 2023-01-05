Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E53E65EE97
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjAEOTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjAEOTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:19:35 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD80DD2D7;
        Thu,  5 Jan 2023 06:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1672928358; bh=wIz0BoSUc31ugcqNmIKcIFhbT2sYdHTdsIFwKNmgt3c=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=RME5plFvOeHxkPSPC8NUcEWmioeYrtEvMDw1dUjVf5BhO+rEboJlr6WqVZodpvWW/
         Ipdu6eGvVU2ic7snqC4PPd7oqkO0YYctlJfIZwsM0nYnUJSRUOB0apyKEF7r9zugkQ
         OcOWQGizmLnj5Kt4EyxEwUuN+YbVghpJ8qVjFeWfKRfAynl81/J5yNuXtvZUM+g8Ez
         k7G3ZKkZxic7d+dcIpXLde9TM1M1xq7RmWY9fXnrjLQQeXHD9j545Bp9EMYyWi+veO
         wsMBHvZw1mjfnK5jB0Iw8Ur7h02vQ7Edkz6rRCABGldAYZbDavLvRfkc0iEVeoD17y
         75aFUVvlyAWtw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MWRVb-1pJhfC3df9-00XqJR; Thu, 05 Jan 2023 15:19:18 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Convert to *_with_info() API
Date:   Thu,  5 Jan 2023 15:19:08 +0100
Message-Id: <20230105141911.8040-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P+VnuccQuxbVylJ/aoMnO10jH2ggKviSZwlBemNMjXUK0KVPsJI
 jIbaRZJ0o4NMYkbOxYV33FqCy86KGTO3ugcyVzlNT0hVWVqSNLHo+yhVfoMZ2ahcsCBK8ld
 xQOnuKqiBCAzpFypwBBs5O/4k6twep6p9bByQ+tzoMlVhJlYhKuew4yX00LG6lJ1o5Ve+PS
 9w2CFuO83v30vnsceKRlw==
UI-OutboundReport: notjunk:1;M01:P0:Jm7Ns/0S2/M=;vF7aIa4EFgNX/fnazeAaBFWdVBO
 yHy81OZK/1ONCKlCIm12TpgRdkU6+Kf616DXfOVuHGy/zEp7dYRW6yoyl3QsQq3Lb/JKr0Fab
 mkCWf9psv/pWsHxBkcU/isjn3Q3I1dcLhy31RGZBcu+8P3gCfdV4WbfPhz4OPkD5MVwcowxXD
 vrLK145wNHkjHJiK6UkgkpSd6UWOqmZf1mb+GNZY8RWL+xVWuLgKCEGQiSqQwsurwYE/c2LVA
 eSc1yLs6NkU+nBMS6qKfCVNAnArIlHjdf6zwXJzPe2Igtaxb1KvWzPUpDSAcE2lOf+Sd5b9IC
 y9KXYuoY0S+SMIIo8HUAMvgmHN4TQcV3p2PMP0Ubxs88G5e7bt3OgLT8bjbEkmQiL175E3fdj
 yPUxzhWqQ5hTJRhPjqAzK89Jr1x8Ooe1tIS67hhu0VoLeo3JRR+Cjnw3YCD/fy8BiWSUu7ygX
 +otiZx/pI1vBLpM2aTZyQMZGOzedVBD425WI3J5vwXyLntc1aEo4vonN+pdt+OUJqsqhLudmo
 pwNEd+3nmRRxmM1ib/yIvxcP2cHwpXkKTUv9NvIbG3cZ2RlDzOPmzdAy+QYwpFEkD1IYxAXyj
 AJPvhQv3FfeH5ro1eIlGRsJVcGqEY5b/1JDVAJrEpjJ741s4uonpfs2tSu5/CKC6gdyMk9dun
 5wFXw8l+9XqFlWRq6v4mREzeN4oHHf4/ZWSFBS670HDpioI7EtZnio79P1tOZCVlxJji4/eId
 clRbu4U6qbUoLsXrV+YpXffyUO+9YoZ1/uU8VOdkia6VHrH2X2cZWPSmibhqB5CyzjYoFZzvt
 hRr/yeKMuVRuWYNagi3kT7qgM4yY1jX822WbalPxBxJOAxxFmNw2XjjSAtMplUczDUBgv2fMy
 +Dl3R51DqnmMRtVKtNk0gXPkpwoJS3FMOKDVDkaNW/iYFS6Uk07J4xbn0wfJEhVMmaaX/YXjl
 Pa3P6MUOO4WDHPhlA5VANpMN2ZE=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series converts the ftsteutates driver to the *_with_info()
API, reducing module size by ~30%.
The first patch does the actual conversion, while the second patch deals
with the nonstandard fanX_source attributes, which are being replaced
with the standard pwmX_auto_channels_temp attributes. The last patch
adds support for fanX_fault attributes.

All patches where tested on a Fujitsu DS3401-B1.

Armin Wolf (3):
  hwmon: (ftsteutates) Convert to devm_hwmon_device_register_with_info()
  hwmon: (ftsteutates) Replace fanX_source with pwmX_auto_channels_temp
  hwmon: (ftsteutates) Add support for fanX_fault attributes

 Documentation/hwmon/ftsteutates.rst |   5 +
 drivers/hwmon/ftsteutates.c         | 550 +++++++++++-----------------
 2 files changed, 210 insertions(+), 345 deletions(-)

=2D-
2.30.2

