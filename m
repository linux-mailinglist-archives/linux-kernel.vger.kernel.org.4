Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B3874A874
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 03:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjGGB2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 21:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGGB2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 21:28:40 -0400
X-Greylist: delayed 2568 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Jul 2023 18:28:38 PDT
Received: from mx.treblig.org (unknown [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93A41BF0;
        Thu,  6 Jul 2023 18:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=SPXW4HA5NH/c+C0DrIDwZN76DiNAzrkqtCJX7xB7o0c=; b=FE2mUBY9tZNpyNzEU6mzQT4d4I
        orZGI6uL2KCK5DaDLSH5nPIdn+WGtjgRroxC2rjaj2eIhN3IGkkAS6Fo59qVXTVIqR1PIsjy/b2I9
        9VS+zNG4HeK6Mlhea51J3JMaDqJ1oiHNSpDqcJjxnlv1GkgHdrfvwMWZYy0XQHsNXsP5s+7sjgBsh
        H4zjQ7IZqJpJbnIqv8e6ktnh/NUFGUMNOSTN2VYYdhxpa5UHAsYJFDZ9zpTLY7uH/MvC+5ml+91D6
        ral+dlTWfUhqT8XRz7f1xVP7Te8uqGjVVwaXbpsZZl6uJwSF1NK+SZfYMicXkZzv7gwX8IIl9nC86
        y4K9mh4Q==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1qHZbO-0004eg-63; Fri, 07 Jul 2023 00:45:38 +0000
Date:   Fri, 7 Jul 2023 00:45:38 +0000
From:   "Dr. David Alan Gilbert" <linux@treblig.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        primalmotion <primalmotion@pm.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux USB <linux-usb@vger.kernel.org>
Subject: Re: Fwd: unable to boot when monitor is attached
Message-ID: <ZKdgMs2ChLnJ3U8n@gallifrey>
References: <5eb57bfe-94a4-136b-497e-deeb31846db1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <5eb57bfe-94a4-136b-497e-deeb31846db1@gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-23-amd64 (x86_64)
X-Uptime: 00:41:58 up 10:13,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Bagas Sanjaya (bagasdotme@gmail.com) wrote:
> Hi,
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
> > 
> > In the latest 6.3 and 6.4, it is impossible for me to boot my laptop if my DELL U2720Q monitor is plugged in (USB-C). I have to unplug it, then boot. As soon as the first second of boot went through, I can plug in my monitor and there is no issue afterward. There is no issue waking up after suspend. Only when it boots.
> > 
> > See the attached pictures of the trace. The trace itself seems random (at least to me :)). I tried several things, like removing any attached USB devices from the monitor built-in USB-hub, but that does not change anything. (there is a keyboard and trackpad attached).
> 
> See Bugzilla for the full thread.
> 
> Unfortunately, the reporter can only provide photos of kernel trace
> (as he doesn't have any other means to extract kernel logs, maybe
> connecting over serial helps; see Bugzilla for these attachments).

I note the photos have 'crud' at the bottom; as if something interesting
is in the video ram; perhaps something is freaked out by this nice 4k
monitor and some useful data structures are ending up in video ram.

(Also note it's a librem with pureboot)

Dave

> 
> Anyway, I'm adding it to regzbot so that it doesn't fall through
> cracks unnoticed:
> 
> #regzbot introduced: v6.1..v6.3 https://bugzilla.kernel.org/show_bug.cgi?id=217637
> #regzbot title: unable to boot with Dell U2720Q monitor attached
> 
> Thanks.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217637
> 
> -- 
> An old man doll... just what I always wanted! - Clara
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
