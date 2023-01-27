Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E8267DD95
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 07:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjA0Gk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 01:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjA0GkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 01:40:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF76D69533;
        Thu, 26 Jan 2023 22:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MhFrf85hQtqD5mQa4ZU2zg8z1KkDk1n+Nd8Z/FzHqwQ=; b=EL7ZOMgaw2vpy3e9tHD33iKdHA
        YX+D4u4BH83oeMQOatOHb/Uved2fAD7gLjfH6xVstAWMeOAXnYrnLb7qmp8sw8A3m3PNWK6sWdUPS
        V1/RSDeICT3hkVd+gNO+oJvz2603CFO3IPEKOYtgjs4hKs8lQZ3ZBrI96geJAWZLx5aZm6rOJrofY
        Hl4G7J0F/dLOhStQuTG2jIH4a5w+EHjnFBdFXiL/YINc0sGmiOuLRxa6JbGFnerVCEf/DCC1KjQXh
        9a0+cT54PA/47BLXv0czKBQzOeDY1f7dSViUP6EZyBm7l8xVWbFRSMxAFDA/cicBsl9sNJWjnogVd
        2SgEBAOw==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLIPE-00DM0u-6d; Fri, 27 Jan 2023 06:40:12 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 06/35] Documentation: fault-injection: correct spelling
Date:   Thu, 26 Jan 2023 22:39:36 -0800
Message-Id: <20230127064005.1558-7-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127064005.1558-1-rdunlap@infradead.org>
References: <20230127064005.1558-1-rdunlap@infradead.org>
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

Correct spelling problems for Documentation/fault-injection/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/fault-injection/fault-injection.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/Documentation/fault-injection/fault-injection.rst b/Documentation/fault-injection/fault-injection.rst
--- a/Documentation/fault-injection/fault-injection.rst
+++ b/Documentation/fault-injection/fault-injection.rst
@@ -235,7 +235,7 @@ proc entries
 Error Injectable Functions
 --------------------------
 
-This part is for the kenrel developers considering to add a function to
+This part is for the kernel developers considering to add a function to
 ALLOW_ERROR_INJECTION() macro.
 
 Requirements for the Error Injectable Functions
