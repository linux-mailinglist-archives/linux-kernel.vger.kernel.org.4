Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE205674BB9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjATFHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjATFGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:06:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8268534A;
        Thu, 19 Jan 2023 20:54:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7764B826A1;
        Thu, 19 Jan 2023 19:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0E1C433D2;
        Thu, 19 Jan 2023 19:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674155042;
        bh=V3Wdo7NIBdWlO7v3VnTSJL6nge2GTSXrtALvGgkL+To=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A8wBm8+tv8qMrQNE0E2JAzRjS4IDWsjvUwNa4cf7Q7qMQqyNMDGW++qNClwwIg9z5
         RiH1ZP0bj+tkvkIjsktfnXiXR1u/AmwI0JCMCHt4b75OTYD7aQK2IRDYmGq68GJP01
         oyiMKsr2nXlXJX3DXf3Vgxgm8jsgwiqU66WgdB+Q=
Date:   Thu, 19 Jan 2023 20:03:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial fixes for 6.2-rc5
Message-ID: <Y8mUGMOvnTEo2i4F@kroah.com>
References: <Y8l42/yYoPZNiJa4@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8l42/yYoPZNiJa4@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 06:07:39PM +0100, Johan Hovold wrote:
> The following changes since commit b7bfaa761d760e72a969d116517eaa12e404c262:
> 
>   Linux 6.2-rc3 (2023-01-08 11:49:43 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.2-rc5
> 
> for you to fetch changes up to 71dfd381a7c051f16a61f82fbd38a4cca563bdca:
> 
>   USB: serial: option: add Quectel EM05CN modem (2023-01-16 08:47:47 +0100)

Pulled and pushed out, thanks!

greg k-h
