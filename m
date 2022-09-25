Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37F05E962C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 23:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbiIYV1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 17:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiIYV1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 17:27:17 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D18C29CBF
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 14:27:16 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id ay9so3153704qtb.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 14:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=rs2iEn7xSV/AcStIg2IvJebqNsYo6UJfyzF5gsqV+Xg=;
        b=MkrTpJU79gAnhdvHM3ZNdVT+JBSDM5TgFLytwyTRcReYHHhaf0RsiU0Ujw4Ixq7ifX
         2I9I2tMabLgzE59Y9b5KP97/+IeeyoDg+AdeiAF22e4TIddrSXP58UPXfZ9a6JPYqLI/
         m4mjISuirGZqNs0n6NJWMrnHttPb9gJd2t8nJiuCe3Qjm08pUEQeDHTW5cj6luwzrKdk
         Ob02m74R0RgdBNwDuof5qE91mWQTduwQ6aPkBAQnLv8GsOqgXGEhNmVLsboq6Sx+xOwe
         YmVUfgaGUnTLVzj1lO1quY0GUk9HzZrvMmOqxQiapBztime2uLBlgb6AveaoCEMSLoe4
         pU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=rs2iEn7xSV/AcStIg2IvJebqNsYo6UJfyzF5gsqV+Xg=;
        b=aArpJT2jYSbqEh6Lg95luuLKX9/99wLRu7AM4+H2GoOu6O/Kz8qYoT68Trq3ENrSaG
         jsDbRw/JeIb7PViyu/AKrJo9kM7IhUBfJdFJ1Dxdy8RbyU96jnbySzVoWoGSzILxfP9A
         a5oX+uK4P9GOvSf3dPnhibRXdzXPyJqJYXwiklybJ+C21BkKhfemBusED1U8MtM5SmBt
         YIAc4Ep8wH+lmTA6mv0EcGIu5ULZB88dLtmM9WMpICWmukIO3mN+s9hJcPp/e+caxOd9
         vYN4s+g528tjIhYPdIARYavBM77Em+Sbh13w/JK1NkCwEbcohVnTw0FpnEABfPWzT4DB
         kzvg==
X-Gm-Message-State: ACrzQf3uhUISX0dolC+cFM4V7XIqm0U87s/R7EOPEyfpZRIBZvUlBBIY
        vF2/e1893dkF7P18VQvUoqQ=
X-Google-Smtp-Source: AMsMyM4yvF4cW+3fNV3jahjqCaPysJb47IFtnSh8rBubJHo1LJI5cSv4cxuoVdx+iQ9hiiHMQ9Au1Q==
X-Received: by 2002:ac8:58cf:0:b0:35c:c69b:4aa1 with SMTP id u15-20020ac858cf000000b0035cc69b4aa1mr15610425qta.355.1664141235190;
        Sun, 25 Sep 2022 14:27:15 -0700 (PDT)
Received: from sophie ([185.156.46.189])
        by smtp.gmail.com with ESMTPSA id t9-20020a05622a180900b0031e9ab4e4cesm10170408qtc.26.2022.09.25.14.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 14:27:14 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 0/5] memblock tests: add tests for
Date:   Sun, 25 Sep 2022 16:26:51 -0500
Message-Id: <cover.1664138928.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add tests for memblock_alloc_exact_nid_raw(). There are two
sets of tests: range tests and NUMA tests. The range tests use a normal
(i.e., UMA) simulated physical memory and set the nid to NUMA_NO_NODE. The
NUMA tests use a simulated physical memory that is set up with multiple
NUMA nodes. Additionally, most of these tests set nid != NUMA_NO_NODE.

The range tests are very similar to the range tests for
memblock_alloc_try_nid_raw(). The NUMA tests have the same setup as the
corresponding test for memblock_alloc_try_nid_raw(), but several of the
memblock_alloc_exact_nid_raw() tests fail to allocate memory in setups
where the memblock_alloc_try_nid_raw() test would allocate memory. Also,
some memblock_alloc_exact_nid_raw() tests drop the lower limit of the
requested range in order to allocate within the requested node, but the
same setup in a memblock_alloc_try_nid_raw() test allocates within the
requested range.

Rebecca Mckeever (5):
  memblock tests: add range tests for memblock_alloc_exact_nid_raw
  memblock tests: add top-down NUMA tests for
    memblock_alloc_exact_nid_raw
  memblock tests: add bottom-up NUMA tests for
    memblock_alloc_exact_nid_raw
  memblock tests: add generic NUMA tests for
    memblock_alloc_exact_nid_raw
  memblock tests: remove completed TODO item

 tools/testing/memblock/Makefile               |    2 +-
 tools/testing/memblock/TODO                   |    7 +-
 tools/testing/memblock/main.c                 |    2 +
 .../memblock/tests/alloc_exact_nid_api.c      | 2299 +++++++++++++++++
 .../memblock/tests/alloc_exact_nid_api.h      |   25 +
 5 files changed, 2328 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/memblock/tests/alloc_exact_nid_api.c
 create mode 100644 tools/testing/memblock/tests/alloc_exact_nid_api.h

-- 
2.25.1

