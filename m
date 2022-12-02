Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0484A640506
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbiLBKra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbiLBKr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:47:27 -0500
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8884638A0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 02:47:26 -0800 (PST)
Received: from 8bytes.org (p200300c27724780086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7724:7800:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id ED0252A1015;
        Fri,  2 Dec 2022 11:47:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1669978045;
        bh=MrRLtMGdkNoDB4cZ7dIOWUTKNshh0a2U2aNyuOa2eRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=5TWv0wC8jU4XRCyosPu9bWr5fOVAReMSrNqp3/OtCB0ohTA5exc8DMzMI98VfXIOb
         1AA4wRbGs7t+unoPkbN2VSylB1B23yZ/fDxENs3poGMtIeQg7DBIorHCvYm6Rb8of5
         nEu9Bt5FEmi2AW/pcNSGu9s6/yDWmYxcklsFJUPjAFzN+oRsLz8Kg2KxJbrStikK7m
         JtW1KbI/BPK8VMzRTbq2E9JR5PCaiHPDjUHe5QLuhcAzFiYI9djEpajYG/SIPm/ngA
         cXcuD2eBPFL8fyWSexjOqDRGUFXNp/lmFtcvSxDGaT+oOCSKWYqlcJnBAxaN32CaaZ
         1Kc4ovisG5c3w==
Date:   Fri, 2 Dec 2022 11:47:23 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] [PULL REQUEST] iommu/vt-d: Fixes for v6.1-rc8
Message-ID: <Y4nXu9uBwXZFwjq2@8bytes.org>
References: <20221201040127.1962750-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201040127.1962750-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 12:01:23PM +0800, Lu Baolu wrote:
> Jacob Pan (1):
>   iommu/vt-d: Add a fix for devices need extra dtlb flush
> 
> Xiongfeng Wang (2):
>   iommu/vt-d: Fix PCI device refcount leak in has_external_pci()
>   iommu/vt-d: Fix PCI device refcount leak in dmar_dev_scope_init()
> 
> Yang Yingliang (1):
>   iommu/vt-d: Fix PCI device refcount leak in prq_event_thread()
> 
>  drivers/iommu/intel/iommu.h |  4 ++
>  drivers/iommu/intel/dmar.c  |  1 +
>  drivers/iommu/intel/iommu.c | 73 +++++++++++++++++++++++++++++++++++--
>  drivers/iommu/intel/svm.c   | 19 +++++++---
>  4 files changed, 88 insertions(+), 9 deletions(-)

Applied to iommu/fixes, thanks Baolu.
