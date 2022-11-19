Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB52630D89
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 09:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbiKSItl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 03:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbiKSIte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 03:49:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4736B9ED
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 00:49:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EBB56009E
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 08:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEB3C433D6;
        Sat, 19 Nov 2022 08:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668847766;
        bh=UVCfR3anyQssNbga8oJ+NA2adZ5isywkxGYwWPbPgQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VAhl2tmZTRkke5JgfIumxAtjUqC4brzImyR2zWapBhnFUD+AfsLFdwJezVqzgywH0
         jVZaijSnnFy2DviiqoXsGm5WIUb/2HyglBB9gwXz8lY7v1sUlsq94mRzmEoQ8ORDyN
         CB4H70m8XpOMk8oYxu1yFqECTlSVYU56bLX2LYz0=
Date:   Sat, 19 Nov 2022 09:49:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC] Add a new generic system call which has better
 performance, to get /proc data, than existing mechanisms
Message-ID: <Y3iYlLmxvIqn/ETF@kroah.com>
References: <20221118191202.2357801-1-anjali.k.kulkarni@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118191202.2357801-1-anjali.k.kulkarni@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 11:12:02AM -0800, Anjali Kulkarni wrote:
> Hi Greg,
> I was looking up your readfile() system call and this seems something
> useful to us - is this something expected to go into mainline any time
> soon?

Can you test it to see if it actually helps your workload?  All of the
ones I played with were just very minor improvements or lots in the
noise.

Also, look into using io_uring as that can probably do the same thing,
right?

thanks,

greg k-h
