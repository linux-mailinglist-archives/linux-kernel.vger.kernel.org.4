Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5CA7252A3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 06:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjFGEB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 00:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240521AbjFGD7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 23:59:30 -0400
Received: from out-14.mta0.migadu.com (out-14.mta0.migadu.com [91.218.175.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7832D53
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 20:56:30 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686110188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MxfLOisEwSSoDbm7OS25TBuPcUppsT6Gt8WWAMdhIIU=;
        b=fTlIL/pynF+JOOQ3owzpzetvdPTsB18r/tTO1tsnCWCKIbXEQliQyjTDjRX0gx6E4lRw3L
        J9B5mTv5NPZ0l8yfXo+hVSmwPXJHTXzsWOTRdFGgX/9pvIIqbhEYpSSIZ5gP+VnjHkX9jl
        NeKDHhqzxDtPDfOriGO7+ICqya85SGY=
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/3] mm/hugetlb: Use a folio in hugetlb_fault()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230606062013.2947002-4-zhangpeng362@huawei.com>
Date:   Wed, 7 Jun 2023 11:55:45 +0800
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        vishal.moola@gmail.com, Kefeng Wang <wangkefeng.wang@huawei.com>,
        sunnanyong@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <9EDCD695-17D3-425C-B540-CA30248EA13D@linux.dev>
References: <20230606062013.2947002-1-zhangpeng362@huawei.com>
 <20230606062013.2947002-4-zhangpeng362@huawei.com>
To:     Peng Zhang <zhangpeng362@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 6, 2023, at 14:20, Peng Zhang <zhangpeng362@huawei.com> wrote:
>=20
> From: ZhangPeng <zhangpeng362@huawei.com>
>=20
> We can replace seven implicit calls to compound_head() with one by =
using
> folio.
>=20
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com =
<mailto:zhangpeng362@huawei.com>>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

