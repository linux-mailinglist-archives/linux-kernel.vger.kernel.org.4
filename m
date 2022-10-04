Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1CE5F3E3A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiJDIY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiJDIYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:24:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486631D0DF;
        Tue,  4 Oct 2022 01:24:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0595B81919;
        Tue,  4 Oct 2022 08:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EFCC433D7;
        Tue,  4 Oct 2022 08:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664871856;
        bh=uAjfpz0d0D6bezXkZgdZz4TG3ds1yQdpkwoZg3hhSz8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=gRYdcHsHXABZMzmrUoRUAyd6uhsYxwuNjLdcwvudRJUlIv+PeP7Tzq7f6M3VR+oh+
         2HWo1BqMqVND/holL0f6PGL1AMXDK5Db0nUFEHYHOjM88RHMjvxCZx79e96HiqhRO0
         eDdbj/1PeYLhswbi08kaebebC6UwqzRNJRyBCJYjtlKnE+0PfjwoiJ9IES8m7cXZir
         BWvzKL1Cr36foZxngpIjTkuYxE8TwYeuco8Lo1xOPwlKx/RrJy1VEP10MPHuWhSfb5
         BgsvQXoZVvm6x95RoT/Q+SjHd8w3VzWoo7StUSErtgAx/Ko5UqP7c8EhJtzouJryy5
         uguqfkI/wBg1Q==
Date:   Tue, 4 Oct 2022 10:24:05 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Juergen Stuber <starblue@users.sourceforge.net>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] USB: make devnode() callback in usb_class_driver take
 a const *
In-Reply-To: <20221001165128.2688526-1-gregkh@linuxfoundation.org>
Message-ID: <nycvar.YFH.7.76.2210041023460.29912@cbobk.fhfr.pm>
References: <20221001165128.2688526-1-gregkh@linuxfoundation.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Oct 2022, Greg Kroah-Hartman wrote:

> With the changes to the driver core to make more pointers const, the USB
> subsystem also needs to be modified to take a const * for the devnode
> callback so that the driver core's constant pointer will also be
> properly propagated.
> 
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: Pete Zaitcev <zaitcev@redhat.com>
> Cc: Juergen Stuber <starblue@users.sourceforge.net>
> Cc: Johan Hovold <johan@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/hid/usbhid/hiddev.c     | 2 +-

For hiddev.c:

	Reviewed-by: Jiri Kosina <jkosina@suse.cz>

Thanks,

-- 
Jiri Kosina
SUSE Labs

