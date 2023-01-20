Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED652675A92
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjATQ5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjATQ5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:57:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFC97B2D2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:56:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 344DAB82940
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 16:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B1DC433D2;
        Fri, 20 Jan 2023 16:56:47 +0000 (UTC)
Date:   Fri, 20 Jan 2023 16:56:44 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mohan Kumar D <mkumard@nvidia.com>, will@kernel.org,
        dmitry.baryshkov@linaro.org, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com
Subject: Re: [PATCH v2] arm64: defconfig: Enable HDA INTEL config for ARM64
Message-ID: <Y8rHzJpEg7bMzYM6@arm.com>
References: <20230117181658.17010-1-mkumard@nvidia.com>
 <e871dae2-58ac-7ad9-c198-c4e90d26c69b@linaro.org>
 <1afa38ad-716f-49f8-efd1-ed37bd8dbf6e@nvidia.com>
 <ec440deb-2970-69b8-e54d-6519c95875a8@linaro.org>
 <35eb1396-b91b-8a7f-6585-30d2f2adcf85@nvidia.com>
 <cfb9b0f2-a8fa-9bee-a04d-d195d69e4918@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfb9b0f2-a8fa-9bee-a04d-d195d69e4918@linaro.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 07:20:01AM +0100, Krzysztof Kozlowski wrote:
> On 20/01/2023 06:48, Mohan Kumar D wrote:
> > On 18-01-2023 18:06, Krzysztof Kozlowski wrote:
> >> External email: Use caution opening links or attachments
> >> On 18/01/2023 12:46, Mohan Kumar D wrote:
> >>> On 18-01-2023 13:04, Krzysztof Kozlowski wrote:
> >>>> External email: Use caution opening links or attachments
> >>>> On 17/01/2023 19:16, Mohan Kumar wrote:
> >>>>> Enable CONFIG_SND_HDA_INTEL for NVIDIA PCI based graphics sound card for
> >>>>> ARM64 based platforms as Intel PCI driver was used for registering the
> >>>>> sound card.
> >>>> It's not a part of SoC, not a common device used during debugging or
> >>>> development, so I don't think it is reasonable to enable it. We do not
> >>>> enable driver just because someone uses them. Otherwise please clarify
> >>>> which board has this device embedded (not pluggable by user, but embedded).
> >>> This change is required for enabling HDA sound registration for Nvidia
> >>> discrete GPU cards based on PCI and pluggable to Nvidia Jetson Platforms.
> >> You can plug anything to PCI slot and we do not enable every such PCI
> >> adapter.
> > Without this config enabled, the Intel hda audio driver won't be built 
> > and dGPU won't be able to register sound card. Do you have any 
> > suggestion here?
> 
> Without hundreds of other drivers they also won't be built and won't be
> usable. Anyway, this is just defconfig, so it does not matter. You can
> always enable it in your setup, why is this a problem?
> 
> Again, we do not enable drivers for every PCI card.

I don't think we have any set rules for what goes in a defconfig. If one
has a real use-case, we tend to enable stuff in defconfig, especially if
it's a module.

-- 
Catalin
