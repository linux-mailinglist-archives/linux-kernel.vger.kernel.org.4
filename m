Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697FE6C4C71
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjCVNwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjCVNvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:51:52 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC60E55AE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 06:51:19 -0700 (PDT)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id B23BE24181C;
        Wed, 22 Mar 2023 14:51:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1679493071;
        bh=vMPcPvuHUxpYrOPx4LpQpEsInpJPvv0VgitYVlLxKyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R1/IQHLjWdiGXcE7G13qn4W3taau9Vy/UI+LM9IB4aWV/+QluIke0J/LvTdhihhcE
         7LlPN9pgKzveME8i5ChRGKFoJl4fEYfJSzjhWAADtnue5H3smXToQKxfAugzAxMMrI
         ygtMEaBfKPjROAhhCNpgA8GbeZcxsfbAqon10fZxLLB+LUJFdkkY1WLyvMCDchvMZA
         0UPc8o9vC+ebjbMbn2B4LiHH3OZKQhQQyhSW8D4KSrp2BiyaWpu+1euPrEfJ0xiYoN
         spWBYKSByMCkHj8qv/9FZtiAfNX5jxUIQdhMg2f4V9Te8sTgocYP3VlT68gygBomxc
         0HJZ2Oe/hDtGQ==
Date:   Wed, 22 Mar 2023 14:51:10 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        Timur Tabi <timur@tabi.org>,
        Varun Sethi <Varun.Sethi@freescale.com>,
        Emil Medve <Emilian.Medve@freescale.com>
Subject: Re: [PATCH] iommu/fsl: fix all kernel-doc warnings in fsl_pamu.c
Message-ID: <ZBsHzvMpgSmyf4HV@8bytes.org>
References: <20230308034504.9985-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308034504.9985-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 07:45:04PM -0800, Randy Dunlap wrote:
>  drivers/iommu/fsl_pamu.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Applied, thanks.
