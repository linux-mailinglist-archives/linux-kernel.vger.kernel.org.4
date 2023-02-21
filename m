Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD23969E253
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbjBUObO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjBUObN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:31:13 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD71B2887D;
        Tue, 21 Feb 2023 06:31:10 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D7773735;
        Tue, 21 Feb 2023 14:31:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D7773735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1676989870; bh=984+BH7wbF7nkYLrBo8RWXZ3rHtLXQBHSoEyAwVv/Nc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dttX6UZN7e2ODiYqmEwYE+IAODT7UO6oDnX7383ZQSBADFmgee6+u6L5nC6Mv3ZNh
         /RAeOrkrXXpkLf0CXxpSO26ycjCmFqyr+Kz0j9beQwvKe1nk9rNlGoA6IpjdaByeeX
         Ay6An+erBnVFmLYNssx4XJx4r35xnM9VbujdcDpjdlq3CmzjOL9cVgIAz/UYIRehNs
         /f5zyBnAC7pCwStQcLrJYc9N5lUiiazh0S+6LgyGcGyUttCp1yWfVrKeheiYfTsw68
         nbc9MyVqnSEFRhpGjLvDxnddfiU5kjmKTpMsgMv7pGGI/V213Tsq7OSt2LTX8vE6md
         SYvR/Aou5jHfQ==
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
Subject: Re: [PATCH v3] docs/mm: Physical Memory: add example of
 interleaving nodes
In-Reply-To: <Y/RqKbBeXLswC1AR@kernel.org>
References: <20230213154447.1631847-1-rppt@kernel.org>
 <Y/RqKbBeXLswC1AR@kernel.org>
Date:   Tue, 21 Feb 2023 07:31:08 -0700
Message-ID: <87bkln9jkj.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Rapoport <rppt@kernel.org> writes:

> Ping?

It's in my queue.  The docs tree has conflicts all over the place this
time around, so I closed things down a bit earlier than I otherwise
would have.  I'm expecting to catch up a bit in the coming week.

Thanks,

jon
