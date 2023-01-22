Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937BC677196
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 19:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjAVSmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 13:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjAVSmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 13:42:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846211D90D;
        Sun, 22 Jan 2023 10:42:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4F3EB80B4B;
        Sun, 22 Jan 2023 18:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35774C433D2;
        Sun, 22 Jan 2023 18:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674412928;
        bh=P3ohCxZ9+/DSCIad1DRWt8Xy8Pd3om2MvGHVU5jFW9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C4dQk+v0nG/tw7fz/jzHEvCSkmPWo08Ce9xOt9WAN8i0gf1RJoMJVRvUxfd7Eha+f
         3MTjCjB37i7JQWXF0pFtwHToQ3iGAmSu3/UX4G35BHzeUdNTGDkov10G9U8pgKFQ3N
         XeD+vE0LTAjd5VcBQqrJx9RJd3LLQh4ppRZKRL6GuRseds4OWZpKp/d9DlN/XDSKZt
         yK1o1jmh0/A3beg2I1xFVtOWItgpOJ7QS4Ua0+gE7uQpGn27DqrDjthvkB0y23S/8I
         4RjYBfKVDHZ1PcZyxrOCOc6zOXl3b8VB5lqElO48psUooC7ZJsYOlZ8bIzyHhpY+C2
         f47K7XebtLGoA==
Date:   Sun, 22 Jan 2023 20:41:52 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 0/1] docs/mm: start filling out new structure
Message-ID: <Y82DcBuilEaE03wx@kernel.org>
References: <20230115184212.996298-1-rppt@kernel.org>
 <Y8zKDkJPeEb0wUTK@kernel.org>
 <87tu0ilb2t.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tu0ilb2t.fsf@meer.lwn.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2023 at 10:43:06AM -0700, Jonathan Corbet wrote:
> Mike Rapoport <rppt@kernel.org> writes:
> 
> > Gentle ping.
> 
> Is that your way of saying that you think it's perhaps ready to be
> applied?  I've been watching the discussion but wasn't sure if things
> have settled or not.

Well, everybody who participated in the discussion acked the patch, so
yeah, I think it's ready ;-)
 
> Thanks,
> 
> jon
