Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10147646850
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 05:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiLHEow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 23:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLHEot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 23:44:49 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9125599F19
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 20:44:48 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1670474686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xV+uK2oSZ9jJ7++7f55PRM1gIS9Olu3FCuxCE/H11Z8=;
        b=VZHdbDqW7Ue2/NcSbY9oO+Dk78yj2+jNqhIPtSnJ2Cbtr7KDAAOVfzV3WNa52Culm/vmZ2
        LfRODpclC2w8byW2slZyYkGnltpgIp71nTGFsTmrCDZCM1llesDjcOJQhXsXuDrGJraid/
        kHdrJhHTSxPX4VvJ3PgUk30p1aUZDNQ=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.200.110.1.12\))
Subject: Re: [PATCH mm-unstable v5 01/10] mm: add folio dtor and order setter
 functions
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <9a3b3346-4916-7ae5-5abc-4d3c34a0a0fa@nvidia.com>
Date:   Thu, 8 Dec 2022 12:44:27 +0800
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mina Almasry <almasrymina@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>, hughd@google.com,
        tsahu@linux.ibm.com, David Hildenbrand <david@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E8CA63D6-858B-40E5-B3A6-8ED870546DA8@linux.dev>
References: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
 <20221129225039.82257-2-sidhartha.kumar@oracle.com>
 <BAD34D59-187B-4BB3-B139-7983A8B62648@linux.dev> <Y5ALigw0kUO/B3z2@monkey>
 <4161AF1A-9508-4DF8-B756-FEB476EB32B5@linux.dev> <Y5DXivFOA+bO0IYQ@monkey>
 <b995eccf-5818-84ee-560e-20c00f9936b4@oracle.com>
 <d5755326-a71e-242b-5e1e-86fc897dc292@oracle.com> <Y5DotA/pLbakONGl@monkey>
 <3F95112C-C1B3-4774-9E21-998CADEC38D4@linux.dev>
 <9a3b3346-4916-7ae5-5abc-4d3c34a0a0fa@nvidia.com>
To:     John Hubbard <jhubbard@nvidia.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 8, 2022, at 10:31, John Hubbard <jhubbard@nvidia.com> wrote:
>=20
> On 12/7/22 18:19, Muchun Song wrote:
>> How about adding a new helper like "folio_dissolve_compound(struct =
folio *folio)"?
>> then it may be unnecessary to add a comment.
>=20
> Yes, and in fact, I just finished spelling out exactly how to do that, =
in [1].

Thanks for your guidance. I have replied in thread [1].

>=20
>=20
> [1] =
https://lore.kernel.org/all/d17530ad-8e12-8069-d619-a2d72fe80e15@nvidia.co=
m/
>=20
>=20
> thanks,
> --=20
> John Hubbard
> NVIDIA

