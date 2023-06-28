Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE14A7416F1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjF1RGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:06:17 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:38289 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjF1RFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:05:52 -0400
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-98502b12fd4so707466b.1;
        Wed, 28 Jun 2023 10:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687971951; x=1690563951;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GbpzYNB12mRqlBTiglJpM6+ZxuV+m9A79/DAXIn10tQ=;
        b=iqcQGWhj/hxbbGorLWqTmaWCRDkOrPRhh4f38mYRJi8QUqR0PAggIqK24kTYBxTL/i
         +1LuJ5XtakxJ2uQG4INv9zsT1WLNs2psUh03pYjyEl9LaMtMlJ++0AZMeA6rPTmRpKLH
         FQL+C0aJvHrWPekdqmEbFRGWE+H/2yLi5ekY5X4UHnXOPwkVjpaJfeRW0Ul2qtBlUFi0
         978BQUADn4FroZjBn3X0fHAjpq4aqx4xaw+5x+UDEuQ5po+bFea568Ch2dDaJlESQ4dS
         qXh7YCEln/iMAcOczGCrH34EQZ2Epi0FNEAdySZkP08FpL/+ufu39w3vVXhlZlJ+yM8t
         iQFA==
X-Gm-Message-State: AC+VfDyp6+J7FcDLk9SMiGoiPmyvL4h+32yBEMfM4POaS1UKhuR6JldJ
        sr1O7gJA2LfO9pRVUDgTp/Uevk9H4q2CLCbF7DjB65oi2/c=
X-Google-Smtp-Source: ACHHUZ7xaIilV7u1+MnilVkyayLMB9YB5YQs32HX/0VyG7g+E6dSUxdiWWAvHu8LJv/Jp1eLIi0AuY3zX0ioNYjRwd8=
X-Received: by 2002:a17:906:7496:b0:988:815c:ba09 with SMTP id
 e22-20020a170906749600b00988815cba09mr274829ejl.4.1687971950920; Wed, 28 Jun
 2023 10:05:50 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 28 Jun 2023 19:05:39 +0200
Message-ID: <CAJZ5v0jqkN0H=mJYrhvy8Qm8OpMEqe=r8jcF08pX7QtM=BQ1LQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v6.5-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.5-rc1-2

with top-most commit b5539eb5ee70257520e40bb636a295217c329a50

 ACPI: EC: Fix acpi_ec_dispatch_gpe()

on top of commit bb6950556d4b1dd1226c1f09e84b53cb37e5340f

 Merge tag 'acpi-6.5-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive an urgent ACPI fix for 6.5-rc1.

This fixes suspend-to-idle breakage on multiple systems introduced by
one of the recent commits that may cause the affected systems to overheat
while suspended.

Thanks!


---------------

Rafael J. Wysocki (1):
      ACPI: EC: Fix acpi_ec_dispatch_gpe()

---------------

 drivers/acpi/ec.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)
