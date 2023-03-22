Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FABD6C4E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjCVOtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjCVOtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:49:18 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A848365C7F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:47:53 -0700 (PDT)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 8CA95242E0C;
        Wed, 22 Mar 2023 15:47:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1679496472;
        bh=e6ntdoYKIlmy8eZXXKM/yz6f+rfPawT8id1Orru0Mng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UelYpbZW8XKyweH59YjIRsv7gF2+/dQ3z8w4Pqkqagzd+6OZPeQGFJrIjg5kVJ0zz
         IOV+eubMUHtnntuqCia7UHO5E7N+IHXl2VITQyheSxhmIX8LMlT3JzyeJVNXyi/c0+
         dOeV9m1gB+Fp3q4Oan9DK9Wb1D98emrHU2EOaDfR1ATTZ+wPYZ4cVu2iwJfFTxVaoN
         62KWu4jfvJKZkx51rO83uIwQprWUM3BRqX2LG6qiDLyFNHucbqNPgM/MPKN0S/2LlA
         gTtxFxv9JTh5qhHpQcFQdoJzVAmQuwPtW7VE3WSEIzdp0QyD1y0+vyiv6SLj3Vg4U5
         1l+giSVQxIMOQ==
Date:   Wed, 22 Mar 2023 15:47:51 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu: Use sysfs_emit() for sysfs show
Message-ID: <ZBsVF+WJbsCip22A@8bytes.org>
References: <20230322123421.278852-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322123421.278852-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 08:34:21PM +0800, Lu Baolu wrote:
>  drivers/iommu/amd/init.c    |  4 ++--
>  drivers/iommu/intel/iommu.c | 17 +++++++++--------
>  drivers/iommu/iommu.c       | 31 +++++++++++++++----------------
>  3 files changed, 26 insertions(+), 26 deletions(-)

Applied, thanks.

