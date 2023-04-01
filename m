Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1449A6D3168
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 16:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjDAOnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 10:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDAOnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 10:43:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C62EC6B;
        Sat,  1 Apr 2023 07:43:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0289D60DE4;
        Sat,  1 Apr 2023 14:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFDCC433EF;
        Sat,  1 Apr 2023 14:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680360190;
        bh=jJKWkGuu8Pn0PDFmmLGYmuxPtM3djk+j7/04iXmbiRU=;
        h=From:Date:Subject:To:Cc:From;
        b=Nbhk/zO5KVdZ3+dhDMlJF5EFuVt/au75mBEqWLVn5xTbV+tMcgmgIMuydGk5h9vM/
         wcBeJ3UbDt9VER/bShofy5JU/3wGIlLpnXUnGo9jDEv7a138ucRo5Vm6cgl/D3hr8P
         m9/jZP255Y+NTz4h3Xl3MqJXsIjYgOrpPrgLMvn6DuZOC1cCP8LeSmw+BjtDsGQAff
         6r0HiNuPSWLl2SQWi94PA7twQnwyQM41zvmAFvdH3AwbPS8wwSz2+h/pZmJ5NcaQSj
         5/OiaSo6h611y3DUpibg6+dviV4pR+/D/mfKzJorjpZU2ACPxWcipfgy8aNZcjXxnK
         j0OJAes+Gqhkg==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-17fcc07d6c4so12145093fac.8;
        Sat, 01 Apr 2023 07:43:10 -0700 (PDT)
X-Gm-Message-State: AO0yUKW8UuMDI7yF9R+pUSBaafRNHBa5qGuy60RiqwPANjuQMPAPRGSY
        DrpzLH7m5N+JJwDB1GJOKDnObWEPceYY6VqAglQ=
X-Google-Smtp-Source: AK7set9Wi1kI/70goKat3FOzYyTvIbpeWlsh2lob/ZfhbqmLL9bkHuWCsRNZwkbHq77CWevmMc2kqCF6NeTWF6IvwVE=
X-Received: by 2002:a05:6870:df8d:b0:17a:a5a2:62a6 with SMTP id
 us13-20020a056870df8d00b0017aa5a262a6mr10165781oab.11.1680360189627; Sat, 01
 Apr 2023 07:43:09 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 1 Apr 2023 23:42:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQEKgqrJNeknymSTsiRBbjoJJjWQ8VJ7ViC2-9Z0Mgpyw@mail.gmail.com>
Message-ID: <CAK7LNAQEKgqrJNeknymSTsiRBbjoJJjWQ8VJ7ViC2-9Z0Mgpyw@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v6.3-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Please pull some more Kbuild fixes.
Thank you.



The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v6.3-2

for you to fetch changes up to fb27e70f6e408dee5d22b083e7a38a59e6118253:

  modpost: Fix processing of CRCs on 32-bit build machines (2023-03-23
15:28:41 +0900)

----------------------------------------------------------------
Kbuild fixes for v6.3 (2nd)

 - Fix linux-headers debian package

 - Fix a merge_config.sh error due to a misspelled variable

 - Fix modversion for 32-bit build machines

----------------------------------------------------------------
Ben Hutchings (1):
      modpost: Fix processing of CRCs on 32-bit build machines

Kevin Locke (1):
      kbuild: deb-pkg: set version for linux-headers paths

Mirsad Goran Todorovac (1):
      scripts: merge_config: Fix typo in variable name.

 scripts/kconfig/merge_config.sh | 2 +-
 scripts/mod/modpost.c           | 2 +-
 scripts/package/builddeb        | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)


-- 
Best Regards
Masahiro Yamada
