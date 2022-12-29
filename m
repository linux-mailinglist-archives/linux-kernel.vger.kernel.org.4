Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE61E658CED
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 13:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiL2M5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 07:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiL2M5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 07:57:32 -0500
Received: from mail.holmansrus.com (unknown [143.59.183.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E5F13D5D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 04:57:30 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.holmansrus.com (Postfix) with ESMTP id B7B62E1D70;
        Thu, 29 Dec 2022 06:57:29 -0600 (CST)
Received: from mail.holmansrus.com ([127.0.0.1])
        by localhost (mail.holmansrus.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Za0-y-PG-rg2; Thu, 29 Dec 2022 06:57:29 -0600 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.holmansrus.com (Postfix) with ESMTP id 0003CE1CFB;
        Thu, 29 Dec 2022 06:57:28 -0600 (CST)
X-Virus-Scanned: amavisd-new at holmansrus.com
Received: from mail.holmansrus.com ([127.0.0.1])
        by localhost (mail.holmansrus.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rEt54f3WH5uz; Thu, 29 Dec 2022 06:57:28 -0600 (CST)
Received: from mail.holmansrus.com (mail.holmansrus.com [10.90.0.246])
        by mail.holmansrus.com (Postfix) with ESMTP id AB6E3E1D01;
        Thu, 29 Dec 2022 06:57:28 -0600 (CST)
Date:   Thu, 29 Dec 2022 06:57:28 -0600 (CST)
From:   Walt Holman <walt@holmansrus.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <255732713.91.1672318648501.JavaMail.zimbra@holmansrus.com>
In-Reply-To: <Y60+ClXkkBAfKhUf@kroah.com>
References: <933489772.83.1672266579857.JavaMail.zimbra@holmansrus.com> <Y60+ClXkkBAfKhUf@kroah.com>
Subject: Re: [PATCH 6.1 0000/1146] 6.1.2-rc1 review
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.90.0.246]
X-Mailer: Zimbra 8.8.15_GA_4484 (ZimbraWebClient - GC108 (Linux)/8.8.15_GA_4481)
Thread-Topic: 6.1.2-rc1 review
Thread-Index: ersqxz6lVnikKAcGC4xoUSRYuHBNOQ==
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Dec 29, 2022, at 1:13 AM, Greg KH gregkh@linuxfoundation.org wrote:

> On Wed, Dec 28, 2022 at 04:29:39PM -0600, Walt Holman wrote:
>> > This is the start of the stable review cycle for the 6.1.2 release.
>> > There are 1146 patches in this series, all will be posted as a response
>> > to this one.  If anyone has any issues with these being applied, please
>> > let me know.
>> > 
>> > Responses should be made by Fri, 30 Dec 2022 14:41:29 +0000.
>> > Anything received after that time might be too late.
>> > 
>> > The whole patch series can be found in one patch at:
>> > [ https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.2-rc1.gz
>> > | https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.2-rc1.gz
>> > ] > or in the git tree and branch at:
>> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>> > 	linux-6.1.y
>> > and the diffstat can be found below.
>> > 
>> > thanks,
>> > 
>> > greg k-h
>> > 
>> > -------------
>> 
>> Hello,
>> 
>> I'm getting a NULL Pointer Dereference when shutting down or rebooting. It
>> happens just as it tries to shut down the swap device ( /dev/dm-3 ). This
>> happens late in the shutdown process and nothing gets saved in the logs.
>> However, I've attached a photo of my screen showing the Oops and stack trace.
>> Let me know if there's anything you'd like me to try.
> 
> Does this happen with 6.1.1 also?
> 
> Can you use 'git bisect' to track down the offending change?
> 
> thanks,
> 
> greg k-h

This does NOT happen with 6.1.1 I'll get on bisecting here in a bit. I'm wondering about the changes that were made to blk-mq.c  That's where the new quiesce code and the null pointer dereference occur. I'll start by rolling back that commit and see what happens before bisecting. 

-Walt 
