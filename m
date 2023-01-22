Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1418677125
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 18:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjAVRnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 12:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjAVRnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 12:43:09 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB659729E;
        Sun, 22 Jan 2023 09:43:07 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E1E504E5;
        Sun, 22 Jan 2023 17:43:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E1E504E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1674409387; bh=PhTPdd+tEpQHc/ujMuc1G+8BhQEUkRWbXLoB8rRzFnw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GToCutKvz4FKFZbm9gCzn073f4wM5ApWQLQsb25I+pXh0S1sIIAvC5llud0FA6/vL
         4GhHqas0lIxNHHNYZtLBMGBvSgwO8zIPjhzlUUPQY8Cp8bvaCxAE1+uekLPxPzNjEZ
         zyLEEnj00qaH5LAMpk+k61ZMnzMYE/e2ypbHXcVI+ztv1lof5Nt0d70Dpsqm5R0PLr
         2/CCIL6ydmRoexcJBfdxWstwOyePjWTzdQx8r7+T4R9d4bLJXIF32dPTBJQa2r0nd6
         ASci1U9s9HSM3/3PWva4ygQuruWSSJfHvN05x/XOGUsJo9r/xwcErWy+FxjshvSxW/
         k7PfzPyyRrXHg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mike Rapoport <rppt@kernel.org>
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
In-Reply-To: <Y8zKDkJPeEb0wUTK@kernel.org>
References: <20230115184212.996298-1-rppt@kernel.org>
 <Y8zKDkJPeEb0wUTK@kernel.org>
Date:   Sun, 22 Jan 2023 10:43:06 -0700
Message-ID: <87tu0ilb2t.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Rapoport <rppt@kernel.org> writes:

> Gentle ping.

Is that your way of saying that you think it's perhaps ready to be
applied?  I've been watching the discussion but wasn't sure if things
have settled or not.

Thanks,

jon
