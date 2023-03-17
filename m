Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132566BF6B7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 00:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCQX7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 19:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCQX7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 19:59:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600AC77991
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 16:59:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3878C60B81
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 23:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C80CC433EF;
        Fri, 17 Mar 2023 23:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1679097546;
        bh=m6/a10CVnRU0DBLRiwVNu4MUaIUuwYZVNvRbzYhnpZ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FPsyJDFfTSUm3O8MS0sgG6du4oIaoVMYwrm0+V4kBhyekibpHRlAqdpu4UwWDpRem
         rd81GwY4ueWVBlJSlfRVF9+2KwSLV4dey1jbIweDOU/Cu/G7Jk4rTWu7WaGVUcsi6j
         PdRV76yi8fdf1nDNmUs0PNfQKhi+qZn3kLwmqSqM=
Date:   Fri, 17 Mar 2023 16:59:05 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 0/2] Refactor do_fault_around()
Message-Id: <20230317165905.f4f90b125e459617fa19a3d5@linux-foundation.org>
In-Reply-To: <98fc8545-6bd3-4c06-9b12-d781a19982ac@lucifer.local>
References: <cover.1679089214.git.lstoakes@gmail.com>
        <20230317163936.06d9c7d032a5c2296075caa1@linux-foundation.org>
        <98fc8545-6bd3-4c06-9b12-d781a19982ac@lucifer.local>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2023 23:48:17 +0000 Lorenzo Stoakes <lstoakes@gmail.com> wrote:

> I went so far as to literally copy/paste
> the existing code and my speculative change to a userland program, generate a
> whole host of random sensible input data and compare output data with this and
> the original logic en masse.

Ah, great, all good, thanks.
