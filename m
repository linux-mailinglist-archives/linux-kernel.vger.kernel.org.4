Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF2766151B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 13:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjAHMgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 07:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjAHMgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 07:36:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DFAC768;
        Sun,  8 Jan 2023 04:36:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A59B760C69;
        Sun,  8 Jan 2023 12:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38F0C433D2;
        Sun,  8 Jan 2023 12:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673181363;
        bh=CEml4/PckH5kpQIqMHRbuqau+u4QDk90dU1KpmYVSsY=;
        h=From:To:Cc:Subject:Date:From;
        b=XcegUJZfiikPZJSePOiuz4Ggx3YOwFZuTD1KH45K4fGcFfGZLwuUlNlpBt4AfgfuN
         Sw3QaJIMa+TG2roLw0NyupQuqwSoFLMOkmx+1OoyJDh95qOohQlCVVUU+VrZdSCN+v
         Nq8/Jkdsx//WaRJ79OmeVNWVfoBlG3uxKAOsA2fUjzjAc5z9H2RzQvFvpjiVaqD/VW
         y+lnDJIACF0Z97XofL4E0YpwcUI40fU1pUO5XcWREsJuBlEB2i33JLCcvrhv/9eo3Z
         c9e+DlkZ31uZES403Ah5UyORDiK9xf8U4J7xslR9TL8UTGwkPZ6WyE5tL5K18YGWB4
         /b3CqOmSZfNHg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] init/version-timestamp.c: remove unneeded #include <linux/version.h>
Date:   Sun,  8 Jan 2023 21:35:57 +0900
Message-Id: <20230108123557.2838094-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kbuild test robot detected by 'make versioncheck'.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 init/version-timestamp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/init/version-timestamp.c b/init/version-timestamp.c
index 179e93bae539..043cbf80a766 100644
--- a/init/version-timestamp.c
+++ b/init/version-timestamp.c
@@ -2,7 +2,6 @@
 
 #include <generated/compile.h>
 #include <generated/utsrelease.h>
-#include <linux/version.h>
 #include <linux/proc_ns.h>
 #include <linux/refcount.h>
 #include <linux/uts.h>
-- 
2.34.1

