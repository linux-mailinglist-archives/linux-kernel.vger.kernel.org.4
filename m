Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BD2636972
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239437AbiKWTCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237809AbiKWTCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:02:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1A992B73;
        Wed, 23 Nov 2022 11:02:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CA88B823F2;
        Wed, 23 Nov 2022 19:02:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBFCC433C1;
        Wed, 23 Nov 2022 19:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669230119;
        bh=/+8sC7eTU2zXq6flELFZn64zodlk1JLAzuh+ERsCqDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yKvfYsb246zix6A7u9SqWYymcPPvPJkZDpNcN6KkkufYCDc0Z3U76bP3vxuVLfPLZ
         tCfFWn8mbCHzU0BKi2AOpSSmM5+W1Tge1okHQJ8I+9PFK1AUHr++Q+PXEJtW0jMdld
         9xXrUXmxTYfWASc/OSySE1ObYeTlYmB71Ry1Nt84=
Date:   Wed, 23 Nov 2022 20:01:56 +0100
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
Message-ID: <Y35uJNWfEdpPSo69@kroah.com>
References: <20221118185617.33908-1-andriy.shevchenko@linux.intel.com>
 <20221118185617.33908-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118185617.33908-3-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 08:56:16PM +0200, Andy Shevchenko wrote:
> Switch property entry test to use software_node_register_node_group() API.
> The current one is going to be removed soon.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/test/property-entry-test.c | 30 ++++++++++++-------------
>  1 file changed, 14 insertions(+), 16 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
