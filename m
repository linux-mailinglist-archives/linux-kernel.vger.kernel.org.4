Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53B267D5A3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjAZTsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjAZTr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:47:58 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74BF1422E;
        Thu, 26 Jan 2023 11:47:57 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3917E2CD;
        Thu, 26 Jan 2023 19:47:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3917E2CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1674762477; bh=iEbq0XucaOhUbsSFeea2ZyWKvh6EgTvQcFci3Hgc/do=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=P3hHPb6EsMtRFfrRFaKd8PDG7eOcbyda+el8YbcDfJfSn+1WpdHysVXCE9skn+TR+
         z00GLDoHjyZM4m2NLG9rXQ5UqkUOVD1KmFvUL9FxKQmk65rX4kK/bTmNrDPL3ZEkqf
         euKOLSzeYCM6FfPsESVnrdRQdR4hH9tcU0wjzVtV2s9DzsxNt+crnNXqVqjoQmB24k
         xvxWvENssOUY5KyUuwlknydqWeSRWMbXdjAWs0IWLbj2VCqdg9CHC0T3pkqyTMxX1B
         njHqPuLEbAJGPKRu/LCWi0CtEB8FrQjLPutPsLR7Q7sx4hWhrUtusLxlNEiSorCxGZ
         LtSfHm4KC/uHA==
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
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v5 1/1] docs/mm: Physical Memory: add structure,
 introduction and nodes description
In-Reply-To: <Y9LWIQtPQ5yLIwu9@kernel.org>
References: <20230125192841.25342-1-rppt@kernel.org>
 <20230125192841.25342-2-rppt@kernel.org> <87r0vh9n17.fsf@meer.lwn.net>
 <Y9LWIQtPQ5yLIwu9@kernel.org>
Date:   Thu, 26 Jan 2023 12:47:56 -0700
Message-ID: <871qnh9ixf.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Rapoport <rppt@kernel.org> writes:

> Do you want v6? ;-)

Naw, I didn't think it was worth holding up the work any longer, so it's
applied.  Feel free to send a fixup though :)

Thanks,

jon
