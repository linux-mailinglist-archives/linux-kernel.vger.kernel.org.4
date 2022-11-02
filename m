Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62C7615C94
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 07:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiKBG6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 02:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKBG6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 02:58:18 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438CA25EB6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 23:58:17 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1667372295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XgBppt+XcBVJ8E15lm+WvBKPfh2wbve87IQ7ntUCiho=;
        b=qVH/mhT3tQhyE9AR5MtgKA6qShk3koX9pzjsy2VbUck8cYrhfvraaDv4bQN3vrm9G4i92b
        MI/5rhJL24ukc7UtIl+frNOJ2Rdvh7lVUHm0VfqL4oVBa/9qmmcOvB3EznK9XABd4Jr0rP
        rTykMvDKULAv6vdOs9bc+2EI9Dksszo=
MIME-Version: 1.0
Subject: Re: [PATCH v2 8/9] mm/hugeltb_cgroup: convert
 hugetlb_cgroup_commit_charge*() to folios
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20221101223059.460937-9-sidhartha.kumar@oracle.com>
Date:   Wed, 2 Nov 2022 14:57:37 +0800
Cc:     linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mina Almasry <almasrymina@google.com>, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A1EE18E6-EBAD-48D6-844F-E1F8B8BD8F80@linux.dev>
References: <20221101223059.460937-1-sidhartha.kumar@oracle.com>
 <20221101223059.460937-9-sidhartha.kumar@oracle.com>
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
> Convert hugetlb_cgroup_commit_charge*() to internally use folios to =
clean
> up the code after __set_hugetlb_cgroup() was changed to take a folio.
>=20
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

