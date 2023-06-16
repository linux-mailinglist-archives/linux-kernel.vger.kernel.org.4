Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4177F732B0A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjFPJGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343975AbjFPJGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:06:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D636E3C3C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:04:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D79D63185
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4679FC433C0;
        Fri, 16 Jun 2023 09:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686906264;
        bh=ApZSchng3QVjySvucr/CxJMq9FxqU7kumKKqVh5yzjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y7HysZYaeJ0B4uWVDfOff4vQKFAoKJEiHuYfBYQMxF6hFbR/+ho4s/XMDx0N4rAMx
         s0uAvcbbXiMWxCEpQQl4np+g/cg/SnlPqOZgNVth8b6gNPLEKTH4hKqeOFQuLW5D4x
         cuOCGn5z+aqqriaZ6ruOJWHXLypG7+dEy7CYWzfs=
Date:   Fri, 16 Jun 2023 11:04:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alison Wang <alison.wang@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Leo Li <leoyang.li@nxp.com>, Forrest Shi <xuelin.shi@nxp.com>,
        "X.F. Ren" <xiaofeng.ren@nxp.com>, Feng Guo <feng.guo@nxp.com>
Subject: Re: [EXT] Re: [PATCH 0/8] ethosu: Add Arm Ethos-U driver
Message-ID: <2023061646-coil-broadly-9efc@gregkh>
References: <20230616055913.2360-1-alison.wang@nxp.com>
 <2023061647-upward-petty-7695@gregkh>
 <AM9PR04MB89076472B9A29DDFFB2F958CF458A@AM9PR04MB8907.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR04MB89076472B9A29DDFFB2F958CF458A@AM9PR04MB8907.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 08:26:28AM +0000, Alison Wang wrote:
> 
> On Fri, Jun 16, 2023 at 01:59:05PM +0800, Alison Wang wrote:
> > This series contains Arm's NPU Ethos-U driver for NXP i.MX93 platform.
> >
> > Ethos-U Linux driver is to provide an example of how a rich operating 
> > system like Linux can dispatch inferences to an Arm Cortex-M 
> > subsystem, consisting of an Arm Cortex-M and an Arm Ethos-U NPU.
> 
> What is an "inference"?
> [Alison Wang] The inference here means machine learning inference. It is the process of
> running data points into a machine learning model to calculate an output such as a single 
> numerical score. For example, we use this driver, user space application and Cortex-M firmware
> to complete an inference about image classification.

Nice, so why isn't this under drivers/accel/ then?  Does it not need
that framework?

> Where are the userspace tools (if any) that are needed for this driver to work properly?
> [Alison Wang] You could refer to https://github.com/nxp-imx/ethos-u-driver-stack-imx.git .

Please put that in the documentation for the commit.

thanks,

greg k-h
