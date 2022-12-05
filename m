Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A8E6426E3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 11:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiLEKng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 05:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiLEKne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:43:34 -0500
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71D3A559C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 02:43:32 -0800 (PST)
Received: from 8bytes.org (p200300c27724780086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7724:7800:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id F1B4D22024E;
        Mon,  5 Dec 2022 11:43:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1670237011;
        bh=FUZ3mP02M0qgiK21lDW2eL1s8dfFYJmuVtohfwzKNpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fvO7NFJzPMBOSd++Nb3xEuDW43D75gK/neAu4kvgwYqoaRzD5YMxJNJ4frTe6wtr6
         1l5H5vfVB3WLqKMgFeYO1MFSHQ1njB+hpgAfhb2OjlZv5BMjPXGS8j6xazj5eF7x4K
         dwfjrLrFMJbcjgFMa4sUzsj4DiV5s2IyKB/6cHPpWD7bBXRluYPg1sl8chwl98Bv75
         u1IOXLTo/EIsu6ZWEfC42xzg1DYM8VmJ4doDkC3+5ldYBAFax1PZou3uJVD557ixLg
         gEUXdmYA+Z66x4DQ9FZMQj0S6gYUh5j5dYey9mdL/GNF+Le9htnUKwBJ39SCriHFR1
         o3X432ZwDCkzA==
Date:   Mon, 5 Dec 2022 11:43:29 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Yuzhang Luo <yuzhang.luo@intel.com>
Subject: Re: [PATCH v3] iommu/vt-d: Add a fix for devices need extra dtlb
 flush
Message-ID: <Y43LUVS1heMxGBC7@8bytes.org>
References: <20221130062449.1360063-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130062449.1360063-1-jacob.jun.pan@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 10:24:49PM -0800, Jacob Pan wrote:
>  drivers/iommu/intel/iommu.c | 67 +++++++++++++++++++++++++++++++++++--
>  drivers/iommu/intel/iommu.h |  3 ++
>  drivers/iommu/intel/svm.c   |  5 ++-
>  3 files changed, 72 insertions(+), 3 deletions(-)

I removed this commit from my fixes branch. Please re-submit with the
fix included and I will queue it for 6.2 once Lu Baolu acked it.

Thanks,

	Joerg
