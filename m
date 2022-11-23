Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED61636977
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239595AbiKWTCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239586AbiKWTCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:02:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51925A659C;
        Wed, 23 Nov 2022 11:02:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6A2761EB7;
        Wed, 23 Nov 2022 19:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7EDEC433D6;
        Wed, 23 Nov 2022 19:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669230127;
        bh=sQtdYWQYbReOobWHyRqhovaI/ls3vURfF0ovYZRIXfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hGPsx3u45wRTHyYj29v3sKZmMwPmZcoqdh3kJkIfVjDf0w3Mz6WV05RqwH5BiOSvh
         1GME0/QeJif/EaI9NCrziXwLgs4j27Kz2PSGjzDOb3bHH9VkCs0YxS29DKJmChuh77
         dKNTZ/N5ipjgpqq69Xm8THOvexUvS/JjqtQYVVl8=
Date:   Wed, 23 Nov 2022 20:02:04 +0100
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
Subject: Re: [PATCH v1 4/4] software node: Remove unused APIs
Message-ID: <Y35uLO41Xtm+q7ri@kroah.com>
References: <20221118185617.33908-1-andriy.shevchenko@linux.intel.com>
 <20221118185617.33908-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118185617.33908-4-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 08:56:17PM +0200, Andy Shevchenko wrote:
> There are no more users of software_node_register_nodes() and
> software_node_unregister_nodes(). Remove them.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
