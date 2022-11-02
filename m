Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70E261592F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 04:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiKBDGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 23:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiKBDFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 23:05:55 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9267823E9B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 20:05:53 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1667358351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JHCYlfcq1glUmJxjdCY0wtKAm+erlSHAwv/pGjwc4wY=;
        b=ZvB6a+UpvupFMDaje+cXcpLufM2sMxV7/QwkXR1oqlcJczBJoukVgwv3OARli4Z7evCqX9
        v5oXvR4Xb33OBGp1nW0/C4CtTMttajATqvy20tqLD+Npq3hvx5BLBOzEBrnA65A+UJQLUf
        zV2Tu1EU5algf4TUbx+fiJqJEh0aFCY=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.200.110.1.12\))
Subject: Re: [PATCH v2 1/9] mm/hugetlb_cgroup: convert __set_hugetlb_cgroup()
 to folios
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20221101223059.460937-2-sidhartha.kumar@oracle.com>
Date:   Wed, 2 Nov 2022 11:05:33 +0800
Cc:     linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mina Almasry <almasrymina@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>, minhquangbui99@gmail.com,
        aneesh.kumar@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <AEBE708B-49EE-4AB8-96E1-2C239899A8DB@linux.dev>
References: <20221101223059.460937-1-sidhartha.kumar@oracle.com>
 <20221101223059.460937-2-sidhartha.kumar@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 2, 2022, at 06:30, Sidhartha Kumar <sidhartha.kumar@oracle.com> =
wrote:
>=20
> Change __set_hugetlb_cgroup() to use folios so it is explicit that the
> function operates on a head page.
>=20
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

