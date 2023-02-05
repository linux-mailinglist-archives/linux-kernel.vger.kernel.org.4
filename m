Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41C368B1B4
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 21:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjBEUz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 15:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBEUzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 15:55:23 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA7A1A49F;
        Sun,  5 Feb 2023 12:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1675630500; bh=hLmcV1s3cTU9WLWvvGVPIAQYigFM6bBky19OK8b5U+4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=r04R8TkdI/HeOSf9yxBHWMhiBCfq0YEMiBbvizy0UzhTMT6tEMe+Qy5JkJz4CgLkz
         is2zRJ9fH9tpta+RsL2vLBYGnLp4/oh7MQ2L2QHNdObii1SztKzaBe/UvQTlXci7cb
         sdO8khr/ETjtd9m4c/RxeJB3JvsjMCv463kbq4zeR7+OLDMpUMv7h1Obi6fuq+u8db
         AsTuJm9si3ZgL5ip4ozrZKMWBY9y7EuwhU7VSB6j+IfWyVc2cyxsKPNfgTQcr66O+k
         bq7ZZr/j/hF1tUyCDxj1ygXeJWpNEUpvqwlmWofV+xTYYx4IuYFypcf3OTnojF7P2j
         LO9ypmdvrmDPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MRCOK-1pCips0Hw4-00NC3W; Sun, 05 Feb 2023 21:55:00 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] platform/x86: dell-ddv: Various driver updates
Date:   Sun,  5 Feb 2023 21:54:54 +0100
Message-Id: <20230205205456.2364-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AnwqbvaAXsbxdJGkH7b1Gm31VKClQFeRvB7plgX+K72lnZG/+lx
 M+6Jm2KGyxSI4+1EBVpsF1oGD0Ary+kUSmivCoK7XEvRRo/tlAy0K5OYgvyXUTmKyD8ikR+
 cI8pxZYF9aqJ+fGhfwYxXhZADGZ5bOh79me5k9Kvul0/YyGimjyHZRY+77/NAoDXK+v0VDv
 gzwWcEyEtc4l4SrxWKC8A==
UI-OutboundReport: notjunk:1;M01:P0:OYmw2vWMjYQ=;4Advj6m7nggOxT8CrA6ZpNpMQ31
 ghGW7xp8fI/No93C56DlimE4y7CPhAvCu56RAJz2ypzl0ADHR9IdccPXwIo9L1RpV2J5SL/WI
 mFGQWT/86n10483UgiilhyfI7dUpwUABPNnHnjBG26g6QqHON4eSXMCI9VIteOsZ8JKZ02+qQ
 sTzTiineqMyOgBYT7aa6Dr4+mKUUVlts0ovy7TqU8JCbaiT022CQo/Yr/6gMGRWF6ONYR95yd
 UnhTKpXCnR2WzrPE0JMTcyAEtjYuOvVblgH6lAVm0T+yk9T9/cXnznXMqO8Cfs9gI9K5J8Pz0
 LWu5rMmQP7tRBJF+WfzLc/OWwPcU5oijsPbZhezmv9uqYW5Bk89BB61KPMMbnEiiT78xGN84B
 kK2uAmLQ0qrzQZPg+wOVvv/h8P39sZVzL3rKds8HuyUaLjnS6L8Ei2GORDKl3FKKPvlEiCeEp
 I5i9kGV/pSAa32u3ibIo7tGTWyvi5JPy/qFOdne7oR5AyuwvAmCfupgW44qe0FM1t84HLzcTT
 GE+GaBs30U6Xoq5Du7oqNHZxfVG0XHcL99IdKo6NMNbjRCM5RCAbsiSxaq8LSVLMLDWt7GJV9
 5oHjKvPv3vkwcQKtXavqumMAZSxBqsEwIIPcUSEBObqovX6PaAmaWXwgJo604Ba9jgLfBBe5E
 RlZushojNHtCV9gJ2rssNXU+2Sjmx9vEoqvJ20XLlOA3OVYZL0rh38piJMC1GKfNo6JKNZirt
 1xwkVd4twcthfqXNrn/nHBojOHlEHCZK4H+GQS3Okq3eGvFZTFQG535FVvvSZj/Amk2gwyAW+
 /+4lByLABok4u4/cUGQoUN8WlXrI9p9DgMLBRF/hMlYGzaMrN+9E8O3sT9EGBEONWv1kWNAgc
 1MSeBAquT4gQtz6DzWfYhadpXAuRX1/cl9sRQHMG4VQF3GRliEnWkkm+oBZ1dEJbmG5MuqLkA
 X4Sj2GtBFTIt4EJCm1ZmHKFihQY=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to bugreport 216655 on bugzilla, the contents of the
fan/thermal sensor buffers could be almost completely decoded.

The first patch adds support for exposing the sensor values
over a standard hwmon interface, and the second patch enables
asynchronous probing for the driver since the sensor interface
can be quiet slow.

The patch series was tested on a Dell Inspiron 3505, with the hwmon
patch being tested by multiple people over bugzilla and email. Those
who tested the final version of the hwmon patch are credited with
Tested-by tags.
=2D--
Changes in v2:
- remove already merged patches
- add patch enabling asynchronous probing
- cache sensor buffers
- add missing break statements
- remove C++ style comments
- rework battery hook and hwmon probing
- rework Kconfig dependencies

Armin Wolf (2):
  platform/x86: dell-ddv: Add hwmon support
  platform/x86: dell-ddv: Prefer asynchronous probing

 drivers/platform/x86/dell/Kconfig        |   8 +-
 drivers/platform/x86/dell/dell-wmi-ddv.c | 494 ++++++++++++++++++++++-
 2 files changed, 497 insertions(+), 5 deletions(-)

=2D-
2.30.2

