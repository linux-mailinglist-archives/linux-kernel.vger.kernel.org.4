Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC2A5E8A56
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 10:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiIXI4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 04:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiIXI4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 04:56:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EFA2228C;
        Sat, 24 Sep 2022 01:56:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EE98B80EE2;
        Sat, 24 Sep 2022 08:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B20C433D6;
        Sat, 24 Sep 2022 08:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664009800;
        bh=BRZ1Esxyvw3+h+I1W8oly2AiSt+QTIuC74vL8tAloPg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hg3fj5lqIfZUKYGW0pOmSkM5gDM+fwRbZjY7fgPKD1tCYrX+A1aWc/oD9C6jX+jYB
         gWLVJwqydQXcGvfQyzRrfFJhmtUdfqrdsJ0dVbOB7XojWMaSbRPOS2EX8QcP1GMsju
         JTgulScfjVLLGzrXjsuZDCewPw7hGy40prjBATd9YivtMpeAtSVY1xhqcmkBg68vvk
         utZiz7zowVHzb8AqiuP9wp7QoMmKwSOb9LR1seaFPF9tFpOcQHg8Jkr8wWvaKst7jq
         99KkvGyyyLfoBA4iitQ2KRIbgpn33GwJzQVY8Nuuy7vOsdSuHreOmkYX0goSCKnOuZ
         bFItqu+7TFOMw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oc0xn-00028E-KJ; Sat, 24 Sep 2022 10:56:43 +0200
Date:   Sat, 24 Sep 2022 10:56:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable-commits@vger.kernel.org, johan+linaro@kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Patch "usb: dwc3: qcom: fix peripheral and OTG suspend" has been
 added to the 5.19-stable tree
Message-ID: <Yy7GS22UBJt4SK1H@hovoldconsulting.com>
References: <20220923165534.652593-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923165534.652593-1-sashal@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FFS, Sasha...

On Fri, Sep 23, 2022 at 12:55:34PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     usb: dwc3: qcom: fix peripheral and OTG suspend
> 
> to the 5.19-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      usb-dwc3-qcom-fix-peripheral-and-otg-suspend.patch
> and it can be found in the queue-5.19 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Stop pulling in these dwc3 patches! I already spent an afternoon doing
backports for all the stable trees so that you wouldn't pull in half the
world as dependencies.

This fixes an issue with a commit in 6.0, which should not be backported
in the first place.

Just as I told you two weeks ago when these were dropped the last time:

	https://lore.kernel.org/lkml/YxbfJqPb8x0WjmqR@hovoldconsulting.com/

If you can't fix up the trivial context change yourself, then use one of
the backports of:

	https://lore.kernel.org/lkml/20220906120702.19219-3-johan@kernel.org/

or simply just leave it out as the issue can't be triggered in 5.19
currently.

Just drop all the dwc3 patches from the pending-5.19 branch.

> commit a989a972abf4ae3f79bbff2d9dc9956eda25e2f0
> Author: Johan Hovold <johan+linaro@kernel.org>
> Date:   Thu Aug 4 17:09:58 2022 +0200
> 
>     usb: dwc3: qcom: fix peripheral and OTG suspend
>     
>     [ Upstream commit c5f14abeb52b0177b940fd734133d383da3521d8 ]
>     
>     A recent commit implementing wakeup support in host mode instead broke
>     suspend for peripheral and OTG mode.
>     
>     The hack that was added in the suspend path to determine the speed of
>     any device connected to the USB2 bus not only accesses internal driver
>     data for a child device, but also dereferences a NULL pointer or
>     accesses freed data when the controller is not acting as host.
>     
>     There's no quick fix to the layering violation, but since reverting
>     would leave us with broken suspend in host mode with wakeup triggering
>     immediately, let's keep the hack for now.
>     
>     Fix the immediate issues by only checking the host bus speed and
>     enabling wakeup interrupts when acting as host.
>     
>     Fixes: 6895ea55c385 ("usb: dwc3: qcom: Configure wakeup interrupts during suspend")
>     Reported-by: kernel test robot <lkp@intel.com>
>     Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>     Link: https://lore.kernel.org/r/20220804151001.23612-7-johan+linaro@kernel.org
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>

Johan
