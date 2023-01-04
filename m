Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3E865D791
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 16:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbjADPw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 10:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239738AbjADPvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 10:51:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038A939FAF;
        Wed,  4 Jan 2023 07:51:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3639B8169C;
        Wed,  4 Jan 2023 15:51:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA262C433EF;
        Wed,  4 Jan 2023 15:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672847510;
        bh=jfvmoah+zMIM9RDzfW7Jv6YrDFgEvogPpuYypfWkijs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Isu4gmrY7vB6ihb1dq7/zCJRojBXrkL4emqmG5GbBONwHyswHsljX+a0z8aARA0PJ
         Dx6D8qk5mMPcmmTlqJlrs2UuD0+HTV0vl6R96cHQlNSCLDUZAVkB7PDKAqUjxjOspt
         iREpnT8xqPd5fGzQaG+DM8mAZC/1Qh2kaqBCs5Ds=
Date:   Wed, 4 Jan 2023 16:51:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     lizhe <sensor1010@163.com>
Cc:     jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v4] serial: linflexuart: remove redundant uart type
 assignment
Message-ID: <Y7Wgk0W1vpiZMi52@kroah.com>
References: <20230104152444.3407-1-sensor1010@163.com>
 <Y7WdpQkqJA03z8w0@kroah.com>
 <41a69271.666a.1857d7827c3.Coremail.sensor1010@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41a69271.666a.1857d7827c3.Coremail.sensor1010@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Wed, Jan 04, 2023 at 11:48:24PM +0800, lizhe wrote:
> 
> 
> 
> HI : 
>     1 .  
> I'm Chinese, lizhe is my name, and my email is sensor1010@163.com ,
> How to express real name?

Your full name that you sign documents with?  If so, great, but odds are
there is a capital letter in there, right?  Or just use your Chinese
name, that's fine too.

thanks,

greg k-h
