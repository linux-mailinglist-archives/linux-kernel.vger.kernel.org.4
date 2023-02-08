Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D1E68F466
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjBHRYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjBHRYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:24:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFE64F87A;
        Wed,  8 Feb 2023 09:24:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6226F61758;
        Wed,  8 Feb 2023 17:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8BEC433EF;
        Wed,  8 Feb 2023 17:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675877040;
        bh=AeSSyAsNzNorJ9VbPjWB5HtPzWecVl6bAkmH6bnbe8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X8ov12kIrSNopowsBkMFNCbS+sxz3NVhY1yXTNIWsvAdZ+x/0AVlpie4WXWV5kp4h
         zxmnXO5g59zIn15+Ash6RfvIWZHJOdbxndWg8nCLMa0b3Tt7ZmPRfOIWI3aMPfxplR
         9hRhLFjC9ZzumftBL4ZvMHDpQXGii+IGiDd29qHM=
Date:   Wed, 8 Feb 2023 18:23:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     jassisinghbrar@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        error27@gmail.com, stern@rowland.harvard.edu,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] usb: gadget: udc: max3420_udc: fix serialized access
Message-ID: <Y+ParZzyRjsx8z5O@kroah.com>
References: <20230208163418.342210-1-jassisinghbrar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208163418.342210-1-jassisinghbrar@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 10:34:18AM -0600, jassisinghbrar@gmail.com wrote:
> From: Jassi Brar <jaswinder.singh@linaro.org>

Also, housekeeping issue, I know Linaro has good email servers, please
use them and not gmail accounts to send patches so that we can validate
that you really are the correct author.

thanks,

greg k-h
