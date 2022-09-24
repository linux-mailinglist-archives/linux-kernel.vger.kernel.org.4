Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E89B5E8E26
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 17:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbiIXPsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 11:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbiIXPs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 11:48:28 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B6037FAB;
        Sat, 24 Sep 2022 08:48:27 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id i15so1829115qvp.5;
        Sat, 24 Sep 2022 08:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=WX8TwZF8c8gXM19UKc28n63m7yNqYx0bJDzrwuTWqoU=;
        b=j/6SN4VEvMJ5drZBKQqjQJCbQHY2zwYdrR4VTf/XsBj4h8t/qbdgzM9A1f2b/gz4Qr
         F8H205uIECWQChQlNbzqVMVuxVumlxuIJJbTw0CkoeAwmw5qn05YgEzNECPcAGRFVd/s
         Ete6SSS1C+WvdZA5Hffp6aMxrj6h1I3sVWAYPu6lx0+nH3W+cPfE8r2LdmzajmPAYAmp
         k4IcqqhgNWgw9bFbx9y21aKd4D0HYhCHXYq63umHgvvoQaMzvKwkR9HazMk5R/7F3sXj
         NaeHRJV2Zt3kqD3WNArQ88MANSIHC7u7D6TqrWVS8Kxi6EeXEnpZ3jX2Nrm2Jow83exx
         0Qag==
X-Gm-Message-State: ACrzQf2+CYlCS2Y1nj7hyu08AmUa1SbwXUZbnhQJSoXVj7Z/9Zc2W17B
        yp0GWcAX1YVeorwPgjtUBHuAvkLgSsfXEbplS3/TbyOjJBU=
X-Google-Smtp-Source: AMsMyM7uDbDiGPeWBvAxhHEIDR5roDNZ07cN6rpyUA/pt/vgzYu+Th6NwQSj84p2W9QABxAFpLz3nMEwWs5GJ98UZOI=
X-Received: by 2002:a0c:da14:0:b0:4aa:aad9:e450 with SMTP id
 x20-20020a0cda14000000b004aaaad9e450mr11425212qvj.130.1664034506580; Sat, 24
 Sep 2022 08:48:26 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 24 Sep 2022 17:48:15 +0200
Message-ID: <CAJZ5v0gwRVKR+4neD7xH+CCpnr6HQyvdJ14vjj7S4nMTAabRAA@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.0-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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
 pm-6.0-rc7

with top-most commit 9614369a042a3a345ef7e2997c277aa8a271b8a0

 Merge tag 'opp-fixes-6.0' of
git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm

on top of commit 521a547ced6477c54b4b0cc206000406c221b4d6

 Linux 6.0-rc6

to receive power management fixes for 6.0-rc7.

These fix an uninitialized variable usage in the operating performance
points code and add missing DT bindings for it.

Specifics:

 - Fix uninitialized variable usage in dev_pm_opp_config_clks_simple()
   (Christophe JAILLET).

 - Add missing OPP DT properties (Rob Herring).

Thanks!


---------------

Christophe JAILLET (1):
      OPP: Fix an un-initialized variable usage

Rob Herring (1):
      dt-bindings: opp: Add missing (unevaluated|additional)Properties
on child nodes

---------------

 Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml   | 1 +
 Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml | 1 +
 drivers/opp/core.c                                           | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)
