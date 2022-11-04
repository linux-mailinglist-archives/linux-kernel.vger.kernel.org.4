Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CF2619F35
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiKDRsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiKDRsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:48:39 -0400
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DF111174
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 10:48:36 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4N3p5H19tJzMpnTX;
        Fri,  4 Nov 2022 18:48:35 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4N3p5G5ZzgzxM;
        Fri,  4 Nov 2022 18:48:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1667584115;
        bh=iVDJr0LhXXdAELXpJxhjsS6rEhTZnKpe++oxRvcucnc=;
        h=From:To:Cc:Subject:Date:From;
        b=VQr44hrcj/MPfx7fm9tW8K6CqoDgm7q3NVKjgVUAGlI+NZwTtn+CsaTiYealZKz1F
         eu17Ji/urCPtR121AhjOEAslPPu2k3QZSJ1YDZQ4vg866OZxKAmICJ6zrJsEavj2A8
         OzNW+u1d0xRP1GHEgWPZ80BpqE58UIUhL4sZunhY=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock fix for v6.1 #2
Date:   Fri,  4 Nov 2022 18:48:30 +0100
Message-Id: <20221104174830.57435-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This change fixes test build for some distro.

Please pull this Landlock test build fix for v6.1-rc4 .  This commit
merged cleanly with your tree, and has been successfully tested in the
latest linux-next releases for two weeks.

Regards,
 Mickaël

--
The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.1-rc4

for you to fetch changes up to 091873e47ef700e935aa80079b63929af599a0b2:

  selftests/landlock: Build without static libraries (2022-10-19 22:10:56 +0200)

----------------------------------------------------------------
Landlock fix for v6.1-rc4

----------------------------------------------------------------
Mickaël Salaün (1):
      selftests/landlock: Build without static libraries

 tools/testing/selftests/landlock/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)
