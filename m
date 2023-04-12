Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A83A6DE99D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 04:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjDLCq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 22:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDLCq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 22:46:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8641103
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 19:46:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E5A460FFC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 02:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD51C433D2;
        Wed, 12 Apr 2023 02:46:54 +0000 (UTC)
Date:   Tue, 11 Apr 2023 22:46:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] seq_buf: add seq_buf_do_printk() helper
Message-ID: <20230411224652.576dd18c@gandalf.local.home>
In-Reply-To: <20230411143852.868524-1-senozhatsky@chromium.org>
References: <20230411143852.868524-1-senozhatsky@chromium.org>
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

On Tue, 11 Apr 2023 23:38:52 +0900
Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> Sometimes we use seq_buf to format a string buffer, which
> we then pass to printk(). However, in certain situations
> the seq_buf string buffer can get too big, exceeding the
> PRINTKRB_RECORD_MAX bytes limit, and causing printk() to
> truncate the string.
> 
> Add a new seq_buf helper. This helper prints the seq_buf
> string buffer line by line, using \n as a delimiter,
> rather than passing the whole string buffer to printk()
> at once.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Looks good to me. Want me to pull this in my tree, or do you have
patches dependent on this?

-- Steve
