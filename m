Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D976283CC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbiKNPYK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Nov 2022 10:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236478AbiKNPYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:24:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E201A077
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:24:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32756B81055
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 15:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3DDC433D6;
        Mon, 14 Nov 2022 15:23:59 +0000 (UTC)
Date:   Mon, 14 Nov 2022 10:24:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Gautam Menghani <gautammenghani201@gmail.com>
Cc:     akpm@linux-foundation.org, mhiramat@kernel.org,
        shy828301@gmail.com, zokeefe@google.com, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: Refactor mm_khugepaged_scan_file
 tracepoint to remove filename from function call
Message-ID: <20221114102441.39e84671@gandalf.local.home>
In-Reply-To: <20221026044524.54793-1-gautammenghani201@gmail.com>
References: <20221026044524.54793-1-gautammenghani201@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2022 10:15:24 +0530
Gautam Menghani <gautammenghani201@gmail.com> wrote:

> Refactor the mm_khugepaged_scan_file tracepoint to move filename
> dereference to the tracepoint definition, for maintaing consistency with
> other tracepoints[1].
> 
> [1]:lore.kernel.org/lkml/20221024111621.3ba17e2c@gandalf.local.home/
> 
> Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
> ---
>  include/trace/events/huge_memory.h | 8 ++++----
>  mm/khugepaged.c                    | 3 +--
>  2 files changed, 5 insertions(+), 6 deletions(-)

From the tracing point of view:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
