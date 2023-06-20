Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938AC737133
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjFTQMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjFTQL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:11:59 -0400
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1B7F4;
        Tue, 20 Jun 2023 09:11:57 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2b4681a9466so8545891fa.0;
        Tue, 20 Jun 2023 09:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687277512; x=1689869512;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rQl4xRVT1xdoraumy12t+JLRmtUcFkzxrGvoeRkhzx4=;
        b=Uk1xJ4/VbTppEK4LZC13B+hjFJUdZ1n1Q1N/QlnUStPhe0RCF7xtMR38p2s8xpURc/
         ORv4kokMEy82KmpRilQVu+GC40a6AcTSFX2piNiJiOTckXnBWnsfbHJxjGZYGJu6yYf5
         H79gUXO8xRjXJfzY31qaRKT0LShYfqFfAvm6O+Ald+0IBFYXPdwQqy62xeZviyztjt3/
         t8rMDqMrLrAMwpGSwZ/HUE+otKDlh/MmRlDwALlTtlpSYwJ2NTh/JsWuITM6e2cg3FgJ
         lt//k90cEF6xvAYHsQn1lMcdbmmncOeAM3wv5Ww9xNk8/WhqhMV1aXeaoTR1vrU5HRyM
         QP7w==
X-Gm-Message-State: AC+VfDyywHmdlTJXAWNPNdMB9JRinTS9gV4QslPAqAtb2H16XATyQkhy
        G/dHAD/2iveH0VAcwW3qIVbSQF4/trfIWFKIuAU=
X-Google-Smtp-Source: ACHHUZ4gwOnmQ3d/4CUddiA4Q3IUmNl/1qb8PNcykXwFj6V+hAzYbW/D4eKlgcaocyZQEPtn4Hcwl+5FFQue2hzgTCI=
X-Received: by 2002:a2e:b55a:0:b0:2b4:6828:69b3 with SMTP id
 a26-20020a2eb55a000000b002b4682869b3mr5746938ljn.5.1687277512295; Tue, 20 Jun
 2023 09:11:52 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 20 Jun 2023 18:11:41 +0200
Message-ID: <CAJZ5v0irirNR8h5JNkdsKTZACpBYXa7mLv55F-i6cYa03jZD1g@mail.gmail.com>
Subject: [GIT PULL] Thermal control fix for v6.4-rc8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
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
 thermal-6.4-rc8

with top-most commit 0bb619f9227aa370330d2b309733d74750705053

 thermal/intel/intel_soc_dts_iosf: Fix reporting wrong temperatures

on top of commit 858fd168a95c5b9669aac8db6c14a9aeab446375

 Linux 6.4-rc6

to receive a thermal control fix for 6.4-rc8.

This fixes a regression introduced during the 6.3 cycle and causing
intel_soc_dts_iosf to report incorrect temperature values due to a
coding mistake (Hans de Goede).

Thanks!


---------------

Hans de Goede (1):
      thermal/intel/intel_soc_dts_iosf: Fix reporting wrong temperatures

---------------

 drivers/thermal/intel/intel_soc_dts_iosf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
