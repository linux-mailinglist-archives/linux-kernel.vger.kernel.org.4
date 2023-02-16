Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547ED699F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 22:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjBPVzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 16:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjBPVzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 16:55:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5755C4E5DD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 13:55:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BB7060C83
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 21:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A340C433D2;
        Thu, 16 Feb 2023 21:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1676584449;
        bh=S5wpYECKaU9vuWePclk87d4XR9DF11SQ9nts7AslRW8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DF8/1LqXUAqfEhk+pv3j5HWpdepAlluMF1qY2wTFQlVPB9yPbikCFBlpv5Sx/DwRo
         8WaUZX0Olwt6Yj8gkVvOdEOih47xhx7MiuKNJHeaBXxkYj3+jrbnuGMBveMBfaMEfa
         3/zcuomu45U6AS7BWGE4jlC7pvvfMzGcLDle1I2s=
Date:   Thu, 16 Feb 2023 13:54:08 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, regressions@leemhuis.info,
        Nick Bowler <nbowler@draconx.ca>
Subject: Re: [PATCH] mm/migrate: Fix wrongly apply write bit after mkdirty
 on sparc64
Message-Id: <20230216135408.18b8ccc91d1677d5d762feab@linux-foundation.org>
In-Reply-To: <7c218446-cd3a-da90-0c18-83579bef34ca@redhat.com>
References: <20230216153059.256739-1-peterx@redhat.com>
        <7c218446-cd3a-da90-0c18-83579bef34ca@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2023 16:37:19 +0100 David Hildenbrand <david@redhat.com> wrote:

> On 16.02.23 16:30, Peter Xu wrote:
> > Nick Bowler reported another sparc64 breakage after the young/dirty
> > persistent work for page migration (per "Link:" below).  That's after a
> > similar report [2].
> > 
> > It turns out page migration was overlooked, and it wasn't failing before
> > because page migration was not enabled in the initial report test environment.
> > 
> > David proposed another way [2] to fix this from sparc64 side, but that
> > patch didn't land somehow. 
> 
> I pinged another time and asked Andrew to pick it up eventually.
> 

urgh, sorry, I'd have filtered that out as a sparc patch.


