Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F4062BC7F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbiKPLuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239169AbiKPLtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:49:06 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36606357
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:36:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F17B7CE19D9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 11:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89841C433D7;
        Wed, 16 Nov 2022 11:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668598603;
        bh=ixX+YPCFYHc7XCB1Nv7cC2vBHNQiJFkPbukvg6lvDDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aT2GzcU6MmM+chkSs0wEtE+qg72d3PeQ6+SnJrj9kIBQOs4LlxxRT6qbYVfngcEaB
         ugWOrQO2wUHC11K25tfdy07Ark78EhhXMXED6w23y3dGIw31lVm8cdE0PStWI06HUw
         hauSQMmq71tq31pRlJyGBkDFv82kpyiiAnVnASaw=
Date:   Wed, 16 Nov 2022 12:36:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     matt.hsiao@hpe.com
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        christophe.jaillet@wanadoo.fr, gustavoars@kernel.org,
        nishadkamdar@gmail.com, torvalds@linux-foundation.org,
        dhaval.experiance@gmail.com, viro@zeniv.linux.org.uk,
        arvind.yadav.cs@gmail.com, standby24x7@gmail.com,
        wfp5p@virginia.edu, jslaby@suse.cz, prarit@redhat.com,
        tj@kernel.org, adobriyan@gmail.com
Subject: Re: [PATCH v2] misc: hpilo: relicense HPE iLO driver as Dual MIT/GPL
Message-ID: <Y3TLSON/7XRG5BiN@kroah.com>
References: <20221116103457.27486-1-matt.hsiao@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116103457.27486-1-matt.hsiao@hpe.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 06:34:57PM +0800, matt.hsiao@hpe.com wrote:
> From: Matt Hsiao <matt.hsiao@hpe.com>
> 
> Currently, the hpilo driver is licensed as GPL. To run OpenBSD on HPE
> servers with BMC (HPE iLO) functionality, a dual MIT/GPL license is needed
> for porting the hpilo driver to OpenBSD.
> 
> Signed-off-by: Matt Hsiao <matt.hsiao@hpe.com>
> ---
> 
> Hello contributors in the CC list,
> 
> Thanks for your contributions to the hpilo driver. Please kindly review
> the license change and hopefully you would agree and approve it. Thanks!
> 
> Patch v2:
> ---------
> - Change MODULE_LICENSE to Dual MIT/GPL too

As I asked for on the v1 version (delayed email on my side), I need a
lawyer from HPE to sign off on this change as well.

thanks,

greg k-h
