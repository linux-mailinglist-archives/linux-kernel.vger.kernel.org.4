Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB75643124
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiLETKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbiLETJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:09:47 -0500
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DB712AE2
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 11:09:09 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id 2GptpuEMg8GHK2GptpaL6D; Mon, 05 Dec 2022 20:09:08 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 05 Dec 2022 20:09:08 +0100
X-ME-IP: 86.243.100.34
Message-ID: <798ce9ef-fb5e-012f-a016-8f39589e4e10@wanadoo.fr>
Date:   Mon, 5 Dec 2022 20:09:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] block: sed-opal: Don't include <linux/kernel.h>
Content-Language: fr, en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jonathan Derrick <jonathan.derrick@linux.dev>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-block@vger.kernel.org
References: <a2de79b3de30fe70c457953af935dadd49441f00.1670069909.git.christophe.jaillet@wanadoo.fr>
 <Y42ZV/AwSqUlDnas@infradead.org>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <Y42ZV/AwSqUlDnas@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 05/12/2022 à 08:10, Christoph Hellwig a écrit :
> On Sat, Dec 03, 2022 at 01:18:49PM +0100, Christophe JAILLET wrote:
>>   #include <uapi/linux/sed-opal.h>
>> -#include <linux/kernel.h>
>> +
>> +#include <linux/compiler_types.h>		/* for __user */
> 
> Not sure we really need the comment here, we don't comment on the
> other includes either.  Also why the added empty line?
> 

Ok for the comment, I'll remove it.
In header files, sometimes, when not obvious, we find such comments. 
Sometimes we don't.

For the empty line, it was mostly a matter of taste. My goal was to 
explicitly show that one was <uapi/linux, and the other one only <linux/

I'll remove it as well.

My main point, was only to remove kernel.h.

CJ
