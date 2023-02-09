Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6277691282
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 22:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjBIVPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 16:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjBIVPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 16:15:41 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4135A5777E;
        Thu,  9 Feb 2023 13:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1675977316; bh=KgfxBza1fidacXBdRGtdFRcowmrgFrkUaPC7ZDozNAI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=sOExddv0OEtqZFuD7u5T2v0cbW34BNUv8XKBfn8MHSjOmxH9DdNDSHwigSe+jhPRt
         ZtsbDSkavp3dhdPQ+ccsNUH/PPHdT/ey3t+YBgH6mXOsCNidrF6MQqrE2L5u7VYkys
         LDtcLDLNml0WVHB2geZeeomz1rCFUPj9PEiv2X/2U1aCmydOW/adOtkbNesoxTToav
         qo5FeIG/uIu2t0m8TuVnfPyAv/7tPYtXeY019g0LWodrUHdippGGapxgqfv68S6ruH
         EwQNL6rilv++bZrHRF+Tz2+qmsycySU17keUr/koV8KsdLXtsPTMz345cqhaIsrcCf
         HBKhYhCy/3pjw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mj8mV-1ouDUv0MgH-00fEfp; Thu, 09 Feb 2023 22:15:16 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] platform/x86: dell-ddv: Various driver updates
Date:   Thu,  9 Feb 2023 22:15:01 +0100
Message-Id: <20230209211503.2739-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7Lxv7ldKMU43trf3dNpBLREFOhHjZbJG9bP2V8ia7JX1RQXhoU6
 fbPknx+1U6o2ng5Jh7Pn6V+vi0zT1XSC+imU7JeJ8x+F1KqYLonlK33ZUqv+iLpQjXJXrKO
 gE5nDSrRwJd5kpNyXyvO0rGYJFwv/+M8NhiTnaeg38MKKJ0kKHEfl76Vk5rqKv+hhqhE5oL
 e8jFtyGlgLoRYvdDG52vA==
UI-OutboundReport: notjunk:1;M01:P0:0pVdM3XDfhM=;fmfwIdgP2MFRROw/3paT6KaEnaS
 cpEeKUMWcwQoO9MbijjphzCKrsvfCWSiP4sq38JWKHrnh5E2gZAnhF4f03HL2BfTo2L6tLeSO
 PaOmOeVpD6yyvqYAcT65goTQPvoRwyhj3Qj5nbDYp5rpQZTuECQx8tKymv43y8oO1FirnjvRK
 hqW7nxUwMj6ffVG3k3H3KlJmm/KfzrhywTZi+dcFei0i3gI1R+5/UOveulnjUFhp7r3LYnvci
 aVJHSUCQQIlXoTsOhXFrzDUQTkc99KN5U2DOCw0DVjqHDeR8L1fWcZ7QeI+mj/TDTtb2LGtA3
 eltcvw8VDgkMmjvpfbze/wqmpYR/S7frDrqrn9kJRJxp8yfAfeMzlvlQZMlhTnS8dAFGuAPf5
 SDw9ZLmoPU+GqfrD/Zrwwp4U7ZCAWGCqEl+FXVHUv2o/cSMav2nDBaCER+vOh8n8eGWbk1XDb
 2MGzIOrswY/gIPk58dY/9zz1sxjsV8QvRBnzEs1p7KMi174ud+NKpLwcYk/zyiLsZpLH2x296
 86rsuY6dCSuAIA9bFvpmuUpEA8O6LcsS1EebydLksUL6nMYZ9F0xpQ98fgJFT0lpziwSU7aXA
 fMD2glXSwska1Ri6T8yF21kxp/NhtR6cEmwJ24bEoO8Mo3X1SM5Lu3Mw0/rOuFC1F5xXihkUo
 jCdOb95E6gDFU0wNlDfr2WC4k/q8J/RLYy+wMOjHEx6TNlY8Ml/W9zaf9x06otwEHZ5pxpISX
 eKS4ekrI5No43J/jqzOeHtlSw7sNw9M7RM7Eo4nq8+xLCMYWdt58rfq1z2pXdA4hei56JBaNR
 b6fOJ5ARfbWv8/7xjwppD2uyusktAdxmk8z7oIKLY8mh6lbNkEfyhTIvOMlgkW6lSRTknPvqN
 Zn5FGlklEYogiTDUj09MuRYayKbRh9gb2OLNmPLWUb4JM+eEkVqEFSYh2uB5pWrw6RrsYfMAO
 Ls4RDtpTE7PCWXzh2m1CberHO0o=
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
Changes in v3:
- remove empty lines before break/return
- invalidate buffer cache on resume
Changes in v2:
- remove already merged patches
- add patch enabling asynchronous probing
- cache sensor buffers
- fix compilation on 32 bit
- add missing break statements
- remove C++ style comments
- rework battery hook and hwmon probing
- rework Kconfig dependencies

Armin Wolf (2):
  platform/x86: dell-ddv: Add hwmon support
  platform/x86: dell-ddv: Prefer asynchronous probing

 drivers/platform/x86/dell/Kconfig        |   8 +-
 drivers/platform/x86/dell/dell-wmi-ddv.c | 492 ++++++++++++++++++++++-
 2 files changed, 495 insertions(+), 5 deletions(-)

=2D-
2.30.2

