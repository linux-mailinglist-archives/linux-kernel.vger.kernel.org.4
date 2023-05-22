Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EEF70B2A3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 02:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjEVAzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 20:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEVAzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 20:55:12 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3082FDB;
        Sun, 21 May 2023 17:55:11 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-25332422531so2085690a91.0;
        Sun, 21 May 2023 17:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684716910; x=1687308910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PsLQs8twnUd4CROC4LOnv3O2udtb3+iwSMNlphTO0Ao=;
        b=VdCeEyzAcPp8O24FlnuOgTe5oWxLbZcDWjvTGzVLVS/oAPy0nCDcsV84ouKUeREXj4
         kV4Jet9EqO6CHb0uGCBV0IeTqJDeJbTF8IIPgInaogQ6oBsayOi8VhftR3ivv6mKBc/w
         Epj6kJUQ+VH6h5Vgk5xoa36X8AZY1bKzETaQXja9Y5mXtpYHG9DGNR0OuRDzlF9qjyV0
         pONlfpT8ShZ+RtPdcOZebCLYPJMz7gvQLAUxa08kHFolWF8BLXxrvyw5F0cyVwZD3TJr
         RHCQN2SV9AigP0hHdnkpbAlOA8ifbRSc5yQe/SvjHx/wIImmUlygEXHzMlLS8PcmFyvy
         wq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684716910; x=1687308910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PsLQs8twnUd4CROC4LOnv3O2udtb3+iwSMNlphTO0Ao=;
        b=McrZTfMwESJGEC4A8hWVbSzo0h9aqhG+0PHWKHxN70msU+D2T/YqBv+eG4vJjSnqG9
         neKVTeGuw3PZyTtgjnsJuVRXdKJB+fL1A7J9uxCzzZYC7n50TKnIs0f6rRJAYvKdjjlH
         Jkj7tQhlSmHql8OPQUkKqXl4pOGNb53cP5eayCvJL4rZeCSI9mt13j77ACCgYE7Ewpgb
         FRUNyN1rH7K5EPc7DoX04zKYZU9bnb8h/z5a2eQcYcszPJ/xz/7rYgIO4f85h2HbAZAi
         9FxW5knjow3g7hEMQrj6tLb5Yh5LOSTEvNsHKEf1oV4KRKLMyDVi6OjMN28pJ/Hugjfd
         zMNQ==
X-Gm-Message-State: AC+VfDzRzyyHQXqyWuBURCca5gYnX84FwNnudigg7qZyM5N+VJVFj6iR
        rDbwN0x1meAsACa8AzW+/OM=
X-Google-Smtp-Source: ACHHUZ7w2+lb7PDmQAxEv+tjgCCeapydGEja1vAwMl9NDwIWex3ibUYMn+nb15VBTOeifnl0eXHsRQ==
X-Received: by 2002:a17:90b:a57:b0:253:5599:5fa4 with SMTP id gw23-20020a17090b0a5700b0025355995fa4mr14138536pjb.19.1684716910533;
        Sun, 21 May 2023 17:55:10 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-10.three.co.id. [180.214.232.10])
        by smtp.gmail.com with ESMTPSA id w62-20020a17090a6bc400b00246774a9addsm5175334pjj.48.2023.05.21.17.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 17:55:09 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id D67A110693A; Mon, 22 May 2023 07:55:05 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux SPDX Licenses <linux-spdx@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Actions <linux-actions@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Cc:     Jan Kara <jack@suse.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Diederik de Haas <didi.debian@cknow.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2 0/2] SPDX conversion from UDF
Date:   Mon, 22 May 2023 07:54:33 +0700
Message-Id: <20230522005434.22133-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2293; i=bagasdotme@gmail.com; h=from:subject; bh=Dq8Nbn/b6968iQgCwgZhjDFLMuWaAZdasoZ7z9G5NIk=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDClZe53faDHPqNv/Mp7xltQh80D9rxGeD3fLFFwPWZ7BW ZZWqVbWUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgIm49TD8Tyz7fbvmQ8/dvt8v Pq6///UV19mTvBGWbIuyl5nmqGotPcTwP3P7ty+n1fpfWqyZoCRzX6DPO1DW/vbD8Jjwjrakf0q X2AA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small SPDX conversion series targets UDF file system, which is
splitted from v2 of my SPDX conversion series that is triggered by
Didi's GPL full name fixes [1]. It is done to ease review.

All boilerplates in fs/udf/ is converted, except fs/udf/ecma_167.h.
The latter file apparently looks like 2-clause BSD Source-Code
license, yet the second clause is from third clause of 3-Clause BSD.
This custom license can't be expressed satisfiably in SPDX license
identifier, hence the file doesn't get converted.

This series is based on mm-nonmm-unstable branch.

Changes since v1 [2]:
  * Correct SPDX tag for LGPL (correct spdxcheck warning)

[1]: https://lore.kernel.org/linux-spdx/20230512100620.36807-1-bagasdotme@gmail.com/
[2]: https://lore.kernel.org/linux-mm/20230517083344.1090863-1-bagasdotme@gmail.com/

Bagas Sanjaya (2):
  fs: udf: Replace GPL 2.0 boilerplate license notice with SPDX
    identifier
  fs: udf: udftime: Replace LGPL boilerplate with SPDX identifier

 fs/udf/balloc.c    |  6 +-----
 fs/udf/dir.c       |  6 +-----
 fs/udf/directory.c |  6 +-----
 fs/udf/file.c      |  6 +-----
 fs/udf/ialloc.c    |  6 +-----
 fs/udf/inode.c     |  6 +-----
 fs/udf/lowlevel.c  |  6 +-----
 fs/udf/misc.c      |  6 +-----
 fs/udf/namei.c     |  6 +-----
 fs/udf/partition.c |  6 +-----
 fs/udf/super.c     |  6 +-----
 fs/udf/symlink.c   |  6 +-----
 fs/udf/truncate.c  |  6 +-----
 fs/udf/udftime.c   | 18 ++----------------
 fs/udf/unicode.c   |  6 +-----
 15 files changed, 16 insertions(+), 86 deletions(-)


base-commit: 7e61b33831bc7680b24bc04af9ed9c1553dac406

Range-diff against v1:

1:  442194d17ed043 = 1:  30fb64a215be1c fs: udf: Replace GPL 2.0 boilerplate license notice with SPDX identifier
2:  ccb407446ab324 ! 2:  f7cfeaa5cec879 fs: udf: udftime: Replace LGPL boilerplate with SPDX identifier
    @@ Commit message
     
      ## fs/udf/udftime.c ##
     @@
    -+// SPDX-License-Identifier: LGPL-2.0-or-later
    ++// SPDX-License-Identifier: LGPL-2.0+
      /* Copyright (C) 1993, 1994, 1995, 1996, 1997 Free Software Foundation, Inc.
         This file is part of the GNU C Library.
     -   Contributed by Paul Eggert (eggert@twinsun.com).

-- 
An old man doll... just what I always wanted! - Clara

