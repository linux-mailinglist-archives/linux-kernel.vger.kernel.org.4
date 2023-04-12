Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95306E0013
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjDLUoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDLUoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:44:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5987E4EC5;
        Wed, 12 Apr 2023 13:44:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E89AD622CC;
        Wed, 12 Apr 2023 20:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C8BC433EF;
        Wed, 12 Apr 2023 20:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681332247;
        bh=aoAHy7DEiYr/xln2kAunwsb8zReQcW/Oo/qN/Fl7/8k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VDKWuY8vNj6YxhcCZ+ic86Utd60bh/CErc5li9e+X7YBlPXuQHxBoOIAX9RBDBL6u
         qSJoAisF4GNfADV3HeQznFPynj3k8PoLmxZb4mvepSgi52FtL6x0yFYiOBNfVQlRwE
         5awcIAvR64OUZP2q6prjoJZvh+BOg/YFkeuPqJMMlewGLEHf6nwKjUwFNuFhJxWM14
         o+XlU7sxPeRxGpuAKmxX/IycKhfxqmfNficR3WZpSR6+1sop50DL/gyoidBjwMxpEP
         oQngrjxAkCUV46Hx5oiWm7EK8FvKl1gakHTBxpIh/wC3ydVliozftnvDfBoqu44HkM
         DtVzz6YWRI19Q==
Date:   Wed, 12 Apr 2023 21:44:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [RFC PATCH 0/2] Support for Avago APDS9306 Ambient Light Sensor
Message-ID: <20230412214403.5c053ed6@jic23-huawei>
In-Reply-To: <eefdbad5-35ed-04c6-0955-87c99a4d345d@tweaklogic.com>
References: <20230411011203.5013-1-subhajit.ghosh@tweaklogic.com>
        <20230411144031.000077c7@Huawei.com>
        <eefdbad5-35ed-04c6-0955-87c99a4d345d@tweaklogic.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023 12:46:49 +0800
Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:

> Hi Jonathan,
> Thank you for getting back.
> 
> > Hi Subhajit,
> > 
> > No need to sign off a cover letter.  The content isn't captured in the
> > git tree anyway.
> > 
> > For an RFC, I'd expect to see a clear statement in the cover letter of
> > why it is an RFC rather than a formal patch submission.  What specifically
> > are you looking for comments on?
> > 
> > Point us in the right direction and we might answer the questions quicker.
> > 
> > Thanks,
> > 
> > Jonathan  
> Thank you for clearing it up.
> Next version of RFC I will put specific reasons.
> Before submitting a formal patch I wanted to check if my implementation of
> single reads of ALS data raw values from userspace when interrupts are
> enabled is the right thing to do or not. Also wanted to check if my event
> related userspace ABI implementation is in line with IIO subsystem.
> I will put it into better words in the next cover letter.
> 
> Can you also help me out with the git tree I should use to format the
> patches? As per my understanding it is the subsystem maintainer tree
> and the main branch but the macros and functions which you have suggested
> in other reviews are available in Linux mainline.

For a new driver it rarely matters and I'd advise simply using
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
which is the mainline tree.  Please base either on the previous
release (currently 6.2) or rc1 of the current release (v6.3-rc1)
if doing this.

If you need a feature that has only been applied in the same cycle, or
are building on recent work that has been applied to the iio tree then
for fixes you want:
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git fixes-togreg
for new stuff you want:
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg

The IIO tree routes through Greg KH's char-misc tree so will see the togreg
branch move forwards to be based on that as Greg takes pull requests from me.
Usually this happens once or twice a kernel cycle.  Don't worry too much about
this. If it should affect a patch because some changes crossed I'll generally
fix it up whilst applying whichever gets applied second and ask the
authors to check I didn't make a mistake.

Joanthan
> 
> Regards,
> Subhajit Ghosh
> 

