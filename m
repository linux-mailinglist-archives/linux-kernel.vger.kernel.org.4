Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A83E5BDACA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 05:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiITDUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 23:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiITDUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 23:20:02 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8A822BD7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 20:19:59 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663643998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4l96y7W2Pt8M88Ll0M0moh/gfORDHvn+1u/UjSg0jVw=;
        b=geKVrdExE9tc1o1+pxvfG6B3hT3rN2r4k63kXVPg9vidYPCswwAqMIKzLUMZpNvnwLfs+x
        sPDHIVxsvRcuaEnK/hvXO55CXTXYJ0CHYm+YMsevkbzHL9YnqleOAoHBDYcEuEu6avnf3C
        AfuzTFUHFTe3qCULn6nrNtXzvLucERk=
MIME-Version: 1.0
Subject: Re: [PATCH v4] mm/hugetlb: add available_huge_pages() func
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20220920015122.68064-1-xhao@linux.alibaba.com>
Date:   Tue, 20 Sep 2022 11:18:57 +0800
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <DABF55CE-C02E-4676-A872-0813D22CF453@linux.dev>
References: <20220920015122.68064-1-xhao@linux.alibaba.com>
To:     Xin Hao <xhao@linux.alibaba.com>
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



> On Sep 20, 2022, at 09:51, Xin Hao <xhao@linux.alibaba.com> wrote:
> 
> In hugetlb.c file, there are several places to compare the values of
> 'h->free_huge_pages' and 'h->resv_huge_pages', it looks a bit messy, so
> there add a new available_huge_pages() func to do these.
> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

