Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4E45F3631
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 21:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiJCTRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 15:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJCTRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 15:17:01 -0400
Received: from smtp.smtpout.orange.fr (smtp07.smtpout.orange.fr [80.12.242.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A12D399DA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 12:16:59 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id fQvwoZeRokifIfQvwokOwJ; Mon, 03 Oct 2022 21:16:56 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 03 Oct 2022 21:16:56 +0200
X-ME-IP: 86.243.100.34
Message-ID: <b6c0cda1-b30d-5ca9-54e5-0643f7d5ffd9@wanadoo.fr>
Date:   Mon, 3 Oct 2022 21:16:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] HID: alps: Simplify the .remove function
Content-Language: en-US
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-input@vger.kernel.org
References: <33cf94ec234b88ffc79eb4496c640093aa8c5e70.1664721476.git.christophe.jaillet@wanadoo.fr>
 <YzsCdyPxrNcHE3XF@gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <YzsCdyPxrNcHE3XF@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 03/10/2022 à 17:40, Marcus Folkesson a écrit :
> Hi Christophe!
> 
> On Sun, Oct 02, 2022 at 04:38:26PM +0200, Christophe JAILLET wrote:
>> If the .remove function of a 'hid_driver' is NULL, the default behavior is
>> to call hid_hw_stop().
>>
>> So alps_remove() can be removed here, it is just hand-writing what
>> already exists.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
> 
> 
> There is already a patch out there :-)

Great,

But I always find it funny when something that is there since many years 
(819d64e51d62 - 2016-06-23) is fixed twice in a row from unrelated work!

CJ

> 
> https://lore.kernel.org/all/20220915123438.520775-1-marcus.folkesson@gmail.com/
> 
> Best regards,
> Marcus Folkesson

