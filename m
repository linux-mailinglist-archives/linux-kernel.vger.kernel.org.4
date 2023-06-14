Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA97273021B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244519AbjFNOhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245325AbjFNOhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:37:50 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8AA1BE5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:37:49 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6664e4d8fb4so537629b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1686753469; x=1689345469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gyujhLRyZRg2hIoBNu92A1RubEtIut+RN18vb/NDgD4=;
        b=iQFnpbthAVwC3lLw+Vz5Cwabp+JkO7FkrbyZ1Sc1qkFjKTV7BAUnip59ec72h939vt
         4q+BHJoB6/j+PWBqHnwefjNokhGRWgl654d5KmO9Lc42nLrxm7j+mvcya+SuY9XglbR8
         qQCy2letdDjnOYHPNBJ6Bp2xtbXVRanF+26ADQ/8zjjDfMi3JTyhHl06ksxyk3qDvprj
         EXKoqWbq3lyTf4e0iXQUS0XnXmZK9DhKPGrzFJzEp5MsABdLsVUYYOHnG3JvgASaROrT
         PPqu/SlYzRLBdMY49RGq6RAMkSuzS0NC9a+381JGrg1vlpR5pKnGQ7nN4/KVS+NLra7i
         7dHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686753469; x=1689345469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyujhLRyZRg2hIoBNu92A1RubEtIut+RN18vb/NDgD4=;
        b=EXlTQkxEXuqTCVSHtq9TlQLS6WgHncEeD9jfC+PeNw6bbKBzKwGuW3M8uNcT4ZJ6TR
         ENPPGyfnxsgJNi1RiJLdajK/1RBWlLWIvy3Yc91SU9lebXnJ4fXgA9HmRde/3Ie4AP8J
         DXhsTY0i1s1xfLzzeuBhSb+jC803i7J5Z08dNKKJ7QH8mCwdOAViIKt4YUMe56Uohy2m
         B3QfrdewCT1v4oewcsDjPbIpGeNTMUotcZGQjDD64fa5nPjIfPUp3bhKyrR+6pOZBC26
         TWJYkmncGLgg/87QN1WZGtPwF6FU4j5bP/5cj+1lBE16xO7gdMaivFUEgwibu4El6NWv
         3k5Q==
X-Gm-Message-State: AC+VfDxmt7Xt0xbRZtCqE3BSQFasIUnk7t/KW/vhspWRTU20jKOPwZNV
        88Ho9HHTyuYpzpXLpHlTd2sn5w==
X-Google-Smtp-Source: ACHHUZ4gjsy4buH+Wu++ANwpnxK4p0HLM0YlNzqwKgT1nSXYAGD+SqhcEQRWNy9UWTZbvT7d/eIJyQ==
X-Received: by 2002:a05:6a20:1603:b0:100:6863:8be7 with SMTP id l3-20020a056a20160300b0010068638be7mr1771480pzj.62.1686753469052;
        Wed, 14 Jun 2023 07:37:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id u15-20020a17090341cf00b001a2104d706fsm12284211ple.225.2023.06.14.07.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 07:37:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q9Rd4-0058kr-Oy;
        Wed, 14 Jun 2023 11:37:46 -0300
Date:   Wed, 14 Jun 2023 11:37:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 7/7] mm/gup: Retire follow_hugetlb_page()
Message-ID: <ZInQupl0ukTX45x4@ziepe.ca>
References: <20230613215346.1022773-1-peterx@redhat.com>
 <20230613215346.1022773-8-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613215346.1022773-8-peterx@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 05:53:46PM -0400, Peter Xu wrote:
> Now __get_user_pages() should be well prepared to handle thp completely,
> as long as hugetlb gup requests even without the hugetlb's special path.
> 
> Time to retire follow_hugetlb_page().
> 
> Tweak the comments in follow_page_mask() to reflect reality, by dropping
> the "follow_page()" description.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/hugetlb.h |  12 ---
>  mm/gup.c                |  19 ----
>  mm/hugetlb.c            | 223 ----------------------------------------
>  3 files changed, 254 deletions(-)

It is a like a dream come true :)

I don't know enough about hugetlb details but this series broadly made
sense to me

Thanks,
Jason
