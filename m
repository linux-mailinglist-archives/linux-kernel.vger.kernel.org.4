Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378A96697B4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241541AbjAMMxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241559AbjAMMwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:52:54 -0500
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73492C3AD7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:40:15 -0800 (PST)
Received: from 8bytes.org (p200300c277327f0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7732:7f00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id B8308261F6C;
        Fri, 13 Jan 2023 13:39:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1673613571;
        bh=ZrIWWj4usm5Rj3xincm+UxecnlDcjwmwb4gBdCSxknM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lzDeew4ATI58lxfpM/0GZWP96lXAR+w+NiCV6gk0Knaro38yrVTPYQH4EI5o9EQlB
         J+W3Od5qp7RxiN3qhQudj2Te+4iRiicgsfIiQ+MtClXAiDPyGk0G3DJ/CAqbANilsG
         V1NnRPreYWPRaHZ/32WlGrQmCRoNWjBJ9nMln/XZBqxI7iQ0K+0GnJ26OAdWVAFVk4
         FobMWWcl4txFr6bphn4DWkVR9a1P/fbx8U8S5ttfIO30IaQ8pF/GVYb3SvsvDEzzLH
         EoGmFIi6Xbjv6751FCynrKbtosk85vhS+rhDAwJR1eybvdleWguCU/HdZ52vgi5Zn0
         tiuZlXQD5TlfA==
Date:   Fri, 13 Jan 2023 13:39:30 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Fix refcount leak in iommu_device_claim_dma_owner
Message-ID: <Y8FRAswB8pW2c8AI@8bytes.org>
References: <20221230083100.1489569-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230083100.1489569-1-linmq006@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 12:31:00PM +0400, Miaoqian Lin wrote:
> iommu_group_get() returns the group with the reference incremented.
> Move iommu_group_get() after owner check to fix the refcount leak.
> 
> Fixes: 89395ccedbc1 ("iommu: Add device-centric DMA ownership interfaces")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/iommu/iommu.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Applied for 6.2, thanks.
