Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1B86369D9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239492AbiKWTZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbiKWTZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:25:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349A9C6959;
        Wed, 23 Nov 2022 11:25:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C184A61E7A;
        Wed, 23 Nov 2022 19:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC80C433C1;
        Wed, 23 Nov 2022 19:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669231504;
        bh=GE9XZ20MqdTZOk+li0IqsrrL8BtMgeL5mwS/9DEQT6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wbuXlZfIjnD7PkbeW9cNi+tZZIpH7iGhIDjsF3zAgNV0Z6R7z8U/pRcJSZL9Ofmej
         1LhNiCZ4I169UAcSTTwMYElxWyQ9ib0u70ZXRClQBq8kzdC5IWSnAfP/h/06FcDhoI
         iJvJkyL6MtY4osLtf15c3cw9tJBkWQSy8aGxdPso=
Date:   Wed, 23 Nov 2022 20:25:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>
Subject: Re: [PATCH v1 3/4] software node: Switch property entry test to new
 API
Message-ID: <Y35zjXyi80/VXQxz@kroah.com>
References: <20221118185617.33908-1-andriy.shevchenko@linux.intel.com>
 <20221118185617.33908-3-andriy.shevchenko@linux.intel.com>
 <Y35uJNWfEdpPSo69@kroah.com>
 <Y35vWSXmmKp987KD@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y35vWSXmmKp987KD@smile.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 09:07:05PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 23, 2022 at 08:01:56PM +0100, Greg Kroah-Hartman wrote:
> > On Fri, Nov 18, 2022 at 08:56:16PM +0200, Andy Shevchenko wrote:
> > > Switch property entry test to use software_node_register_node_group() API.
> > > The current one is going to be removed soon.
> 
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Thank you! I hope this stays for v2 (which had been on mailing lists for
> a few days).

Yes, sorry, that's the same there, so it holds for there too.
