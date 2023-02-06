Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F70568B3D3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 02:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBFB2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 20:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBFB2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 20:28:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B053612F0F;
        Sun,  5 Feb 2023 17:28:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4980660BAD;
        Mon,  6 Feb 2023 01:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42610C433D2;
        Mon,  6 Feb 2023 01:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675646880;
        bh=t9G8OoFLpiW3MTHtj2kJ4MrcZSlxmCfX1CehvS4POC8=;
        h=From:To:Cc:Subject:Date:From;
        b=H4z+BB38w50oBUjOo94JnKmg0bADEyBr2xlmWL89xxdd+xKX77WA8YcKCX4CGf/3t
         j8CwnAT0XgMuYMzxsmtjOvQGRZnupXtQ9S3F/67TAzD4hbtgusyCBiO61agv87eRlu
         GyBBo5KwZo18xiQY++xlhiumHPcR1YRnYQTjvmorMW31VPvMq3+fslOmo8WMhtb+Be
         R0xI8bMH4hFCb5sgrMDZm/PnhHmIbDbo/yqY+kAOUia1DZnYmq71gxEcpW0YZi7Vby
         DdB0Hfy0i12Wv6FssrNVERVMjpycq2+Bq2VySk83TMyKtOxMqIXSaN2+QUUTZcHmly
         p8Uq/FU6fQ3yw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] .gitattributes: use 'dts' diff driver for *.dtso
Date:   Mon,  6 Feb 2023 10:27:54 +0900
Message-Id: <20230206012754.2771051-1-masahiroy@kernel.org>
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

Now we have the third extension for DT source files (overlay).

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 .gitattributes | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitattributes b/.gitattributes
index 4b32eaa9571e..a49e9ee50e9f 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -2,3 +2,4 @@
 *.h   diff=cpp
 *.dtsi diff=dts
 *.dts  diff=dts
+*.dtso diff=dts
-- 
2.34.1

