Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D126589E0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 08:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbiL2HNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 02:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiL2HN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 02:13:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A1FBF7F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 23:13:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C859B819C5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 07:13:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AF7C433D2;
        Thu, 29 Dec 2022 07:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672298003;
        bh=sOhTO9hFaxt8SzRNyMIFUWKw/hhgVle/1nPxfZCuhi4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bhJ5fIVXMCvTdl8tMPP7Iqytv5eg9fLpMGp2WxdW5bm3ATvgmKvuyUk2b1icS4vJP
         2nstZ18ydwS+hiwr+Det4HhGuctNi+x+nPQcP91xTdaWPbmZ3wg0s7Y4DhktFy7nFk
         CjzHrnOZepXKkCrXETnoI3QzQ7yiT+SW/aj2FlA0=
Date:   Thu, 29 Dec 2022 08:13:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Walt Holman <walt@holmansrus.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6.1 0000/1146] 6.1.2-rc1 review
Message-ID: <Y60+ClXkkBAfKhUf@kroah.com>
References: <933489772.83.1672266579857.JavaMail.zimbra@holmansrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <933489772.83.1672266579857.JavaMail.zimbra@holmansrus.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 04:29:39PM -0600, Walt Holman wrote:
> > This is the start of the stable review cycle for the 6.1.2 release.
> > There are 1146 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri, 30 Dec 2022 14:41:29 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > [ https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.2-rc1.gz | https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.2-rc1.gz ] > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > ------------- 
> 
> Hello, 
> 
> I'm getting a NULL Pointer Dereference when shutting down or rebooting. It happens just as it tries to shut down the swap device ( /dev/dm-3 ). This happens late in the shutdown process and nothing gets saved in the logs. However, I've attached a photo of my screen showing the Oops and stack trace. Let me know if there's anything you'd like me to try. 

Does this happen with 6.1.1 also?

Can you use 'git bisect' to track down the offending change?

thanks,

greg k-h
