Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080A66CF4EB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 22:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjC2U7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 16:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjC2U7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 16:59:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCC044B8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 13:59:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A12761E27
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 20:59:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4855AC433EF;
        Wed, 29 Mar 2023 20:59:46 +0000 (UTC)
Date:   Wed, 29 Mar 2023 16:59:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [BUG v6.3-rc4+] WARNING: CPU: 0 PID: 1 at
 drivers/thermal/thermal_sysfs.c:879 cooling_device_stats_setup+0xac/0xc0
Message-ID: <20230329165944.39ba9342@gandalf.local.home>
In-Reply-To: <20230329165819.50ce6ab1@gandalf.local.home>
References: <20230329165819.50ce6ab1@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 16:58:19 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> In preparation to adding my patch that checks for some kinds of bugs in
> trace events, I decided to run it on the Linus's latest branch, to see if
> there's any other trace events that may cause issues. But instead I hit
> this unrelated bug. Looks to be triggering an added lockdep_assert() on
> boot up.

The bug happened on this commit, from Linus's tree:

  fcd476ea6a888ef6e6627f4c21a2ea8cca3e9312

In case it was fixed after that.

-- Steve
