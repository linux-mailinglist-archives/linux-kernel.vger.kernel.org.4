Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669436030E2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJRQlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJRQla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:41:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C83AE8C4C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:41:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49D9A61633
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 16:41:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B749CC433C1;
        Tue, 18 Oct 2022 16:41:26 +0000 (UTC)
Date:   Tue, 18 Oct 2022 12:41:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/7] mm: vmap: Add alloc_vmap_area trace event
Message-ID: <20221018124127.2c5adf45@gandalf.local.home>
In-Reply-To: <20221017160233.16582-2-urezki@gmail.com>
References: <20221017160233.16582-1-urezki@gmail.com>
        <20221017160233.16582-2-urezki@gmail.com>
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

On Mon, 17 Oct 2022 18:02:25 +0200
"Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:

> It is for a debug purpose and for validation of passed parameters.
> 
> To: Steven Rostedt <rostedt@goodmis.org>

FYI, it's "Cc:" not "To:" as I did not receive this email (nor patches 2 or 3).

> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

-- Steve
