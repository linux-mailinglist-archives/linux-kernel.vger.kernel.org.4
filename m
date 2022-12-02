Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B454640F12
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 21:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbiLBUR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 15:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234514AbiLBURz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 15:17:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC0021886;
        Fri,  2 Dec 2022 12:17:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60DE7B82279;
        Fri,  2 Dec 2022 20:17:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E906C433C1;
        Fri,  2 Dec 2022 20:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670012272;
        bh=UPgyDqVtI4sBKcyW4PXkCDbwBBQobxjh4DV5HWykYno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OXHirJk16MC+0kC4YsXGf480BYDX06Z7a6y9cQQIUNhkffwxd6L6+fkhdpCSTDTT3
         NuWzSYxy+dM3F6eJX0eMuBbwbI+OZ0kKxsr6MvDH5lZafCKj5KbjXIcj8yTck0PkNt
         +0OR5ra3GC++5ejZdT16P7eG3aLp1VxiHwJUb3wHdBpd943Prufa0QgkF3tc79gFWU
         NRfvNO9pj0a2AJAMQV2uOuG04CP889Lg/HC8HACmjl0aZVSa2Vckq5fY+J/wlR1PHk
         yXRI6HoMCoi0fQFnq3R/At7CWGdC2mZa/CalhDy7Qv7CSrRH+PShPtPvKPVJ+pfVAm
         tGL5UZOH8jK1A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p1CTw-0007xY-UN; Fri, 02 Dec 2022 21:18:01 +0100
Date:   Fri, 2 Dec 2022 21:18:00 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial fixes for 6.1-rc8
Message-ID: <Y4pdeBFL+7pQF1jD@hovoldconsulting.com>
References: <Y4o6ypWhDfI8DPuO@hovoldconsulting.com>
 <Y4pEcSmEuwGWo4TD@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4pEcSmEuwGWo4TD@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 07:31:13PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Dec 02, 2022 at 06:50:02PM +0100, Johan Hovold wrote:
> > The following changes since commit b7b275e60bcd5f89771e865a8239325f86d9927d:
> > 
> >   Linux 6.1-rc7 (2022-11-27 13:31:48 -0800)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.1-rc8
> 
> It's too late for 6.1-final for my tree, so I'll just queue these up for
> 6.2-rc1 and they can be backported if needed for 6.1.

Sounds good.

Johan
