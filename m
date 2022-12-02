Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726D1640713
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbiLBMqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbiLBMqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:46:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE29DC879;
        Fri,  2 Dec 2022 04:46:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF1D0622B0;
        Fri,  2 Dec 2022 12:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCD9C433C1;
        Fri,  2 Dec 2022 12:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669985191;
        bh=KeNvmjz5yvwkCbeUh8yprX3SS1E82mOsKB5RGfR5hEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w4LU94ggBx5nwibSkrnjbrVqxN2IFd6JPBrCaH4U0Yco++e5i9hibsP9EL9jALtpz
         V8BaOLFOxU4eF6lAbiKr/Oq6jFdsmOQ2lXvpafxtZKROQAAiSBwLz1TwDENvkdRfG7
         AYDmBRJpek27DBrCTZyo6dFQSM5R2w3hNi94EBSs=
Date:   Fri, 2 Dec 2022 13:46:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Allen Webb <allenwebb@google.com>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 0/1] Fix CONFIG_USB=y && CONFIG_MODULES not set
Message-ID: <Y4nzorzdLh2Jnj3f@kroah.com>
References: <CAJzde07w6U83U_63eaF0-6zaq0cOkaymuLb3CBZ++JQi+Y9JdA@mail.gmail.com>
 <20221201211630.101541-1-allenwebb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201211630.101541-1-allenwebb@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 03:16:29PM -0600, Allen Webb wrote:
> # Patch Review Discussion
> 
> Luis Chamberlain <mcgrof@kernel.org> would prefer something generic and
> mentioned kmod already has builtin.alias.bin.

Wait, how can 0/1 have a patch in it?

Take some time and read the mailing list for hundreds of examples of how
people submit patch series and how they document the changes in them and
why they should be accepted.  I think you are making this much harder
than it has to be.

even more confused,

greg k-h
