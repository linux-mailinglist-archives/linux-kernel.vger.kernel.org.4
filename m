Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C266CD15F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 06:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjC2E7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 00:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjC2E7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 00:59:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5040273E;
        Tue, 28 Mar 2023 21:59:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DA3EB81BD2;
        Wed, 29 Mar 2023 04:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD21C433EF;
        Wed, 29 Mar 2023 04:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680065978;
        bh=VyIflVYAjyIL5MoWA1Yn7cwvosZyO5A3cGssRTvK1ls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PMO3JRjuntfa6092bvweVA6gESQcQKflaFhlMhABpqD1bYr+ZI4jXbr3Sz8eFEK6v
         X5GK2F9v1w1yXrnK+p4cEihTOs6UrOFi23O7lYMr+AZ25M1cfhRUzsTEeuFFKoJ+aH
         0MaYepierb85W9WH2+p2bmLG8+dKSCjBwfSwZDvo=
Date:   Wed, 29 Mar 2023 06:59:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joseph Lutz <joseph.lutz@novatechautomation.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: drivers/usb/class/usbtmc.c
Message-ID: <ZCPFuJnQ6BbF4n6o@kroah.com>
References: <DS7PR07MB775169F24942174F54B4246494889@DS7PR07MB7751.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DS7PR07MB775169F24942174F54B4246494889@DS7PR07MB7751.namprd07.prod.outlook.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 06:23:31PM +0000, Joseph Lutz wrote:
> I am having some issues with the kernel driver "drivers/usb/class/usbtmc.c". I am trying to figure out who I can contact that would have information about how this driver is working.

Hi,

First off, please do not send html email, the mailing lists reject it
(as you found out), and it will not get to anyone.

> The script ./scripts/get_maintainer.pl drivers/usb/class/usbtmc.c​ gives me the following addresses which is why I am writing to you.
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB SUBSYSTEM)
> linux-usb@vger.kernel.org (open list:USB SUBSYSTEM)
> linux-kernel@vger.kernel.org (open list)
> 
> I am not certain whether I should be communicating with these email addresses or if I should be communicating with the individuals on the github sight. https://github.com/dpenkler/linux-usbtmc

If you look at the git history for the driver in the kernel, you will
see Dave Penkler <dpenkler@gmail.com> as a probably good contact.

So try resending your message, with the information you had before about
the problem you are seeing, to the lists and to Dave and in non-html
format and we can go from there.

thanks,

greg k-h
