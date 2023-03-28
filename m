Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BE56CBB8E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjC1Jxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjC1Jxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:53:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630992705;
        Tue, 28 Mar 2023 02:53:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2C016160B;
        Tue, 28 Mar 2023 09:53:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A0BC433EF;
        Tue, 28 Mar 2023 09:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679997220;
        bh=VhcEmaPkel8t+3tqqVdwI5zgGFM9/5+T/o02FWQ94dM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ivQoSC2YH3DO/kBIom8ARFZmat2GWfuuU3f83pGVVozRRhpq2SRPLfvey5XkBprFx
         14lDUpzUCsn3rMU79Scw5SP7smAaNF8xkyTIAiYp8YHKHy/JiXRo+5/xH6r+Mb5Ebw
         8ccpCKE6luvFYvl7Rl4mAZyjn23R6xqisLGSd8FdTKHVCbhIo4Dm+llX/1t6wmwezD
         3Nv0HqG2IOFkwZg0RSzG7qA8f1pI4bWS2EHjDhWA8CQ4Caw+i6opHqlMgz139SW8q2
         97UjzKwuaQAtcw0DXdoovGxBWDquUAVf4wqC6cABXTsY2PxN/hVY7J9C+l9wceolv3
         hPF2jR3ufuGEQ==
Date:   Tue, 28 Mar 2023 11:53:37 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Yang Li <yang.lee@linux.alibaba.com>, kyungmin.park@samsung.com,
        myungjoo.ham@samsung.com, cw00.choi@samsung.com,
        alim.akhtar@samsung.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] devfreq: exynos-ppmu: Use
 devm_platform_get_and_ioremap_resource()
Message-ID: <20230328095337.sr6s3klmhiyz63pr@intel.intel>
References: <20230328053853.23159-1-yang.lee@linux.alibaba.com>
 <8779217b-bd70-37a4-c779-139690048d4d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8779217b-bd70-37a4-c779-139690048d4d@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 28, 2023 at 09:19:01AM +0200, Krzysztof Kozlowski wrote:
> On 28/03/2023 07:38, Yang Li wrote:
> > According to commit 890cc39a8799 ("drivers: provide
> > devm_platform_get_and_ioremap_resource()"), convert
> 
> I don't understand why do you reference this commit. There is no bug
> introduced there, there is nothing related to this driver.
> 
> > platform_get_resource(), devm_ioremap_resource() to a single
> > call to devm_platform_get_and_ioremap_resource(), as this is exactly
> > what this function does.

I've seen Yang has sent many of these cleanups, perhaps he can
write something like:

"
Commit 890cc39a8799 ("drivers: provide
devm_platform_get_and_ioremap_resource()") introduces the
devm_platform_get_and_ioremap_resource() function which combines
both platform_get_resource() and devm_ioremap_resource() into a
single call.

Update the code to use the new combined function instead of the
separate calls.
"

With that

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
