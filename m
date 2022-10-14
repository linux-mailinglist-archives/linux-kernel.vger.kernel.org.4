Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E1B5FE62E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 02:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiJNATp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 20:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJNATd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 20:19:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F536183D86;
        Thu, 13 Oct 2022 17:19:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F9DEB8217F;
        Fri, 14 Oct 2022 00:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8830FC433C1;
        Fri, 14 Oct 2022 00:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665706769;
        bh=tTEyDY4y1+87Ir4x7Jh4HSnnTm32iutjilnAr13AlmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RIQVTdUhKbvSNm5TJSCNviQbTKH+idQm2WL/bYb3g0XILtwdlcQcAUs3eT5lrCBep
         X1VPRKWnTKTolEsn8aVM6bnKc+Q3kTmN08H1cQvkwhRuBwj4BvnKeaBMRYZsxNRH1T
         PiqepcQvyMiIOAcDvF7dTVRD1FBJHmmkdftey2dladzpaTYqnNLSuyr+4GfUO0mSox
         x+9NUV1lP3YdxdqSBh/yAEHmzJi4jyXL6KGvVVLT03l+uVe7u+X9r6/mcyLzMa5p6O
         0jQVrqGhqWLGsliL+i9Fu/cPjVgJGKlV51/AbWAUVzsld4U/Hi1TCbtKIo3su50Cjb
         xW9Aj21g+KvyA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: [PATCH 3/3] alpha: remove unused __SLOW_DOWN_IO and SLOW_DOWN_IO definitions
Date:   Thu, 13 Oct 2022 19:19:11 -0500
Message-Id: <20221014001911.3342485-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014001911.3342485-1-helgaas@kernel.org>
References: <20221014001911.3342485-1-helgaas@kernel.org>
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

From: Bjorn Helgaas <bhelgaas@google.com>

Remove unused __SLOW_DOWN_IO and SLOW_DOWN_IO definitions.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
---
 arch/alpha/include/asm/io.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
index 1c3605d874e9..7aeaf7c30a6f 100644
--- a/arch/alpha/include/asm/io.h
+++ b/arch/alpha/include/asm/io.h
@@ -14,10 +14,6 @@
    the implementation we have here matches that interface.  */
 #include <asm-generic/iomap.h>
 
-/* We don't use IO slowdowns on the Alpha, but.. */
-#define __SLOW_DOWN_IO	do { } while (0)
-#define SLOW_DOWN_IO	do { } while (0)
-
 /*
  * Virtual -> physical identity mapping starts at this offset
  */
-- 
2.25.1

