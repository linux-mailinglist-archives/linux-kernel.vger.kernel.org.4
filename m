Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D610F64CDC5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 17:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238241AbiLNQPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 11:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237917AbiLNQPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:15:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAAD10B74
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:15:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF32161B23
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 16:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61845C433EF;
        Wed, 14 Dec 2022 16:15:47 +0000 (UTC)
Date:   Wed, 14 Dec 2022 11:15:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [for-next][PATCH 6/8] ftrace: Prevent RCU stall on
 PREEMPT_VOLUNTARY kernels
Message-ID: <20221214111544.01660987@gandalf.local.home>
In-Reply-To: <b95f7a3d-429a-3564-fc9e-fa05d1d551df@igalia.com>
References: <20221214140133.608431204@goodmis.org>
        <20221214140209.346584113@goodmis.org>
        <b95f7a3d-429a-3564-fc9e-fa05d1d551df@igalia.com>
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

On Wed, 14 Dec 2022 12:53:04 -0300
"Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:

> On 14/12/2022 11:01, Steven Rostedt wrote:
> > From: "gpiccoli@igalia.com" <gpiccoli@igalia.com>  
> 
> Hi Steve, would be possible to use my full name here, like: Guilherme G.
> Piccoli <gpiccoli@igalia.com> ?

Sure, I haven't pushed to the next repo yet.

I found the reason it didn't go into my patchwork, and did a resend via a
"redirect", and that must have changed the from address :-/

-- Steve
