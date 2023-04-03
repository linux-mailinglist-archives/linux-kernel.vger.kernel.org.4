Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9E46D5234
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 22:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbjDCUUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 16:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbjDCUUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:20:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C7C40D8
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 13:20:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24E2762947
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 20:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6CCC433EF;
        Mon,  3 Apr 2023 20:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1680553175;
        bh=IiNaMa37JiuQJYqBejdJVnvGJ6ocKdl/z6g1YwT51PA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WPbYEbtWG8H+qMLeGAmOlxHKjiEPMP/sZhVKrkN23iw0+Jld+j6oeLWnouvxAHKi4
         DYJqu8AHtCyyG1V5ahxS804wjtZ8nTcWYxNlVgTPXRq9p7QqVy4hbpkSC475X1tq//
         rjuMvZMK33rJWKx4hAtAIsV5CSDccY5R0bQPfUmk=
Date:   Mon, 3 Apr 2023 13:19:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 0/8] Fix VMA tree modification under mmap read lock
Message-Id: <20230403131934.e370ca6caded57a5a7977818@linux-foundation.org>
In-Reply-To: <20230403194443.af3kbawab3d4r5pr@revolver>
References: <20230327185532.2354250-1-Liam.Howlett@oracle.com>
        <20230327123515.bce6c1ea3660e9b17db50c33@linux-foundation.org>
        <20230327194800.fzqfrxfh3nfmqwgk@revolver>
        <a017acde-7520-743c-963b-94a23c0f30c8@suse.cz>
        <20230328130230.gdmychfid3aggikd@revolver>
        <20230403194443.af3kbawab3d4r5pr@revolver>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2023 15:44:43 -0400 "Liam R. Howlett" <Liam.Howlett@Oracle.com> wrote:

> I just wanted to know where we stand with these patches?

They're in the mm.git hotfixes queue.  I'll be asking Linus
to pull them this week.
