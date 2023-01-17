Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C72666E62D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 19:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbjAQShN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 13:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjAQSbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 13:31:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4022F539A2;
        Tue, 17 Jan 2023 10:03:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 330DCB8198D;
        Tue, 17 Jan 2023 18:03:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B77C433EF;
        Tue, 17 Jan 2023 18:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673978628;
        bh=TdhYGhhVDn9/5V6nyNmqMYhYOHv92PX9O2ciVLbIRVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jlp/DYjzLSsfVa6EfnkLK9etlziSUmG4MtAlEM4eL33MnNo9JHkATlCRZcDApwrOS
         LpyQjU5L0l+skkbW/cSv6Y8QNURjJQdLxTtscg4nxVyLFKF79PjscNF/NOv+ndA080
         8dsXQ5DuEN4AQ0DbDB14L3tMqk+orrPy1eRnIO3k=
Date:   Tue, 17 Jan 2023 19:03:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v3 0/4] software nodes: Get rid of rarely used APIs
Message-ID: <Y8bjAhZhcUOhFn/p@kroah.com>
References: <20221228094922.84119-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221228094922.84119-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 11:49:18AM +0200, Andy Shevchenko wrote:
> There is only a single user of software_node_register_nodes() and
> software_node_unregister_nodes(). Convert it to what others use and
> remove the unneeded APIs.
> 
> Since we have maintainers' tags applied it can be routed either through
> driver core or media tree — whatever you prefer.

I'll take these now, thanks!

greg k-h
