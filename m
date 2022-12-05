Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9A5642960
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbiLEN2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbiLEN2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:28:38 -0500
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C2726545
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 05:28:37 -0800 (PST)
Received: from 8bytes.org (p5b00664c.dip0.t-ipconnect.de [91.0.102.76])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 323AE220236;
        Mon,  5 Dec 2022 14:28:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1670246916;
        bh=sjZwdQ/E01patbFy4dg4K68uAHycgom59GJVqAil0v4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ngUhzk0KWx+ZNn/Hg4gJoztANeDcsGZwllQdnUXhIvjUDSGfq8bIp3hG4Nql0vHL8
         KHVIHGebJAj0jZLZ6fE2JRTvbYNyHnYG3h1RXIwWnIOPaXzuRF1jhDdQJUVwstwMRH
         +VZQA1bbXT34aOivkZu1QxY4J16V3ew0O1nsuZUgGgRaqCjivK0NjcPMua8+zft1aL
         AJxQ7lUZ3a+Lc9nfFT/Kn6hdKERldvvFqiCWVtSm2/DyuD5a/BUZS8/yVDKJNoL35e
         dGrbfugvEH4eDjUz5xHFL//0LnmMxgd9cZrsRyKvN2K2OTUMfZxEQSjV0t94F/lzHA
         k0kLgZLacLKzQ==
Date:   Mon, 5 Dec 2022 14:28:35 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] [PULL REQUEST] iommu/vt-d: Fixes for v6.1
Message-ID: <Y43yA2lQhXVJQDhQ@8bytes.org>
References: <20221205131412.2003159-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205131412.2003159-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 09:14:11PM +0800, Lu Baolu wrote:
> Jacob Pan (1):
>   iommu/vt-d: Fix buggy QAT device mask

Pulled, thanks.
