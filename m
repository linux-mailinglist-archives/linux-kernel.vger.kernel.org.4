Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46FF6312FB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 09:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiKTIVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 03:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKTIVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 03:21:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716D4970A8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 00:21:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F13B60C0B
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 08:21:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957BBC433C1;
        Sun, 20 Nov 2022 08:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668932505;
        bh=elZoUtt4+Cz+4m6hCEZRiBaFyMNqvEmC2jXE1vEy4gU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T8mOFsocyCJ5i9x7p9AAcQx5oQv0JeazCM+ihLU2urL7QgET15UM/kHpxXH9d1OFl
         dd+E60K4HAvU3eNFyfR5x2zynfJZXo2YV5dRaxfzlPSPMgfKeeUIIIJxMOjGNV3zX1
         EmjvvCzzLor6xjYjOvG7s6p4lQ73DirZ3hVjZUYE=
Date:   Sun, 20 Nov 2022 09:21:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Add a new generic system call which has better
 performance, to get /proc data, than existing mechanisms
Message-ID: <Y3njl8c0Azfq6QKm@kroah.com>
References: <20221118191202.2357801-1-anjali.k.kulkarni@oracle.com>
 <Y3iYlLmxvIqn/ETF@kroah.com>
 <MN2PR10MB414411D0E29F20412E6DF0C0C4089@MN2PR10MB4144.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR10MB414411D0E29F20412E6DF0C0C4089@MN2PR10MB4144.namprd10.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note, html email is rejected by kernel mailing lists, and top-posting
does not work at all in discussions.  Please fix your email client if
you wish to participate in kernel development.

On Sat, Nov 19, 2022 at 05:50:03PM +0000, Anjali Kulkarni wrote:
> I will give it a try, but the majority of the savings are due to avoiding the conversion from binary to string in /proc.

That goes contrary to your previous statement saying that the readfile
call would help out here.

And there might be ways to convert binary to strings, perhaps look into
doing that?

good luck,

greg k-h
