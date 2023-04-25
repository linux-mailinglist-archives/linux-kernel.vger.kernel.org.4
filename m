Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B041E6EDB37
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 07:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbjDYFdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 01:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjDYFdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 01:33:38 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F117A9C;
        Mon, 24 Apr 2023 22:33:36 -0700 (PDT)
Received: from [IPV6:2001:250:4000:5113:4158:5222:9d70:d70b] ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33P5WZnI010549-33P5WZnJ010549
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 25 Apr 2023 13:32:36 +0800
Message-ID: <9c09cb12-05d1-7c50-0d99-945fd384e3a3@hust.edu.cn>
Date:   Tue, 25 Apr 2023 13:32:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v2] usb: phy: phy-tahvo: fix memory leak in
 tahvo_usb_probe()
To:     Greg KH <gregkh@linuxfoundation.org>, ktestrobot@126.com,
        U201911841@hust.edu.cn
Cc:     lidaxian@hust.edu.cn, hust-os-kernel-patches@googlegroups.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        balbi@kernel.org, s.shtylyov@omp.ru
References: <644741EB.013E97.00008@m126.mail.126.com>
 <ZEdh-_Jv02qb6K4n@kroah.com>
From:   Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <ZEdh-_Jv02qb6K4n@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/4/25 13:15, Greg KH wrote:
> On Tue, Apr 25, 2023 at 10:58:51AM +0800, ktestrobot@126.com wrote:
>> Hi, Li Yang
>> This email is automatically replied by KTestRobot(Beta). Please do not reply to this email.
> But I will!
>
>> If you have any questions or suggestions about KTestRobot, please contact ZhongYong <U201911841@hust.edu.cn>
> First question, why are you responding from an email that is not allowed
> to be responded to and forced to have us manually add an address?
> That's not very nice or helpful for us who have to see these messages,
> please fix that.

Hi greg,

thanks for your feedback.

This robot is only used for our internal patch review. It should not 
send any email out to Linux kernel mailing list.

Why does this situation (this testing robot mistakenly sent emails to 
the kernel mailing list) occur?

Because Zhong Yong who is responsible for this testing robot does not 
classify patches which are sent to kernel mailing list and which are 
still in the internal review.

Sorry about this false alarm.

>
>> --- Changed Paths ---
>> drivers/usb/phy/phy-tahvo.c
>> --- Log Message ---
>> Smatch reports:
>> drivers/usb/phy/phy-tahvo.c: tahvo_usb_probe()
>> warn: missing unwind goto?
>>
>> After geting irq, if ret < 0, it will return without error handling to
>> free memory.
>> Just add error handling to fix this problem.
>>
>> --- Test Result ---
>> *** CheckPatch	PASS ***
>> *** CheckSmatch	PASS ***
>> *** ApplyToLinuxNext	PASS ***
> Why is only "does the patch apply" matter for this bot?  What is it
> supposed to be doing here?  Is it going to run on every single patch to
> this mailing list,

Because we have many newbie students, from first grade to forth grade in 
our university. They sometimes make mistakes in the patch generation, 
crafting patches that cannot be applied in the kernel tree.

This robot will check all the patches sent to this internal mailing list 
and report this issue. **But our design is only to use it for internal 
review. It should not send any emails to kernel mailing list.**

> and if so, how can we turn it off as "it applied!" is
> a very very low bar to be testing something for, and we already have a
> bot that does this.

This bot is only used for our internal review mailing list, and 
**again** it will not send any emails to kernel maintainers.

It is because the student missed an important logic: filter out the 
patches that are already sent for external review.

Really sorry about this situation.

Dongliang Mu

>
> thanks,
>
> greg k-h
