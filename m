Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA644613304
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiJaJso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiJaJsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:48:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D730FD57
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 02:48:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7394A60FA9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F4AC433D6;
        Mon, 31 Oct 2022 09:48:39 +0000 (UTC)
Date:   Mon, 31 Oct 2022 05:48:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION 6.0.x / 6.1.x] NULL dereferencing at tracing
Message-ID: <20221031054837.3a101e75@rorschach.local.home>
In-Reply-To: <87h6zklb6n.wl-tiwai@suse.de>
References: <87h6zklb6n.wl-tiwai@suse.de>
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

On Mon, 31 Oct 2022 08:11:28 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> Hi Steven,
> 
> we've got a bug report indicating the NULL dereference at the recent
> tracing changes, showing at the start of KDE.  The details including
> the dmesg are found at:
>   https://bugzilla.opensuse.org/show_bug.cgi?id=1204705
> 
> It was reported at first for 6.0.3, and confirmed that the problem
> persists with 6.1-rc, too.
> 
> The culprit seems to be the commit
> f3ddb74ad0790030c9592229fb14d8c451f4e9a8
>     tracing: Wake up ring buffer waiters on closing of the file
> and reverting it seems fixing the problem.
> 
> Could you take a look?
> 

Thanks for the report, can you send me your .config.

Thanks!

-- Steve
