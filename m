Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5766551A1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 15:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbiLWOwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 09:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiLWOwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 09:52:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA30B490;
        Fri, 23 Dec 2022 06:52:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F8ECB80315;
        Fri, 23 Dec 2022 14:52:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668E4C433D2;
        Fri, 23 Dec 2022 14:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671807123;
        bh=ZqINvsqVNRXwYbI0s1JzUb9QAQtGd0IZGVVPh94JtJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pH7GVQYxLmiMQTu2OuoMWE3vHeoCumrc9t0hJZAusc+LQ411W+KWa82pqo6mjOShc
         lGYVi4VX5kEhdRLvf7hrJBK2hScF4W+eQ9iJjKkMM6jcx0b6Wj3fTDCc1mLRpXyXuo
         8jbQmKJYbJG9JGm+/pqBtIheS6JiqfTUqvpi1Dv0=
Date:   Fri, 23 Dec 2022 15:52:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Puma Hsu <pumahsu@google.com>
Cc:     Oliver Neukum <oneukum@suse.com>, mka@chromium.org,
        dianders@chromium.org, albertccwang@google.com, raychi@google.com,
        howardyen@google.com, leejj@google.com, hch@infradead.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] add hooks for usb suspend and resume
Message-ID: <Y6XAkF5MyfW6XNzV@kroah.com>
References: <20221214081456.714859-1-pumahsu@google.com>
 <c5f24a60-2756-dc99-ee48-99a657a9626c@suse.com>
 <CAGCq0LZ6PLF+CCOAU6LSr3DaZ78MQ3kAmKwnXPEtjC76GsRPUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGCq0LZ6PLF+CCOAU6LSr3DaZ78MQ3kAmKwnXPEtjC76GsRPUg@mail.gmail.com>
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

On Fri, Dec 23, 2022 at 11:00:00AM +0800, Puma Hsu wrote:
> Thanks for the comments. I will have an introduction for our design first.

<snip>

Please put this in the next round of patches you all submit, and work
together to NOT submit independant patch series when they are obviously
interconnected.

thanks,

greg k-h
