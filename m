Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B731B64735C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiLHPmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLHPmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:42:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84EC31A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:42:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 843FCB82448
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:42:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AE6C433C1;
        Thu,  8 Dec 2022 15:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670514131;
        bh=i9HuY//WsNFxbNT20NGYjsIDHgV71KWKWHMzOWdE8xE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l2Zap1pb2AnlXHiS5frvvxcfOep5iEthOgdgO7ysUhldUGw/wXf4y5sDaR6MH5PyJ
         CMqxp4i6VLgSqoqSrOAR+UXPGwxlenocjMuX+jIOetkaKbobWoDdEOkqc/ILzqtWgW
         xcn7rXkgtNANgrKD04EAgpBnx0zgZ9XJHzI0evgw=
Date:   Thu, 8 Dec 2022 16:42:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?Q?Micha=C5=82?= Lach <michal.lach@samsung.com>
Cc:     linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        russell.h.weight@intel.com, rafael@kernel.org,
        ming.lei@canonical.com, tiwai@suse.de
Subject: Re: [PATCH] drivers/firmware_loader: remove list entry before
 deallocation
Message-ID: <Y5IFz3ovrjlmPctM@kroah.com>
References: <CGME20221123111806eucas1p23fdcdbe6e5f4a9e714db428fcd6552b9@eucas1p2.samsung.com>
 <20221123111455.94972-1-michal.lach@samsung.com>
 <000901d90af2$309b7c80$91d27580$@samsung.com>
 <Y5HkIl41zN9fwKV8@kroah.com>
 <97ae8658-4eca-61af-5d5b-21b958ce1c24@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97ae8658-4eca-61af-5d5b-21b958ce1c24@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 04:23:52PM +0100, Michał Lach wrote:
> On 12/8/22 14:18, Greg KH wrote:
> > On Thu, Dec 08, 2022 at 11:45:28AM +0100, Michał Lach wrote:
> >> Pinging
> > 
> > I have no context here at all.
> > 
> > confused,
> 
> It seems like my mail client messed up the encoding, sorry.
> Below quoting the patch message:

Ok, but what does an empty ping here mean?

Are you asking why no one else has reviewed this?  Why it hasn't been
accepted?  What else needs to happen?  Something else?

be specific please :)

thanks,

greg k-h
