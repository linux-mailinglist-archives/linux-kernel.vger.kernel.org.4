Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242626B0E6A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjCHQS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjCHQS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 11:18:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4322700
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 08:18:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9C6D616FE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 16:18:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71BAC433D2;
        Wed,  8 Mar 2023 16:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678292305;
        bh=MxcbmAJFBs/SYZwP3KHVRqCJ7HeXBMCKu6PhXK8//Lc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pbjKz5LEZ/qSDvAGA6yFoNxADMEVBhmPAOhHz/qr9SRaohOG3DDsNa2Q2Ql93k24M
         uKpHJ4gSwCNW6qPSWAStSeBGlBnPN6+Pi/kPtcGuyqKsf7mtmG0UsrY9nx8bXCeypP
         XbCN9uxC/fNYdghg5zQKA9XXia230DgZsmqQwoq8aq+ie2Ul3jCIBNZQESBeHP/fx0
         S3WKghaaofugKb+FQ/8U0LP3qRmem5g1Bx1BrHZftXCuzFOrOu/ph/KFbRl+/3e8x3
         BVqjhOppGQWDN5VMfPSGaWryxeKWf8kdm5pbyR8ztWiv/NuaE2t/DfcWmt5gLDC7tu
         UjLngCxoGbmeg==
Message-ID: <5093bf43-32b0-2c15-ff18-8ad16bba3635@kernel.org>
Date:   Wed, 8 Mar 2023 10:18:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] iommu/fsl: fix all kernel-doc warnings in fsl_pamu.c
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Aditya Srivastava <yashsri421@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
References: <20230308034504.9985-1-rdunlap@infradead.org>
Content-Language: en-US
From:   Timur Tabi <timur@kernel.org>
In-Reply-To: <20230308034504.9985-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/23 9:45 PM, Randy Dunlap wrote:
> Fix kernel-doc warnings as reported by the kernel test robot:
> 
> fsl_pamu.c:192: warning: expecting prototype for pamu_config_paace(). Prototype was for pamu_config_ppaace() instead
> fsl_pamu.c:239: warning: Function parameter or member 'omi_index' not described in 'get_ome_index'
> fsl_pamu.c:239: warning: Function parameter or member 'dev' not described in 'get_ome_index'
> fsl_pamu.c:332: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   * Setup operation mapping and stash destinations for QMAN and QMAN portal.
> fsl_pamu.c:361: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   * Setup the operation mapping table for various devices. This is a static
> 
> Fixes: 695093e38c3e ("iommu/fsl: Freescale PAMU driver and iommu implementation.")
> Fixes: cd70d4659ff3 ("iommu/fsl: Various cleanups")

Acked-by: Timur Tabi <timur@kernel.org>

One a side note, I'm pretty sure the @freescale.com addresses in the cc: 
list are invalid, so I've removed them.
