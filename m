Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DF9621ADB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbiKHRhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbiKHRhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:37:40 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5116654B28
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 09:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667929048; bh=Q1+7UmqKBu+Y+X7DFQZw3y1YtFosOJkcKhbS2OpqI38=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=Jhy2bw8hxW6RrxZj1NGtQ2NsA7J/qKV1L1LXHW3ssLg3Uqxftww2XWWiRd+qDv08v
         o4MkgY+2NdYODWIlstVBDveNgcw478oXS5BNEwKxTH3Vnv5s/IBYjq2e1FCcJKpQyT
         UBt9vwFQFMPBLRkRWi7tmtIzCXdx4KMMGTIpER5U=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue,  8 Nov 2022 18:37:28 +0100 (CET)
X-EA-Auth: 2jlnkKun69RFoBqslVp9cVErIP+oD3aiqt0KNyu8yB4BP9nE7nAw/ipHx31HlDL3SrScidGnsX+ZGsSPuBXx6R148nTAceWX
Date:   Tue, 8 Nov 2022 23:07:23 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: staging/wlan-ng query: convert to flexible array member
Message-ID: <Y2qT0zSlhtQrYwl+@qemulion>
References: <Y2px+zOGjkpGh6qC@qemulion>
 <Y2p29zc/TeX8OFWU@kroah.com>
 <Y2p5hqdFo5UZoHUY@qemulion>
 <Y2p7TOeg8vzK0rvB@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2p7TOeg8vzK0rvB@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 04:52:44PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Nov 08, 2022 at 09:15:10PM +0530, Deepak R Varma wrote:
> > On Tue, Nov 08, 2022 at 04:34:15PM +0100, Greg Kroah-Hartman wrote:
> > 	  MODPOST drivers/staging/wlan-ng/Module.symvers
> > 	  LD [M]  drivers/staging/wlan-ng/prism2_usb.ko
> > 	  BTF [M] drivers/staging/wlan-ng/prism2_usb.ko
> > 	drv@qemulion:~/git/kernels/staging$
> > </snip>
> >
>
> Test the device to make sure it still works?

I was able to build and load the driver on my machine. I do not have p54 device
to test. Is there another way to test it? Some sort of a udev program???

<snip>
	 static struct usb_driver prism2_usb_driver = {
	-       .name = "prism2_usb",
	+       .name = "prism2_usb_dvk",
		.probe = prism2sta_probe_usb,
		.disconnect = prism2sta_disconnect_usb,
		.id_table = usb_prism_tbl,
	drv@qemulion:~/git/kernels/staging$ sudo dmesg
	[  948.476144] prism2_usb: module is from the staging directory, the quality is unknown, you have been warned.
	[  948.478631] usbcore: registered new interface driver prism2_usb_dvk
</snip>

Thank you,
./drv

>


