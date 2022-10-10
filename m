Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614575FA632
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJJUaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiJJU3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:29:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17B5140CE
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 13:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3DqQXJCCi6a0pdKCJkN/56qZdQ1tlN+/58wkHRl8e6c=; b=l5ikvtwLpF/QEIOI+DuuJHxSqV
        GaCo0GGurYGvbSvAAUfzFMkb+Wj2rR+1h1khXTxyXuNIeGOfVoJ9UjKwC89yXeprxYcg1Wl7iKJb2
        YbfU08L4gZWUA7jWICZVUbsCM3wZZECLLp/oaOoNM3PqKyBzca8i0vGCoByncHyD94D98oxKhfRs7
        0sZMbKqjxBc0TGe75AlWvZS/Hu45gLs4bN6JtoEu5pNMvqrPqgZQ7tzK5IZR9b36mHUzuWsh17vKx
        42qLQsrWQMbYA8xEMbcAJlcEairUZzwu3/Uo2wQdbBpiaVgb/pH/hXSxIB8JSlo4ic8/QyuWR5Qac
        xOw6LWOQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ohzNX-004TVR-EO; Mon, 10 Oct 2022 20:28:01 +0000
Date:   Mon, 10 Oct 2022 21:27:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Chen <harperchen1110@gmail.com>
Cc:     vbabka@suse.cz, hughd@google.com, dhowells@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: kernel BUG in page_try_dup_anon_rmap
Message-ID: <Y0SAT5grkUmUW045@casper.infradead.org>
References: <CAO4mrfdLMXsao9RF4fUE8-Wfde8xmjsKrTNMNC9wjUb6JudD0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO4mrfdLMXsao9RF4fUE8-Wfde8xmjsKrTNMNC9wjUb6JudD0g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 08:25:58PM +0800, Wei Chen wrote:
> Dear Linux Developer,
> 
> Recently when using our tool to fuzz kernel, the following crash was triggered:

We don't need more people running syzkaller.  We need more people
investigating syzkaller reports.
