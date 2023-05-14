Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCF2701C64
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 11:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbjENJEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 05:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjENJEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 05:04:43 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED2E1BE2;
        Sun, 14 May 2023 02:04:42 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5307502146aso2631330a12.1;
        Sun, 14 May 2023 02:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684055082; x=1686647082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIanyhJS88Q7RfVNqljO8EtKKIvGna+18p2AMpDpX+U=;
        b=CgLdpdVKhiQqsKr2AyMNHWm3uR3kk6DMFszCy7EQcABgt28gkiZ1AafbMGbW86JTx+
         LnizcfPOhbNBU8/9RIfbvviAVLKL1ApA166UNnezr4YyshFLSs+QU908wo51TG06sFUn
         6vwOI3CzVmcFf9Rtmw2XNfDisol0wwtMnYLSalk8sHyygzfj7RXU2E0S5A3rVNLe39cR
         P9B3/gSUsU9KGsf+To00d+xpUeEBLJy8bzbwQhFkSQSDjJkM8eLN3QknKrQRTgN3aOg1
         LLg2u3AUAQJQG1iOcSi9qA9U4jCzF82jq5Jb8ACLvSevx4NBSVdYaSwjhoKG0QHfQPWI
         C1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684055082; x=1686647082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qIanyhJS88Q7RfVNqljO8EtKKIvGna+18p2AMpDpX+U=;
        b=IVTh4R3jtUWvddI4EJDi5QtZnIc09RSZuZkZ139sOmRjryZ0s1Nz+zmcrgwc3xCm7C
         znZlA1/G2hfx+jgdxtuj9ypOanVE9gGZx7CLr8kWfFCyYTLQp9jadO3ybWQ66i1Nt5c7
         vBpbCP0Qua1iOqbZiZv/wMlUKif90DGS2fkrbcEmnYHIc8mlg9R07ItqQbRtzKMcg56c
         k1k/qPu3rB6y14oTraN8dZxJCwbU86JGJIuLNUMBQ6IgR9z27ivmYdMAFeG/mqK5CzDG
         DOtH38nFlN9qLNp20Ak81q+KV+yKsWOWuybWexPREexfUrRcl/XJZCGlfNTptQTcJlsk
         U2PQ==
X-Gm-Message-State: AC+VfDyv8fYYhXybBkvYIbiHI9ICSKouDz39rTcipVt7oGGOEFKSvZHP
        2IZCGjQ4IHaSpX9kjDxIWjc=
X-Google-Smtp-Source: ACHHUZ4V5wgMt2YCt4Gb1ub46b4Vak78d55bkX0cYjQkPO8T8Qiv0fPcs8d2tc7YVgqJPIXodP5WAQ==
X-Received: by 2002:a17:903:22cb:b0:1ac:6e1f:d19c with SMTP id y11-20020a17090322cb00b001ac6e1fd19cmr30176048plg.41.1684055081976;
        Sun, 14 May 2023 02:04:41 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-68.three.co.id. [180.214.232.68])
        by smtp.gmail.com with ESMTPSA id jj3-20020a170903048300b001a9666376a9sm11029564plb.226.2023.05.14.02.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 02:04:41 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 6CA011061DE; Sun, 14 May 2023 16:04:36 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux RISC-V <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>
Subject: [PATCH 3/5] Documentation: riscv: vector: Use bullet lists for prctl list
Date:   Sun, 14 May 2023 16:04:30 +0700
Message-Id: <20230514090432.78217-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230514090432.78217-1-bagasdotme@gmail.com>
References: <20230514090432.78217-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1431; i=bagasdotme@gmail.com; h=from:subject; bh=cZzclkM/zLfkcp8yZSx1IGcKkEsU6t+56HAynF/Kr40=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCkJS+R/RJzdLfV0aWb3xHVc1QXO9/n0mb18FBjuz246V HJDISSxo5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABNZl8HIsCvPbkujH3+x3hJt oyKnX5v2sJq/UmgWD6lSrFV/6MfPysiw6g130FSu6xuc+hdWP3zTcr5Vwe9Jyox87rIcya02b6S 4AQ==
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

The documentation lists two userspace prctl() calls. Use bullet
lists for the listing.

Fixes: 412c68cfeeb178 ("riscv: Add documentation for Vector")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/riscv/vector.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/riscv/vector.rst b/Documentation/riscv/vector.rst
index 178b3f3f452462..c7bd701c7963b6 100644
--- a/Documentation/riscv/vector.rst
+++ b/Documentation/riscv/vector.rst
@@ -13,7 +13,7 @@ order to support the use of the RISC-V Vector Extension.
 Two new prctl() calls are added to allow programs to manage the enablement
 status for the use of Vector in userspace:
 
-prctl(PR_RISCV_V_SET_CONTROL, unsigned long arg)
+* prctl(PR_RISCV_V_SET_CONTROL, unsigned long arg)
 
     Sets the Vector enablement status of the calling thread, where the control
     argument consists of two 2-bit enablement statuses and a bit for inheritance
@@ -89,7 +89,7 @@ prctl(PR_RISCV_V_SET_CONTROL, unsigned long arg)
         * Every successful call overwrites a previous setting for the calling
           thread.
 
-prctl(PR_RISCV_V_SET_CONTROL)
+* prctl(PR_RISCV_V_SET_CONTROL)
 
     Gets the same Vector enablement status for the calling thread. Setting for
     next execve() call and the inheritance bit are all OR-ed together.
-- 
An old man doll... just what I always wanted! - Clara

