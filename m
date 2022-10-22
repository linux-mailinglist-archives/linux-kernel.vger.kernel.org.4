Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786DA608CFE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiJVLwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiJVLvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:51:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A9E17A971;
        Sat, 22 Oct 2022 04:50:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 564FEB811D9;
        Sat, 22 Oct 2022 11:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD1DC433C1;
        Sat, 22 Oct 2022 11:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666439416;
        bh=lm7vjP87FUYA+4yVB1xuZ81DthREd8rb0PB0BwUCruE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NipwSaWdcs9m4O+fCa0fFpPa/RA9l2D0Gham+FMxfP4ViTRtjBTsZ3hAr7sZ7nDaB
         BG/rMLL8TDRxD5bHM+itjSwLmIT5dEZt1B9IMRMklcUp7VNouvLa8uX/IJV+r7182z
         auhHY2+3oMYtBSHtOXldKLtGA5c4SgaO5f//hkeI=
Date:   Sat, 22 Oct 2022 13:50:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 0/5] device property: Consitify a few APIs and
Message-ID: <Y1PY9PnoJ3tuvtQC@kroah.com>
References: <20221004092129.19412-1-andriy.shevchenko@linux.intel.com>
 <Yzwi3tyAv4IoZdGR@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yzwi3tyAv4IoZdGR@kroah.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 02:11:10PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Oct 04, 2022 at 12:21:24PM +0300, Andy Shevchenko wrote:
> > The property.h has inconsistency in how we annotate the parameters which
> > are not modified anyhow by the certain APIs. Also dev_fwnode() needs to
> > be rectified in sense of the handling const qualifier.
> > 
> > This series improves the above with only a couple of APIs left for now
> > untouched (PHY, which I believe doesn't belong to property.h to begin
> > with).
> 
> Looks sane at first glance.  I'll look at it some more once 6.1-rc1 is
> out, thanks.

All now applied, thanks.,

greg k-h
