Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8738C6E0B00
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjDMKGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjDMKGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:06:20 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A60D6A4D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:06:19 -0700 (PDT)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 57B5D242D84;
        Thu, 13 Apr 2023 12:06:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1681380378;
        bh=4gThnfpsRqzwASHZ1HgYwpGgnzDNTnscEc/9wsZnTcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rS4CpcSGtqIoISkWPV9IMCAAxxpTcZRGGcID1l/cwQPy04xYA+jAcnXTaBzK0yHMa
         /TjIH42K/MNxHZ/4fmvdPgu9yeXmA4duGqrfLdxb9H6b/z6gXEemnS3uOhDKdUT0f7
         K9sezEAd8G+gDuV+qBnXwQr3U3Hpw8ZRMU7Da+Rpdwm3LZA2tiitYdhFbLLTzmxbGk
         mKCccaHP3hjXpiZAg9fe5/XiT7cTTjp7ZpPwQrxcJJ0fOnwmolSYaGPe1FCq1o1VMn
         hBGc5WOOS8nKrySbq7+YPQYfoQGHOGmyLNf072c6F+fFO8eJvx9V8t1J9zvhL8mCnd
         nmbpZ1qsUeZuw==
Date:   Thu, 13 Apr 2023 12:06:17 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Tina Zhang <tina.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/17] [PULL REQUEST] Intel IOMMU updates for Linux
 v6.4
Message-ID: <ZDfUGa2qikAlA9rN@8bytes.org>
References: <20230413040645.46157-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413040645.46157-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 12:06:28PM +0800, Lu Baolu wrote:
> Lu Baolu (7):
>   dmaengine: idxd: Add enable/disable device IOPF feature
>   iommu/vt-d: Allow SVA with device-specific IOPF
>   iommu/vt-d: Move iopf code from SVA to IOPF enabling path
>   iommu/vt-d: Move pfsid and ats_qdep calculation to device probe path
>   iommu/vt-d: Move PRI handling to IOPF feature path
>   iommu/vt-d: Remove unnecessary checks in iopf disabling path
>   iommu/vt-d: Remove extern from function prototypes
> 
> Tina Zhang (7):
>   iommu/vt-d: Make size of operands same in bitwise operations
>   iommu/vt-d: Remove BUG_ON on checking valid pfn range
>   iommu/vt-d: Remove BUG_ON in handling iotlb cache invalidation
>   iommu/vt-d: Remove BUG_ON when domain->pgd is NULL
>   iommu/vt-d: Remove BUG_ON in map/unmap()
>   iommu/vt-d: Remove a useless BUG_ON(dev->is_virtfn)
>   iommu/vt-d: Remove BUG_ON in dmar_insert_dev_scope()

Applied, thanks.
