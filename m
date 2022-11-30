Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9084E63D405
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbiK3LKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbiK3LJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:09:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260B474CCE;
        Wed, 30 Nov 2022 03:09:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABDDD61B23;
        Wed, 30 Nov 2022 11:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF78AC433D6;
        Wed, 30 Nov 2022 11:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669806594;
        bh=VrGx7vva0UE6iHhAKgadVFwkUCKa9rYDmB273vEMUaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ExopNyTSR3VYIlbunrbIkaALgSVsLjYtV5vaCK5f2yX7qUu7d6raatNpeMK+Ks8bm
         ZLgsNcFYY9EXk5yZYBbbysRz4K3RE40U6LNP8yX/Z4vUlbYbRz4Kol7gV8oFQjkGQ+
         LdP5mdZvYdFfGTG2OYtIBm6obZUr2SlBfgNDekxg=
Date:   Wed, 30 Nov 2022 12:09:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: xr: avoid requesting zero DTE rate
Message-ID: <Y4c5/lUf4OAECuV9@kroah.com>
References: <20221129141857.15363-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129141857.15363-1-johan@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 03:18:57PM +0100, Johan Hovold wrote:
> When the requested line speed is B0 (hangup) there is no need to use the
> current speed in the line-coding request. This specifically avoids
> requesting a zero DTE rate when the current speed is B0, which could
> potentially confuse buggy firmware.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
