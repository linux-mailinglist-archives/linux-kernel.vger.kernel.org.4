Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA8566E2CD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjAQPwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbjAQPwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:52:12 -0500
Received: from smtp.tiscali.it (santino-notr.mail.tiscali.it [213.205.33.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33D801D935
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 07:51:35 -0800 (PST)
Received: from [192.168.178.50] ([79.21.79.228])
        by santino.mail.tiscali.it with 
        id 9rrU2902i4vZGgn01rrVmv; Tue, 17 Jan 2023 15:51:32 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: fantonifabio@tiscali.it
Message-ID: <521902b6-d40d-f445-dbee-0280e526cae0@tiscali.it>
Date:   Tue, 17 Jan 2023 16:51:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: fantonifabio@tiscali.it
Subject: Re: [PATCH v2] documentation: fix Generic Block Device Capability
To:     Christoph Hellwig <hch@infradead.org>
Cc:     corbet@lwn.net, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergei Shtepa <sergei.shtepa@veeam.com>
References: <20230110132104.12499-1-fantonifabio@tiscali.it>
 <Y8WPFMFxpfdZKs5a@infradead.org>
 <62a18c7d-93d9-657e-48fd-1af06d6d1d9e@tiscali.it>
 <Y8Y6jLdXnnBTps7l@infradead.org>
From:   Fabio Fantoni <fantonifabio@tiscali.it>
In-Reply-To: <Y8Y6jLdXnnBTps7l@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: Avast (VPS 230117-2, 17/1/2023), Outbound message
X-Antivirus-Status: Clean
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1673970693; bh=htFWbz6gHdfiZHubJoYDHAUUk8NJyt1xhcczoshiPb8=;
        h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To;
        b=24SUTDbJqs2YXRS69GAiYaenfKYRr+NmRN1iTwQdOjaQ3cdoDronuyncqeisnUvJW
         GS6Il7F0wRxXUfqKgTVkEUd3mAgpKZ2JCoG0462uwii3u91E7NJNv5KMu4y3qmzsNl
         Ub9l+4bX3Ed6VBNlbGnbfpzAQN3xIwIQP+OHEdDs=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/01/2023 07:05, Christoph Hellwig ha scritto:
> On Mon, Jan 16, 2023 at 07:14:41PM +0100, Fabio Fantoni wrote:
>> Il 16/01/2023 18:53, Christoph Hellwig ha scritto:
>>> On Tue, Jan 10, 2023 at 02:21:04PM +0100, Fabio Fantoni wrote:
>>>> - * ``GENHD_FL_REMOVABLE``: indicates that the block device gives access to
>>>> + * ``GENHD_FL_REMOVABLE`` (0x01): indicates that the block device gives access to
>>> The numberic values really do not belong into the documentation.  They
>>> are just implementation details.
>>>
>> Thanks for reply, if values are not into the documentation see from
>> /sys/block/<disk>/capability output what flags are enabled will require look
>> to source code of include/linux/blkdev.h and
>> Documentation/block/capability.rst will be less useful, or I'm wrong?
> Urgg.  I think this file is generally just a bad idea.  The flags are
> kernel internal and not isolated from userspace.  It seems nothing broke
> with the various renumbering lately, but we need to isolate it from
> the implementation details.  And if it really should be a user API
> we need a text version of it.

Up to 5.13 the page was "ok" 
(https://www.kernel.org/doc/html/v5.13/block/capability.html) from 5.14 
doc comments of other functions was appaired, from 5.17 the flags had 
"major" changes and values was removed from doc comment 
(https://www.kernel.org/doc/html/v5.17/block/capability.html)

With this patch return to have only block capability flags in this file 
and including the values: https://snipboard.io/QrN6hg.jpg

But as you tell that this file is a bad idea, 
Documentation/block/capability.rst should be removed?

About if should be a user API, I don't have enough experience to be able 
to say if and in which cases it could be useful on the user side. From 
what I could see with the documentation page correct is that you can at 
least immediately see (after a very fast search) for example if the 
block device is removable and if it is partitionable. And even if the 
values was changed pointing to the doc page of the used kernel version 
and having the values in doc is still possible see what flags are 
enabled from doc page.

