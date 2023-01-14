Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E73F66ABA6
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 14:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjANNcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 08:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjANNcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 08:32:48 -0500
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4084395
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 05:32:45 -0800 (PST)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id GgeIpQmdRVDZbGgeJpIxxi; Sat, 14 Jan 2023 14:32:43 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 14 Jan 2023 14:32:43 +0100
X-ME-IP: 86.243.2.178
Message-ID: <7677faba-bd82-d49a-ad06-c42179b456cc@wanadoo.fr>
Date:   Sat, 14 Jan 2023 14:32:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 18/30] module: Use kstrtobool() instead of strtobool()
Content-Language: fr
To:     Luis Chamberlain <mcgrof@kernel.org>, atomlin@redhat.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-modules@vger.kernel.org
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
 <bb37ff26b0c748d0ca883d8f301190cd1177aad2.1667336095.git.christophe.jaillet@wanadoo.fr>
 <Y2K5v08yIDNk7sNW@bombadil.infradead.org>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <Y2K5v08yIDNk7sNW@bombadil.infradead.org>
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

Le 02/11/2022 à 19:41, Luis Chamberlain a écrit :
> On Tue, Nov 01, 2022 at 10:14:06PM +0100, Christophe JAILLET wrote:
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
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> 
>    Luis
> 

Hi,

This has been R-b 2 months ago by 2 persons, and I've just resent 
patches in this serie that have neither been merged in -next, nor A-b or 
R-b.

So for this one, it is just a polite reminder. 😄

Do you have visibility on when it should be merged?

CJ
