Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC3E699605
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjBPNm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjBPNmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:42:25 -0500
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 891F855E77
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:42:20 -0800 (PST)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 28D312245E3;
        Thu, 16 Feb 2023 14:42:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1676554939;
        bh=yOTiUP0Jwiv6lAYuLmeP8b3CGVgkw7PMeJqE90Xxj+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2L34TKAd+XrPb/18XNnKZpLr4BFEot2XeuXjTL0whTNiLrE1E7Cu88Aw926/WmiUt
         0mPCi7JKC7lNZsx/lvvwUQYsiagESxyGCATaGsRMGk4fkX1/QHFBYTzrlsDZPqpLDz
         NFVZYnfB0fiH83OEXdl+XJ/P6YYzofRu//INuUSZX9Qg0uFJskO3zFP8ETrpbSxsoJ
         3HTb5QYWXGYX5+GnQa6BzMN0MbtefMtmxsixjGow0NXmzJGn8Yl3UmvqONLOhslQ1i
         YC3eJDC/w8EOXPY+si49N6OXqFB+y410vEhzSIasZQ9okkZMaun35RivIP6TUAWBSA
         GDgvyItR8k2mQ==
Date:   Thu, 16 Feb 2023 14:42:17 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Tina Zhang <tina.zhang@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] [PULL REQUEST] iommu/vt-d: Fixes for v6.2-rc8
Message-ID: <Y+4yuaciYYnptpKI@8bytes.org>
References: <20230216130816.151824-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216130816.151824-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

On Thu, Feb 16, 2023 at 09:08:12PM +0800, Lu Baolu wrote:
> Below iommu/vt-d fixes are queued for your fixes branch.
> 
> - Two performance optimizations
> - Fix PASID directory pointer coherency
> - Fix missed rollbacks in error path
> 
> Please consider it for the iommu/fixes branch.

So nothing of this seems really critical (e.g. fixes a regression that a
number of people are encountering). Especially the performance
optimizations do not qualify as fixes at this stage of the cycle. I will
queue them in the VT-d branch so that they go upstream in the next merge
window, unless you convince me otherwise.

Regards,

	Joerg
