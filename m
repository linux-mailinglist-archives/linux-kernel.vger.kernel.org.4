Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BC574A83D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 02:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjGGAvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 20:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGGAvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 20:51:48 -0400
Received: from out-6.mta0.migadu.com (out-6.mta0.migadu.com [IPv6:2001:41d0:1004:224b::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D93FE6E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 17:51:47 -0700 (PDT)
Date:   Fri, 7 Jul 2023 09:51:34 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688691104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R8hae9bkXUIrv7Qq5bHdTQh6mq6Q71tfUFCX8Q7qpvw=;
        b=ZtDSL74rvK+DQrwrsX32P91WnXevCHHbttxX/x3D2V1LczBlzKUL3d7DefMuaLi4yZR7ht
        QHt3d23PPprco3k1zENF9gZK+S6l5TOc5okCoxlB/TCqETVn2bL89rgJ2iLNN3JUFNIyex
        5mw+hX2FzySHqoqv/1NSvtdZ7fBc8Rc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Jiaqi Yan <jiaqiyan@google.com>
Cc:     mike.kravetz@oracle.com, naoya.horiguchi@nec.com,
        songmuchun@bytedance.com, shy828301@gmail.com,
        linmiaohe@huawei.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duenwen@google.com, axelrasmussen@google.com, jthoughton@google.com
Subject: Re: [PATCH v2 4/4] selftests/mm: add tests for HWPOISON hugetlbfs
 read
Message-ID: <20230707005134.GB72816@ik1-406-35019.vs.sakura.ne.jp>
References: <20230623164015.3431990-1-jiaqiyan@google.com>
 <20230623164015.3431990-5-jiaqiyan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230623164015.3431990-5-jiaqiyan@google.com>
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

On Fri, Jun 23, 2023 at 04:40:15PM +0000, Jiaqi Yan wrote:
> Add tests for the improvement made to read operation on HWPOISON
> hugetlb page with different read granularities. For each chunk size,
> three read scenarios are tested:
> 1. Simple regression test on read without HWPOISON.
> 2. Sequential read page by page should succeed until encounters the 1st
>    raw HWPOISON subpage.
> 3. After skip raw HWPOISON subpage by lseek, read()s always succeed.
> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>

Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
