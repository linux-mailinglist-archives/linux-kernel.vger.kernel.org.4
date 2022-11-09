Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C556C622426
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 07:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiKIGv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 01:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiKIGvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 01:51:48 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0C2193FF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 22:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667976699; bh=ExypxdAet/mf4rZXfaz8Msk/ciHV77CT05iXnSAj0K0=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=esikdfQFWrWPohf8OZh6U6Sxk6hAeO4u7sWVO4nyuZbNy6B71pYxqQ5q7R6iqTrFn
         wMWlMvwJwWdrB/YkLRceWxhvE6vso26coXcOmuyLG2K3c/jFarIGvFt3vbm9u/l4Fy
         QSPsdAYNGpC5e747iEyLIgSMrSNaUL5HvqwTzGnU=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Wed,  9 Nov 2022 07:51:39 +0100 (CET)
X-EA-Auth: HzTQK8+OWDs0qY3dbkyDZ/7/IRH01+0Cn+3bQVowOWiV2Ds32Ar+ww2qQMm6mfUgLy125X4SQjVpfy61iIxROpYdwu3peC48
Date:   Wed, 9 Nov 2022 12:21:30 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: staging/wlan-ng query: convert to flexible array member
Message-ID: <Y2tN8u5zwH5Ufkgd@qemulion>
References: <Y2px+zOGjkpGh6qC@qemulion>
 <Y2p29zc/TeX8OFWU@kroah.com>
 <Y2p5hqdFo5UZoHUY@qemulion>
 <Y2p7TOeg8vzK0rvB@kroah.com>
 <Y2qT0zSlhtQrYwl+@qemulion>
 <Y2qgs3hu95Okjs2w@kroah.com>
 <Y2qiMbpBobzvR4ED@qemulion>
 <Y2qxeDQ+76CvfN1c@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2qxeDQ+76CvfN1c@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 08:43:52PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Nov 09, 2022 at 12:08:41AM +0530, Deepak R Varma wrote:
> > On Tue, Nov 08, 2022 at 07:32:19PM +0100, Greg Kroah-Hartman wrote:
> > > > > Test the device to make sure it still works?
> > > >
> > > > I was able to build and load the driver on my machine. I do not have p54 device
> > > > to test. Is there another way to test it? Some sort of a udev program???
> > >
> > > You need the real hardware to test it properly.
> >
> > Do you know if I work with someone to test the change locally rather than
> > sending in a untested change?
>
> If you can find someone, sure!

Hello Greg,
I reached out to couple of recent patch authors to check if they are able to
help test the change.

Hello all,
Does anyone have a hardware that can test prism2_usb [wlan-ng] driver change? I
assume it would be quick to test the change I am proposing. Let me know if you
are able to help.

Thank you!
./drv


>


