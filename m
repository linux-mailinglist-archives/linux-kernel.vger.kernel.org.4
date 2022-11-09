Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1136224CB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 08:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiKIHmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 02:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiKIHmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 02:42:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD871B784;
        Tue,  8 Nov 2022 23:42:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60173B81D1C;
        Wed,  9 Nov 2022 07:42:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E99C433C1;
        Wed,  9 Nov 2022 07:42:08 +0000 (UTC)
Date:   Wed, 9 Nov 2022 13:12:05 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mhi tree
Message-ID: <20221109074205.GA4651@thinkpad>
References: <20221109151637.67be60f8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221109151637.67be60f8@canb.auug.org.au>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 03:16:37PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mhi tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> drivers/bus/mhi/host/pci_generic.c: In function 'mhi_pci_get_irqs':
> drivers/bus/mhi/host/pci_generic.c:743:60: error: assignment of member 'irq' in read-only object
>   743 |                         mhi_cntrl_config->event_cfg[i].irq = 0;
>       |                                                            ^
> 
> Caused by commit
> 
>   c970e67d64a5 ("bus: mhi: host: make mhi_controller_config::event_cfg const")
> 

Dropped it now.

Thanks,
Mani

> I have used the mhi tree from next-20221108 for today.
> 
> -- 
> Cheers,
> Stephen Rothwell



-- 
மணிவண்ணன் சதாசிவம்
