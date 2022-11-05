Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A62761DD98
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 20:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiKETJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 15:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKETJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 15:09:22 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088679FF8;
        Sat,  5 Nov 2022 12:09:22 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id a27so5029568qtw.10;
        Sat, 05 Nov 2022 12:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NjtvR6bAq3+xmYuUSX6pXJhQLypuCESvmua1+ptWuE4=;
        b=2+PcrLZEfozFCf8JMNw9K61B36w/GkJ+1hkqGxcThxL1jAVrlKdB7z3eeoxEDHqcEB
         Z6jQCnF5Y9Qon3RUqOZoax1NcU9zaZrj1B/Ls/9au2TEZmjBDI3qa1qt6Wa9QYDri+md
         k73KsZJdkFeJBtJ0+D4WFeo3CRknZPzztY8B+/wymGohtjv3LUZ9X6+XIgnV806k2RD3
         E4boUNZPTndrNcPWqpYHz8sQdsTWX84kZQjTMiwuKH5rE1pGd2KvzVWz2gkWamaVRhTF
         DusNrjhhtylHpC63pCscEhyNc4nQ38TQtOCWa5d57ZW75QhsP0sc+AfqxnpkDJldp1S2
         zQLQ==
X-Gm-Message-State: ACrzQf3J7qzZQoPDytx8XSXGgXQYpkkuzrS+ayqN2Q0uioQyPFglEBhC
        Z/iW7ctU0xbd5BzKyzEko7dZ/bNwH8GX/co3mFQLAjnbu9U=
X-Google-Smtp-Source: AMsMyM4KOXiAQMylP59BA+3abWz8wmOF/OhUbeY5XAQNe8/GttWAi6/jhGFZLBUYephPIcyzA47YP2DR0Em2gv9TG00=
X-Received: by 2002:a05:622a:4c07:b0:3a5:27ec:6dd3 with SMTP id
 ey7-20020a05622a4c0700b003a527ec6dd3mr26071593qtb.411.1667675361180; Sat, 05
 Nov 2022 12:09:21 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 5 Nov 2022 20:09:10 +0100
Message-ID: <CAJZ5v0iw2J0yVP_2hZWac24bDAjkGdLyCrLCqOsM4u62oGfvgA@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v6.1-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.1-rc4

with top-most commit 6faf4ce500d658bcf4d1fe6fe5de2d4d50366e25

 Merge branch 'acpi-x86'

on top of commit dd183e320524f076a765ec441193deb90bd53836

 Merge branches 'acpi-resource', 'acpi-pcc' and 'devprop'

to receive an ACPI fix for 6.1-rc4.

This adds a StorageD3Enable quirk for Dell Inspiron 16 5625 (Mario
Limonciello).

Thanks!


---------------

Mario Limonciello (1):
      ACPI: x86: Add another system to quirk list for forcing StorageD3Enable

---------------

 drivers/acpi/x86/utils.c | 6 ++++++
 1 file changed, 6 insertions(+)
