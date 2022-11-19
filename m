Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5FE630DF7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 11:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbiKSKBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 05:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiKSKBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 05:01:01 -0500
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A89882BD7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 02:00:59 -0800 (PST)
Received: from 8bytes.org (p200300c27724780086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7724:7800:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id F20992A00CB;
        Sat, 19 Nov 2022 11:00:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1668852059;
        bh=sG3j6AU8MT7jufEihjOKuYx6KM3TpI7FmwnE0kt4DPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wHI+bN/Y6atuiEw7CN4iZYxkoJGEz5uowLzy1V+chdLZlwgBnDWOPjBb0RLl5IKtj
         n9jXzKIlquZoFNlGrpfI2gr17/ny4K1sdcfDx0Hl4kgYUBtF53PBL24JW09oakM9qF
         qVWkvkFSrV8g3hZ1RFj0jlNGwkHrSndUBOPxOhkiEfKa/bOR4lzaotzWTWTPGjlXTn
         sL2KmF8eDsRiUkN0k+RdUPzeH5Y90vBwOeBgL1YmzZfb8+FzB0wEhzIPlTl4Vm7TRN
         15e6TLrVaNx6o56bX0lMpbAlg8JBp7dZpq+gFTd/BQK83illa5l/y5h4BVslmQzzAW
         UwKx9vOyDrMKA==
Date:   Sat, 19 Nov 2022 11:00:57 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Denis Arefev <arefev@swemel.ru>
Cc:     Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        trufanov@swemel.ru, vfh@swemel.ru
Subject: Re: [PATCH] iommu: amd: Added value check
Message-ID: <Y3ipWTntw24G5XNE@8bytes.org>
References: <20221118104252.122809-1-arefev@swemel.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221118104252.122809-1-arefev@swemel.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 01:42:52PM +0300, Denis Arefev wrote:
> Аdded a return value check for the function
> mmu_notifier_register.
> 
> Return value of a function 'mmu_notifier_register'
> called at iommu_v2.c:642 is not checked,
>  but it is usually checked for this function
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Denis Arefev <arefev@swemel.ru>
> ---
>  drivers/iommu/amd/iommu_v2.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.
