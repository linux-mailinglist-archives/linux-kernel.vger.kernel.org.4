Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C91B6B52A6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjCJVS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjCJVSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:18:25 -0500
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B20A262
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:18:23 -0800 (PST)
Date:   Fri, 10 Mar 2023 21:18:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doas.su;
        s=protonmail; t=1678483100; x=1678742300;
        bh=mF+nSMZzLJPS12G0KEfjtTfNFer+NMmFp89iOOpgIlQ=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=cAynFGzwxzakx+3lHAIbGzbBjAsM1agM4E2IGDdC3zmMpledijLXhWd1tWuggwWjg
         mZM2x5kHHyy7EqM7AaMwIgREz5sNOQXsavVv+Jzy85eDWDg2vT2ScnEdhAyO0Hb13U
         ac5DpNVqBaiktgnQYhdEThcnQNnExYHEBAGbnSk32KfMnEkoeVMuIeRkNePPhJtl4w
         1AttFQ+AI1469BPx2LtlwZfB0xvXB5xxD+siNQmgplh133TbQQXKucap9SoM8JBdi8
         6/EhWgyW5PPpnHBLz4bQZ6Da/vBzVV0nR73W8P105asS+q7cDMXNOmcwD7tN6/eejW
         /vtf2zq/c8Gbg==
To:     linux-kernel@vger.kernel.org
From:   Miroslav Cimerman <mcimerman@doas.su>
Cc:     Miroslav Cimerman <mcimerman@doas.su>
Subject: [PATCH] ntfs: fix typo in dir.c
Message-ID: <20230310211638.6457-1-mcimerman@doas.su>
Feedback-ID: 68733797:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant word in the documentation.

Signed-off-by: Miroslav Cimerman <mcimerman@doas.su>
---
 fs/ntfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
index 518c3a21a556..8bf69be5c737 100644
--- a/fs/ntfs/dir.c
+++ b/fs/ntfs/dir.c
@@ -57,7 +57,7 @@ ntfschar I30[5] =3D { cpu_to_le16('$'), cpu_to_le16('I'),
  * the dcache aliasing issues.
  *
  * Locking:  - Caller must hold i_mutex on the directory.
- *=09     - Each page cache page in the index allocation mapping must be
+ *=09     - Each cache page in the index allocation mapping must be
  *=09       locked whilst being accessed otherwise we may find a corrupt
  *=09       page due to it being under ->writepage at the moment which
  *=09       applies the mst protection fixups before writing out and then
--=20
2.39.2


