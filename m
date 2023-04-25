Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F9A6EE71E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 19:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbjDYRus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 13:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbjDYRuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 13:50:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98743AD0F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 10:50:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3326C60DF3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 17:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3533C433D2;
        Tue, 25 Apr 2023 17:50:43 +0000 (UTC)
Date:   Tue, 25 Apr 2023 13:50:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv3] seq_buf: add seq_buf_do_printk() helper
Message-ID: <20230425135042.3c75591a@gandalf.local.home>
In-Reply-To: <CAJD7tkZf-TfRdXiVHwBBYw8PuptpfmzeKFGmDzB0mGnTYURrrA@mail.gmail.com>
References: <20230415100110.1419872-1-senozhatsky@chromium.org>
        <CAJD7tkZf-TfRdXiVHwBBYw8PuptpfmzeKFGmDzB0mGnTYURrrA@mail.gmail.com>
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

On Tue, 25 Apr 2023 06:14:33 -0700
Yosry Ahmed <yosryahmed@google.com> wrote:


> Hey Steven,
> 
> Is there a chance this patch makes it in the next merge window? It
> would be convenient to have it in Linus's tree so that we can send
> patches using the new helper. I am assuming there is no risk involved
> in merging an unused helper (but I can easily be wrong :)).

Yeah, the merge window opened quicker than I expected. I don't think this
would be a problem to pull in. It's not high risk.

-- Steve

