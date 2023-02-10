Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB8B6929BE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 22:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbjBJV7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 16:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjBJV72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:59:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405F87DD22
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 13:59:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFB8E61EAA
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 21:59:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD46C433EF;
        Fri, 10 Feb 2023 21:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1676066367;
        bh=aqHfOPN6cTs4gE4mjOFdD6UuEqhAggZpnmYAD74tnCs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ctDp4g6ZS77LvekOd2UbX6kBBoByxy+taYBZ8y4y1Hx4ROTyXDJnfWJJGEfNZnR9U
         d50WjiDdAq1APUGlMuU1BroLqtj5tZEFBXuDy9w1+CI5WXDzJ97m1OnEOVSzNdckil
         4wDEd9lXZcTLu4HwXEpMosrhDy8uNMd8Nw6ugKOI=
Date:   Fri, 10 Feb 2023 13:59:26 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-mm@kvack.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH v2 4/4] mm: Remove get_kernel_pages()
Message-Id: <20230210135926.f0c86a21d5b4862d4d897b25@linux-foundation.org>
In-Reply-To: <20230203-get_kernel_pages-v2-4-f1dc4af273f1@intel.com>
References: <20230203-get_kernel_pages-v2-0-f1dc4af273f1@intel.com>
        <20230203-get_kernel_pages-v2-4-f1dc4af273f1@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Feb 2023 20:06:35 -0800 Ira Weiny <ira.weiny@intel.com> wrote:

> The only caller to get_kernel_pages() [shm_get_kernel_pages()] has been
> updated to not need it.
> 
> Remove get_kernel_pages().

Acked-by: Andrew Morton <akpm@linux-foudation.org>

