Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9BB672C81
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjARXWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjARXWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:22:23 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE44062D3F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 15:22:22 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id v23so670581plo.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 15:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jcBVdDrnnXYU1qsXN2I3YBEJVx1mRFWvZrGorjBbC8A=;
        b=J5t9ffR/XrbI2uamTczH2pw+C23Blk1REYIIeD1qQE2C5j3frL/3NqadmYrK0Ced33
         mQ6Oj+xQrGSJ2VjFMe0tA1UaupXcxRCZyB0T0+AfnGoiGXuewiBO4Eaoc0EhkaFerZt5
         cSrmdBGtAb1sRgu/Nm9QwDILerR9OtFekPC8d/QrOsQrGT58/SFQ7DDAgCV5MPTM0F8G
         ZYC7XtYx9UplNHjHYX5JcZ4MI5Mc8//74wrAuQqDpgetMruJtc3jsEiI9edXBXI+257+
         DPP44d/xLqTN2FRm5L/glDZnhcWvjYwB79m/grD1YAr8VeHHymoIfvZcrZ1R7Z5sgPGV
         qa2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jcBVdDrnnXYU1qsXN2I3YBEJVx1mRFWvZrGorjBbC8A=;
        b=RfAHjO7ixXQGGEJx15yDZ0xJglP0XZBWOaBA6vWmMmEHDg3ypw7GAz54EnkiGBARx5
         iP257HK7xQsPBNgy+cG2YTbfDvDiHO+fbFJmiJnwmLoGpgUWX4X8bSynvlBhOxVWsaMe
         Zv3GZ6LVux/Y0L24G14MI+V00NpL6qESJUoKtNgsb16A8Ca0SzS7qw6uEfgB6F0IWjcH
         XqOol5lqAcdpwZmkomZpq51ac9ZKvWj9N5f0/hFnJOaoPzxwxaE9scvSvCwuGfsFN2SV
         Q2JGGmZS/QqpY54huZVj+bxSynQ9OKPUODpYpcFs9RYKhEyqwl22Hyc8onY1zTDg0CFw
         bkRw==
X-Gm-Message-State: AFqh2kq7EwAI//pEdDYZKPM+8LrEBhkjittcJe9B+i+x3ck28DVFomB9
        oM364J/Y2aDx4N+qYdjDkgU=
X-Google-Smtp-Source: AMrXdXsah6NwKqBNfxU5H+uCAkyXQIVwMUdrCVgc40fv7MTo4FkS5GXkuwUCjzv29H3LtSK5O9Jy/g==
X-Received: by 2002:a17:90a:77c6:b0:226:3f8:5b78 with SMTP id e6-20020a17090a77c600b0022603f85b78mr8843788pjs.13.1674084142365;
        Wed, 18 Jan 2023 15:22:22 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::4e4b])
        by smtp.googlemail.com with ESMTPSA id k1-20020a17090a7f0100b00223f495dc28sm1862265pjl.14.2023.01.18.15.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 15:22:21 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable 0/5] 
Date:   Wed, 18 Jan 2023 15:22:14 -0800
Message-Id: <20230118232219.27038-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series converts migrate_page_add() and queue_pages_required()
to migrate_folio_add() and queue_page_required(). It also converts the
callers of the functions to use folios as well.

Vishal Moola (Oracle) (5):
  mm/mempolicy: Convert queue_pages_pmd() to queue_folios_pmd()
  mm/mempolicy: Convert queue_pages_pte_range() to
    queue_folios_pte_range()
  mm/mempolicy: Convert queue_pages_hugetlb() to queue_folios_hugetlb()
  mm/mempolicy: Convert queue_pages_required() to queue_folio_required()
  mm/mempolicy: Convert migrate_page_add() to migrate_folio_add()

 mm/mempolicy.c | 108 ++++++++++++++++++++++++-------------------------
 1 file changed, 52 insertions(+), 56 deletions(-)

-- 
2.38.1

