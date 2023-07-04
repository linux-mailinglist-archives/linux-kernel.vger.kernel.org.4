Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEA57476E8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjGDQje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjGDQj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:39:29 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAEAE6E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 09:39:26 -0700 (PDT)
Received: from i53875a33.versanet.de ([83.135.90.51] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qGj3k-0005wg-08; Tue, 04 Jul 2023 18:39:24 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH 0/2] Update .mailmap for my work address and fix manpage
Date:   Tue,  4 Jul 2023 18:39:17 +0200
Message-Id: <20230704163919.1136784-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

While updating mailmap for the going-away address, I also found that
on current systems the manpage linked from the header comment changed.

And in fact it looks like the git mailmap feature got its own manpage.


Heiko Stuebner (2):
  mailmap: Update manpage link
  mailmap: add entries for Heiko Stuebner

 .mailmap | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.39.2

