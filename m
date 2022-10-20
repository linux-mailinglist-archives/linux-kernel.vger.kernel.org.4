Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F84B6064DB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiJTPns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJTPnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:43:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BAC1B90DE
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:43:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F8C861C2C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 15:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01027C433D6;
        Thu, 20 Oct 2022 15:43:43 +0000 (UTC)
Date:   Thu, 20 Oct 2022 11:43:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     chensong <chensong_2000@189.cn>
Cc:     mingo@redhat.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, xiehuan09@gmail.com
Subject: Re: [PATCH] trace/ring_buffer: remove unused arguments
Message-ID: <20221020114348.40fe9644@gandalf.local.home>
In-Reply-To: <e3547bc8-3acf-187c-1671-f5274112d01c@189.cn>
References: <1666274811-24138-1-git-send-email-chensong_2000@189.cn>
        <20221020101549.06e3fa5b@gandalf.local.home>
        <e3547bc8-3acf-187c-1671-f5274112d01c@189.cn>
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

On Thu, 20 Oct 2022 23:25:56 +0800
chensong <chensong_2000@189.cn> wrote:

> > I guess this doesn't hurt.
> 
> I was reading __kprobe_trace_func, store_trace_args stores args in 
> fbuffer.entry,which is event->array, but at the end, rb_commit uses 
> fbuffer.buffer instead of event.
> 
> Then i thought, if it's useless, why not just clean it up.


I meant your change probably doesn't hurt.

-- Steve
