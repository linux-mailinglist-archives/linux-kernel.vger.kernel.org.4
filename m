Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AC971466D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 10:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjE2InW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 04:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjE2InP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 04:43:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10738B1;
        Mon, 29 May 2023 01:43:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 932066127C;
        Mon, 29 May 2023 08:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5773EC433EF;
        Mon, 29 May 2023 08:43:11 +0000 (UTC)
Date:   Mon, 29 May 2023 04:43:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        linux-doc@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        William White <chwhite@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH V2 0/9] rtla improvements
Message-ID: <20230529044307.2dcfca3d@rorschach.local.home>
In-Reply-To: <838075fb-8b82-1aee-97a1-95102c03c16d@kernel.org>
References: <cover.1684863094.git.bristot@kernel.org>
        <20230529042839.5d4af427@rorschach.local.home>
        <838075fb-8b82-1aee-97a1-95102c03c16d@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2023 10:38:16 +0200
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> On 5/29/23 10:28, Steven Rostedt wrote:
> > Hi Daniel,
> > 
> > Could you make sure to Cc linux-trace-kernel@vger.kernel.org and not
> > linux-trace-devel. The former is for any patch that goes into the
> > kernel repo, the later is for the tracing libraries (like libtracefs).
> > The reason why this matters is that the patchwork that is associated to
> > the Linux kernel tree will not get these (and I will not work on them
> > when I'm working on kernel patches). But it will go into the 
> > patchwork for the libraries (and never be processed by the patchwork
> > infrastructure), and I will likely not work on them, because when I
> > look at the library patchwork, I ignore anything that goes into the
> > kernel.  
> 
> Sure, I will do that. IIRC, we agreed that we would use linux-trace-devel for
> rtla because it is a user-space tool. But I agree with you, as they are patches
> going to the kernel repo, linux-trace-kernel is a better place. It is easier to
> myself too... :-).

I think we agreed on that because linux-trace-kernel didn't exist yet ;-)

> 
> > 
> > Perhaps resend with the proper Cc and it will then be processed. I
> > allowed this to happen before, but that's because I did everything
> > manually and not with my scripts. And I'm tired of doing that.  
> 
> I will do that in the v3.
> 
> I will also update the maintainers entry for RTLA and RV, as both are pointing to
> linux-trace-devel.

I already sent the patch!

-- Steve
