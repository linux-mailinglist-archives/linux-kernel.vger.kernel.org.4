Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044136CB657
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 07:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjC1Fu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 01:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC1Fu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 01:50:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266C11BFD;
        Mon, 27 Mar 2023 22:50:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B60F360D3E;
        Tue, 28 Mar 2023 05:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94146C433D2;
        Tue, 28 Mar 2023 05:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679982626;
        bh=q+knkIWysAQmFQ2JUpdp6VbIGcT75FFuH0sjU1kxZ/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0vebPBW1MIEoJZ0uQPMERMd6rXRdHSCgYZZEWHICtCHB74ZGm7WLYJmJJEL+UUJ/G
         PB+IJ9GrmvJ/4q44oZXA/D6W0kI9I7FW0qb4CWdKU+Qhfajw9H34gkiqQ7DMrIrugs
         QROK8G6LSYv6/7IvF56hrueJXwLvHhqRxBebfNJo=
Date:   Tue, 28 Mar 2023 07:50:23 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Starke, Daniel" <daniel.starke@siemens.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 1/3] tty: n_gsm: add ioctl for DLC specific parameter
 configuration
Message-ID: <ZCKAH3y7qBmWNjf2@kroah.com>
References: <20230315105354.6234-1-daniel.starke@siemens.com>
 <DB9PR10MB58810D7D5F76820DD19C686DE0889@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR10MB58810D7D5F76820DD19C686DE0889@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 05:27:59AM +0000, Starke, Daniel wrote:
> Is there any blocking point which prevents this patch series from being
> merged?

Yes, me getting through my pending backlog:
	$ mdfrm -c ~/mail/todo/
	1211 messages in /home/gregkh/mail/todo/

Give me some time to catch up please.

To help out, and while you wait, please review other patches on the
mailing lists to help relieve the review load so that your patches can
get closer to the top of the list.

thanks,

greg k-h
