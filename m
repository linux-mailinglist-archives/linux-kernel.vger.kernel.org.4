Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC257062FD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjEQIfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjEQIeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:34:13 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942AE6194
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:33:51 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so11491494b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684312431; x=1686904431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xtx/5B8H/rVaVXYUM8sgj4CYA6Dh2uyNukruYFTcNhs=;
        b=hpfTYsOKZUTKDuGBdBu0RCZDVieutrWJrMd7A0AmhSoBA172Pga1u0OCq4TQYeWpz4
         XLTC6gieO1yPkOEemhHmq6LIprdk3zeu4ZeUWjiHQbvxfyI+n76QZPxU5d1dxY6+mPtP
         jQfn07RfqnRBnSxLz2RuC30t4mNuFH85sZ6P00sR783z0U/phrOswZRX9xNozWRzUz4D
         Udshf5pgLEU2gZmikESGH6ZEtnoHH0K0R1r1FXiaA9XuYEnQ8u0uR6T4pJLGMdfKv757
         F4NwzQqKGoSfL36HeRRW7j6KwDXu1daaBA0E8M7bcSBTeGfa3iEeNCkYR/k+D2daNw1b
         9cFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684312431; x=1686904431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xtx/5B8H/rVaVXYUM8sgj4CYA6Dh2uyNukruYFTcNhs=;
        b=VOs3Gnf27L5ce/LyuM0lik9ZBpbLH01781ldYxhdtKZBhO9KTi1K1b3WpZDpcbv36O
         B+UDCO18aBkqgqZeen9nM6RuGAD7bvitgM71WkY0ss5NaSyyerd55qMFUr3JrtRy0GOa
         AeYHJiTVKaohk+Rm01EZvoQDFpA6LF49oKM47BauIM37UoodMiuo4jSMyiYMRADOO9yy
         XZ2CNI2k0SKGM15ZimO2ouZV8gvww+sKyCObp14z8kJXY1UbtmVFwf9oTg/NxdcjHXgg
         MEng8+/UztThwQi/KekeGRcyh2exEFxfRQDxMrKM9zgF+gWvtwt9e/7wVjsFbO+Trl5a
         cbtw==
X-Gm-Message-State: AC+VfDwtFU+GDDav0QhxqWCHIQQVNG/g568VZBlMx0zQg31QLGSOdNGt
        OfVPu4X0LU1M2BjRSrqJ0Cs=
X-Google-Smtp-Source: ACHHUZ6fwHK1sTgE6sZNB+k12Q/9TotcyFkRuxUf3TTWLmhlbf5g1os5cp5yYnULZLDbXEJDPvqPoA==
X-Received: by 2002:a05:6a00:a82:b0:648:e2c8:c40 with SMTP id b2-20020a056a000a8200b00648e2c80c40mr1882964pfl.11.1684312430925;
        Wed, 17 May 2023 01:33:50 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-12.three.co.id. [180.214.232.12])
        by smtp.gmail.com with ESMTPSA id u8-20020a62ed08000000b0063d2dae6247sm9029431pfh.77.2023.05.17.01.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 01:33:50 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id C1AF710627D; Wed, 17 May 2023 15:33:46 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Actions <linux-actions@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Cc:     Jan Kara <jack@suse.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/2] SPDX conversion for UDF
Date:   Wed, 17 May 2023 15:33:42 +0700
Message-Id: <20230517083344.1090863-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1539; i=bagasdotme@gmail.com; h=from:subject; bh=CJo83dBt6rIK+5/RONxg1BgO7ghf8CvlB4Gt3zory/4=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCkpE5OYXplmz8tcUJucOyk3Slju7Hk+L9djCjsUf3oq3 ZgcPrWro5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABOZmcbwh3sNSwCTDlN8/t/7 AmuL/x7SfXo3PGn5C7bTco+jZubu28HI8GHZl5DTNztUVGMiXltsPcihyCShp9xgv2Wb764Nbhv y+QE=
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
identifier, hence ecma_167.h is doesn't get converted.

This series is based on mm-nonmm-unstable branch.

Happy reviewing!

[1]: https://lore.kernel.org/linux-spdx/20230512100620.36807-1-bagasdotme@gmail.com/

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


base-commit: 689cdaf84d7c00a1a77b25f545b4f3a48e3476d4
-- 
An old man doll... just what I always wanted! - Clara

