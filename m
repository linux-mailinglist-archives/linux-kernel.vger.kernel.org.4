Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCD55F7432
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 08:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJGG04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 02:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiJGG0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 02:26:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CAB4C02C;
        Thu,  6 Oct 2022 23:26:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FA75B82200;
        Fri,  7 Oct 2022 06:26:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6983EC433D6;
        Fri,  7 Oct 2022 06:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665124010;
        bh=BXij9N9202DOclCxbLmvVz+mof/Qfp7auTme1KOWVuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f4jpzxjHA0J54dY6VTW3447ocX5l26jFk9pehmDm/BAn5pLehCvBHKkBFnPVJ/aB9
         OefYQMvRMAOV5QzBKcOVaQu6MsMfnKRU9MXMc0AQWSDDdcipRDlZjhkuRCblSPXkpJ
         cMWQ71jzXJYaOC+FxHwyDiOG3wXZzK6pfZAE9tkg=
Date:   Fri, 7 Oct 2022 08:27:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     justinpopo6@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, kishon@ti.com, linux-phy@lists.infradead.org,
        f.fainelli@gmail.com, alcooperx@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, justin.chen@broadcom.com
Subject: Re: [PATCH] MAINTAINERS: Update maintainers for broadcom USB
Message-ID: <Yz/G0jQxc4c2gzhl@kroah.com>
References: <1665098469-19008-1-git-send-email-justinpopo6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1665098469-19008-1-git-send-email-justinpopo6@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 04:21:09PM -0700, justinpopo6@gmail.com wrote:
> From: Justin Chen <justinpopo6@gmail.com>
> 
> Al Cooper is no longer the downstream maintainer for broadcom USB.
> I will be taking his place as downstream and as an additional
> upstream maintainer.

What do you mean by "downstream" here?

> Signed-off-by: Justin Chen <justinpopo6@gmail.com>

I need Al's ack as well.

thanks,

greg k-h
