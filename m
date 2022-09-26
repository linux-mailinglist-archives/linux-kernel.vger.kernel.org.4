Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E027C5EA9ED
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbiIZPNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235798AbiIZPNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:13:04 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7D9E78BE2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:53:14 -0700 (PDT)
Received: from 8bytes.org (p549ad5ad.dip0.t-ipconnect.de [84.154.213.173])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 561102227B5;
        Mon, 26 Sep 2022 15:53:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1664200393;
        bh=5PaDoyKNdKDJX2cMsX5qdadmFvQXzf7iGroKCZ22kGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LIaJMQZuZnjV8USISuWc3CvctvFHVU4mCJ+uaxRx6mSE0YdvCeBoGzszZ8p7nuIQD
         gykJWLIV26oCfMYZxE1Xd7UwTFn/TRRJieRDAfKeHvYqnatLVAsejDPiTcsdvN0/Bt
         jC4P4JQXeeobG6zBfI/7g/3BcCfN2EMgfumfp++JHZ77FcJs2ffRdUc67AANP8Zwdl
         BcmAIKoRWe5hMBXqr0jM5jv8vLLY9FzAsnNe/hvQmE3iDST87BmIBGWSbvTGqwVmqM
         OSTPMP2Gqdt3ebLCPxtrx4QJfyIAYXEPqU9AfKNIYm18tX5ncWpIwo1YCrckgq0/+i
         TDIxu2W5q5PJQ==
Date:   Mon, 26 Sep 2022 15:53:12 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 0/6] [PULL REQUEST] Intel IOMMU updates for Linux
 v6.1
Message-ID: <YzGuyA0vaNGDfTtZ@8bytes.org>
References: <20220926131529.4045281-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926131529.4045281-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 09:15:23PM +0800, Lu Baolu wrote:
> Lu Baolu (5):
>   iommu/vt-d: Remove unnecessary SVA data accesses in page fault path
>   iommu/vt-d: Decouple PASID & PRI enabling from SVA
>   iommu/vt-d: Remove pasid_set_eafe()
>   iommu/vt-d: Avoid unnecessary global IRTE cache invalidation
>   iommu/vt-d: Avoid unnecessary global DMA cache invalidation
> 
> Yi Liu (1):
>   iommu/vt-d: Rename cap_5lp_support to cap_fl5lp_support

Applied, thanks Baolu.
