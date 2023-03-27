Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7D66CA2C6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjC0Ls1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjC0Ls0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:48:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7825526B2;
        Mon, 27 Mar 2023 04:48:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C6C9611CD;
        Mon, 27 Mar 2023 11:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004AEC433EF;
        Mon, 27 Mar 2023 11:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679917704;
        bh=tLtZvmFNf2Kfy0YYLLGC3FJmLP1Ns+V1EFzqh3HVKjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AlA+lU+HeeU1QK/EZjKCJ0Tso+B99iq80yZ4PX7XM7btkyuPud9ecJWHwD1LiMnts
         t94baSO5Tt1vEuuJvkXBTIVQCgaFenyI3vVx+DE3wm+TyusW8VycOHWMW1woFEa9k4
         bBL2JPMukpC/qJ5Z1/fjyq5Oa//6Z1E/p8C/E/hY=
Date:   Mon, 27 Mar 2023 13:48:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v1 1/1] device property: Remove unused struct net_device
 forward declaration
Message-ID: <ZCGChRgzVZoaElge@kroah.com>
References: <20230323151519.58479-1-andriy.shevchenko@linux.intel.com>
 <ZCFryP+yZ7w38Ix9@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCFryP+yZ7w38Ix9@smile.fi.intel.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 01:11:20PM +0300, Andy Shevchenko wrote:
> On Thu, Mar 23, 2023 at 05:15:19PM +0200, Andy Shevchenko wrote:
> > There is no users in the property.h for the struct net_device.
> > Remove the latter for good.
> 
> Oh, this seems unfortunate as it doesn't Cc Greg. Folks, shall we add
> the header to "DRIVER CORE, KOBJECTS, DEBUGFS AND SYSFS"?

Yes please.
