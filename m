Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF8666366C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 01:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237634AbjAJAuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 19:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237843AbjAJAuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 19:50:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B8B18B27
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 16:50:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9128A60C6B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 00:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A952FC433EF;
        Tue, 10 Jan 2023 00:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1673311800;
        bh=1dBy9wQ/T4eLPsNf9xiz3Q6ijI6woYVWaqyv/gCcMwU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1O5mAd8Zpd7OPacP6rPA3gRNFKYZRNECZYv0XtDXzcqWr6s/Cp1MPsszoxQwP3fW6
         y4lT75/QG3XCfEzA+O7MCW9JNilJyS9U/Ccu05+BZr9pVXzCEf4EYKV58ay9SlX/n5
         HtZ3rlc5I3RIl2ljGu3w7UeaFi3fxZlHOWM4mJ08=
Date:   Mon, 9 Jan 2023 16:49:59 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, hughd@google.com
Subject: Re: [PATCH mm-unstable] mm: remove the hugetlb field from struct
 page
Message-Id: <20230109164959.cb0cb7b3f8a4ba5a2051529a@linux-foundation.org>
In-Reply-To: <20230109230806.910287-1-sidhartha.kumar@oracle.com>
References: <20230109230806.910287-1-sidhartha.kumar@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
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

On Mon,  9 Jan 2023 17:08:06 -0600 Sidhartha Kumar <sidhartha.kumar@oracle.com> wrote:

> commit dad6a5eb5556(mm,hugetlb: use folio fields in second tail page)
> added a transitional hugetlb field to struct page and struct folio to make
> room for another int in the first tail of a compound page. Hugetlb folio
> conversions have changed all page users of this field to use the fields
> within the folio so struct page no longer needs this hugetlb specific
> field.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
> This is rebased on 01/09/2023 mm-unstable plus Matthew's series[1] applied
> 
> [1]https://lore.kernel.org/linux-mm/20221231214610.2800682-1-willy@infradead.org/

Matthew's series had some compilation issues and needs quite some
rework to make it apply to current mm-unstable..

So, please resend this patch once v2 of "Get rid of first tail page
fields" has materialized.
