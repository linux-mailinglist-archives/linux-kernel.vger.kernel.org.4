Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E706CCD96
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 00:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjC1WkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 18:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjC1WkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 18:40:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9ADD8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:39:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81136B81EE5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 22:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8E9C4339B;
        Tue, 28 Mar 2023 22:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1680043133;
        bh=gzeXO5QIwdOYBvsPqvO09t1CFBXhqr3jAyNyuJzFOAs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cgNolMjz2rb3vp+zQ0CDdOUS5cRMVZNh+2Fmzibvz9ZkUe3YqT70Oi8YX8gd6cRz9
         7WKMvzXu47CN8bJnJXNlawN3WIGOZ55uHDtbugxdNGLHvMlLXymFQhQyjHp5yQQDO/
         J4PzMIoZXo0f7g/Vl+Cx0R+VnszKgMSD7L9PzlEQ=
Date:   Tue, 28 Mar 2023 15:38:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     <yang.yang29@zte.com.cn>
Cc:     <david@redhat.com>, <imbrenda@linux.ibm.com>,
        <jiang.xuexin@zte.com.cn>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <ran.xiaokai@zte.com.cn>,
        <xu.xin.sc@gmail.com>, <xu.xin16@zte.com.cn>
Subject: Re: [PATCH v6 0/6] ksm: support tracking KSM-placed zero-pages
Message-Id: <20230328153852.26c2577e4bd921c371c47a7e@linux-foundation.org>
In-Reply-To: <202302100915227721315@zte.com.cn>
References: <202302100915227721315@zte.com.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2023 09:15:22 +0800 (CST) <yang.yang29@zte.com.cn> wrote:

> The core idea of this patch set is to enable users to perceive the number of any
> pages merged by KSM, regardless of whether use_zero_page switch has been turned
> on, so that users can know how much free memory increase is really due to their
> madvise(MERGEABLE) actions. But the problem is, when enabling use_zero_pages,
> all empty pages will be merged with kernel zero pages instead of with each
> other as use_zero_pages is disabled, and then these zero-pages are no longer
> monitored by KSM.

We appear to have some outstanding activity on this quite old patchset.
From my notes:

- An unresponded-to question from Claudia:
	https://lkml.kernel.org/r/20230307192421.30ab869c@p-imbrenda

- Hoping for overall review from David

- Another query from Claudia, and a response indicating that a v7 is
  in the works.
	https://lore.kernel.org/all/20230307194320.79373a26@p-imbrenda/T/#u

- Another unresponded-to review query:
	https://lkml.kernel.org/r/20230307195119.745d0b46@p-imbrenda

- Another response indicating that a v7 is coming
	https://lkml.kernel.org/r/20230307195313.2e21245a@p-imbrenda

So I think I'll drop the v6 series.  Please address all these things in
the next version and let's start over.

