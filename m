Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CF561E2EA
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 16:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiKFPTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 10:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiKFPS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 10:18:58 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 95851D2C5
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 07:18:57 -0800 (PST)
Received: (qmail 408407 invoked by uid 1000); 6 Nov 2022 10:18:56 -0500
Date:   Sun, 6 Nov 2022 10:18:56 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 3/3] can: etas_es58x: report the firmware version
 through ethtool
Message-ID: <Y2fQYGroZ7l3mSoe@rowland.harvard.edu>
References: <20221104073659.414147-1-mailhol.vincent@wanadoo.fr>
 <20221104171604.24052-1-mailhol.vincent@wanadoo.fr>
 <20221104171604.24052-4-mailhol.vincent@wanadoo.fr>
 <Y2Ydf6UxVvTe8Zmz@kroah.com>
 <CAMZ6RqJkzag-PGuzHcDQkSXjqH6d8=uAe-UN8VXUoNWX2x+qbw@mail.gmail.com>
 <CAMZ6RqLMGfW0QcNdBKhfwayV=+FNHhvM_-ob0UvL=o6=zN0J7A@mail.gmail.com>
 <Y2afm9xFIvJnwXh/@kroah.com>
 <Y2cDlrNjL5YSAPm2@rowland.harvard.edu>
 <Y2eYw9Kna712mzR8@kroah.com>
 <CAMZ6RqJVFwhCjxghmDBt2kYeT_KhqE-4h=UGtKaSA1bwke1CaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZ6RqJVFwhCjxghmDBt2kYeT_KhqE-4h=UGtKaSA1bwke1CaA@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2022 at 09:47:05PM +0900, Vincent MAILHOL wrote:
> I have two questions:
> 
> 1/ Can I still export and use usb_cache_string()? In other terms, does
> the first patch of this series still apply? This looks like the most
> convenient function to retrieve that custom string to me.

FWIW, that's okay with me.

> 2/ Is it a no-go to also populate ethtool_drvinfo::fw_version? Some
> users might look for the value in sysfs, while some might use ethtool.
> If the info is not available in ethtool, people might simply assume it
> is not available at all. So, I would like to provide both.

I don't see any reason not to do this.

Alan Stern
