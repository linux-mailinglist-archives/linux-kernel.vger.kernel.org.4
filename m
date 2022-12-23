Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DB6654C26
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 06:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiLWFIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 00:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiLWFIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 00:08:16 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E8C12AF7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 21:08:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C9222CE1B8B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 05:08:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96975C433EF;
        Fri, 23 Dec 2022 05:08:10 +0000 (UTC)
Date:   Fri, 23 Dec 2022 00:08:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jianlin Lv <iecedge@gmail.com>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        alison.schofield@intel.com, davidgow@google.com,
        thunder.leizhen@huawei.com, jianlv@ebay.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracepoint: Allow livepatch module add trace event
Message-ID: <20221223000808.0f4df11b@rorschach.local.home>
In-Reply-To: <CAFA-uR_Bhc8fdBXajKzSSXQ1Cf_iLirK0gS+TovPM9G7MLv=dg@mail.gmail.com>
References: <20221102160236.11696-1-iecedge@gmail.com>
        <20221114122255.72588f45@gandalf.local.home>
        <CAFA-uR8TakkW=KoA_9RXcyw00Zj8+nNn2erSZ4Y9ULNM8ne11g@mail.gmail.com>
        <20221114220216.05dd0541@gandalf.local.home>
        <20221116000707.a8a692e377d8daaf3764ee64@kernel.org>
        <20221115101837.37da9d1e@gandalf.local.home>
        <CAFA-uR_Bhc8fdBXajKzSSXQ1Cf_iLirK0gS+TovPM9G7MLv=dg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Dec 2022 12:52:18 +0800
Jianlin Lv <iecedge@gmail.com> wrote:

> hi, Steve
> Any other comments for code changes?
> Is it possible for this patch to be merged?

Ah, I had it marked as waiting for a reply. But I think we got side
tracked on the discussion.

Anyway, this is a trivial patch, I think I can get it in during -rc1.

-- Steve
