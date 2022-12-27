Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73415656B50
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 14:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbiL0NYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 08:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbiL0NYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 08:24:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4D9B48C;
        Tue, 27 Dec 2022 05:24:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E3BA61165;
        Tue, 27 Dec 2022 13:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71636C433EF;
        Tue, 27 Dec 2022 13:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672147480;
        bh=xL07ujvpHp6987H6UAe2sUx+4o3+Enu9OnndWMooVf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g7GUimRO2RBJ9nCSf83CZ6ONOEuOGy9BM9aK/gYkaEt63Jv//Szcqb2ecZ2hfq86b
         4U+EktIYxt2va1iIzIWDtDd1U60KVV0wd6HGeXUffQ2wHAH8SOG97jkUYQ2trXazrA
         lMMvZMAtbe4qemkpELzbVFteos4s1lmV2Kq5lUrjURLzoQ/G9D4283g2wk8MX+1f8S
         ZShA5TFUTl6ZmAgNP9OA2RNo+oo/pyZ02E8jZObPHRtzP2R2MvBlMor45setTVRWtQ
         DYlOjGF6UC+LMr96bECxX3Ukf2L58sznC41N9vLPBzScU/Ly6nvMQIAq9FVNt5O3kh
         nCSzUmJNiGU6A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pA9wd-0004oR-Pr; Tue, 27 Dec 2022 14:24:40 +0100
Date:   Tue, 27 Dec 2022 14:24:39 +0100
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
Message-ID: <Y6ryF2J2nzYbJV05@hovoldconsulting.com>
References: <20221225150913.691403-1-sashal@kernel.org>
 <Y6q3k21nJFWKye76@hovoldconsulting.com>
 <Y6rtS7AaQ+EmfD8o@sashalap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6rtS7AaQ+EmfD8o@sashalap>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 08:04:11AM -0500, Sasha Levin wrote:
> On Tue, Dec 27, 2022 at 10:14:59AM +0100, Johan Hovold wrote:
> >On Sun, Dec 25, 2022 at 10:09:13AM -0500, Sasha Levin wrote:
> >> This is a note to let you know that I've just added the patch titled
> >>
> >>     phy: qcom-qmp-combo: fix runtime suspend
> >>
> >> to the 5.15-stable tree which can be found at:
> >>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >>
> >> The filename of the patch is:
> >>      phy-qcom-qmp-combo-fix-runtime-suspend.patch
> >> and it can be found in the queue-5.15 subdirectory.
> >>
> >> If you, or anyone else, feels it should not be added to the stable tree,
> >> please let <stable@vger.kernel.org> know about it.
> >>
> >>
> >>
> >> commit d17b3a7b0119f7d92788acbe0f3d3b31bd8f892b
> >> Author: Johan Hovold <johan+linaro@kernel.org>
> >> Date:   Mon Nov 14 09:13:45 2022 +0100
> >>
> >>     phy: qcom-qmp-combo: fix runtime suspend
> >>
> >>     [ Upstream commit c7b98de745cffdceefc077ad5cf9cda032ef8959 ]
> >>
> >>     Drop the confused runtime-suspend type check which effectively broke
> >>     runtime PM if the DP child node happens to be parsed before the USB
> >>     child node during probe (e.g. due to order of child nodes in the
> >>     devicetree).
> >>
> >>     Instead use the new driver data USB PHY pointer to access the USB
> >>     configuration and resources.
> >>
> >>     Fixes: 52e013d0bffa ("phy: qcom-qmp: Add support for DP in USB3+DP combo phy")
> >>     Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>     Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> >>     Link: https://lore.kernel.org/r/20221114081346.5116-6-johan+linaro@kernel.org
> >>     Signed-off-by: Vinod Koul <vkoul@kernel.org>
> >>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> >
> >This one was not marked for stable and can not be backported without
> >further dependencies. This driver did not even exist in 5.15, and no,
> >you should no try to backport the split of the original driver either.
> 
> I'll drop this patch.
> 
> >Sasha, please stop this madness.
> 
> So help me understand this... The fixes tag says:
> 
> 	Fixes: 52e013d0bffa ("phy: qcom-qmp: Add support for DP in USB3+DP combo phy")
> 
> 52e013d0bffa was merged in v5.10. Does the tag point to the wrong
> commit?

The fixes tag is correct, but the qmp driver has since been split into
multiple drivers.

But first, the commit in question will not even compile without
7a7d86d14d07 ("phy: qcom-qmp-combo: fix broken power on") which from
what I can tell has not yet been backported (even though it has a stable
tag).

Did you make sure that you compile-tested this patch after applying it
to 5.15?

Second, this commit fixes the combo driver which did not exist before
94a407cc17a4 (phy: qcom-qmp: create copies of QMP PHY driver) which
split the older driver into multiple drivers. This onef and all the
follow-on cleanups should not be backported.

If we find anything that really needs to be fixed in stable kernels
prior to the driver split, those fixes need to be backported properly
to the older version of the driver. This should not be automated.

Johan
