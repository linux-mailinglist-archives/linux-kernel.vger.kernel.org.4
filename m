Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB8C74DBFF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjGJRKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjGJRKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:10:20 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DFED7;
        Mon, 10 Jul 2023 10:10:18 -0700 (PDT)
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qIuOt-0006Iv-7K; Mon, 10 Jul 2023 19:10:15 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [RFC PATCH v1 0/3] docs: stable-kernel-rules: add delayed backporting option and a few tweaks
Date:   Mon, 10 Jul 2023 19:10:10 +0200
Message-Id: <cover.1689008220.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1689009018;df12a5bf;
X-HE-SMSGID: 1qIuOt-0006Iv-7K
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a RFC and a bit rough for now. I only set down to create the
first of the three patches. But while doing so I noticed a few things
that seemed odd for me with my background on writing and editing texts.
So I just quickly performed a few additional changes to fix those to see
if the stable team would appreciate them, as this document is clearly
their domain.

If those changes or even the initial patch are not welcomed, I'll simply
drop them. I'd totally understand this, as texts like these are delicate
and it's easy to accidentlly change the intent or the meaning while
adjusting things in good faith.

At the same time I might be willing to do a few more changes, if people
like the direction this takes and want a bit more fine tuning.

CC: Greg KH <gregkh@linuxfoundation.org>
CC: Sasha Levin <sashal@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>

Thorsten Leemhuis (3):
  docs: stable-kernel-rules: mention other usages for stable tag
    comments
  docs: stable-kernel-rules: make rule section more straight forward
  docs: stable-kernel-rules: improve structure to optimize reading flow

 Documentation/process/stable-kernel-rules.rst | 189 ++++++++++--------
 1 file changed, 105 insertions(+), 84 deletions(-)


base-commit: 016571b6d52deb473676fb4d24baf8ed3667ae21
-- 
2.40.1

