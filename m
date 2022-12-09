Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA4D6489BF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 21:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiLIU5X convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 9 Dec 2022 15:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiLIU5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 15:57:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33163A848C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 12:57:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E648EB828CF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 20:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F44BC433D2;
        Fri,  9 Dec 2022 20:57:15 +0000 (UTC)
Date:   Fri, 9 Dec 2022 15:57:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Gautam Menghani <gautammenghani201@gmail.com>
Cc:     mhiramat@kernel.org, akpm@linux-foundation.org,
        shy828301@gmail.com, zokeefe@google.com, vbabka@suse.cz,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm/khugepaged: add tracepoint to collapse_file()
Message-ID: <20221209155713.1ea9c199@gandalf.local.home>
In-Reply-To: <20221202201807.182829-1-gautammenghani201@gmail.com>
References: <20221202201807.182829-1-gautammenghani201@gmail.com>
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

On Sat,  3 Dec 2022 01:48:07 +0530
Gautam Menghani <gautammenghani201@gmail.com> wrote:

> Currently, is_shmem is not being captured. Capturing is_shmem is useful 
> as it can indicate if tmpfs is being used as a backing store instead of 
> persistent storage. Add the tracepoint in collapse_file() named 
> "mm_khugepaged_collapse_file" for capturing is_shmem.
> 
> Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
> ---

From a tracing point of view:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
