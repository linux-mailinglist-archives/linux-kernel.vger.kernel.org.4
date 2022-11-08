Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072D36208DB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 06:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbiKHFQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 00:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiKHFQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 00:16:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31131ADB9;
        Mon,  7 Nov 2022 21:16:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 759B86146A;
        Tue,  8 Nov 2022 05:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACDFC433C1;
        Tue,  8 Nov 2022 05:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667884561;
        bh=3YQnC8xfTpqZFER+BjK19u6hpaTXLABT28LVYGye13U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TnTxspL2Mnl2muQIjejoGHG1zNRTaV9ojbiF4bjWiCzvJWRq15Xkra57kus4OBRfg
         GAx2Ah6N9RZjLlYO4uwuUe66yPJt4gZcMPmfM0pc2cV8sPJk4Jw4p/pNM1HOV2WOWm
         hVNSHIBGkYNnCndgVzGQuQhScHLm9n6X9EJWYviwDSEzBFAs5saxhrl/z+eRnnU3mL
         E4FLvOwnmWEmVEMLCaiiZa+vDh3WQXiHbz7ogN9VcgGZIpe6M4ruPdjHxydcBkqLJK
         FpEVWGEdvGIcrSxMmID+tNJx7vHEXj2dcwR32iVKuT5V5dwBQXFumO72EdDgP3IufD
         RHiz70WPS3hBQ==
Date:   Tue, 8 Nov 2022 10:45:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Doug Brown <doug@schmorgal.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the dmaengine tree
Message-ID: <Y2nmDQYfrMvlVYwV@matsya>
References: <20221107183054.7007fd7a@canb.auug.org.au>
 <ccaa1df9-279e-e3a5-514e-e3baebb03357@schmorgal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccaa1df9-279e-e3a5-514e-e3baebb03357@schmorgal.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-11-22, 12:00, Doug Brown wrote:
> Hi Stephen and Vinod,
> 
> On 11/6/2022 11:30 PM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > In commit
> > 
> >    639d91b2d4c8 ("dmaengine: pxa_dma: use platform_get_irq_optional")
> > 
> > Fixes tag
> > 
> >    Fixes: 7723f4c5ecdb ("driver core: platform: Add an error message to platform_get_irq*()"
> > 
> > has these problem(s):
> > 
> >    - Subject has leading but no trailing quotes
> > 
> > Actually, it looks like it is missing the closeing ')'.
> > 
> 
> Dang it, I'm sorry. I don't know how I messed that up. I'm not familiar
> with the process for fixing this after it's already been accepted into
> the dmaengine tree -- should I just submit a V2 patch with this fixed?

I have fixed it up...

-- 
~Vinod
