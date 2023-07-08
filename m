Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7B674BECA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 20:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjGHSu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 14:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGHSu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 14:50:57 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1820E46
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 11:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1688842252;
        bh=uNaVJKuJfvJ+VV4OUJkfGKz46h22SgI0vLkd93kL/1s=;
        h=Message-ID:Subject:From:To:Date:From;
        b=FPHg32JLTgCaSiVGptZZkhyCnpkU7V05vcWHxQrT7zQGaxMn6MBQjtRjn+YguVzXz
         6Mxe7QB4j+jPFO9hoti9jtvqaxARYcCg1+uRd2fDJyzAo6v9k76yTU5IyxDhn5Ff/n
         HSZgb9bZ8k0I/Bx2SzBBiu+WjVSD2QVAwOoim2Jc=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 57CF01281321;
        Sat,  8 Jul 2023 14:50:52 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id pRVodgcfHSJB; Sat,  8 Jul 2023 14:50:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1688842252;
        bh=uNaVJKuJfvJ+VV4OUJkfGKz46h22SgI0vLkd93kL/1s=;
        h=Message-ID:Subject:From:To:Date:From;
        b=FPHg32JLTgCaSiVGptZZkhyCnpkU7V05vcWHxQrT7zQGaxMn6MBQjtRjn+YguVzXz
         6Mxe7QB4j+jPFO9hoti9jtvqaxARYcCg1+uRd2fDJyzAo6v9k76yTU5IyxDhn5Ff/n
         HSZgb9bZ8k0I/Bx2SzBBiu+WjVSD2QVAwOoim2Jc=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B1BD51280A7D;
        Sat,  8 Jul 2023 14:50:51 -0400 (EDT)
Message-ID: <c5d8a017f39f95d4214ba638ecb8e41d2994cda0.camel@HansenPartnership.com>
Subject: [GIT PULL] final round of SCSI updates for the 6.4+ merge window
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 08 Jul 2023 14:50:50 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few late arriving patches that missed the initial pull request.  It's
mostly bug fixes (the dt-bindings is a fix for the initial pull).

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

The short changelog is:

Abel Vesa (1):
      scsi: dt-bindings: ufs: qcom: Fix ICE phandle

Arnd Bergmann (1):
      scsi: lpfc: Fix lpfc_name struct packing

Azeem Shaikh (2):
      scsi: target: tcmu: Replace strlcpy() with strscpy()
      scsi: ncr53c8xx: Replace strlcpy() with strscpy()

Damien Le Moal (1):
      scsi: core: Simplify scsi_cdl_check_cmd()

Gustavo A. R. Silva (1):
      scsi: smartpqi: Replace one-element arrays with flexible-array members

Keoseong Park (1):
      scsi: ufs: core: Remove unused function declaration

Mike Christie (1):
      scsi: target: iblock: Quiet bool conversion warning with pr_preempt use

Rong Tao (1):
      scsi: target: docs: Remove tcm_mod_builder.py

Yueh-Shun Li (1):
      scsi: isci: Fix comment typo

With diffstat:

 .../devicetree/bindings/ufs/qcom,ufs.yaml          |   9 +-
 Documentation/target/scripts.rst                   |   6 -
 Documentation/target/tcm_mod_builder.py            | 656 ---------------------
 drivers/scsi/isci/scu_task_context.h               |   2 +-
 drivers/scsi/lpfc/lpfc_hw.h                        |  10 +-
 drivers/scsi/ncr53c8xx.c                           |   2 +-
 drivers/scsi/scsi.c                                |  37 +-
 drivers/scsi/smartpqi/smartpqi.h                   |   4 +-
 drivers/scsi/smartpqi/smartpqi_init.c              |   5 +-
 drivers/target/target_core_iblock.c                |   2 +-
 drivers/target/target_core_user.c                  |   4 +-
 drivers/ufs/core/ufshcd-priv.h                     |   1 -
 12 files changed, 32 insertions(+), 706 deletions(-)
 delete mode 100755 Documentation/target/tcm_mod_builder.py

James


