Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2020E609402
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 16:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJWOg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 10:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiJWOg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 10:36:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB837199A
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 07:36:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F685B80D5C
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 14:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4061DC433D6;
        Sun, 23 Oct 2022 14:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666535812;
        bh=VHsCq3KJhfBXSa7NUYUeMeEK9sRiriWcBkcMV40tuF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a896ovhiG/FxmSu0fUzsV6CY0BrsT8dlwDHluHliQHIUJ8ujOXesmdEZUx0zI/DFS
         YyDIn+00UNjOptdtwAASs0xc1yTfdcPuD6Pm/u0u7nW+e8reQsal0vgbKU1n6TCaoV
         CL9phJ5a86B97feq0A3GfN1U6OD/vLeednRaveno=
Date:   Sun, 23 Oct 2022 16:36:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chen Lin <chen45464546@163.com>
Cc:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        treding@nvidia.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chen Lin <chen.lin5@zte.com.cn>
Subject: Re: [PATCH] iommu/arm-smmu: Warn once when the perfetcher errata
 patch fails to allpy
Message-ID: <Y1VRgf1wsng07cMT@kroah.com>
References: <20221022024559.4913-1-chen45464546@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221022024559.4913-1-chen45464546@163.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 10:45:59AM +0800, Chen Lin wrote:
> From: Chen Lin <chen.lin5@zte.com.cn>
> 
> Default reset value of secure banked register SMMU_sACR.cache_lock is 1.
> If it is not been set to 0 by secure software(eg: atf), the non-secure 
> linux cannot clear ARM_MMU500_ACTLR_CPRE bit. In this situation,
> the prefetcher errata is not applied successfully, warn once.
> 
> Signed-off-by: Chen Lin <chen.lin5@zte.com.cn>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 3 +++
>  1 file changed, 3 insertions(+)

As has been stated many times before, please fix your email systems and
stop using personal accounts, if you wish for us to think that you
really are developing from a zte.com.cn account.

thanks,

greg k-h
