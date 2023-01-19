Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08252673258
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjASHXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjASHW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:22:57 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60AB44A9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 23:22:56 -0800 (PST)
Received: from eugen-station.. (unknown [82.76.24.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ehristev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B19DF6600869;
        Thu, 19 Jan 2023 07:22:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674112975;
        bh=ejq+B7e6fIb0A7GSPRtAKPlAxXdt8t4wg9hHr/BbD+I=;
        h=From:To:Cc:Subject:Date:From;
        b=Gh7qOhoGl/eO0ocx0hy8VqgxnBYbIrLj6iLK+tbpbMgnyStB0/YlLWv2bibRcaeD7
         FBW8/L4azCTnJWqulSBFSIrBY1Bt40JQKKnrqJNbEzeaJ+paY890S7i2OhmHvma3mV
         jCEaXUdM73hJluZEnBAH9A56T+8G6MErZRnMJWfcvVxzDB7ulSKC4G/j8uwPLJKo4A
         IEwuQndzRU6ltAvd1u8ePtmM2fVhZDsyYj3AIyNMwCcuey72yOJdkyU8RTuR5kXH31
         Cee0LobxhZHsFzfbwCBQWd4ge0clLWDVqdRJG+6UvF/NXGg5DuRoyIKxUEFP1dnmNI
         faJVKZLz+wFlQ==
From:   Eugen Hristev <eugen.hristev@collabora.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH] .mailmap: update e-mail address for Eugen Hristev
Date:   Thu, 19 Jan 2023 09:22:29 +0200
Message-Id: <20230119072229.99603-1-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update e-mail address.

Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 8deff4cec169..79e0d680c748 100644
--- a/.mailmap
+++ b/.mailmap
@@ -130,6 +130,7 @@ Domen Puncer <domen@coderock.org>
 Douglas Gilbert <dougg@torque.net>
 Ed L. Cashin <ecashin@coraid.com>
 Erik Kaneda <erik.kaneda@intel.com> <erik.schmauss@intel.com>
+Eugen Hristev <eugen.hristev@collabora.com> <eugen.hristev@microchip.com>
 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> <ezequiel@collabora.com>
 Felipe W Damasio <felipewd@terra.com.br>
-- 
2.34.1

