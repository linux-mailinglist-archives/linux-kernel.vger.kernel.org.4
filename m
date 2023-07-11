Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A937974E715
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 08:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjGKGT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 02:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjGKGT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 02:19:58 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB70E49;
        Mon, 10 Jul 2023 23:19:57 -0700 (PDT)
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qJ6j5-0000FA-K7; Tue, 11 Jul 2023 08:19:55 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] docs: stable-kernel-rules: add delayed backporting option and a few tweaks
Date:   Tue, 11 Jul 2023 08:19:52 +0200
Message-Id: <cover.1689056247.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1689056397;0c99b682;
X-HE-SMSGID: 1qJ6j5-0000FA-K7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I only set down to create the first of the two patches. But while
doing so I noticed a few things that seemed odd for me with my
background on writing and editing texts. So I just quickly performed a
few additional changes to fix those to see if the stable team would
appreciate them, as this document is clearly their domain.

v2:
[this mail]
* a few small tweaks after feedback from v1 submission
* drop patch 3 for now
* drop RFC

v1:
https://lore.kernel.org/linux-doc/d30686781c47c83927e0a41f6a1167a679fa822c.1689008220.git.linux@leemhuis.info/

Thorsten Leemhuis (2):
  docs: stable-kernel-rules: mention other usages for stable tag
    comments
  docs: stable-kernel-rules: make rule section more straight forward

 Documentation/process/stable-kernel-rules.rst | 60 ++++++++++++-------
 1 file changed, 37 insertions(+), 23 deletions(-)


base-commit: 016571b6d52deb473676fb4d24baf8ed3667ae21
-- 
2.40.1

