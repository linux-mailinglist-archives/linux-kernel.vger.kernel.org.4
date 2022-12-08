Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381E16470AD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 14:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiLHNS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 08:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiLHNSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 08:18:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528F393A66
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 05:18:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA2DD61F20
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 13:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD20BC433D7;
        Thu,  8 Dec 2022 13:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670505510;
        bh=OE2p3IdlRIDNul7bR3CfBPXG8zDJGnV23WSvlp8hwKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T9qgKxn+ySLGraxMbXvcw4xG5vWA3xfYDnmcsE9BeO+RlweMbpndWGcQycl4QxmLe
         Tou4lNqgKOYhCfTBHDqlfL0Mn5ybKRRpJ+ekTvqOdIu6viF3+xj2zRshwQYVjMKd9E
         b2AEIkVhPfXFf/m5ympibgOWO4KmHSU75p/XLB+E=
Date:   Thu, 8 Dec 2022 14:18:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?Q?Micha=C5=82?= Lach <michal.lach@samsung.com>
Cc:     linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        russell.h.weight@intel.com, rafael@kernel.org,
        ming.lei@canonical.com, tiwai@suse.de
Subject: Re: [PATCH] drivers/firmware_loader: remove list entry before
 deallocation
Message-ID: <Y5HkIl41zN9fwKV8@kroah.com>
References: <CGME20221123111806eucas1p23fdcdbe6e5f4a9e714db428fcd6552b9@eucas1p2.samsung.com>
 <20221123111455.94972-1-michal.lach@samsung.com>
 <000901d90af2$309b7c80$91d27580$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000901d90af2$309b7c80$91d27580$@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 11:45:28AM +0100, Michał Lach wrote:
> Pinging

I have no context here at all.

confused,

greg k-h
