Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F27066A917
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 05:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjANEEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 23:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjANEEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 23:04:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9738D
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 20:04:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E1AFB821EE
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 04:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B906C433EF;
        Sat, 14 Jan 2023 04:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1673669037;
        bh=UZwgVXisZsP1kdZEKmT413M6we7bfvA5XgSZeTKv2fg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gm4K8b70c+yUircpvvOk2J8fIiu7cALtwf6ljmjm5TJCMD1OYIUAV4aHHmGQtQLf9
         anss7KaVpmxF4T+Hl3b9GDfbVVMUjyRJzvFcEyI5B29BKSh2SsNZbQwWjwutDNvtxB
         VvpLwBHjpo5RxhuRl7F9vK5rrcmwO0FVW2dr7Mw0=
Date:   Fri, 13 Jan 2023 20:03:56 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Cc:     gregkh@linuxfoundation.org, jan.kiszka@siemens.com,
        kbingham@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mingo@redhat.com, rppt@kernel.org,
        vbabka@suse.cz, x86@kernel.org
Subject: Re: [PATCH v5] scripts/gdb: add mm introspection utils
Message-Id: <20230113200356.d30a23872521f0cf24ed996c@linux-foundation.org>
In-Reply-To: <20230113175151.22278-1-dmitrii.bundin.a@gmail.com>
References: <Y8Bqg3vbQK53EtlH@kroah.com>
        <20230113175151.22278-1-dmitrii.bundin.a@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jan 2023 20:51:51 +0300 Dmitrii Bundin <dmitrii.bundin.a@gmail.com> wrote:

> Changes in v5: https://lore.kernel.org/all/20230102171014.31408-1-dmitrii.bundin.a@gmail.com/
>     - Added SPDX line

Almost.

--- a/scripts/gdb/linux/mm.py~scripts-gdb-add-mm-introspection-utils-v5
+++ a/scripts/gdb/linux/mm.py
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
 #
 # gdb helper commands and functions for Linux kernel debugging
 #
@@ -6,8 +7,6 @@
 # Authors:
 #  Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
 #
-# This work is licensed under the terms of the GNU GPL version 2.
-#
 
 import gdb
 
--- a/scripts/gdb/vmlinux-gdb.py~scripts-gdb-add-mm-introspection-utils-v5
+++ a/scripts/gdb/vmlinux-gdb.py
@@ -37,3 +37,4 @@ else:
     import linux.clk
     import linux.genpd
     import linux.device
+    import linux.mm
_

