Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30D5680A6C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbjA3KHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236231AbjA3KHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:07:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F29B1A970;
        Mon, 30 Jan 2023 02:07:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC65DB80EBC;
        Mon, 30 Jan 2023 10:07:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3606C433EF;
        Mon, 30 Jan 2023 10:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675073257;
        bh=duVMDImvFZfvYQ61d29Y76cm/zyFTulxj66PhFIobTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AQYD90FqpWweSvwLoaIvtqwqCmD8WdvPWlprWogqp0f780P3a9vn67kv1IuuZBnaC
         LYLg7Mxb3iBcjV+0ihYcrbLHY3COv6VRrqPfQiqq5hWUsfnpDfeIxygfr/6xQkuyS1
         TMzx+hCci74yQbtoL5EsGGFrfpByq3QBDe7TUAIyxtizNGhCvBSHT21Ek+9eQqDxBv
         oPDqeOvezfq7Udo2V/Iz5qL/jQSLUh+BsQF2gifeYlO+OsI0IdKL0haZFtXLIFlfCG
         0HAEp43Knqqn3Zm6II+ii5D8rsYWfWcvV9e86CNylFbipAyfliS8GnlsbzL6MnrNDp
         tj4rWoM/wGDcA==
Date:   Mon, 30 Jan 2023 12:07:23 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 18/35] Documentation: mm: correct spelling
Message-ID: <Y9eW27IbyTWxut7D@kernel.org>
References: <20230127064005.1558-1-rdunlap@infradead.org>
 <20230127064005.1558-19-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230127064005.1558-19-rdunlap@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 10:39:48PM -0800, Randy Dunlap wrote:
> Correct spelling problems for Documentation/mm/ as reported
> by codespell.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: linux-mm@kvack.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/mm/hmm.rst      |    4 ++--
>  Documentation/mm/hwpoison.rst |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> 
> diff -- a/Documentation/mm/hmm.rst b/Documentation/mm/hmm.rst
> --- a/Documentation/mm/hmm.rst
> +++ b/Documentation/mm/hmm.rst
> @@ -416,10 +416,10 @@ can be used to make a memory range inacc
>  
>  This replaces all mappings for pages in the given range with special swap
>  entries. Any attempt to access the swap entry results in a fault which is
> -resovled by replacing the entry with the original mapping. A driver gets
> +resolved by replacing the entry with the original mapping. A driver gets
>  notified that the mapping has been changed by MMU notifiers, after which point
>  it will no longer have exclusive access to the page. Exclusive access is
> -guranteed to last until the driver drops the page lock and page reference, at
> +guaranteed to last until the driver drops the page lock and page reference, at
>  which point any CPU faults on the page may proceed as described.
>  
>  Memory cgroup (memcg) and rss accounting
> diff -- a/Documentation/mm/hwpoison.rst b/Documentation/mm/hwpoison.rst
> --- a/Documentation/mm/hwpoison.rst
> +++ b/Documentation/mm/hwpoison.rst
> @@ -50,7 +50,7 @@ of applications. KVM support requires a
>  For the KVM use there was need for a new signal type so that
>  KVM can inject the machine check into the guest with the proper
>  address. This in theory allows other applications to handle
> -memory failures too. The expection is that near all applications
> +memory failures too. The expectation is that near all applications
>  won't do that, but some very specialized ones might.
>  
>  Failure recovery modes

-- 
Sincerely yours,
Mike.
