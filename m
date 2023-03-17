Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22346BEAB6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCQOIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCQOIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:08:01 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2812EA56BE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:07:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 67BC4CE2011
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 14:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5A4C433EF;
        Fri, 17 Mar 2023 14:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679062067;
        bh=LTJvD2qIW13wqUmcIzfTnVnTtDxW+6wDdG5TJsCLS9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IzEoSpaXkCWE7gzSpGE73uXUJLh/XJMCagUKBC7atZpcfonMTR4iWKJ4VuI8UOOYm
         e+XY3kIDHdTBdMRCBzQGKjZLo0GfVVt0ZxzjA517EOncaAhu3WLpi2SgohbNNff3+b
         9+2NsZh1PabiasC4dSKZycu4RtWpt8SmTlNDO4HA=
Date:   Fri, 17 Mar 2023 15:07:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Graf <graf@amazon.com>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 1/1] mei: Move uuid.h to the MEI namespace
Message-ID: <ZBR0MVcQrokpSoRp@kroah.com>
References: <20230310170747.22782-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310170747.22782-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 07:07:47PM +0200, Andy Shevchenko wrote:
> There is only a single user of the UUID uAPI, let's make it
> part of that user.
> 
> The way it's done is to prevent compilation time breakage for
> the user space that does
> 
> 	#include <linux/uuid.h>
> 
> In the future MEI user space tools can switch over to use mei_uuid.h.

When will that happen?

And why the churn, what's the problem with keeping this as uuid.h?

thanks,

greg k-h
