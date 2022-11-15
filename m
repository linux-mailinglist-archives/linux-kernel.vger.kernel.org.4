Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4124562A1DF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 20:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiKOT3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 14:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiKOT3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:29:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C9015724;
        Tue, 15 Nov 2022 11:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oj/LYRaa/WopSA/lV9yZN5Xxax3IbvylgpwFxFjSk8M=; b=4B6BE85a6e0giCD+GbtM34EFM6
        x8P/RDuMpqVKH04cYe52/ZxuUQw9z1HE09oZpcuuKalB0m5DMWR7mUNsbfSqROxo2ejjZ8UIezZBi
        nM9lQ6eqVQMejOv5iXExWpqwR+V882/czCf/J95yyODel09lZ2ycyYbbJVwqyDRa+ACEs69ezm7wy
        cxTqErrc7fxROPtJjVZFLAQZvhLcZPYdCUHAkebfE8Y0uuY3949UiFKo57T4aaoiXoh0tp85hvypK
        OSZcWmGiKd1WGz2I7NsGr6BYzTzkk+CIrf67dsSVZSOkEOdrc1Y9e3OTKWV7H/q8Y3H2aBNR6sASI
        RH6fmAFQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ov1cd-00EHxC-Kl; Tue, 15 Nov 2022 19:29:27 +0000
Date:   Tue, 15 Nov 2022 11:29:27 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Prarit Bhargava <prarit@redhat.com>, pmladek@suse.com,
        Petr Pavlu <petr.pavlu@suse.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Message-ID: <Y3Pol5H4kJioAV9W@bombadil.infradead.org>
References: <20220919123233.8538-1-petr.pavlu@suse.com>
 <20220919123233.8538-3-petr.pavlu@suse.com>
 <YzdR0gRNQI2BGnJ9@bombadil.infradead.org>
 <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
 <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
 <d0bc50e3-0e42-311b-20ed-7538bb918c5b@suse.com>
 <Y277Jb9i2VeXQoTL@bombadil.infradead.org>
 <e070839f-c224-047b-9411-91143c1d8394@redhat.com>
 <Y3Jg8X7qv2AKPU1J@bombadil.infradead.org>
 <5467e66d-55de-ca8f-c1ae-ffe6efe7290d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5467e66d-55de-ca8f-c1ae-ffe6efe7290d@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 04:45:05PM +0100, David Hildenbrand wrote:
> Note that I don't think the issue I raised is due to 6e6de3dee51a.
> I don't have the machine at hand right now. But, again, I doubt this will
> fix it.

There are *more* modules processed after that commit. That's all. So
testing would be appreciated.

  Luis
