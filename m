Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C15B603641
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJRWyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJRWyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:54:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA6BAC4B0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 15:54:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8B4A61713
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:54:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E655FC433D7;
        Tue, 18 Oct 2022 22:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666133648;
        bh=62ein6zk//FYRqXxpk4NDw+VTD3FYrLTczKhbyNmhTA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kuIsBb/jJu+Rb0wN62bc6xOuq8iX6x/+dLOeQscUmPiKFEfN6wELKwD3WtRjcpVbD
         o1GKVuOj7os7ZJLQpjdXhB/GIczm6coNTWBqodL8slCZlHzaMW9CXDfq2LwsXMfCIW
         uXnMVPTPd/W+6aejFjGP85YFK6G/gY1hSucfx4LM=
Date:   Tue, 18 Oct 2022 15:54:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     xu xin <xu.xin.sc@gmail.com>
Cc:     david@redhat.com, imbrenda@linux.ibm.com, jiang.xuexin@zte.com.cn,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn, xu.xin16@zte.com.cn, yang.yang29@zte.com.cn
Subject: Re: [PATCH v3 0/5] ksm: support tracking KSM-placed zero-pages
Message-Id: <20221018155407.41c993924ec09a64ae966d50@linux-foundation.org>
In-Reply-To: <20221018090022.373574-1-xu.xin16@zte.com.cn>
References: <20221017165541.6e2d3cebdc1ba13861ea4b2b@linux-foundation.org>
        <20221018090022.373574-1-xu.xin16@zte.com.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2022 09:00:22 +0000 xu xin <xu.xin.sc@gmail.com> wrote:

> >A full description of the real-world end-user operational benefits of
> >these changes would help, please.
> >
> 
> The core idea of this patch set is to enable users to perceive the number of any
> pages merged by KSM, regardless of whether use_zero_page switch has been turned
> on, so that users can know how much free memory increase is really due to their
> madvise(MERGEABLE) actions.

OK, thanks.

> The motivation for me to do this is that when I do
> an application optimization of KSM on embedded Linux for 5G platform, I find
> that ksm_merging_pages of some process becomes very small(but used to be large),
> which led me to think that there was any problem with the application KSM-madvise
> strategy, but in fact, it was only because use_zero_pages is on.

Please expand on the above motivation and experience, and include it in
the [0/n] changelog.  But let's leave it a few days to see if there's
additional reviewer input.
