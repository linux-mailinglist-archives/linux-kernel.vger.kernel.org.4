Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41FE5EA7DE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbiIZODt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbiIZODZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:03:25 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E2201FF175
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 05:15:47 -0700 (PDT)
Received: from 8bytes.org (p549ad5ad.dip0.t-ipconnect.de [84.154.213.173])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 0ABCB2226BF;
        Mon, 26 Sep 2022 14:15:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1664194544;
        bh=WJXzkJQIz7xvAh8fFvNVW3CzT7S3ga8NnyAq8PJmDTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p7yDg7D2eBLRRfXdbW1D2luzaBOXJbckULanfHivc7nlwUmYEhfnece2+c6SsKykZ
         PkvrzpLbaQHUMKFzpIx1j9INp9xbb9Iirx1Qgl8RyPyXYHrx5ecrto8+8TEA3kZY2A
         wfqhPMHfnSi+5xDssBDj5Ztp6UbR3QzTYFHI4wpYL9BxJmMvq0ojST9tPuULDUoQy1
         nKgMbO/n+z3y/OfWbSy1kXeuhZzJPQUT/hhh8HXT+3uv9SK7IFEMAQAyJ6nTNaaTCD
         /l+jgLGrujUVzA4zfgyCD122Mr49YiTOANG6STZKx/9lOXmNHuvlzfLqMjkg6PGNE1
         7EyMFSaDOB7IA==
Date:   Mon, 26 Sep 2022 14:15:42 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] [PULL REQUEST] Intel IOMMU updates for Linux v6.1
Message-ID: <YzGX7ri+CYTpKfeP@8bytes.org>
References: <20220923004206.3630441-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923004206.3630441-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

On Fri, Sep 23, 2022 at 08:42:00AM +0800, Lu Baolu wrote:
> Lu Baolu (5):
>   iommu/vt-d: Remove unnecessary SVA data accesses in page fault path
>   iommu/vt-d: Decouple PASID & PRI enabling from SVA
>   iommu/vt-d: Remove pasid_set_eafe()
>   iommu/vt-d: Avoid unnecessary global IRTE cache invalidation
>   iommu/vt-d: Avoid unnecessary global DMA cache invalidation
> 
> Yi Liu (1):
>   iommu/vt-d: Rename cap_5lp_support to cap_fl5lp_support

These don't apply cleanly on v6.0-rc4 or -rc7. Please rebase these
patches to my x86/vt-d branch and re-send.

Thanks,

	Joerg
