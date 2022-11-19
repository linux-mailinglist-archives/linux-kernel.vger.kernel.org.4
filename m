Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A214630DEB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 10:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbiKSJrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 04:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiKSJry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 04:47:54 -0500
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B8B5A8C0F
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 01:47:53 -0800 (PST)
Received: from 8bytes.org (p200300c27724780086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7724:7800:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 655AD2A02A4;
        Sat, 19 Nov 2022 10:47:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1668851272;
        bh=Zf9aa1RLS0tHLuH7NSJiJ3JYeFNUYTJkPc4aVdeJiSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ISFKVf7a37WmbmKCcO5VrYObPltiajnMbgrttv7Gt2R7g92VrTtqqzcicFJ+/Ub9z
         eq4i8om4uhAbHrOuBbCn+ESYudjnCsoSAMz+7qCUTX9arfYOPXaLiUlWhBCkgSsFtA
         VICRVIaeBabXq3Anm9MSw0Omfba8BlkxgMueiScoBRhIMhCFqoRllFfRqTxcj1LOg8
         25M8SkXqsJQK/FmYOq04ER0X9cBBaZTFaENj0qVQqm+3LXOEQ2Dq9foJfx37Atnuh7
         9plMENALUyvJxFFJWu3Fc1SqeIAhYwZdcIjbsQUFIbNY8Z6WuZ6A3RqYrTVmADAmus
         3YRV/ts6hknZA==
Date:   Sat, 19 Nov 2022 10:47:51 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Tina Zhang <tina.zhang@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] [PULL REQUEST] iommu/vt-d: Fixes for v6.1-rc6
Message-ID: <Y3imR2x/ZfEFP94t@8bytes.org>
References: <20221116051544.26540-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116051544.26540-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 01:15:42PM +0800, Lu Baolu wrote:
> Tina Zhang (2):
>   iommu/vt-d: Preset Access bit for IOVA in FL non-leaf paging entries
>   iommu/vt-d: Set SRE bit only when hardware has SRS cap
> 
>  drivers/iommu/intel/iommu.c | 8 +++-----
>  drivers/iommu/intel/pasid.c | 5 +++--
>  2 files changed, 6 insertions(+), 7 deletions(-)

Applied for v6.1, thanks Baolu and Tina.
