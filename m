Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABE2674E21
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 08:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjATH2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 02:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjATH2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 02:28:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A9C7DF95;
        Thu, 19 Jan 2023 23:28:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73A1161E4C;
        Fri, 20 Jan 2023 07:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE27C433EF;
        Fri, 20 Jan 2023 07:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674199682;
        bh=CPmbqgDo1jMvmz7vzmd6eFS6+yn+lorlB1s2VX9NuaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N6aK0tPxZG3EHoyLYYaZGU/iubh/1xpOwfzgLHUv7LTo/O7hjdTKCX66XIUxYh9aK
         UDN+fqQqz1uU6UwR+XdhkZtBdXT3YKeqp4ojsduDR3S+hFgtgleXLQvSSxiTVPLixV
         qyDydK6kC5UWOrONJY8ceqml0uE5qsS7TX4abbTM=
Date:   Fri, 20 Jan 2023 08:28:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 9/9] pktcdvd: Sort headers
Message-ID: <Y8pCgNPEfgMUZqVG@kroah.com>
References: <20230119220809.5518-1-andriy.shevchenko@linux.intel.com>
 <20230119220809.5518-9-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119220809.5518-9-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 12:08:09AM +0200, Andy Shevchenko wrote:
> Sort the headers in alphabetic order in order to ease
> the maintenance for this part.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

What maintenance?  Sorting headers is pointless, but whatever...

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
