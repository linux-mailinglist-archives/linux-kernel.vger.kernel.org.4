Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4516C8863
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjCXWcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjCXWca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:32:30 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477C71F49E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:32:02 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r29so3154357wra.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679697095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MIcRYN1jbAzyDvYI035gfgvA4GBDGHeabBKjiIiu+YA=;
        b=YfsxhWwl0K6P35tY1w//PN63ezROkJ+gcDejUZgFu73sxkVV6Bdt9+l8FezY4S9Gcn
         BTcgotEy+63bdQGE6FalmRU2D18XI4Oga5BmNFJ7G1m8LZuDV7JMw9U0QCzFSj4U+NxJ
         Cz3R9dT0hXE+DwjjGs4qjdosRDj5AmA0sL7p9wVNy8eGmi0J+VZu1jblpsHXeX3m9VFc
         4OMhRiGHOMcj2do5x9Wy1M4v0V3k9pNm3UR/xSmPEg+UkY0NiAUOhc/USfpCMO/IwjB5
         nYbw7DYsTyJ9RliwC6nN/9MPjJr/GjGSacBUho+GCdecNOUwqAcbTcvzVFeXOEABN1tc
         U0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679697095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MIcRYN1jbAzyDvYI035gfgvA4GBDGHeabBKjiIiu+YA=;
        b=ralJMIYTNEMtwMgMXex4PQPcDdgHhrbP0tb3riXExcsDGaGlkAylEwYjkzA8wx7Lk7
         l7oEX4M13hDQXKDjqZtdOjGtYReOCID05ClXX1Si7txob6y5wyOfEBTGX7MnmM9KFpCG
         BDSxFOtEJCKh0ee+cgfKDrAE2owOoCIfn75tuSa7/X/A1zOY25uD9KP5mG4Y70YMPtV7
         OymvLuhor/VioCmqlUKw6Iu5jkQGSvDe2+8fZmbVDibfNjhu5xutabmJj8LEhmiM67mg
         njVwnKu3DvdCDk/uR6GgyEgmpn1KwCMipP88q8CG7C9/DElxwOHNGGRg75FXBXqCmIyk
         Z3Qw==
X-Gm-Message-State: AAQBX9eolk4kPMcHL5ScwuFZqZyTvwRy4Mm7BzXRhpBNhOfoaK456ABk
        Yl9OiBrBRTFQdQbW+6vbiLo=
X-Google-Smtp-Source: AKy350ZrBODnkxChGN1cL026reqMl5jlUgk89UrhqSecgD8UKQRHj0oqWK5CjIUcvevBmJfi6aoQdw==
X-Received: by 2002:adf:cf04:0:b0:2ce:a897:9fd0 with SMTP id o4-20020adfcf04000000b002cea8979fd0mr3146036wrj.6.1679697094998;
        Fri, 24 Mar 2023 15:31:34 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id d7-20020adffbc7000000b002d5a8d8442asm14984138wrs.37.2023.03.24.15.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 15:31:34 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] staging: rtl8192e: code cleanup patches
Date:   Sat, 25 Mar 2023 03:31:27 +0500
Message-Id: <cover.1679696777.git.kamrankhadijadj@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix several cleanup issues reported by checkpatch.pl in module
staging/rtl8192e in file rtllib_rx.c

Changes in v5:
 - Resent the correct patchset becuase mistakenly sent a wrong patchset
   in the previous revision.

Changes in v4:
 - Changed the subject of the cover-letter that was mistakenly edited in
   the previous patchset.

Changes in v3:
 - Changed the description of all patches in order to explain 'why' the
   patches need to be merged.

Changes in v2:
 - Resent patchset with the correct email address

Khadija Kamran (4):
  staging: rtl8192e: remove extra blank lines
  staging: rtl8192e: add blank lines after declarations
  staging: rtl8192e: add spaces around binary operators
  staging: rtl8192e: remove blank lines after '{'

 drivers/staging/rtl8192e/rtllib_rx.c | 73 +++++++++++-----------------
 1 file changed, 29 insertions(+), 44 deletions(-)

-- 
2.34.1

