Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F4B681654
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237167AbjA3Q1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237042AbjA3Q1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:27:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887BA4345A;
        Mon, 30 Jan 2023 08:26:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22ED7611DE;
        Mon, 30 Jan 2023 16:26:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72978C433D2;
        Mon, 30 Jan 2023 16:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675096016;
        bh=J9MQ1F4rdXhR7D6bdFdyFE6EtY/SjbE8uHtkoXC5Xoo=;
        h=From:To:Cc:Subject:Date:From;
        b=YOaGeeNx/5e09Vt1TQt/htw2Jk2gnEQoraaBsG4Kuxan/ZTMS1zZyHtonom96a4u1
         Z35DE8WkkTvc6kzoMGNMql/rwtVqUx5OKhgBjD7RtsHrDG4VfQevFBMl6XH0X9Ht6A
         phoUT6qc/G+GFVMfwOQWe7b8KdFg5y/okfY9XcgPZoR34HkKTLJ0RSmrejF5w0zW0n
         KB28Kl7/tzfiZulOKKT66BrE7eLKBavrWUw2df0MkiiLboLP3HfeWTYe6Mx2Y0UbxF
         by1k99hlW/tcrKyHZH6MPSBzLdUrzXzx5q+U0umDm+jR9TzSjhvsh3SbLFjscN4NrS
         6Y9XwId+nha0w==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH] dt-bindings: rename .yamllint to yamllint
Date:   Tue, 31 Jan 2023 01:26:50 +0900
Message-Id: <20230130162650.399490-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file is ignored by git by the '.*' rule in the top .gitignore.

I do not see a good reason why this should be a hidden file.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

I think many people are aware of this issue
since this is now W=1 warning due to this patch:
 https://lore.kernel.org/all/20221229074310.906556-2-masahiroy@kernel.org/


 Documentation/devicetree/bindings/Makefile                | 4 ++--
 Documentation/devicetree/bindings/{.yamllint => yamllint} | 0
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/{.yamllint => yamllint} (100%)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index bf2d8a8ced77..edc65522072b 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -34,7 +34,7 @@ CHK_DT_DOCS := $(shell $(find_cmd))
 quiet_cmd_yamllint = LINT    $(src)
       cmd_yamllint = ($(find_cmd) | \
                      xargs -n200 -P$$(nproc) \
-		     $(DT_SCHEMA_LINT) -f parsable -c $(srctree)/$(src)/.yamllint >&2) || true
+		     $(DT_SCHEMA_LINT) -f parsable -c $(srctree)/$(src)/yamllint >&2) || true
 
 quiet_cmd_chk_bindings = CHKDT   $@
       cmd_chk_bindings = ($(find_cmd) | \
@@ -64,7 +64,7 @@ override DTC_FLAGS := \
 # Disable undocumented compatible checks until warning free
 override DT_CHECKER_FLAGS ?=
 
-$(obj)/processed-schema.json: $(DT_DOCS) $(src)/.yamllint check_dtschema_version FORCE
+$(obj)/processed-schema.json: $(DT_DOCS) $(src)/yamllint check_dtschema_version FORCE
 	$(call if_changed_rule,chkdt)
 
 always-y += processed-schema.json
diff --git a/Documentation/devicetree/bindings/.yamllint b/Documentation/devicetree/bindings/yamllint
similarity index 100%
rename from Documentation/devicetree/bindings/.yamllint
rename to Documentation/devicetree/bindings/yamllint
-- 
2.34.1

