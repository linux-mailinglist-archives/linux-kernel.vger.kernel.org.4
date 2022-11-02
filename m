Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5441E615C6A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 07:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiKBGri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 02:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKBGrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 02:47:36 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506F710FF1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 23:47:35 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1667371653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dF889jQ7QNG5mkzx+GbJdYjy1UVqNctQcUxUm5YSiJc=;
        b=pc6oGSzZYZenmgctBBOWffBiZjwM2Sah6VJacbJiR4iN9O623QPCCms83QkxFHcOZ5UHKQ
        Y0LW+Q4dSdHMAd+qEUPbmTBD7ec+vLWtl1M2eNGXRlotLGHw21/VMatw6Sg9uk90C/eePt
        4Uj8Fz/hiVoUVMTVfSW9mxuWcgwqgXs=
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/9] mm/hugetlb_cgroup: convert hugetlb_cgroup_migrate
 to folios
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20221101223059.460937-5-sidhartha.kumar@oracle.com>
Date:   Wed, 2 Nov 2022 14:47:16 +0800
Cc:     linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, almasrymina@google.com,
        linmiaohe@huawei.com, minhquangbui99@gmail.com,
        aneesh.kumar@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <7200AC55-42FF-44E8-A790-61AC712F0F2A@linux.dev>
References: <20221101223059.460937-1-sidhartha.kumar@oracle.com>
 <20221101223059.460937-5-sidhartha.kumar@oracle.com>
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



> On Nov 2, 2022, at 06:30, Sidhartha Kumar <sidhartha.kumar@oracle.com> =
wrote:
>=20
> Cleans up intermediate page to folio conversion code in
> hugetlb_cgroup_migrate() by changing its arguments from pages to =
folios.
>=20
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

