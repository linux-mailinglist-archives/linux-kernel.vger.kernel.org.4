Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133A66F8EB9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 07:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjEFFsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 01:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEFFs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 01:48:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D79171B;
        Fri,  5 May 2023 22:48:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19214611DC;
        Sat,  6 May 2023 05:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775D1C433D2;
        Sat,  6 May 2023 05:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683352105;
        bh=rZlE3C/xNIQS690d4XI94A2grg6piThzHbCoQJ5U268=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G81x1AuXZPfIS9eOD03bRkL+U6wPAuECEqEV5rFabzEyO73m51qxPGjPVP8UOYGh0
         ILgbsjdsi754NkNhRGEyq6+yHwtHc9VvFwQSSfui9Iy0dasYVfi9Z7r0k5tt57ty1H
         E+Bvt6I50p0DB9/0oKXq6pm4stgj6d2Dk8FQLypU=
Date:   Sat, 6 May 2023 09:38:35 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ronald Warsow <rwarsow@gmx.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: no sha256sum for 6.3.1 (was Re: Linux 6.3.1)
Message-ID: <2023050617-stardom-granola-32e3@gregkh>
References: <f0497747-2318-7355-6ea6-ff01f9eb97ef@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0497747-2318-7355-6ea6-ff01f9eb97ef@gmx.de>
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2023 at 03:03:45PM +0200, Ronald Warsow wrote:
> Hi Greg
> 
> fetching new kernels via script:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mricon/korg-helpers.git/tree/get-verified-tarball
> 
> it seems
> https://cdn.kernel.org/pub/linux/kernel/v6.x/sha256sums.asc
> 
> doesn't contain a hash for 6.3.1

Yeah, that does look odd.

Konstantin, I think you said you updated some things on the servers
right after I did the 6.3.1 release, would this have caused the
signature to not be recorded in this file?

thanks,

greg k-h
