Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A336634265
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 18:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbiKVRWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 12:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbiKVRWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 12:22:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A84AF0D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 09:22:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CB1DB81D02
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 17:22:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464A9C433C1;
        Tue, 22 Nov 2022 17:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669137760;
        bh=blketPLwx3kAKRAe598PLNvJaliVMPU5vUUurHEWy5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jgg9xP1Y+bGrHjx/Gks4aBE9jR884j5nWetPY3p1RD3rq0fDvWQcTxpXm56W7ycRK
         Ucr+wXhGA9TtFEiuJ7Kt0BXEaG3zCxu/wxCQm7XSwLgcbw6tW4484MVi6wU5NbV8R+
         2CRIWxn86GcgrewEGdDk8V+IMiMFVW/vA3oqMeB0=
Date:   Tue, 22 Nov 2022 18:22:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] nvmem: fixes for 6.1
Message-ID: <Y30FXehscJfTKDeN@kroah.com>
References: <20221118063840.6357-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118063840.6357-1-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 06:38:36AM +0000, Srinivas Kandagatla wrote:
> Hi Greg,
> 
> Here is a few minor fixes in u-boot-env, rmem and lan9662-otp nvmem providers.
> -two lan9662 fixes are to fix the compatible string and fix a smatch
> warning.
> - rmem fixes an error handling path.
> - u-boot env has fix for data offset.
> 
> If its not too late, can you take them for 6.1.
> 

2 of these were already in 6.1-rc6, but I took the others now as well.

thanks,

greg k-h
