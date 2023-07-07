Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B808774ADA1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 11:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjGGJLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 05:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbjGGJK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 05:10:59 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39EA2119;
        Fri,  7 Jul 2023 02:10:53 -0700 (PDT)
Received: from [IPV6:2001:250:4000:5122:bd1d:72:5112:b20e] ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 3679AL2c005927-3679AL2d005927
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 7 Jul 2023 17:10:22 +0800
Message-ID: <d402ab4f-ccd4-91c4-b084-c1c86f1c4760@hust.edu.cn>
Date:   Fri, 7 Jul 2023 17:10:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3] wifi: ath9k: fix printk specifier
To:     Jonas Gorski <jonas.gorski@gmail.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230706111700.14305-1-dzm91@hust.edu.cn>
 <87cz15s2gv.fsf@toke.dk>
 <CAOiHx=kccbUFGsWMA_31UPW6p=k1qa+HyL5OGyzv50W2Mc111w@mail.gmail.com>
Content-Language: en-US
From:   Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <CAOiHx=kccbUFGsWMA_31UPW6p=k1qa+HyL5OGyzv50W2Mc111w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/7/23 00:04, Jonas Gorski wrote:
> On Thu, 6 Jul 2023 at 13:39, Toke Høiland-Jørgensen <toke@toke.dk> wrote:
>> Dongliang Mu <dzm91@hust.edu.cn> writes:
>>
>>> Smatch reports:
>>>
>>> ath_pci_probe() warn: argument 4 to %lx specifier is cast from pointer
>>> ath_ahb_probe() warn: argument 4 to %lx specifier is cast from pointer
>>>
>>> Fix it by modifying %lx to %p in printk.
>>>
>>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>> Third time is the charm! :)
>>
>> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> But do we *want* to replace %lx with %p? Because this now causes a
> change in behavior, as the kernel will omit the pointer's address,
> while before it printed the actual memory address. Using %px would
> have kept the original behavior.

This is why I made mistake in the patch submission. I think %px is more 
suitable and generate a patch, but then checkpatch.pl thinks I should 
use %p instead.

I change the code change, but forget the commit message.

>
> So if the change is desired, it should be noted in the commit message.
>
> best Regards,
> Jonas
