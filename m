Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8976EDB6A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 07:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbjDYF5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 01:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjDYF5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 01:57:49 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD7C768A;
        Mon, 24 Apr 2023 22:57:48 -0700 (PDT)
Received: from [IPV6:2001:250:4000:5113:4158:5222:9d70:d70b] ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33P5vFDl023591-33P5vFDm023591
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 25 Apr 2023 13:57:15 +0800
Message-ID: <32501aa1-ce22-e0b3-f63c-0ae7f2e3ab34@hust.edu.cn>
Date:   Tue, 25 Apr 2023 13:57:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v2] usb: phy: phy-tahvo: fix memory leak in
 tahvo_usb_probe()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     ktestrobot@126.com, U201911841@hust.edu.cn, lidaxian@hust.edu.cn,
        hust-os-kernel-patches@googlegroups.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, balbi@kernel.org, s.shtylyov@omp.ru
References: <644741EB.013E97.00008@m126.mail.126.com>
 <ZEdh-_Jv02qb6K4n@kroah.com>
 <9c09cb12-05d1-7c50-0d99-945fd384e3a3@hust.edu.cn>
 <ZEdqIz8Vfd09zBFL@kroah.com>
From:   Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <ZEdqIz8Vfd09zBFL@kroah.com>
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


On 2023/4/25 13:50, Greg KH wrote:
> On Tue, Apr 25, 2023 at 01:32:35PM +0800, Dongliang Mu wrote:
>> On 2023/4/25 13:15, Greg KH wrote:
>>> On Tue, Apr 25, 2023 at 10:58:51AM +0800, ktestrobot@126.com wrote:
>>>> Hi, Li Yang
>>>> This email is automatically replied by KTestRobot(Beta). Please do not reply to this email.
>>> But I will!
>>>
>>>> If you have any questions or suggestions about KTestRobot, please contact ZhongYong <U201911841@hust.edu.cn>
>>> First question, why are you responding from an email that is not allowed
>>> to be responded to and forced to have us manually add an address?
>>> That's not very nice or helpful for us who have to see these messages,
>>> please fix that.
>> Hi greg,
>>
>> thanks for your feedback.
>>
>> This robot is only used for our internal patch review. It should not send
>> any email out to Linux kernel mailing list.
> But it did :(
>
>> Sorry about this false alarm.
> It happened more than once here, so please be more careful with the bot.

Sure. All the emails sent to kernel mailing list are from the same time 
period. It results from the same development mistake. We will be more 
careful in the future.

Sorry again for our mistake.

BTW, should I reply to the affected mailing list and explain the 
situation? Or just leave it alone.

Dongliang Mu

> thanks,
>
> greg k-h
