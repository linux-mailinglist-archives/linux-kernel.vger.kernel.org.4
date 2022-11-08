Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BE7621C06
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbiKHSi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKHSi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:38:56 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C15A1C406
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 10:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667932726; bh=TPAj0q+ojgQRR92+IWucBz3U88D6H7YDwaMa5MVeU64=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=Sg7aODFKmyNFHj/x85Of7QDEmx2jDFt7Djw/z3Gy3nHtF/Uza06H+5DJSPSvpHfFX
         60XjlbxgYHMDNNioCEcvrQ5HJWb6yJnAgWPb6XyqDy+S3NgPZv9HnONpfhnZiOKAMD
         iFazhp7sssZ1NYEFsxjNYG4O6Y1xR12cuIzg2vqk=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue,  8 Nov 2022 19:38:46 +0100 (CET)
X-EA-Auth: TZqfKQaxwqdVg2PYONWFARJueSPXgTQI1O0AWkSXOUQBZS2NqQ3vrLk4zMjWIK50AYtvfRt0sl+aZ1G3aSxj1/mIPTVcU/xg
Date:   Wed, 9 Nov 2022 00:08:41 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: staging/wlan-ng query: convert to flexible array member
Message-ID: <Y2qiMbpBobzvR4ED@qemulion>
References: <Y2px+zOGjkpGh6qC@qemulion>
 <Y2p29zc/TeX8OFWU@kroah.com>
 <Y2p5hqdFo5UZoHUY@qemulion>
 <Y2p7TOeg8vzK0rvB@kroah.com>
 <Y2qT0zSlhtQrYwl+@qemulion>
 <Y2qgs3hu95Okjs2w@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2qgs3hu95Okjs2w@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 07:32:19PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Nov 08, 2022 at 11:07:23PM +0530, Deepak R Varma wrote:
> > On Tue, Nov 08, 2022 at 04:52:44PM +0100, Greg Kroah-Hartman wrote:
> > > On Tue, Nov 08, 2022 at 09:15:10PM +0530, Deepak R Varma wrote:
> > > > On Tue, Nov 08, 2022 at 04:34:15PM +0100, Greg Kroah-Hartman wrote:
> > > > 	  MODPOST drivers/staging/wlan-ng/Module.symvers
> > > > 	  LD [M]  drivers/staging/wlan-ng/prism2_usb.ko
> > > > 	  BTF [M] drivers/staging/wlan-ng/prism2_usb.ko
> > > > 	drv@qemulion:~/git/kernels/staging$
> > > > </snip>
> > > >
> > >
> > > Test the device to make sure it still works?
> >
> > I was able to build and load the driver on my machine. I do not have p54 device
> > to test. Is there another way to test it? Some sort of a udev program???
>
> You need the real hardware to test it properly.

Do you know if I work with someone to test the change locally rather than
sending in a untested change?


Thank you,
./drv
>


