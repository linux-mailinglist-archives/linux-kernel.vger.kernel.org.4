Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6385E8A96
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 11:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbiIXJPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 05:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiIXJPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 05:15:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63A3844E1;
        Sat, 24 Sep 2022 02:15:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 855BEB80DDC;
        Sat, 24 Sep 2022 09:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824C1C433C1;
        Sat, 24 Sep 2022 09:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664010900;
        bh=/VWSsbXxJMut/IA0g4ci/cwIKwuCpZI1lIWyAaOGmFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bfkr7BXErs49C+6avn5NOqtbCp6k1iW5/ssLrcsfOnoY8w+ofk2qAiW+0rVCof+VK
         mut4YqCcPlSyMxMP0kUmMsKhIKjYLNUhMXJNky8h1kMr6urq4zPXrNY92+qh5ueC+h
         ftYh/QZo6o2e6t9UIeurKnEhmALxExwRrCGB3oAY=
Date:   Sat, 24 Sep 2022 11:14:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>, stable-commits@vger.kernel.org,
        johan+linaro@kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: Patch "usb: dwc3: qcom: fix peripheral and OTG suspend" has been
 added to the 5.19-stable tree
Message-ID: <Yy7KkehWhnQL9UBo@kroah.com>
References: <20220923165534.652593-1-sashal@kernel.org>
 <Yy7GS22UBJt4SK1H@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy7GS22UBJt4SK1H@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 10:56:43AM +0200, Johan Hovold wrote:
> FFS, Sasha...
> 
> On Fri, Sep 23, 2022 at 12:55:34PM -0400, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     usb: dwc3: qcom: fix peripheral and OTG suspend
> > 
> > to the 5.19-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      usb-dwc3-qcom-fix-peripheral-and-otg-suspend.patch
> > and it can be found in the queue-5.19 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> Stop pulling in these dwc3 patches! I already spent an afternoon doing
> backports for all the stable trees so that you wouldn't pull in half the
> world as dependencies.
> 
> This fixes an issue with a commit in 6.0, which should not be backported
> in the first place.
> 
> Just as I told you two weeks ago when these were dropped the last time:
> 
> 	https://lore.kernel.org/lkml/YxbfJqPb8x0WjmqR@hovoldconsulting.com/
> 
> If you can't fix up the trivial context change yourself, then use one of
> the backports of:
> 
> 	https://lore.kernel.org/lkml/20220906120702.19219-3-johan@kernel.org/
> 
> or simply just leave it out as the issue can't be triggered in 5.19
> currently.
> 
> Just drop all the dwc3 patches from the pending-5.19 branch.

Now dropped, except for the one I added yesterday :)

thanks,

greg k-h
