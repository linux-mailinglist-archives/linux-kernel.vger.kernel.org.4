Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18A1690108
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 08:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjBIHPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 02:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBIHOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:14:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0E441B57;
        Wed,  8 Feb 2023 23:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=RYo/EQQ1egA2iZvGckezR1l+gcipaQNMwSxKiMmzRqU=; b=VxwpDNHtPRR/iBAkJ8q0RXA4Ti
        aIhno8DVR7555c9vxaGsUDC7WwXkgPF3DcSvWNnidL6GSzj8ISYNao9jdOcjQBeMA9FQ7i0Z9EoSR
        m1scgpVQLRgQx6rRkOGpC2LETrn7R5+pMFx5Y5q55Ne2kcTmcii7Qj8prjFtBKK9Yh0kg0XPJKxXx
        JDWmxqSLwwT97Ghd2a1k8SC4RUBJrOkl2lPAfcw6ZqWbDGJwT8FO5bD/w4fhYS5aGEFIYZv3+qwuj
        2hA+zpDOitcB+FkkNHFR2a8OJyPUh8teoAs0YJuE/+OGUx2oyQLVRrNvIikMm/WcUZVYCUAa8oscQ
        z3nDRS2w==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQ18G-000LPt-Sf; Thu, 09 Feb 2023 07:14:12 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 20/24] Documentation: trace/rv: correct spelling
Date:   Wed,  8 Feb 2023 23:13:56 -0800
Message-Id: <20230209071400.31476-21-rdunlap@infradead.org>
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

Correct spelling problems for Documentation/trace/rv/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/trace/rv/runtime-verification.rst             |    2 +-

diff -- a/Documentation/trace/rv/runtime-verification.rst b/Documentation/trace/rv/runtime-verification.rst
--- a/Documentation/trace/rv/runtime-verification.rst
+++ b/Documentation/trace/rv/runtime-verification.rst
@@ -31,7 +31,7 @@ In Linux terms, the runtime verification
 *RV monitor* abstraction. A *RV monitor* includes a reference model of the
 system, a set of instances of the monitor (per-cpu monitor, per-task monitor,
 and so on), and the helper functions that glue the monitor to the system via
-trace, as depicted bellow::
+trace, as depicted below::
 
  Linux   +---- RV Monitor ----------------------------------+ Formal
   Realm  |                                                  |  Realm
