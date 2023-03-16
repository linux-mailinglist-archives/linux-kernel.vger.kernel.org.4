Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FF96BD19E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjCPN5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCPN5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:57:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED583B3E2A;
        Thu, 16 Mar 2023 06:57:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8714762049;
        Thu, 16 Mar 2023 13:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0301CC4339B;
        Thu, 16 Mar 2023 13:57:49 +0000 (UTC)
Date:   Thu, 16 Mar 2023 09:57:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@elte.hu>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Mike Rapoport <mike.rapoport@gmail.com>
Subject: Re: [PATCH] ring-buffer: remove obsolete comment for
 free_buffer_page()
Message-ID: <20230316095748.0b93bfc5@gandalf.local.home>
In-Reply-To: <c5d9c8b4-663c-c00f-438b-f104e1228ef7@suse.cz>
References: <20230315142446.27040-1-vbabka@suse.cz>
        <72de48c7-014d-80ac-51e9-ba22450f1d5b@quicinc.com>
        <1cb12058-f59e-1433-6ba6-f500be250996@quicinc.com>
        <c5d9c8b4-663c-c00f-438b-f104e1228ef7@suse.cz>
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

On Thu, 16 Mar 2023 09:29:30 +0100
Vlastimil Babka <vbabka@suse.cz> wrote:

> On 3/15/23 16:53, Mukesh Ojha wrote:
> > 
> > 
> > On 3/15/2023 9:21 PM, Mukesh Ojha wrote:  
> >> 
> >> 
> >> On 3/15/2023 7:54 PM, Vlastimil Babka wrote:  
> >>> The comment refers to mm/slob.o which is being removed. It comes from  
> > 
> > nit: mm/slob.c  
> 
> Thanks, Steven can you fix that up while picking the patch, or need v2?

I'll fix it up.

-- Steve
