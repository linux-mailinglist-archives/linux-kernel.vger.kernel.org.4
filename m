Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F79F6072E6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiJUIub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiJUIuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:50:09 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 751A263F16
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:50:02 -0700 (PDT)
Received: from 8bytes.org (p5b00664c.dip0.t-ipconnect.de [91.0.102.76])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id D0178242598;
        Fri, 21 Oct 2022 10:50:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1666342201;
        bh=cfUwgLtB39hN+mxHSysvq+yWIatvClQidnX8Cm/4Wl8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fi6NSOqWAegHInoG7ee0kItylfJTR1WSMcJuy+C2Xu3d4q9h4yCOsoITPPuOipl50
         Eh/gRKzhiljtdQLQdUj7LxsljH1TpeTwPFK4w1tAhdV4wqqrzvwylvvle8M3kI7GvX
         zPhYKhJ+oTohpMUfokdMHRq7EQc+Dw9h14r8pygFH7nNh4n0T0Eyu7fT/9uFUUaWRc
         HZrwCWXsKGQuU2HYd+GHv/9BMVAtcaVpUCUyvFAxFCm4x8uYRo+4rX0Pj12s6jz1UL
         WU/D4+XWV0pcejhYt7rO3iscv9kygmrsNgZoPnHP3hmnwr2xmXhGaAIDWrIapIHkC8
         3j/y8Fl+FFaEw==
Date:   Fri, 21 Oct 2022 10:49:59 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Charlotte Tan <charlotte@extrahop.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] [PULL REQUEST] iommu/vt-d: Fixes for v6.1-rc2
Message-ID: <Y1JdN+UchhONn0Eh@8bytes.org>
References: <20221019004447.4563-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019004447.4563-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 08:44:43AM +0800, Lu Baolu wrote:
> Hi Joerg,
> 
> Below fixes are queued for v6.1. They aim to fix:
> 
> - A lockdep splat issue in intel_iommu_init().
> - Allow NVS regions to pass RMRR check.
> - Domain cleanup in error path.
> 
> This series is also available at github.
> https://github.com/LuBaolu/intel-iommu/commits/vtd-fix-for-v6.1-rc2

Applied, thanks Baolu.

