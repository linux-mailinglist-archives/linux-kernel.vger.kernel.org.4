Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EFB6D3B00
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 01:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjDBXxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 19:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDBXxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 19:53:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DBF9EF1
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 16:53:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB6FC61239
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 23:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DF6C433D2;
        Sun,  2 Apr 2023 23:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680479595;
        bh=ltPEbF2nHt2rsmy/3jx2u3rUnXIX6TvuDwOBnZTp1cE=;
        h=From:Date:Subject:To:Cc:From;
        b=DICcnRV+7l/iOeli6NE7rUq5KXhuUFZLIJA/5guYMlMB5Sq8xHi77Kv52SqEKF8eh
         UdQvvHGgPpfHtcKejHrc63UwogMhkoEsw+w/lvS6POh86ziJtVbscWrhhcdMl/xFlG
         sDSBL0uUEgpcdMQ3LNvJknVEpaHKp+Q2PZy9oncZl14I0vjbZrYabVY5Km88il2Fgl
         6krDssp9TABSt+Xat+8TSWL6Kht0uO7j1/brNEZrfAdFA33Z5j7eOK7iziuJyV4kab
         QOrPysL4lFLUd0ge0v7IMfUUnpTzSwOrcd8YVS688WE3oycCLjZu839IT4rmdV2ZKi
         /uDjQiZq203CA==
From:   Eric Van Hensbergen <ericvh@kernel.org>
Date:   Sun, 02 Apr 2023 23:53:00 +0000
Subject: [PATCH v2] Update email address and mailing list for v9fs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230401-ericvh-fix-maintainers-v2-1-ece364bc6543@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFsVKmQC/4WOTQ6CMBCFr2JmbRVaSowr72FYtHWgE7WYKWkwh
 Ls7cAEXs/jeT+YtkJEJM1wPCzAWyjQmAX08QIguDajoIQy60qZqqlpJPJSoeprV21Ga5JCzurS
 2sRrb0BgHUvYuo/LsUohbXeKYzwnnaTM/jLsgzr0TjpSnkb/7iFJv6t9/pVbimWCN9drb0N+ey
 Alfp5EH6NZ1/QFBN6Qw2gAAAA==
To:     linux-kernel@vger.kernel.org
Cc:     v9fs-developer@lists.sourceforge.net, v9fs@lists.linux.dev,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1548; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=ltPEbF2nHt2rsmy/3jx2u3rUnXIX6TvuDwOBnZTp1cE=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBkKhVq9UaRUyrm7OT+RT06zI14mjM6O1P84aSUf
 KJOkic6ZDmJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZCoVagAKCRCI/9X7Sl//
 mC/TEAC1d4L6RPq0umdzXwdr5iKjvczkId8RQzBjJDdXwd/HizkIsBMv9ZonNdQ7hgeOap3R6kD
 lPr/rRJ8s1AxPH7Lh6r0sKXaaCkp1exmAtWdEHXGYh1AjoyEj8ZJTbg77g0qb1FVbPFiRflDEm8
 Ds5a5P4g7xBomvcQjQ14uBMxbmc64KP5v/pgOqJnXPOFjglKLs3kUEaMAB+C8uGJ2hH+TkBvfNV
 nMcO2ezYLj7ZkJYJESemyftZTkU5TsChyAab7tDARLijHTlOdQe1plSNMqR1gzimx+1pO16KE22
 /QwBTv0+cmPB919jDAQKFNMjf3pcV8u2Se5fqEW1Umv1xN+qaiYNs4TTxjyXxgae2W/NEjhRbL5
 HPHWlIzss+crw2jSF/jXY0TFfeQECGiRwjApMkhen7K1UlXZ8mCfvXxTVFVDIyoj3FfNj0EoU2h
 O22x1bVnXDebhNHNhyGQQ6E4/hAivxCM37yMQprEpeiRFF1EFk80VFCnh9qf2ghEqjBk1CvfYSN
 Xxo5jzMpqiwAa4JimjFxa1jjUVgLNQvk5t8PcaGtIgXIX/PgjzMmdgaS5oAjsgiIc9K156zSGBm
 kL6fWKvSjj/2IEnZ/vqxUMllWOVrOKgka7trqhe9jaOignxz9AxGAmTouu74uo+Z1Uhmi0o8eMV
 0bSc/PyCECNwpJw==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've recently moved the mailing list to lists.linux.dev to move away
from the sourceforge infrastructure.  This also updates the website
from the (no longer v9fs relevant?) swik.net address to the github
group which contains pointers to test cases, the protocol, servers,
etc.  This also changes my email from my gmail to my kernel.org
address.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
Acked-by: Dominique Martinet <asmadeus@codewreck.org>
Acked-by: Christian Schoenebeck <linux_oss@crudebyte.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f305..8799a222048b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -224,13 +224,13 @@ S:	Orphan / Obsolete
 F:	drivers/net/ethernet/8390/
 
 9P FILE SYSTEM
-M:	Eric Van Hensbergen <ericvh@gmail.com>
+M:	Eric Van Hensbergen <ericvh@kernel.org>
 M:	Latchesar Ionkov <lucho@ionkov.net>
 M:	Dominique Martinet <asmadeus@codewreck.org>
 R:	Christian Schoenebeck <linux_oss@crudebyte.com>
-L:	v9fs-developer@lists.sourceforge.net
+L:	v9fs@lists.linux.dev
 S:	Maintained
-W:	http://swik.net/v9fs
+W:	http://github.com/v9fs
 Q:	http://patchwork.kernel.org/project/v9fs-devel/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git
 T:	git git://github.com/martinetd/linux.git

---
base-commit: 707823e7f22f3864ddc7d85e8e9b614afe4f1b16
change-id: 20230401-ericvh-fix-maintainers-865452e6c43a

Best regards,
-- 
Eric Van Hensbergen <ericvh@kernel.org>

