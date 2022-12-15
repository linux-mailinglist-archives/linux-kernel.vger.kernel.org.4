Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7C064E034
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiLOSH1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Dec 2022 13:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiLOSHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:07:24 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377953B9C2;
        Thu, 15 Dec 2022 10:07:23 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id ay32so161671qtb.11;
        Thu, 15 Dec 2022 10:07:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+R0AT2rjdktfIXZg7SxOTYK0enlSVf79ci15L9O/olY=;
        b=I1GvffJ2PjtcQPoLEjwqan+NboCeBEX2pzAAlCUV5aztohz2HryO9Ej8YR1nbBhl5U
         mDl6HSYsK1Dzjf76jPNi+2Ze70SGY+oe1B63JR9zlDpUT7Extg10KEYjpKNjiy2CvhBH
         VBIrXGTfjw0eJnk8z9PgWXO2iYSHJwx7HJZ94xfX5lIO9hXFgHH2LtnIyV/s+quZ/hKB
         Vmud/D2sH6FJ5eIm0QBTpYxC5sWcY7IjuyAi+2VQtGjL/Vq1Zys93DmCV1mXKpKBBzS/
         DbmEYFIjhBoCwH6X1MVsMWPg+uJtANDjyPhE3OoAGMsDbDoW1X+lUw1AIjuFbVz7L+Ei
         4Nwg==
X-Gm-Message-State: ANoB5pnk32rAGfUPcJPscg3PlBVWIU2K/Lr2b7kj+N8S/oYHR4uHHNk3
        TgmxoWpL9spC9ZI0jFWEx/Fy4dRf1Zh9dy3SfUmqzLjfi1g=
X-Google-Smtp-Source: AA0mqf4UExJ/79GGQ8Zn7GM8tPddicE6lS3dfTgxiLRxelaeXDmcRaolLP69250vgb79Zxt+8D9QQZRGiWyEk8ZL8s0=
X-Received: by 2002:ac8:7dcb:0:b0:3a6:8dd0:4712 with SMTP id
 c11-20020ac87dcb000000b003a68dd04712mr32464045qte.411.1671127642366; Thu, 15
 Dec 2022 10:07:22 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 15 Dec 2022 19:07:11 +0100
Message-ID: <CAJZ5v0hy7LXMyKF1H3Sh7ZKS8HyuMWPX_htN84wBYkRxxeNupA@mail.gmail.com>
Subject: [GIT PULL] More ACPI updates for v6.2-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
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
 acpi-6.2-rc1-2

with top-most commit 3d03140c4844bbd128728e8a367bb467d95f888e

 Merge branch 'acpi-ec'

on top of commit bee74dcbd3908291f4bfff3c81a52d52dcd48814

 Merge branches 'acpi-fan', 'acpi-pcc', 'acpi-misc' and 'pnp'

to receive additional ACPI updates for 6.2-rc1.

These fix an AML byte code execution issue in ACPICA and two issues in
the ACPI EC driver which requires rearranging ACPICA code.

Specifics:

 - Avoid trying to resolve operands in AML when there are none (Amadeusz
   Sławiński).

 - Fix indentation in include/acpi/acpixf.h to help applying patches
   from the upstream ACPICA git (Hans de Goede).

 - Make it possible to install an address space handler without
   evaluating _REG for Operation Regions in the given address space (Hans
   de Goede).

 - Defer the evaluation of _REG for ECDT described ECs till the matching
   EC device in the DSDT gets parsed and acpi_ec_add() gets called for
   it (Hans de Goede).

 - Fix EC address space handler unregistration (Hans de Goede).

Thanks!


---------------

Amadeusz Sławiński (1):
      ACPICA: Fix operand resolution

Hans de Goede (4):
      ACPICA: include/acpi/acpixf.h: Fix indentation
      ACPICA: Allow address_space_handler Install and _REG execution
as 2 separate steps
      ACPI: EC: Fix EC address space handler unregistration
      ACPI: EC: Fix ECDT probe ordering issues

---------------

 drivers/acpi/acpica/dswexec.c  |   6 +-
 drivers/acpi/acpica/evxfregn.c |  92 ++++++++++++++++++++++++++---
 drivers/acpi/ec.c              |  32 ++++++----
 drivers/acpi/internal.h        |   1 +
 include/acpi/acpixf.h          | 130 ++++++++++++++++++++++-------------------
 5 files changed, 181 insertions(+), 80 deletions(-)
