Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E9066E006
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjAQOK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjAQOKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:10:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF7A2A163;
        Tue, 17 Jan 2023 06:10:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99F6BB81645;
        Tue, 17 Jan 2023 14:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1F9C433D2;
        Tue, 17 Jan 2023 14:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673964621;
        bh=1LQNFj0nyxhQ3JRrf8nhxOpkNbiHaRBCqv2yNnBl7JI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h74ssUzgixd7/MX7aln510ZzUSGlvxrMC2fWe1KPCNxqb1Uofh5aIOyn6gf8yI9Mx
         7ytiUBK7gdiVe/1CCl80lRBPCLYW+xIHRt/VH4DhLVN8G4nQ1YwT38xZ7gGr9tFZIo
         EzcZPmIfUCqzXZJpQnfjrUca1r7Z7c5ioCtFayaM=
Date:   Tue, 17 Jan 2023 15:10:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nipun Gupta <nipun.gupta@amd.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rafael@kernel.org, eric.auger@redhat.com,
        alex.williamson@redhat.com, cohuck@redhat.com,
        song.bao.hua@hisilicon.com, mchehab+huawei@kernel.org,
        maz@kernel.org, f.fainelli@gmail.com, jeffrey.l.hugo@gmail.com,
        saravanak@google.com, Michael.Srba@seznam.cz, mani@kernel.org,
        yishaih@nvidia.com, jgg@ziepe.ca, jgg@nvidia.com,
        robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
        masahiroy@kernel.org, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        okaya@kernel.org, harpreet.anand@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, git@amd.com
Subject: Re: [PATCH 05/19] bus/cdx: add cdx controller
Message-ID: <Y8asSo2daSm5AWfR@kroah.com>
References: <20230117134139.1298-1-nipun.gupta@amd.com>
 <20230117134139.1298-6-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117134139.1298-6-nipun.gupta@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 07:11:37PM +0530, Nipun Gupta wrote:
> --- /dev/null
> +++ b/drivers/bus/cdx/controller/cdx_controller.c
> @@ -0,0 +1,243 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Platform driver for CDX bus controller.

Why is this a platform driver?  Shouldn't it also be on some type of bus
so that you can find it?

> +MODULE_VERSION("1.0");

There's never need for any module versions once the code is in the
kernel tree as then they make no sense at all.  Please drop them from
this series.

thanks,

greg k-h
