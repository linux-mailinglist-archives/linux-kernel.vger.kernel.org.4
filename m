Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447C35E9220
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 12:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiIYKfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 06:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbiIYKev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 06:34:51 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349C8EE02;
        Sun, 25 Sep 2022 03:34:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 227CECE0B8E;
        Sun, 25 Sep 2022 10:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAE5C433D6;
        Sun, 25 Sep 2022 10:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664102077;
        bh=qpOghKpTxCTriS29Prwi5ptER7POgqpb8lzSopbdUAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=siI2k+rtXQyVnfr+YCJXpEgW4WRFxY4ZewaWHnvV9KEkiC7w+nR1Rp9T5MfBO507K
         NVhjEfNSgrU1k/+KaQ+ZV+RMiAJLIENakWPKy+imlqDw7WqIyvUtR6nLIMZNzUvuw2
         dNPKm2yqp77KxU0JGXjWAJjXczaCv19IYLjChOJQ=
Date:   Sun, 25 Sep 2022 12:34:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fix: add XHCI_SPURIOUS_SUCCESS to ASM1042 despite
 being a V0.96 controller
Message-ID: <YzAuuvSBPohXMCc0@kroah.com>
References: <em0b7a6682-2da4-4480-8801-1107ea9756dd@aea403bc.com>
 <Yy7ENBX2Zo3vNgB1@kroah.com>
 <em98cdb3f1-82c0-4fd3-92af-9c3d062b3d0c@35bdcead.com>
 <YzAMRPjywl0f4uSY@kroah.com>
 <emf600f901-91ef-4aea-931e-9f6fc5f42c86@689b6561.com>
 <YzAoUyw1opYHVFGB@kroah.com>
 <em9fc0c9e0-e371-41cf-9065-1b007b937158@689b6561.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <em9fc0c9e0-e371-41cf-9065-1b007b937158@689b6561.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2022 at 10:21:39AM +0000, Jens Glathe wrote:
> ... and this is the moment where I append the patch file in hope that this
> somehow works.

I can't take attachments, sorry.  Try using 'git send-email' to get this
to work properly.  This guide might help you out with that:
	https://git-send-email.io/

Also look at your subject line and try to match it up with how other
commits for this driver/file are done, it needs to be tweaked a bit.

thanks,

greg k-h
