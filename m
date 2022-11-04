Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCF261A5E3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 00:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiKDXgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 19:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKDXgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 19:36:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F80B2F665
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 16:36:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF3CF6233C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 23:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D93C433C1;
        Fri,  4 Nov 2022 23:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1667605001;
        bh=22T8ApIzd/4Wr/C49UU1NXC4Fpg7XFQ5s94T+J49igo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MMYgUpIu4xmcDoxdp/r1rTSl+kGHZxIXwg0zB3fjuNupncK8Yeu8R5ShGUdDKO/+L
         58AwepgEZtcBjRoXziIzPZkqMDTO8tHYKkPZKCWRKOtxMD/a/YE1/yQzwDaF108kB1
         /aPKNYF4JAL2/R6JB+sSz33RtaQvQhwgiUyyyPuY=
Date:   Fri, 4 Nov 2022 16:36:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Muchun Song <muchun.song@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: hugetlb_vmemmap: include missing
 linux/moduleparam.h
Message-Id: <20221104163640.2057b74c25d6076f64912891@linux-foundation.org>
In-Reply-To: <your-ad-here.call-01667491322-ext-5168@work.hours>
References: <patch.git-296b83ca939b.your-ad-here.call-01667411912-ext-5073@work.hours>
        <71BFC75C-483D-42C0-8248-59FC8DBE148C@linux.dev>
        <your-ad-here.call-01667491322-ext-5168@work.hours>
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

On Thu, 3 Nov 2022 17:02:02 +0100 Vasily Gorbik <gor@linux.ibm.com> wrote:

> 42deddf3ef5c ("s390: select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP") is
> just a one liner activating this feature and only present in linux-next
> and s390 features branch targeting v6.2. So, if you don't want to have
> 
> Fixes: 30152245c63b ("mm: hugetlb_vmemmap: replace early_param() with core_param()")
> 
> fine with me. But then just dropping Fixes tag is probably a better
> option. I hope that won't prevent it from going into some v6.1-rcX.
> 
> @Andrew
> should I resend? or would you be so kind to drop Fixes tag and add Reviewed-by
> without it? Thank you

I retained the

Fixes: 30152245c63b ("mm: hugetlb_vmemmap: replace early_param() with core_param()")

and added Muchun's Reviewed-by:, thanks.

