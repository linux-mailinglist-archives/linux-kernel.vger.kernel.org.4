Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DD76B6F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 07:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjCMGbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 02:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjCMGbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 02:31:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D3F3CE12;
        Sun, 12 Mar 2023 23:31:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2769B80DBE;
        Mon, 13 Mar 2023 06:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F39C433EF;
        Mon, 13 Mar 2023 06:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678689106;
        bh=XYltQqLH/YgnHqNRlpBtYqhy53KcaVe7vPvM9fbFjRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R8oqGE/BCMV/Ng214H0lYH40oL4csE6jT5MP7QnPEz7ghNYnhBG3hRGMZn9v66+q5
         WXGFEWh+nkvZKgURNKKh0G9B+la0M6VIATTdsxsDza6MsgA9JhqaLvav4C0yL0cBqX
         lLE7idxb1o2zIk3Gr5XK6BB1pc5QfoUzC/ChI9Ks=
Date:   Mon, 13 Mar 2023 07:31:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Cixi Geng <cixi.geng@linux.dev>
Cc:     orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, arnd@arndb.de, tony@atomide.com,
        felipe.balbi@linux.intel.com, paul@crapouillou.net,
        linus.walleij@linaro.org, cixi.geng1@unisoc.com,
        gengcixi@gmail.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [RFC PATCH v1] usb/phy add sprd ums512 usbphy
Message-ID: <ZA7DUH+qJyMmWBq5@kroah.com>
References: <20230312171438.177952-1-cixi.geng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230312171438.177952-1-cixi.geng@linux.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 01:14:38AM +0800, Cixi Geng wrote:
> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> This driver is support USB2 phy for Spreadtrum UMS512 SOC's,
> 
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>

Why is this "RFC"?  What is left to do on it to be accepted?

> ---
>  drivers/usb/phy/Kconfig           |  10 +
>  drivers/usb/phy/Makefile          |   1 +
>  drivers/usb/phy/phy-sprd-ums512.c | 511 ++++++++++++++++++++++++++++++
>  drivers/usb/phy/phy-sprd-ums512.h |  39 +++

Why do you need a .h file for a single .c file?  Please just put them
all together into one file.

thanks,

greg k-h
