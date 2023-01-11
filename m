Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCCF6663BD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjAKT1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjAKT1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:27:43 -0500
Received: from mail.holmansrus.com (unknown [143.59.183.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B453D13D;
        Wed, 11 Jan 2023 11:27:42 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.holmansrus.com (Postfix) with ESMTP id 44865E136B;
        Wed, 11 Jan 2023 13:27:41 -0600 (CST)
Received: from mail.holmansrus.com ([127.0.0.1])
        by localhost (mail.holmansrus.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id dXa14Gif68xa; Wed, 11 Jan 2023 13:27:38 -0600 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.holmansrus.com (Postfix) with ESMTP id C00F5E1377;
        Wed, 11 Jan 2023 13:27:38 -0600 (CST)
X-Virus-Scanned: amavisd-new at holmansrus.com
Received: from mail.holmansrus.com ([127.0.0.1])
        by localhost (mail.holmansrus.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lVmmr1jjBcZX; Wed, 11 Jan 2023 13:27:38 -0600 (CST)
Received: from mail.holmansrus.com (mail.holmansrus.com [10.90.0.246])
        by mail.holmansrus.com (Postfix) with ESMTP id 98729E136B;
        Wed, 11 Jan 2023 13:27:38 -0600 (CST)
Date:   Wed, 11 Jan 2023 13:27:38 -0600 (CST)
From:   Walt Holman <walt@holmansrus.com>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Message-ID: <813567712.6.1673465258180.JavaMail.zimbra@holmansrus.com>
In-Reply-To: <211974789ce308698ce79a38848036dc498f6d5c.camel@hadess.net>
References: <1912021550.81.1672759744435.JavaMail.zimbra@holmansrus.com> <211974789ce308698ce79a38848036dc498f6d5c.camel@hadess.net>
Subject: Re: [PATCH] HID: hid-logitech-hidpp: Add support for Logitech G923
 wheel Xbox Edition
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.90.0.246]
X-Mailer: Zimbra 8.8.15_GA_4484 (ZimbraWebClient - GC109 (Linux)/8.8.15_GA_4481)
Thread-Topic: hid-logitech-hidpp: Add support for Logitech G923 wheel Xbox Edition
Thread-Index: l80FnNVrQgRmpSwXZkds7LZYjTB8vg==
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 11, 2023, at 4:28 AM, Bastien Nocera hadess@hadess.net wrote:

> Hey Walt,
> 
> On Tue, 2023-01-03 at 09:29 -0600, Walt Holman wrote:
>> Hello,
>> 
>> This patch adds support for the Logitech G923 Xbox edition steering
>> wheel. This uses the hid-logitech-hidpp kernel module and from my
>> testing, force feedback and all buttons work. This requires the
>> usb_modeswitch application to setup the device in PC mode with a
>> magic string that is the same as the Logitech 920 wheel. Originally I
>> had massaged a patch I found for this wheel, however, much of it was
>> unnecessary and I culled it back to just adding the ID's. Let me know
>> if you need anything else or have any questions. Thanks,
>> 
>> Signed-off-by: Walt Holman walt@holmansrus.com
>> 
> 
> You'll want to follow:
> https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html
> to submit this patch. It definitely shouldn't be an attachment :)
> 
> Cheers

I apologize. I'll re-submit it in a new mail. Thanks,

-Walt
