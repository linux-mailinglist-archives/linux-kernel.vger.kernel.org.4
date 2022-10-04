Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750B25F42BE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 14:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJDMLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 08:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJDMLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:11:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BCC13DEA;
        Tue,  4 Oct 2022 05:11:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 585EDB81916;
        Tue,  4 Oct 2022 12:11:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920CFC433C1;
        Tue,  4 Oct 2022 12:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664885473;
        bh=L1vVhLYxkuI6o2rsPTxLZh+dFFA3mvTMk+Ki9D8adDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=17keS7AUWaQyo1ujOTVulXTep5iOw7iqxe6KGDOUGGq39fUtr10b1owceTk+hcip+
         1ZZYcO1VmEQwXVRkM+APzDQ7+GEkDHwaK2YqTw1m7zJJnDJAWx/yE2xMhyKU2bYK5A
         ouwuKZsMltwgq30tVdtOUT7gPqhQJ0RDx02w8O1I=
Date:   Tue, 4 Oct 2022 14:11:10 +0200
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
Message-ID: <Yzwi3tyAv4IoZdGR@kroah.com>
References: <20221004092129.19412-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004092129.19412-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 12:21:24PM +0300, Andy Shevchenko wrote:
> The property.h has inconsistency in how we annotate the parameters which
> are not modified anyhow by the certain APIs. Also dev_fwnode() needs to
> be rectified in sense of the handling const qualifier.
> 
> This series improves the above with only a couple of APIs left for now
> untouched (PHY, which I believe doesn't belong to property.h to begin
> with).

Looks sane at first glance.  I'll look at it some more once 6.1-rc1 is
out, thanks.

greg k-h
