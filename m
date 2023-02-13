Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2656953E0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 23:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjBMW37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 17:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBMW35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 17:29:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D196A1CF62;
        Mon, 13 Feb 2023 14:29:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 804F1B8191D;
        Mon, 13 Feb 2023 22:29:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF03C433EF;
        Mon, 13 Feb 2023 22:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1676327394;
        bh=QS01rGXzxLsyMl/Onj4q5vx1lOw5p8M4kU0goD8UXBY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hIdy+cN8f3xKEovIMwuI+IA89pF/w3Vj+U14jU0aqKY9c97r/WiRTGoYlDg+if1sX
         ZSJF+5hC4UVq6+XQbfeDZpeA+HhPY5cNOVtONecvGwhu0a1OEG8TKVvW7wbVURA0q9
         x2G80LMK2aM8bqk9TRy/PWvxXkPQ9/dPzdsCHrxU=
Date:   Mon, 13 Feb 2023 14:29:53 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Chunwei Chen <david.chen@nutanix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the mm-hotfixes tree
Message-Id: <20230213142953.9c62494f0db76ba0f8af6ad5@linux-foundation.org>
In-Reply-To: <20230214085452.03575f8b@canb.auug.org.au>
References: <20230213080052.296dddb0@canb.auug.org.au>
        <20230214085452.03575f8b@canb.auug.org.au>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2023 08:54:52 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> On Mon, 13 Feb 2023 08:00:52 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > The following commit is also in Linus Torvalds' tree as a different commit
> > (but the same patch):
> > 
> >   c2d6ac6f92ac ("mm/page_alloc.c: fix page corruption caused by racy check in __free_pages")
> 
> This is now commit 1a520a4425b0.
> 

yup, thanks.  I've made a note not to send this upstream.  But I'll
keep it around in mm-hotfixes-unstable for a while so that users of the
6.2-rc4 based mm.git trees have it.
