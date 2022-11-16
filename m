Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5EB62BC6B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbiKPLri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239162AbiKPLq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:46:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59436F022
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:33:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01D2761D25
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 11:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82AEC4314C;
        Wed, 16 Nov 2022 11:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668598419;
        bh=QZNkSpuli8jsiuB+JH+me7dkfZ7DjjZyO9nWDuG8t9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XIc7re3nfACKXOrLTP23xtcXVkrquGTnt/ABuAdOFCGdPmNWj1CNldjv1lsIFd4iF
         QOUuP3GFQ2/C6ozCJMlGtlf/E0WZxNIHM+S+aqhKUfPgVOfh5y8XBYLvvkIoToTEAu
         aXEfuz5r3JruxJrmEr+AR2Z1H1AxmvFghgMwfM/s=
Date:   Wed, 16 Nov 2022 12:33:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     matt.hsiao@hpe.com
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        christophe.jaillet@wanadoo.fr, gustavoars@kernel.org,
        nishadkamdar@gmail.com, torvalds@linux-foundation.org,
        dhaval.experiance@gmail.com, viro@zeniv.linux.org.uk,
        arvind.yadav.cs@gmail.com, standby24x7@gmail.com,
        wfp5p@virginia.edu, jslaby@suse.cz, prarit@redhat.com,
        tj@kernel.org, adobriyan@gmail.com
Subject: Re: [PATCH] misc: hpilo: relicense HPE iLO driver as Dual MIT/GPL
Message-ID: <Y3TKkJFKWvCEKZg1@kroah.com>
References: <20221116094712.14312-1-matt.hsiao@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116094712.14312-1-matt.hsiao@hpe.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 05:47:12PM +0800, matt.hsiao@hpe.com wrote:
> From: Matt Hsiao <matt.hsiao@hpe.com>
> 
> Currently, the hpilo driver is licensed as GPL. To run OpenBSD on HPE
> servers with BMC (HPE iLO) functionality, a dual MIT/GPL license is needed
> for porting the hpilo driver to OpenBSD.
> 
> Signed-off-by: Matt Hsiao <matt.hsiao@hpe.com>

For dual-license stuff like this, I need to see a signed-off-by: from
your corporate lawyer so that we know that they fully understand the
issues involved here with dual licenses.

You are free to take your original version from your company and submit
it to the BSD codebase, but when taking it from Linux like this, there
is a lot more process and issues involved and so we need HPE's lawyers
to sign off.

Without that, sorry, I can't take this change.

greg k-h
