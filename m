Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C755EF7D7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbiI2Olf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbiI2OlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:41:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 461F01C432A;
        Thu, 29 Sep 2022 07:41:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C3C31650;
        Thu, 29 Sep 2022 07:41:27 -0700 (PDT)
Received: from [10.57.65.170] (unknown [10.57.65.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE13B3F792;
        Thu, 29 Sep 2022 07:41:17 -0700 (PDT)
Message-ID: <7f9d35bf-282f-68cf-b857-3d7e66dbaf63@arm.com>
Date:   Thu, 29 Sep 2022 15:40:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: linux-next: build failure after merge of the irqchip tree
Content-Language: en-GB
To:     broonie@kernel.org, Marc Zyngier <maz@kernel.org>,
        Joerg Roedel <jroedel@suse.de>, Frank Li <Frank.Li@nxp.com>,
        Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <20220929143149.126145-1-broonie@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220929143149.126145-1-broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-29 15:31, broonie@kernel.org wrote:
> Hi all,
> 
> After merging the irqchip tree, today's linux-next build (arm64
> defconfig) failed like this:
> 
> /tmp/next/build/drivers/irqchip/irq-imx-mu-msi.c:14:10: fatal error: linux/dma-iommu.h: No such file or directory
>     14 | #include <linux/dma-iommu.h>
>        |          ^~~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>    841e6e9f2bc95baff ("irqchip: Add IMX MU MSI controller driver")
> 
> interacting with
> 
>    f2042ed21da7f8886 ("iommu/dma: Make header private")
> 
> I have reverted the driver for today.

Once again it looks like an unused include which could just be 
removed... illustrating a large part of why I took the header away :)

Cheers,
Robin.
