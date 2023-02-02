Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538EF6881AA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjBBPWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjBBPWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:22:40 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684EFDE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 07:22:39 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0A65468C7B; Thu,  2 Feb 2023 16:22:35 +0100 (CET)
Date:   Thu, 2 Feb 2023 16:22:34 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 1/1] mei: Move uuid_le_cmp() to its only user
Message-ID: <20230202152234.GA28999@lst.de>
References: <20230202145412.87569-1-andriy.shevchenko@linux.intel.com> <20230202151759.GA28861@lst.de> <Y9vVENZEjg1e43LT@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9vVENZEjg1e43LT@smile.fi.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 05:21:52PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 02, 2023 at 04:17:59PM +0100, Christoph Hellwig wrote:
> > On Thu, Feb 02, 2023 at 04:54:12PM +0200, Andy Shevchenko wrote:
> > > There is only a single user of uuid_le_cmp() API, let's make it private
> > > to that user.
> > 
> > Any reason this code can't just use guid_t and guid_equal?
> 
> It's part of ABI, while guid_* are for the internal use.
> 
> Eventually they may switch to the internal types, but it's up to MEI.

How can a type name be part of a binary interface?
