Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CB268EEF7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 13:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjBHM1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 07:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjBHM1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 07:27:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A5D2E0F7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 04:27:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BD66616C0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 12:27:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A2AC433EF;
        Wed,  8 Feb 2023 12:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675859263;
        bh=tkK2+0BqblY+0MQ5VMV2fKZBuIay8ZTRxNcOWoK9jIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nMlU0WJpOCkzvnkjNR86j5fC98soB1Cu3lJPqQqE4kN8wDY3caeP5Q1MMLQOlLpK1
         8jzflluPJtIRbJVJ4ufPcPmSImLQhpGJf3r6qWOSpy9VNFWx2K7UOPea3nKGlaO/lc
         dGxwqbN9AGYy8W3L4PLqCN7uEHrpiDE0+qqoUuFA=
Date:   Wed, 8 Feb 2023 13:27:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [char-misc-next v2 2/2] mei: gsc_proxy: add gsc proxy driver
Message-ID: <Y+OVPC+XLvXS4HIE@kroah.com>
References: <20230205181132.191064-1-tomas.winkler@intel.com>
 <20230205181132.191064-3-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230205181132.191064-3-tomas.winkler@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2023 at 08:11:32PM +0200, Tomas Winkler wrote:
> From: Alexander Usyskin <alexander.usyskin@intel.com>
> 
> Add GSC proxy driver. It to allows messaging between GSC component
> on Intel on board graphics card and CSE device.
> 
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
> 
> V2: refactor match function
>     use device information instead of driver name
>     to identify the aggregate device.

Much much better, thank you!

If you can clear up the answers to patch 1, I'll be glad to take this
through my tree.

thanks,

greg k-h
