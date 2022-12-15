Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A871D64D5A7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 04:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiLODoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 22:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLODow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 22:44:52 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD2A5289C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 19:44:50 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1671075888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ek1AWVDvL3uGjwPmVZLLu6V363bRYpZOhP1Lu8fyRnA=;
        b=e4jSCMHBjLLS8F5I0zKPVXVejFpN80ydgHO0I78K+igtJzI85DkC/p6bhJPqPeBhgDFmVh
        tuLiW6iAmFq0IHHAiSV+4XJEvIrk3CxTyb3bVpWoBg3M5kIUpIzYg40NqbZZQWWa9M7zGw
        BnmA67tsVkOOEsnRrSvbPnxMG1wqgf8=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH mm-unstable] mm: move folio_set_compound_order() to
 mm/internal.h
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20221213212053.106058-1-sidhartha.kumar@oracle.com>
Date:   Thu, 15 Dec 2022 11:44:14 +0800
Cc:     linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0B650D64-1F64-4695-9365-CF695029C50C@linux.dev>
References: <20221213212053.106058-1-sidhartha.kumar@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 14, 2022, at 05:20, Sidhartha Kumar =
<sidhartha.kumar@oracle.com> wrote:
>=20
> folio_set_compound_order() is moved to an mm-internal location so =
external
> folio users cannot misuse this function. Change the name of the =
function
> to folio_set_order() and use WARN_ON_ONCE() rather than BUG_ON. Also,
> handle the case if a non-large folio is passed and add clarifying =
comments
> to the function.
>=20
> Link: =
https://lore.kernel.org/lkml/20221207223731.32784-1-sidhartha.kumar@oracle=
.com/T/
> Fixes: 9fd330582b2f ("mm: add folio dtor and order setter functions")
>=20
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
> Suggested-by: Muchun Song <songmuchun@bytedance.com>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Suggested-by: John Hubbard <jhubbard@nvidia.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.=
