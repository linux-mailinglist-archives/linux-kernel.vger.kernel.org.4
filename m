Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A6B74CF3C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjGJH5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjGJH5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:57:00 -0400
Received: from out-27.mta1.migadu.com (out-27.mta1.migadu.com [95.215.58.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5CC186
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:56:57 -0700 (PDT)
Date:   Mon, 10 Jul 2023 16:56:49 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688975814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6vfLRncH29O8G93sZQGQLC8nrcF+AkfWL0Sz1WsTaS0=;
        b=nvNhHQr7zsC47OVxBBriW1bYfTKeJu3qLqnxoamORj/I0CxUPDa+P7RhnYVhEsT+N4aJgA
        iunH7QNHjhQfqvezvjGJjT2zgkTzoNFt4bDONuMTmkl6X8p1kmVD5IeEsxtR23/ybDsV+5
        PokJmQKOomy1CWm281wNlc3AisLsWAc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] mm: memory-failure: Don't account hwpoison_filter()
 filtered pages
Message-ID: <20230710075649.GC1686200@ik1-406-35019.vs.sakura.ne.jp>
References: <20230708085744.3599311-1-linmiaohe@huawei.com>
 <20230708085744.3599311-4-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230708085744.3599311-4-linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2023 at 04:57:39PM +0800, Miaohe Lin wrote:
> mf_generic_kill_procs() will return -EOPNOTSUPP when hwpoison_filter()
> filtered dax page. In that case, action_result() isn't expected to be
> called to update mf_stats. This will results in inaccurate but benign
> memory failure handling statistics.

Nice catch.

> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
