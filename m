Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999DD6C36DB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCUQXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjCUQXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:23:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32419C178
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 09:23:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E15EAB818B9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 16:23:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E4FC433EF;
        Tue, 21 Mar 2023 16:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679415806;
        bh=uue6qiaQKVY5+wTP4innAWbKfaDTVoOx45k8f62iqtQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SIS7ALZMfufDYHYMJEOlXVh3eCo81uErof6GPYDZ54jKQsGsn+S/XrML0TzuqYXwz
         v47Lqx8D1y13G7Ve8t+jcvvskRn0H7KXpji8becld/en3/zOutTkvf++aVamwfHzIp
         VDoftoyJhMrLKoUFJmrWIixnb5MmkZ8LSYfg6obY=
Date:   Tue, 21 Mar 2023 17:23:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: fix line ending with '('
Message-ID: <ZBnZ+xM0+59Lmvhi@kroah.com>
References: <ZBhNOkQbG4ygNF98@khadija-virtual-machine>
 <ZBnZD5alylOgjhYd@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBnZD5alylOgjhYd@khadija-virtual-machine>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 09:19:27PM +0500, Khadija Kamran wrote:

<snip>

> Hey Outreachy Mentors,
> 
> Kindly take a look at this patch and let me know if I should wait for
> the response on this patch or submit another patch.

Less than 1 day later?

Please relax and always keep working on new things, don't let my
response time be the gateway for you doing work, otherwise you are not
going to get very much done at all.

You normally have to wait about 2 weeks to get a patch reviewed,
sometimes I go much faster, sometimes slower.  Either way, it's
uncertian...

thanks,

greg k-h
