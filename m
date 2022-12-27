Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC1D6568CB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 10:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiL0JPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 04:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiL0JPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 04:15:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E294C4B;
        Tue, 27 Dec 2022 01:15:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9E0660FDD;
        Tue, 27 Dec 2022 09:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A15C433EF;
        Tue, 27 Dec 2022 09:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672132501;
        bh=eC++wL01uckySJfEXbxAKgLXUsjI8JV+y0KK8u5//aM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uyT/YuOOo+vELTlD6XBW2lJ6vG9nKgFHPfi5uhTJJz7+elF9nknmhJ7+R9/5t8mHQ
         Glm3SblcI0LzA1R1Yjb6B33dNyKP+Lq43nt8Xr35funfHGPabT2vB8R360QTm3ljn4
         cb/RyAl4mCRCLZfOZ1sJ72Wj+raWiUyduLD/WfzkOR1RjAjP35Sl+yjORHcN2M5PNs
         4jnuseahjdqtGRbz5LbYTFIdYiUtd5ThfjNTF6dW9EkLRq4lUTwmyuTKkQMKE8/7VT
         Mz7PHA+JB7zY/RecNLIyYsobWFaiMom6ARG4zWA2PtboZVU9Y83IOpOoHh1v0Jw3/9
         UWa/1NM+fK+EA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pA631-0003dv-U1; Tue, 27 Dec 2022 10:15:00 +0100
Date:   Tue, 27 Dec 2022 10:14:59 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable-commits@vger.kernel.org, johan+linaro@kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: Patch "phy: qcom-qmp-combo: fix runtime suspend" has been added
 to the 5.15-stable tree
Message-ID: <Y6q3k21nJFWKye76@hovoldconsulting.com>
References: <20221225150913.691403-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221225150913.691403-1-sashal@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 25, 2022 at 10:09:13AM -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     phy: qcom-qmp-combo: fix runtime suspend
> 
> to the 5.15-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      phy-qcom-qmp-combo-fix-runtime-suspend.patch
> and it can be found in the queue-5.15 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit d17b3a7b0119f7d92788acbe0f3d3b31bd8f892b
> Author: Johan Hovold <johan+linaro@kernel.org>
> Date:   Mon Nov 14 09:13:45 2022 +0100
> 
>     phy: qcom-qmp-combo: fix runtime suspend
>     
>     [ Upstream commit c7b98de745cffdceefc077ad5cf9cda032ef8959 ]
>     
>     Drop the confused runtime-suspend type check which effectively broke
>     runtime PM if the DP child node happens to be parsed before the USB
>     child node during probe (e.g. due to order of child nodes in the
>     devicetree).
>     
>     Instead use the new driver data USB PHY pointer to access the USB
>     configuration and resources.
>     
>     Fixes: 52e013d0bffa ("phy: qcom-qmp: Add support for DP in USB3+DP combo phy")
>     Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>     Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>     Link: https://lore.kernel.org/r/20221114081346.5116-6-johan+linaro@kernel.org
>     Signed-off-by: Vinod Koul <vkoul@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>

This one was not marked for stable and can not be backported without
further dependencies. This driver did not even exist in 5.15, and no,
you should no try to backport the split of the original driver either.

Sasha, please stop this madness. 

Johan
