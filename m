Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CEF702377
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 07:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjEOFr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 01:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjEOFr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 01:47:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F304C19BB;
        Sun, 14 May 2023 22:47:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 856C160FD2;
        Mon, 15 May 2023 05:47:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F72C433D2;
        Mon, 15 May 2023 05:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684129674;
        bh=0ywVD0h0HAaEfDZLu6C6HFAK9ShsZX/dTJGTGShPoIk=;
        h=From:To:Cc:Subject:Date:From;
        b=LQLjcsL+6+3NWKZ1Xd7l2d2G4WK5AX4sbC2gsrmytvYp1MJdPvamuNKKPNLPTWl68
         7v75eokacePFbT4tl/fPvfn/M0+YMT39sRwbj6kx1kkUmGu3c6JLicQ5zAnW0tTGX0
         RrCDPgjy5H4rdaO1wa2iLRfbTBZl/dsRww79jP3V3nE6bpVFJdtfz26MvKWGUBJX2E
         nTY9UNFecaxiUj8ceIHhi1sLkVs8vmwTJNL9uPh+mFpHXhEwZ7B/t2h5720mkFYDmr
         zuX3Uu/7t2mFslV2BdcHr6CmH9bTSPmfCfYAZxKTWP+7VqHkHe6TRZAZqBmei+LAtp
         QrGKD3ABRQhLA==
Received: from mchehab by mail.kernel.org with local (Exim 4.96)
        (envelope-from <mchehab@kernel.org>)
        id 1pyR3n-003HqO-1o;
        Mon, 15 May 2023 06:47:51 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Media Mailing list <linux-media@vger.kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Athanasios Oikonomou <athoik@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH] docs: uapi: media: ignore new DVB-S2X FEC values
Date:   Mon, 15 May 2023 06:47:37 +0100
Message-Id: <20230515054737.783558-1-mchehab@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some new FEC values was added to support DVB-S2X. They're properly
documented, but its addition adds some extra warnings to htmldocs
build. So, add them to the ignore list.

Fixes: 1825788e2a96 ("media: dvb: add missing DVB-S2X FEC parameter values")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 Documentation/userspace-api/media/frontend.h.rst.exceptions | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/userspace-api/media/frontend.h.rst.exceptions b/Documentation/userspace-api/media/frontend.h.rst.exceptions
index 8b73fee11a79..dcaf5740de7e 100644
--- a/Documentation/userspace-api/media/frontend.h.rst.exceptions
+++ b/Documentation/userspace-api/media/frontend.h.rst.exceptions
@@ -142,6 +142,10 @@ ignore symbol FEC_26_45
 ignore symbol FEC_28_45
 ignore symbol FEC_32_45
 ignore symbol FEC_77_90
+ignore symbol FEC_11_45
+ignore symbol FEC_4_15
+ignore symbol FEC_14_45
+ignore symbol FEC_7_15
 
 ignore symbol TRANSMISSION_MODE_AUTO
 ignore symbol TRANSMISSION_MODE_1K
-- 
2.40.1

