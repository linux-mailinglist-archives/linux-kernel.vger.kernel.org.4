Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA39603255
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiJRSXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiJRSXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:23:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165DB81693
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:23:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2999B820E6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 18:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861A7C433D6;
        Tue, 18 Oct 2022 18:23:01 +0000 (UTC)
Date:   Tue, 18 Oct 2022 14:23:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 0/7] Add basic trace events for vmap/vmalloc (v2)
Message-ID: <20221018142302.7af359f5@gandalf.local.home>
In-Reply-To: <20221018181053.434508-1-urezki@gmail.com>
References: <20221018181053.434508-1-urezki@gmail.com>
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

On Tue, 18 Oct 2022 20:10:46 +0200
"Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:

> Description is here https://lore.kernel.org/linux-mm/20221017160233.16582-1-urezki@gmail.com/

You should always copy the description in each version. It's annoying to
have to click a link from a console email client.

Anyway, it's pretty basic trace events.

For POV of tracing (not the usage of it)

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

for the entire series.

-- Steve

> 
> Changelog v1 -> v2:
> - Fix a compilation error for the ARCH=um SUBARCH=i386
> 
> Uladzislau Rezki (Sony) (7):
>   mm: vmalloc: Add alloc_vmap_area trace event
>   mm: vmalloc: Add purge_vmap_area_lazy trace event
>   mm: vmalloc: Add free_vmap_area_noflush trace event
>   mm: vmalloc: Use trace_alloc_vmap_area event
>   mm: vmalloc: Use trace_purge_vmap_area_lazy event
>   mm: vmalloc: Use trace_free_vmap_area_noflush event
>   vmalloc: Add reviewers for vmalloc code
> 
>  MAINTAINERS                    |  12 +++-
>  include/trace/events/vmalloc.h | 123 +++++++++++++++++++++++++++++++++
>  mm/vmalloc.c                   |  20 +++++-
>  3 files changed, 151 insertions(+), 4 deletions(-)
>  create mode 100644 include/trace/events/vmalloc.h
> 

