Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6727A63A2D0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiK1IXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiK1IXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:23:42 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B04B56
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1669623813; bh=Up2CIk+sVry4Iqd7WUDeEJ6nDcGy7Lz3qIlKH0hlXwI=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=mg4eeOMGMRGLj3CabrcToaMssyTGdJXKrN8B1x0j3dOk7RV/dlVK4dhQidOR6uKG8
         weTR0DxUlQ6Jbj6ZUIkNghvb5q1Q5+B6dNC2ahuesGYQT5OgNszGqmC94ufXX4RkJ4
         Ji7/N/e4B+7QGe+YSnpH2PwCka//W+sb66t4weLE=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Mon, 28 Nov 2022 09:23:33 +0100 (CET)
X-EA-Auth: 3FuYknn2C0S5EzZ3ymcyRQ2tJE93l7iZmX0JVwD1HNJl5YC/XK/xJijrTnTKQOn+seUuz8vxLvh3kLUp2dj1qF17vGCh8o5F
Date:   Mon, 28 Nov 2022 13:53:28 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        gustavoars@kernel.org
Subject: Re: [PATCH] staging: wlan-ng: Replace zero-length arrays with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <Y4RwAJb/aoC0WIhZ@qemulion>
References: <Y3YKhee8L+kAfHM4@qemulion>
 <Y3YvGdkyGm7azGg4@kroah.com>
 <Y3Y1N6AwWEXLpSrx@qemulion>
 <Y3Z3aatcaISvqURJ@kroah.com>
 <Y3jqUpNOygJ4+2jy@qemulion>
 <Y4RnJyiCDYavLAJq@qemulion>
 <Y4Ro+Ex+E1WemSrs@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4Ro+Ex+E1WemSrs@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 08:53:28AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Nov 28, 2022 at 01:15:43PM +0530, Deepak R Varma wrote:
> > >
> > > For your quick reference, the zero length structure declaration are online 963
> > > whereas the union is on line number 1080 of the file drivers/staging/wlan-ng/hfa384x.h
> >
> > Hello Greg,
> > can you please suggest how should I approach this clean-up/correction?
>
> Sorry, but I do not have the bandwidth to help out with this.  I will
> gladly review changes submitted only.

No problem. I completely understand and appreciate. Thank you Greg.

./drv

>
> greg k-h
>


