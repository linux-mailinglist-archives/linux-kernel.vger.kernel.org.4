Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10105E7248
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 05:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbiIWDDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 23:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbiIWDCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 23:02:51 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956FD11E0F3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 20:01:36 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663902095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hmcFuXbaODR1v5wTbuJobCtUGIcSFGxFzD1kGvOGDh4=;
        b=n0GWWvLnuVK8Zk+tm/AieZ0Qcf6zSvXuv+yzmEE1CbG+Ib0I+kz9pRqnSTPbZniDzvISAq
        2/duC0ojXGrBCdcVVr4Fq8mh00C2Hi131a8zFGkrRbnhg5pl5ZiQ6hiQxAOJ6vy6BSFvun
        wYFHL7Bc3V7h5FYnA+rsPwOZaLqsT2E=
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/5] mm/hugetlb: add folio support to hugetlb specific
 flag macros
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20220922154207.1575343-2-sidhartha.kumar@oracle.com>
Date:   Fri, 23 Sep 2022 11:01:25 +0800
Cc:     linux-kernel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        dhowells@redhat.com, Peter Xu <peterx@redhat.com>, arnd@arndb.de,
        ccross@google.com, hughd@google.com, ebiederm@xmission.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <2EF25EBE-8A94-4B73-9E94-7CB1C436D60A@linux.dev>
References: <20220922154207.1575343-1-sidhartha.kumar@oracle.com>
 <20220922154207.1575343-2-sidhartha.kumar@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 22, 2022, at 23:42, Sidhartha Kumar =
<sidhartha.kumar@oracle.com> wrote:
>=20
> Allows the macros which test, set, and clear hugetlb specific page
> flags to take a hugetlb folio as an input. The marcros are generated =
as
> folio_{test, set, clear}_hugetlb_{restore_reserve, migratable,
> temporary, freed, vmemmap_optimized, raw_hwp_unreliable}.
>=20
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

