Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9E674A85A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 03:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjGGBGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 21:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGGBGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 21:06:41 -0400
Received: from out-45.mta1.migadu.com (out-45.mta1.migadu.com [95.215.58.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FFB1BDB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 18:06:40 -0700 (PDT)
Date:   Fri, 7 Jul 2023 10:06:27 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688691998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wRs7UDAuBBZVgG3mgjyndrSpjt8gqrJGLfpPaemJoWM=;
        b=f6OffiSsSmbedveQuKFXNzJtLUS3lqfI4EGER6lUu6oj2ID2wFCTU8Wzw8D1K3J/icI28k
        hu5D4qUCe44JYs77N2IVgR93kznTAUyqVWYC1w0msg6YjB897Aeg4DbOycwwxiGIbgd1A7
        JG81lKy7zSPTk1E4MZrtkBsLDrBFo8U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Jiaqi Yan <jiaqiyan@google.com>
Cc:     mike.kravetz@oracle.com, naoya.horiguchi@nec.com,
        songmuchun@bytedance.com, shy828301@gmail.com,
        linmiaohe@huawei.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duenwen@google.com, axelrasmussen@google.com, jthoughton@google.com
Subject: Re: [PATCH v2 2/4] mm/hwpoison: check if a subpage of a hugetlb
 folio is raw HWPOISON
Message-ID: <20230707010627.GC72816@ik1-406-35019.vs.sakura.ne.jp>
References: <20230623164015.3431990-1-jiaqiyan@google.com>
 <20230623164015.3431990-3-jiaqiyan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230623164015.3431990-3-jiaqiyan@google.com>
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

On Fri, Jun 23, 2023 at 04:40:13PM +0000, Jiaqi Yan wrote:
> Adds the functionality to tell if a subpage of a hugetlb folio is a
> raw HWPOISON page. This functionality relies on RawHwpUnreliable to
> be not set; otherwise hugepage's HWPOISON list becomes meaningless.
> 
> Exports this functionality to be immediately used in the read operation
> for hugetlbfs.
> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>

Looks good to me, thank you.

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
