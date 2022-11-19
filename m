Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39278630DD0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 10:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbiKSJ3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 04:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiKSJ3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 04:29:04 -0500
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8884786F0;
        Sat, 19 Nov 2022 01:29:02 -0800 (PST)
Received: from 8bytes.org (p200300c27724780086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7724:7800:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 56C972A02A4;
        Sat, 19 Nov 2022 10:29:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1668850140;
        bh=dqlKfPO9QbDBrJIzFpFlV20TRcScRvRVpQuvbktrOYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WiNFxz8owGXuZEK3l58tOB0RfvWZN1p69awahKKkvpCjWdYjqIRnRJUhxtGdfwR+O
         +M3rt91d2uy222qwWSXClmIoMaDcKbEHCMj/0HqIJUDPjRjjw25qyZ+UBBqgqqoucQ
         u+FNNMPTDVTH6+hRru8Kd14UJjO6v8FlSnVo/Cl5tnZKc3FsNMUwR/PDIN1C/wokru
         jE1itk8d3cukb6mu0ZXEOIqa6nohhCwFlV5vipizrUGRy2rs8SEDJJOJDb3ZqjqfCS
         PoO5Y5fiMrSI8bDrwBNF8Xh36DS9JaPKn8UG14YLkyosuc+XWreb4K07VP+1IWXIMZ
         5KEaKJ8FnoVcA==
Date:   Sat, 19 Nov 2022 10:28:59 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] iommu/s390: Further improvements
Message-ID: <Y3ih2xslqkmQYLZp@8bytes.org>
References: <20221109142903.4080275-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109142903.4080275-1-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 03:28:58PM +0100, Niklas Schnelle wrote:
> Niklas Schnelle (5):
>   iommu/s390: Make attach succeed even if the device is in error state
>   iommu/s390: Add I/O TLB ops
>   iommu/s390: Use RCU to allow concurrent domain_list iteration
>   iommu/s390: Optimize IOMMU table walking
>   s390/pci: use lock-free I/O translation updates

Applied, thanks.
