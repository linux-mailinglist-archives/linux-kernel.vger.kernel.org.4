Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92326648F1E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 15:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiLJOHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 09:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiLJOGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 09:06:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D689018391
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 06:03:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A727609FA
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 14:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78BAC433EF;
        Sat, 10 Dec 2022 14:03:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1p40SG-000l3U-2c;
        Sat, 10 Dec 2022 09:03:52 -0500
Message-ID: <20221210140320.609495935@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 10 Dec 2022 09:03:20 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/3] probes: Updates for 6.2
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes/for-next

Head SHA1: 0c76ef3f26d5ef2ac2c21b47e7620cff35809fbb


Li Hua (1):
      test_kprobes: Fix implicit declaration error of test_kprobes

Li Huafei (1):
      kprobes: Fix check for probe enabled in kill_kprobe()

Steven Rostedt (Google) (1):
      tracing: Fix race where eprobes can be called before the event

----
 kernel/kprobes.c            | 16 ++++++++--------
 kernel/trace/trace_eprobe.c |  3 +++
 lib/Kconfig.debug           |  1 +
 3 files changed, 12 insertions(+), 8 deletions(-)
