Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2D05BF5E2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 07:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiIUF0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 01:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiIUF0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 01:26:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE86A786EB;
        Tue, 20 Sep 2022 22:26:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 789786209E;
        Wed, 21 Sep 2022 05:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5211EC433D6;
        Wed, 21 Sep 2022 05:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663737981;
        bh=NNXE4AZ9Yod39nOajy5/Jb08sF01Dosb2I2oL/34iQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M8NcnMXRlaqAQTvtBl369EAwJkUgvYavFKg1V4iiZb5WqW6QKDj7awnKqPcKAlEWG
         3IkkmNO1VmGyu/N82gGkdUmb6vjskLMjubCwGo9FXTWyp/Mf6pHrrCqa3/u3ULPdOZ
         K9SLzHeCI2zm0L1162jzng4B69lpHlPI90Nwja2U5dob4oh2BuyBvCf3qzclMsPOHG
         w0aI1Ro4CRXWb59u7MhovEumawqQ2zWY9uoiTXSDxmYrSj04c03HOL8ATY000/TuBd
         y2O+MuaKNGkfthq4lsLl+WyZ39f0ba//TU2xsazGXtKK9CzQmeQRdtKrC5IyYcXfl+
         VFGpzGehuGc4w==
Date:   Wed, 21 Sep 2022 10:56:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: linux-next: manual merge of the soundwire tree with Linus' tree
Message-ID: <Yyqgeeht5qVAqluL@matsya>
References: <20220921152013.2cffcf42@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921152013.2cffcf42@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-09-22, 15:20, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the soundwire tree got a conflict in:
> 
>   drivers/soundwire/qcom.c
> 
> between commit:
> 
>   4ef3f2aff126 ("soundwire: qcom: fix device status array range")
> 
> from Linus' tree and commits:
> 
>   8039b6f3e5c7 ("soundwire: qcom: update status from device id 1")
>   ed8d07acec73 ("soundwire: qcom: do not send status of device 0 during alert")
> 
> from the soundwire tree.
> 
> I fixed it up (I used the latter) and can carry the fix as necessary.

Thanks Stephen,

That seems to be the correct resolution, I will merge fixes to bring
this in.



> This is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell



-- 
~Vinod
