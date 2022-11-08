Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C377621CD5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 20:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiKHTRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 14:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKHTRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 14:17:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6048E657DC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 11:17:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE18C61759
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 19:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84D8C433C1;
        Tue,  8 Nov 2022 19:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1667935037;
        bh=IOGGBG2KKU3FgHyMTtoLjrv0y/3JSmrgNo/jR8VNoqY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=njxm4tQJDF9sxeyCUusNykHkXINE3VijYzT8u/lswfoqQ1ncwv9IdWUrmoC4uAI/4
         4X9Onrxtt0Zpfj/5SZ61MDCjHqs8UcvN3zWlQfTahUIn4kq+b8A4kTZ4IMMu+Yl5BD
         VNN+Bg/562YoTL8ISkZSAerLANt0e3l30LewGPP0=
Date:   Tue, 8 Nov 2022 11:17:16 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rustam Kovhaev <rkovhaev@gmail.com>
Subject: Re: Deprecating and removing SLOB
Message-Id: <20221108111716.4b8c9246152c2addc2329a8f@linux-foundation.org>
In-Reply-To: <fae76c45-ba57-3646-b65b-b8f75e544a95@csgroup.eu>
References: <b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz>
        <fae76c45-ba57-3646-b65b-b8f75e544a95@csgroup.eu>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Nov 2022 18:18:46 +0000 Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> Mark them as dependent on CONFIG_BROKEN ?

For SLOB at least, yes.  Leave it a couple of cycles and unless someone
comes out with a really really really good reason for retaining, away
it goes.

