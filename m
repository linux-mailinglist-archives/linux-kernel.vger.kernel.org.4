Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C436929BD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 22:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbjBJV7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 16:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbjBJV7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:59:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2406A7DD27
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 13:59:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADBA061EB5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 21:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B181FC433D2;
        Fri, 10 Feb 2023 21:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1676066343;
        bh=hBUOtKkxtZPZmPyYXEVQpixGinkIw9aIXulO6Fx7MQc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a/sXNPD9a81HkPyB/RyCbKWhLW0Fy1Fz5afMy+SsA/98bItYohut+acZATCA+Q3k7
         DotIxmhiTBwcNnkFsDWVJFmurN5UgrqaePmY6kRDqktsgXYNLxvbEV8yMichonXHLP
         eJVmH8NILcJfNzsNi/L8F87JKzlWA8w/1hyY/fPI=
Date:   Fri, 10 Feb 2023 13:59:02 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-mm@kvack.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/4] highmem: Enhance is_kmap_addr() to check
 kmap_local_page() mappings
Message-Id: <20230210135902.343f6c40001f1f2e10cedd93@linux-foundation.org>
In-Reply-To: <20230203-get_kernel_pages-v2-1-f1dc4af273f1@intel.com>
References: <20230203-get_kernel_pages-v2-0-f1dc4af273f1@intel.com>
        <20230203-get_kernel_pages-v2-1-f1dc4af273f1@intel.com>
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

On Fri, 03 Feb 2023 20:06:32 -0800 Ira Weiny <ira.weiny@intel.com> wrote:

> is_kmap_addr() is only looking at the kmap() address range which may
> cause check_heap_object() to miss checking an overflow on a
> kmap_local_page() page.
> 
> Add a check for the kmap_local_page() address range to is_kmap_addr().

Acked-by: Andrew Morton <akpm@linux-foudation.org>

