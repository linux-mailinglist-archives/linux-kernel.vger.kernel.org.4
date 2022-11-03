Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0A9617FF0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiKCOss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiKCOsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:48:45 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5691911832
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 07:48:44 -0700 (PDT)
Received: from 8bytes.org (p5b00664c.dip0.t-ipconnect.de [91.0.102.76])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 7205C260426;
        Thu,  3 Nov 2022 15:48:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1667486923;
        bh=txPdoD5AoxivekOG2y0mw0Wp4HusexslPM7jODW2sOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iacJLOr2PYfD2TzAsUkq+kpu8SY6r0IT5osQcka62nym4ut8KD3QHxAu1guGfWK+g
         lc+5JlsUYWcAZRjMyar6fZQ3suendfRNnPhUotlQJ2z1UiSOD3O/kA2RH7OgPtDsIu
         Oxn2tYwkAwicmf51diOBTLPfAn0tf0IJbppN2oXzIz+dS2IkROEdgD+OWCfSKFhxan
         yiisNIpVNTiehP/erhMVdySN2XeeBlluYapIc94P3oOlKBoa+BTz/l4bSPoi4QDdP/
         cwWGWIPMZZGy4Yin1aVih/zpMYbc3p7Gx3wP86bth7I1JvEtsMpFhFwzos+1Z5d+/9
         7IirTh7epT+CA==
Date:   Thu, 3 Nov 2022 15:48:42 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v14 00/13] iommu: SVA and IOPF refactoring
Message-ID: <Y2PUyu46CN6iEHLc@8bytes.org>
References: <20221031005917.45690-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031005917.45690-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 08:59:04AM +0800, Lu Baolu wrote:
> Lu Baolu (13):
>   iommu: Add max_pasids field in struct iommu_device
>   iommu: Add max_pasids field in struct dev_iommu
>   iommu: Remove SVM_FLAG_SUPERVISOR_MODE support
>   PCI: Enable PASID only when ACS RR & UF enabled on upstream path
>   iommu: Add attach/detach_dev_pasid iommu interfaces
>   iommu: Add IOMMU SVA domain support
>   iommu/vt-d: Add SVA domain support
>   arm-smmu-v3/sva: Add SVA domain support
>   iommu/sva: Refactoring iommu_sva_bind/unbind_device()
>   iommu: Remove SVA related callbacks from iommu ops
>   iommu: Prepare IOMMU domain for IOPF
>   iommu: Per-domain I/O page fault handling
>   iommu: Rename iommu-sva-lib.{c,h}

Applied, thanks everyone.
