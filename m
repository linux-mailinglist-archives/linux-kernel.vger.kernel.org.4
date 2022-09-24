Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC8F5E8AB0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 11:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbiIXJWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 05:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiIXJWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 05:22:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0667138F1A;
        Sat, 24 Sep 2022 02:22:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D5F160A39;
        Sat, 24 Sep 2022 09:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8172C433C1;
        Sat, 24 Sep 2022 09:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664011348;
        bh=JptzcU8FfaCLKve+rCyuoGEvbDQfZXZJkTUsc1JHCJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=en8+0/+vvWCQvqKeoHRL8TCbhnxrEGKSTwBo7YXMejs7pzuCGKpIp3qPrX4gF9Npb
         U9+uzqJ0QBHjaBPSamu5gKmBAnbj//nA95b6AQV0PgY6js16BTpk3/v03jYVxYLrZ7
         nwIj32wyauYgskhYKrDOMs2VoYeA3qlawxCgeKNXMnbRjqJ97lMCMwX1oXqf6NDsbZ
         diB9a6B5bZVqb044BgAiUNOejqj74r3AEEW864JwXA/ouyMNf7QXDVav4SiSYRcIIv
         xnbzFclZGbKe/sPUV27A+7M292LyAZHLRwOD+/DnrXQsz1RVGuV/p9DmW6R6S3xLOu
         fRqSt4eSmrz8g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oc1Mm-0002Gp-Ip; Sat, 24 Sep 2022 11:22:32 +0200
Date:   Sat, 24 Sep 2022 11:22:32 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>, stable-commits@vger.kernel.org,
        johan+linaro@kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: Patch "usb: dwc3: qcom: fix peripheral and OTG suspend" has been
 added to the 5.19-stable tree
Message-ID: <Yy7MWOOmXbkf9Guq@hovoldconsulting.com>
References: <20220923165534.652593-1-sashal@kernel.org>
 <Yy7GS22UBJt4SK1H@hovoldconsulting.com>
 <Yy7KkehWhnQL9UBo@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy7KkehWhnQL9UBo@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 11:14:57AM +0200, Greg Kroah-Hartman wrote:
> On Sat, Sep 24, 2022 at 10:56:43AM +0200, Johan Hovold wrote:

> > Just drop all the dwc3 patches from the pending-5.19 branch.
> 
> Now dropped, except for the one I added yesterday :)

Thanks. Didn't see the DMA one at first.

Johan
