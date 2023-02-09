Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F090690101
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 08:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjBIHPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 02:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjBIHON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:14:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E9C7D83;
        Wed,  8 Feb 2023 23:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=huJh30wXrIqcWBSOL1vocAnzpHcHtfTmbim5FCg9IpA=; b=lJq7j5YqUET9eJdZtTqrFsznU/
        vdsyOfi0DwS+OyPkwegVlr0r2aVGUySL2cgWdHWQcXIgV2bxWZsI4k6/rqxCEmchsuZDMzg9+Mrzo
        ZsGToekOMizRfRpRwQmGqTWbw8i1/hcJweEG7j60Ts3CDqnzQoKp4SDk2NaE9jNHa1YbMGzeZEAid
        fh089bDEfcFfl3ihYr4X+xYdIpcVHSJ1YN/MBbWOgsniy6FLIQIxsBzxUgn7ebtGq7Pk3JeznnuNb
        9Z5F6GXDCjVzp5SNvSYE+MlgcgbYN09uaryu8j6LhHBVZjjhFPsf1Yeg5OhbgucCb35+L+KOd2VTs
        +XjvU/CA==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQ18G-000LPt-3V; Thu, 09 Feb 2023 07:14:12 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 18/24] Documentation: timers: correct spelling
Date:   Wed,  8 Feb 2023 23:13:54 -0800
Message-Id: <20230209071400.31476-19-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209071400.31476-1-rdunlap@infradead.org>
References: <20230209071400.31476-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spelling problems for Documentation/timers/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/timers/hrtimers.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/Documentation/timers/hrtimers.rst b/Documentation/timers/hrtimers.rst
--- a/Documentation/timers/hrtimers.rst
+++ b/Documentation/timers/hrtimers.rst
@@ -148,7 +148,7 @@ a given clock has - be it low-res, high-
 hrtimers - testing and verification
 -----------------------------------
 
-We used the high-resolution clock subsystem ontop of hrtimers to verify
+We used the high-resolution clock subsystem on top of hrtimers to verify
 the hrtimer implementation details in praxis, and we also ran the posix
 timer tests in order to ensure specification compliance. We also ran
 tests on low-resolution clocks.
