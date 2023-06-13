Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345A872D74B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 04:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238929AbjFMCTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 22:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjFMCTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 22:19:18 -0400
Received: from out-51.mta1.migadu.com (out-51.mta1.migadu.com [95.215.58.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658EF10EA
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 19:19:16 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686622752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uou5ls9pyCqhIbOJJaAoM7xAehoXLMNstLhmTAo7OhU=;
        b=IrhSsn/xh3QD55/RzjLcma7iGkedEPhSXluN8rW/zEUtAAbP5Cs9WL0RMZVdf6gIGnCUEW
        GW5HaK/yDppZBwthBrUQilCSAh9aHpt+nQY8af4n8rFyceUVHp+aEnu7u7yvS8OynObOrW
        IUw+6wD3JxM2JSRjIkgmjKbBrgangWw=
MIME-Version: 1.0
Subject: Re: [PATCH] [mm-unstable] mm/folio: Replace set_compound_order with
 folio_set_order
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230612093514.689846-1-tsahu@linux.ibm.com>
Date:   Tue, 13 Jun 2023 10:18:29 +0800
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-kernel@vger.kernel.org, jaypatel@linux.ibm.com
Content-Transfer-Encoding: 7bit
Message-Id: <33402181-6C78-4380-A02A-A36EDEBE4F30@linux.dev>
References: <20230612093514.689846-1-tsahu@linux.ibm.com>
To:     Tarun Sahu <tsahu@linux.ibm.com>
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



> On Jun 12, 2023, at 17:35, Tarun Sahu <tsahu@linux.ibm.com> wrote:
> 
> The patch [1] removed the need for special handling of order = 0
> in folio_set_order. Now, folio_set_order and set_compound_order becomes
> similar function. This patch removes the set_compound_order and uses
> folio_set_order instead.
> 
> [1] https://lore.kernel.org/all/20230609183032.13E08C433D2@smtp.kernel.org/
> 
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

