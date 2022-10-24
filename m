Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA1460AE1D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 16:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiJXOt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 10:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbiJXOtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 10:49:06 -0400
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8051004A0;
        Mon, 24 Oct 2022 06:26:33 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id s24so2247615ljs.11;
        Mon, 24 Oct 2022 06:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/f6QvgWEK2QKd8Bu9REf8ADv1aw2vVd3Yv4HOVOz7Ak=;
        b=EhOMIEgIRErpnbm8prEnZ+El1XlhTxkfIZ0a7AXi1Hv2jclABTle/FG3DepAdDAD8E
         nluCcmdihUyFrYzoakm8C8ToLqtOkfeQYYl/DizhDL4VcuRnignLvmRKAvRvnKIKyWuX
         xrcQsyYy7ZJXQT4ZiWOItzrXVtV5khRPxtRkREb5vkewPCMg1rtU3yzWWaE/unpowqJs
         YrozlDAxnn5OjtOgQZKYrD/YPGKirnrpQE46OlU3pCnxcWLqx8L9ZOKmZ0SJlCxiJ/DL
         YGeVbVeiL74nXkd0X0HclwjzNF5kc4UILSxZzjCMmTzx6QZYswqNJtZbhS+jFh/o4Ltw
         TMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/f6QvgWEK2QKd8Bu9REf8ADv1aw2vVd3Yv4HOVOz7Ak=;
        b=SPqxX/j9liyCKvohhtxoGSenZZ7ZyKo3aZbIRn43p+9qtcVtOYmFt0uxw/Q0cg+t4U
         bg3wN+BCgVMpZ9bY0+VH2HtWb3zS2QvS4KB2PfhmXzw/KbJPe3Bpn+GoNNpY62QVsXmS
         UcUG6+eG5VGT2loNdNjpbCswgkkwj/MdUWR1Or+umDQOwd78Mj33fRCv4kHhyxgeCTbY
         56FAUD6yftHI5/bUpKXHmDwIMB7H/xACAxg/5YFMpuWGdvhxijcvsdxp3z3lPbJ+HPeD
         bWX0RtkCW7t2VqHRuWM01s/2Yd2dQw9wJUlgYgS3k62/XHRfxtdEqfALpsVhdUgfBS9z
         rAWQ==
X-Gm-Message-State: ACrzQf2jZmNkWjS4ZnjEZvp0n7xboCl5I4oH5NK+FES/LT9gwJizTux9
        szvhLwbUW0HqwzxyXI7zBtYCqcGn4qE=
X-Google-Smtp-Source: AMsMyM56lIO+9BhSuf6T//Z7gcQumbNn2vHE9335uPa1WiK0ku4dyd2GjwOAotSh/CqivYpDYh4kDQ==
X-Received: by 2002:a17:907:3e87:b0:78d:bb06:9066 with SMTP id hs7-20020a1709073e8700b0078dbb069066mr27596749ejc.387.1666617778278;
        Mon, 24 Oct 2022 06:22:58 -0700 (PDT)
Received: from felia.fritz.box (200116b826dcce007dd5aa083ba5848a.dip.versatel-1u1.de. [2001:16b8:26dc:ce00:7dd5:aa08:3ba5:848a])
        by smtp.gmail.com with ESMTPSA id p1-20020a17090653c100b007a23fe14442sm3065202ejo.195.2022.10.24.06.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:22:57 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust entry after renaming parisc serial driver
Date:   Mon, 24 Oct 2022 15:22:23 +0200
Message-Id: <20221024132223.9697-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9e4e2ce1a78e ("parisc/serial: Rename 8250_gsc.c to 8250_parisc.c")
renames the parisc serial driver file, but does not adjust the entry in
MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair this file reference in PARISC ARCHITECTURE.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 91d95924cff4..0c8198b3329a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15637,7 +15637,7 @@ F:	drivers/input/serio/gscps2.c
 F:	drivers/input/serio/hp_sdc*
 F:	drivers/parisc/
 F:	drivers/parport/parport_gsc.*
-F:	drivers/tty/serial/8250/8250_gsc.c
+F:	drivers/tty/serial/8250/8250_parisc.c
 F:	drivers/video/console/sti*
 F:	drivers/video/fbdev/sti*
 F:	drivers/video/logo/logo_parisc*
-- 
2.17.1

