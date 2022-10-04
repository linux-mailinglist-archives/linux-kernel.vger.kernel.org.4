Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3B05F4AB0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 23:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiJDVH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 17:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiJDVHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 17:07:55 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB16A6C13B;
        Tue,  4 Oct 2022 14:07:52 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id g27so3636115edf.11;
        Tue, 04 Oct 2022 14:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BmoWpeCspOs29Dr+M1Uih3ddTOSH8k/BLFoAKpIsoM8=;
        b=uAHukF1M4FbY8Jxjihu9nFsS3sTAhSJk74pnPvff4NB7IZe3P0CWliepHVMv2mutOK
         Yb4e2LxsuCx9QzZ/9jEp4ii95fSbh6FLXG5sRzd/VIi2t/RjIwkvp+Pbw6qKig0chxWI
         79mng1G/xqdarbMy0C4NWGi+4xjVubk7jq8yI8nUMEQ6/9AA2r86AT1cCIRy5Gwjt5nk
         znxHTwIGoeQkNw+t1TJmbik1747EQqPXykfkb2FlPC7v5y2XCHpJ5I8R1viLET4jlDs7
         fqQr6ID9PcI2JPq/CwdXipmwqKCHqsXWOTHySXhfW1wuS+2qzYumNbGpaPBQ59dL9ZRo
         zQ1g==
X-Gm-Message-State: ACrzQf2ufDEfpxI3yMkoM4dSlGm1raABADqYJUL87XYuoK5mnFIo3nLG
        qCotGuztbk6DhpZcfJScPEVvgzaduIJvNIUXpzuVa2sh6I0=
X-Google-Smtp-Source: AMsMyM45neTD1S6fG+Zyehv+gRPWlymFP2txgUakzpzTDYyKKZw+I3DRNRG4FVmDT1Fu9cFKE9yFShvVkJbNit6ZRUU=
X-Received: by 2002:a05:6402:2b8f:b0:453:2e59:364d with SMTP id
 fj15-20020a0564022b8f00b004532e59364dmr25455248edb.254.1664917670880; Tue, 04
 Oct 2022 14:07:50 -0700 (PDT)
MIME-Version: 1.0
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 4 Oct 2022 23:07:39 +0200
Message-ID: <CAJvTdKn8jCWF3f3_EnBCaOAgQf9UgPCCG4oAysva5U2JF=C_4Q@mail.gmail.com>
Subject: [GIT PULL] turbostat 2022.10.04
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

Please pull these turbostat patches to update Linux to turbostat 2022.10.04.

Add support for two new platforms, and two bug fixes on existing platforms.

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit 4fe89d07dcc2804c8b562f6c7896a45643d34b2f:

  Linux 6.0 (2022-10-02 14:09:07 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat

for you to fetch changes up to 9992dd777123b052e106eb5633de47148fef502e:

  tools/power turbostat: version 2022.10.04 (2022-10-04 23:02:03 +0200)

----------------------------------------------------------------
Artem Bityutskiy (1):
      tools/power turbostat: Do not dump TRL if turbo is not supported

Len Brown (1):
      tools/power turbostat: version 2022.10.04

Zhang Rui (3):
      tools/power turbostat: Add support for RPL-S
      tools/power turbostat: Add support for MeteorLake platforms
      tools/power turbostat: Use standard Energy Unit for SPR Dram RAPL domain

 tools/power/x86/turbostat/turbostat.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)
