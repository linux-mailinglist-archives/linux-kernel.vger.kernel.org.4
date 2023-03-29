Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0266CF56A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 23:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjC2Vb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 17:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC2Vb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 17:31:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7DF1725
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 14:31:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18DCCB8233D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 21:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DAF7C433D2;
        Wed, 29 Mar 2023 21:31:53 +0000 (UTC)
Date:   Wed, 29 Mar 2023 17:31:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [BUG v6.3-rc4+] WARNING: CPU: 0 PID: 1 at
 drivers/thermal/thermal_sysfs.c:879 cooling_device_stats_setup+0xac/0xc0
Message-ID: <20230329173151.1ac16688@gandalf.local.home>
In-Reply-To: <20230329165944.39ba9342@gandalf.local.home>
References: <20230329165819.50ce6ab1@gandalf.local.home>
        <20230329165944.39ba9342@gandalf.local.home>
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

On Wed, 29 Mar 2023 16:59:44 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> The bug happened on this commit, from Linus's tree:
> 
>   fcd476ea6a888ef6e6627f4c21a2ea8cca3e9312

Heh, and I forgot to update Linus's latest for today.

  ffe78bbd512166e0ef1cc4858010b128c510ed7d

which has the other fix I was going to test.

But I still don't see anything that would prevent the bug I reported.

-- Steve
