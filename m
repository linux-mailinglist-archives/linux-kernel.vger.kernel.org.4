Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C5A6D1DD3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjCaKUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjCaKTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:19:08 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AC624434;
        Fri, 31 Mar 2023 03:14:22 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id y4so87676180edo.2;
        Fri, 31 Mar 2023 03:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680257661;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eULPAzDahbeUJiLwtla2K5x4qcH3Gfc9sWMH0ufHWLk=;
        b=t6T+x4Pm7JU4H34SoI4N2nF+mScm+EJniRUfLBz3SGpEGPAMY3iFD5J6rxAE0Ch8YW
         lb3NVlj7/3H7D5FjEyZUWiTuHDYCuYf9XMlk6Ig5PUks+0COjTq9STlzFeCe80mJWXyO
         f74ZhTVxLTjC5aCDzk19vJQadopCMQPHJnRZbfatCITfc1E45QbR9n5TLj0Ln5QQO0IP
         zbus2T+dXDxeseQLSHPQWptO3RF+LacO+vlhqTgoAKUVEC81DQGFnVVFlkGrYWZn7tPY
         wfoY+rWi3PIFVC0RWrZEKkkjwfqurxnJa/6MyI80j7AW1wKTdUfiwdHI4SM0GQgMDFdz
         W8Kg==
X-Gm-Message-State: AAQBX9cIdcATJhPBTF7vXDmL4T+4eqQ92Qauy6Zj6WvrvHyvS6Ty8I0c
        il/rtWziUXbqSvS54yyAtS9imWlpyhr4eQruTZo=
X-Google-Smtp-Source: AKy350YnzcZmd9zEJ8oEx2YVb+wB3YKIEIQkE1CWVJtVHx1VffXzB+euk57fOlshP4KLU0uYvF5pb9TrIcaiElga70o=
X-Received: by 2002:a17:907:160e:b0:946:a095:b314 with SMTP id
 hb14-20020a170907160e00b00946a095b314mr7215686ejc.2.1680257661138; Fri, 31
 Mar 2023 03:14:21 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 31 Mar 2023 12:14:10 +0200
Message-ID: <CAJZ5v0h3BUjDHvYHeyGisArck+BF1R5JmGeD4L5Seo4xQSpM1w@mail.gmail.com>
Subject: [GIT PULL] Thermal control fixes for v6.3-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.3-rc5

with top-most commit 896c5150edfd5c01ed7abfcf02612f4aac6296b3

 Merge branch 'thermal-intel-fixes'

on top of commit 197b6b60ae7bc51dd0814953c562833143b292aa

 Linux 6.3-rc4

to receive thermal control fixes for 6.3-rc5.

These remove two recently added excessive lockdep assertions from the
sysfs-related thermal code and fix two issues in Intel thermal drivers.

Specifics:

 - Drop two lockdep assertions producing false positive warnings from
   the sysfs-related thermal core code (Rafael Wysocki).

 - Fix handling of two recently added module parameters in the Intel
   powerclamp thermal driver (David Arcari).

 - Fix one more deadlock in the int340x thermal driver (Srinivas
   Pandruvada).

Thanks!


---------------

David Arcari (1):
      thermal: intel: powerclamp: Fix cpumask and max_idle module parameters

Rafael J. Wysocki (1):
      thermal: core: Drop excessive lockdep_assert_held() calls

Srinivas Pandruvada (1):
      thermal: intel: int340x: processor_thermal: Fix additional deadlock

---------------

 .../thermal/intel/int340x_thermal/processor_thermal_device_pci.c | 1 -
 drivers/thermal/intel/intel_powerclamp.c                         | 9 ++++++++-
 drivers/thermal/thermal_sysfs.c                                  | 6 ++----
 3 files changed, 10 insertions(+), 6 deletions(-)
