Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9041712AB3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjEZQdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjEZQdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:33:23 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47F3BC;
        Fri, 26 May 2023 09:33:21 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-50a20bfe366so235674a12.0;
        Fri, 26 May 2023 09:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685118800; x=1687710800;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gomzi9+i68UXlcqzXNqpd5rMReQDTrVe8y2yHjIN4s0=;
        b=Yg9QaYrQK9l/Et1XYnROO5lMIkY8kOH22g5ypa4jsOyL/+x6V89lTHwgmFO0sYI5Cn
         5PwL9E1g2whGbjA23kSi5Mw4vX4wpog9SYZ8PAMtr6RfAM1rzORwQe4unhbC2CMWRMhZ
         XpnKdKHcGoqz3xDGd2q/8jN9KrPQ6ZZTcpFL6E6Rrxqj7MmLeuE6bB52Fuaxn8ueSKEU
         X0+6qVDuQFkTtHGY76MmHDdh+8YmU6n0az/EGY3DfQUf5cf6Ibliimqyti08zAYPCT/R
         TWwaxPeblOy0ItxweYrdzR9BpKr6I/H+QNPEBGHcnpmG1OCItw0ka6kDGwh9TyvDZ4X+
         2AqA==
X-Gm-Message-State: AC+VfDxwbl0wAvUWItBaoieJYlUWtXpXEzhHDvXYJ+LxPkJTpQa3KgFL
        t8bDiVSvKnitjvU0AVpROUqWOKOvaBBcmyj6cMd3i6L1+FI=
X-Google-Smtp-Source: ACHHUZ6gdV3c48hoWAHrscb2AUq3jUqJHebVukz+VJRQHCuyKHT9DY123Fve3MTqqdRVb1F9vKvD4ESZ+vAMTF0BI0k=
X-Received: by 2002:a17:906:113:b0:953:2918:71e7 with SMTP id
 19-20020a170906011300b00953291871e7mr2218098eje.5.1685118799983; Fri, 26 May
 2023 09:33:19 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 26 May 2023 18:33:07 +0200
Message-ID: <CAJZ5v0gh2RTNjJ-YQAv8pdrOYJjjdj4dcp7+8EnUAYWiP0BVuw@mail.gmail.com>
Subject: [GIT PULL] Thermal control fix for v6.4-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.4-rc4

with top-most commit 5f7fdb0f255756b594cc45c2c08b0140bc4a1761

 thermal: intel: int340x: Add new line for UUID display

on top of commit 44c026a73be8038f03dbdeef028b642880cf1511

 Linux 6.4-rc3

to receive a thermal control fix for 6.4-rc4.

This fixes a regression introduced inadvertently during the 6.3 cycle
by a commit making the Intel int340x thermal driver use sysfs_emit_at()
instead of scnprintf() (Srinivas Pandruvada).

Thanks!


---------------

Srinivas Pandruvada (1):
      thermal: intel: int340x: Add new line for UUID display

---------------

 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
