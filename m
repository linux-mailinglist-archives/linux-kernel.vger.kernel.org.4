Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF51E6B4FCA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 19:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjCJSIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 13:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjCJSII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 13:08:08 -0500
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BC212BE0;
        Fri, 10 Mar 2023 10:07:59 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id cy23so23810987edb.12;
        Fri, 10 Mar 2023 10:07:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678471678;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GzoWKK0oHU996RcpYCG8oeeKvgCP3Ci5e6SGWugHzK4=;
        b=DSNZ7JzQEa9xDNYsnnPo/pQBgBKg1Y2AUjSurtd2cV2YMXyXjy1kEfWzQDUcCe6I+c
         Np+c0v7Ow/Q+JgNJLMLSfX0ji/fn+0HyZFn+nt6bmNMGYYwemrPoDdtGYA6RodevPrpa
         MetehwFWHUmWYYg2NORTwlJf4cefJ5Uca0x51+luhAFx8ULTEUrLDUdZqdDFzkdo2eMI
         uubfG0F+lV7Rd76PRtqWzxD9SRCyUUfpW/CM57XHLd1QUT4fMDhUkefTQn/kZqiSClyX
         jNDxlVGPF9BVoqT7/IaWJemXWmWNfqQFsb5hwxYsgWL7pksuwBTxOEO7/cZWk1z27NFz
         1Sfg==
X-Gm-Message-State: AO0yUKWkephHQGzFLTaMCLmNfML1DC5Fk/39ZS1hB3WmCuvsGwU4jGVC
        kwvujlsMsPq0vjGQJKx2jpjRumt+dDIQu/L1wW2aVlio8++Oag==
X-Google-Smtp-Source: AK7set+0tP0CEF1x1/xxME5zLOlQkjDRbmbA3HlKFWRTf4dY873FCQCa6HTfZp+EY4sfYjr4wxjNi2sDKk5R7ykbOxc=
X-Received: by 2002:a17:906:4094:b0:8b1:28e5:a1bc with SMTP id
 u20-20020a170906409400b008b128e5a1bcmr12485216ejj.5.1678471677765; Fri, 10
 Mar 2023 10:07:57 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 Mar 2023 19:07:46 +0100
Message-ID: <CAJZ5v0jbVwQ-NcdbRwru+T2mr9e9AKZRAFkCjNVoFzE31GQJXw@mail.gmail.com>
Subject: [GIT PULL] Thermal control fix for v6.3-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.3-rc2

with top-most commit 52f04f10b9005ac4ce640da14a52ed7a146432fa

 thermal: intel: int340x: processor_thermal: Fix deadlock

on top of commit 0a3f9a6b0265b64c02226fcabb5e9a958307913b

 Merge tag 'thermal-6.3-rc1-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive a thermal control fix for 6.3-rc2.

This fixes a recently introduced deadlock in the int340x thermal control
driver (Srinivas Pandruvada).

Thanks!


---------------

Srinivas Pandruvada (1):
      thermal: intel: int340x: processor_thermal: Fix deadlock

---------------

 drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)
