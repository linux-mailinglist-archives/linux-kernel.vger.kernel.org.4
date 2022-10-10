Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B155F989B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 08:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiJJGvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 02:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiJJGvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:51:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59722CFD
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 23:51:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8ED360E05
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 06:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B998C433D6;
        Mon, 10 Oct 2022 06:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665384677;
        bh=VD9PjQ7/pjLy7rLXealUyrJo3mpPcEYLmjdSEvafNtk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TS+Yzb+6PUqKebWDSS3PYpdR9iGZL/gZg3JuWiNMXJdc5lq34jxCM9nS6zWRBjnzd
         X+eNvcAMXIGTG5uyPQYVSz6JEJltxW1hanFRNYvLdNrSDRSorU4G27hbAelZuhbddT
         F9Bofth9DTtZ7i4oNX2fXplF7EfT2kYJrxFaFT7E=
Date:   Mon, 10 Oct 2022 08:52:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] driver core: remove devm_device_add_groups() and
 devm_device_remove_groups()
Message-ID: <Y0PBEFL7O0HOaqnZ@kroah.com>
References: <20221008154310.278062-1-gregkh@linuxfoundation.org>
 <Y0O+xylVpBGtqmIr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0O+xylVpBGtqmIr@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2022 at 11:42:15PM -0700, Dmitry Torokhov wrote:
> Hi Greg,
> 
> On Sat, Oct 08, 2022 at 05:43:10PM +0200, Greg Kroah-Hartman wrote:
> > There are no more in-kernel users of these functions, and no drivers
> > should be ever using them anyway, so remove them as they are not needed.
> 
> I still see call to devm_device_add_groups() in
> drivers/soundwire/sysfs_slave.c in the latest linux-next. Once it is
> gone you can add my
> 
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks, that patch is in a series in my tree, sorry I missed that.  I'll
work to get that merged before submitting this one.

greg k-h
