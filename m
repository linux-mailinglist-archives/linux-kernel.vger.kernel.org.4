Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD0B6BA100
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 21:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjCNUuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 16:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCNUuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 16:50:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D570234E2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 13:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3543D619B3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 20:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08555C433D2;
        Tue, 14 Mar 2023 20:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1678827016;
        bh=JHk46x/emWmmAKUThmzmIVufAq99SXDmf5ZDhxE/9mc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0SIVS/u6wVyRyw6Lwatl8bMnv26kL+zMtvY6e14V6EvXSQk7C0y2qB0gcuxBhphed
         VPyZNC2dsAGHcvN+a2apHUp9E8LF6PxLD8qwnInNr9tLbSso0NA9EmOf8tdx73NZoe
         2111uNsRw+jbzo8J2VmIcJ1Pbtp197xVJDm3DFp8=
Date:   Tue, 14 Mar 2023 13:50:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        bhe@redhat.com, pmladek@suse.com, xiyou.wangcong@gmail.com,
        dmitry.osipenko@collabora.com, rafael.j.wysocki@intel.com,
        bigeasy@linutronix.de, valentin.schneider@arm.com,
        kernel-dev@igalia.com, kernel@gpiccoli.net,
        Arjan van de Ven <arjan@linux.intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Xiaoming Ni <nixiaoming@huawei.com>
Subject: Re: [PATCH v4] notifiers: Add tracepoints to the notifiers
 infrastructure
Message-Id: <20230314135015.789369cd9f71b39a5b7eb291@linux-foundation.org>
In-Reply-To: <20230314200058.1326909-1-gpiccoli@igalia.com>
References: <20230314200058.1326909-1-gpiccoli@igalia.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2023 17:00:58 -0300 "Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:

>  include/trace/events/notifiers.h | 69 ++++++++++++++++++++++++++++++++
>  kernel/notifier.c                |  6 +++

Perhaps the filenames should match, which means "notifier.h".
