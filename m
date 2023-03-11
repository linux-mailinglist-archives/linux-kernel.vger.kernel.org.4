Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7420A6B5E4D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 18:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjCKRFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 12:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCKRFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:05:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8058B763F1;
        Sat, 11 Mar 2023 09:05:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F2FB60D29;
        Sat, 11 Mar 2023 17:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F196C433D2;
        Sat, 11 Mar 2023 17:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678554334;
        bh=XwB/GrtD4QgsUuzr8rRrhVy0wwdqbWVx5IYtLaykaI4=;
        h=From:To:Cc:Subject:Date:From;
        b=CMKvwDarrN0Q+uUYRkqLiVku1aIdmmGLO1Z+d7R6Fy3zYtD0KIlkkrJRaduaOq1HV
         iSZ5LAbBuntSp7GdoKNCDX6FMvR14cKslRh5qQmUnfKFmaeFvmI5728Y8I/5Akesi6
         JJnwDr/Uqpw2f1JyMn2u6GOOVqBCOYsr3DC1/TcWJGhlux7YwvpcXlvoy6kIr+NTfH
         9yziGSWQSr163N7JA+Rx61KReni0dVYWj+/dRccWueoazXpaoDHIq81wXe8/JvxRCm
         SCTPxbG1YWfD0gzMQOIwjxKB6vz8dk0cpR2NqnSJDhgKz7AcaaY1h2KCeKszw3N00i
         SaVe3DP7KUNLg==
From:   Andi Shyti <andi.shyti@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH] MAINTAINERS: update Andi's e-mail to @kernel.org
Date:   Sat, 11 Mar 2023 18:05:16 +0100
Message-Id: <20230311170516.178913-1-andi.shyti@kernel.org>
X-Mailer: git-send-email 2.39.2
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

Use the kernel.org e-mail for the maintainer entry

Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 150ff03b42eb..fe6ef7be49a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18543,7 +18543,7 @@ F:	include/linux/clk/samsung.h
 
 SAMSUNG SPI DRIVERS
 M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
-M:	Andi Shyti <andi@etezian.org>
+M:	Andi Shyti <andi.shyti@kernel.org>
 L:	linux-spi@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
-- 
2.39.2

