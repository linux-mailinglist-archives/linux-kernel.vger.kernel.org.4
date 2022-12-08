Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DC46475A3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 19:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiLHScG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 13:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiLHSb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 13:31:28 -0500
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832A1AE4E6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 10:31:13 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id 3LfhpT2ds1uKA3Lfhpfwkn; Thu, 08 Dec 2022 19:31:02 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 08 Dec 2022 19:31:02 +0100
X-ME-IP: 86.243.100.34
Message-ID: <fbd0748f-9f22-42bb-c388-ce1ea10ef60c@wanadoo.fr>
Date:   Thu, 8 Dec 2022 19:31:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] mfd: qcom_rpm: Fix an error handling path in
 qcom_rpm_probe()
To:     Lee Jones <lee@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-arm-msm@vger.kernel.org
References: <e39752476d02605b2be46cab7115f71255ce13a8.1668949256.git.christophe.jaillet@wanadoo.fr>
 <Y5HYzzwdWCrpWOTv@google.com>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <Y5HYzzwdWCrpWOTv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 08/12/2022 à 13:30, Lee Jones a écrit :
> On Sun, 20 Nov 2022, Christophe JAILLET wrote:
> 
>> If an error occurs after the clk_prepare_enable() call, a corresponding
>> clk_disable_unprepare() should be called.
>>
>> Simplify code and switch to devm_clk_get_enabled() to fix it.
>>
>> Fixes: 3526403353c2 ("mfd: qcom_rpm: Handle message RAM clock")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> This changes the order of the clean-ups if the .remove() function is called
>> but it looks fine to me.
>> ---
>>   drivers/mfd/qcom_rpm.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> Something funny going on here.
> 
> I received 3 identical versions of the same patch.
> 

Yes, was my fault.

Sorry for the inconvenience.

CJ


