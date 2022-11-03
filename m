Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE22961748C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 03:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiKCCx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 22:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiKCCx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 22:53:29 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A1315837
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 19:52:14 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1667443933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lp0yfXzlfHhvEOMOaUivoS1iKMpFYQIUksinGRVVzMA=;
        b=aGfPf6SZQPy8RYJ0buYLhhBk9mO/wQB+ZliJxfhUWRqccZiuQp+ypccJf+t6gNdW1hI4ju
        ms3JQf6Okf8a3VPDX0R0wfTfy9pWKySRgloOn5n8jzWBmdPxBbqhWws+htNa4nkzDvJjT8
        Kr5/qjKKGqSM0nM6M5W4d4x6qocScrI=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.200.110.1.12\))
Subject: Re: [PATCH] mm: hugetlb_vmemmap: include missing linux/moduleparam.h
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <patch.git-296b83ca939b.your-ad-here.call-01667411912-ext-5073@work.hours>
Date:   Thu, 3 Nov 2022 10:51:59 +0800
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <71BFC75C-483D-42C0-8248-59FC8DBE148C@linux.dev>
References: <patch.git-296b83ca939b.your-ad-here.call-01667411912-ext-5073@work.hours>
To:     Vasily Gorbik <gor@linux.ibm.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 3, 2022, at 02:09, Vasily Gorbik <gor@linux.ibm.com> wrote:
>=20
> The kernel test robot reported build failures with a 'randconfig' on =
s390:
>>> mm/hugetlb_vmemmap.c:421:11: error: a function declaration without a
> prototype is deprecated in all versions of C =
[-Werror,-Wstrict-prototypes]
>   core_param(hugetlb_free_vmemmap, vmemmap_optimize_enabled, bool, 0);
>             ^
>=20
> Link: =
https://lore.kernel.org/linux-mm/202210300751.rG3UDsuc-lkp@intel.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 30152245c63b ("mm: hugetlb_vmemmap: replace early_param() with =
core_param()")

Thanks for your fixing. However, the correct commit that should be fixed =
is
42deddf3ef5c ("s390: select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP").

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

