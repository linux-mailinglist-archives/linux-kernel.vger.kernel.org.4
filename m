Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA4A618AB5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 22:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiKCVh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 17:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiKCVhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 17:37:37 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61653220D8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 14:37:22 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id qhtno6Kk4KOP1qhtooADZI; Thu, 03 Nov 2022 22:37:20 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 03 Nov 2022 22:37:20 +0100
X-ME-IP: 86.243.100.34
Message-ID: <a0a59528-6af4-adb2-e4e2-cb4cbe15e986@wanadoo.fr>
Date:   Thu, 3 Nov 2022 22:37:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 12/30] input: Use kstrtobool() instead of strtobool()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-input@vger.kernel.org
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
 <4311e9cb62687449f4175e2b062abcd77aada059.1667336095.git.christophe.jaillet@wanadoo.fr>
 <Y2Qowvjn+7jT767t@google.com>
Content-Language: fr, en-GB
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <Y2Qowvjn+7jT767t@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 03/11/2022 à 21:46, Dmitry Torokhov a écrit :
> On Tue, Nov 01, 2022 at 10:14:00PM +0100, Christophe JAILLET wrote:
>> strtobool() is the same as kstrtobool().
>> However, the latter is more used within the kernel.
>>
>> In order to remove strtobool() and slightly simplify kstrtox.h, switch to
>> the other function name.
>>
>> While at it, include the corresponding header file (<linux/kstrtox.h>)
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Please feel free to merge with the rest of the series. Or let me know if
> you want me to pick just this one through my tree.
> 
> Thanks.
> 

Hi,

the patch can go through your tree.
There is no plan to merge the whole serie at once, and some other 
maintainers have asked for some patches to be re-sent as individual patches.

CJ
