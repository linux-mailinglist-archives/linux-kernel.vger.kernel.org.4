Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3FA67DDE0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 07:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbjA0GlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 01:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjA0GkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 01:40:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8286A69B0A;
        Thu, 26 Jan 2023 22:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=hd5ZNZ7jQzR1kwVwrva/Ej8afUh2zlSDJoudEybauYc=; b=BbbyWUqjfafFGuibK5DNs3k2ZL
        H5y5bXzeudJL4z0W/FYDnwN06hSvyR5n4PfL+AkBiUaYOfgfFYAS9ogQa0cxJlfAXsIR0JUgtutER
        RRhjjPavMex3ppPHgLOfrfXxuI1fJ5gOooziNCAMdDTw93XvhcddUNj0VRsKV8/K8fqLOEvLZJ7by
        uLyFYxW/R3cvSHTy/71Lj8Q4k4HGDz5l8UpLV6xi+zsWtU5IS9Jc58b6p7JlmNs1+xQrb2XMlHwSh
        hJWK1qKsLL2sQ0SeTpqyDLULTgJZW8QJFPABQGco2QbH/j9d19iVNDGkJHtnYoBz+00wkgUJbkdgn
        QT9OL6YA==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLIPL-00DM0u-Uz; Fri, 27 Jan 2023 06:40:20 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH 22/35] Documentation: power: correct spelling
Date:   Thu, 26 Jan 2023 22:39:51 -0800
Message-Id: <20230127064005.1558-22-rdunlap@infradead.org>
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

Correct spelling problems for Documentation/power/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/power/suspend-and-interrupts.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/Documentation/power/suspend-and-interrupts.rst b/Documentation/power/suspend-and-interrupts.rst
--- a/Documentation/power/suspend-and-interrupts.rst
+++ b/Documentation/power/suspend-and-interrupts.rst
@@ -67,7 +67,7 @@ That may involve turning on a special si
 during system sleep so as to trigger a system wakeup when needed.  For example,
 the platform may include a dedicated interrupt controller used specifically for
 handling system wakeup events.  Then, if a given interrupt line is supposed to
-wake up the system from sleep sates, the corresponding input of that interrupt
+wake up the system from sleep states, the corresponding input of that interrupt
 controller needs to be enabled to receive signals from the line in question.
 After wakeup, it generally is better to disable that input to prevent the
 dedicated controller from triggering interrupts unnecessarily.
