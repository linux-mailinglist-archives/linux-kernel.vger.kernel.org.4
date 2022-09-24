Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3335E8B89
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 12:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbiIXKjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 06:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbiIXKjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 06:39:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D10124178;
        Sat, 24 Sep 2022 03:39:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DADA60A52;
        Sat, 24 Sep 2022 10:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB65C433C1;
        Sat, 24 Sep 2022 10:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664015955;
        bh=rZetDSLhcglTSJ1Z8C7ZllgJL2UQDDYRgHkMKIB63WE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yo5gbc9Zj9Jl0yR0dziFEEuQX5K8FVlpBY1P8+2Dg4AWALg1Cg3+23hOEvWZERBt8
         F4sVXx7D9TqBpZYjHIQFtj1ASWOgHfY4QUwBVJcUqhdSs29Pyvn46mh7Zx+WK5YMmS
         RyBJklauq2ulyTUxQY1A3wq6TbxtfmjMnv5AaQ7k=
Date:   Sat, 24 Sep 2022 12:39:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v1 0/2] usb: dwc3: revert OTG changes for Intel Merrifield
Message-ID: <Yy7eUZh6sWbDekEC@kroah.com>
References: <20220923163051.36288-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923163051.36288-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 07:30:49PM +0300, Andy Shevchenko wrote:
> It's late in the cycle, that's why I send these reverts, so we will have a
> full new cycle for testing a better solution if any.

Wait, you need these into what release?  6.1-rc1?

The commits you are referencing are in 5.19, right?  Not 6.0-rc.

> So this is just a proactive move if we have no solution in the nearest days.

How will I know this?

confused,

greg k-h
