Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6453161E8D7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiKGDGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiKGDGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:06:50 -0500
Received: from out28-4.mail.aliyun.com (out28-4.mail.aliyun.com [115.124.28.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC0E60E6;
        Sun,  6 Nov 2022 19:06:48 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.10578|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0166433-0.00299348-0.980363;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047194;MF=kant@allwinnertech.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.Q12-nI._1667790403;
Received: from 192.168.220.136(mailfrom:kant@allwinnertech.com fp:SMTPD_---.Q12-nI._1667790403)
          by smtp.aliyun-inc.com;
          Mon, 07 Nov 2022 11:06:46 +0800
Message-ID: <ba875656-01bb-3e87-75ce-a83b556b7911@allwinnertech.com>
Date:   Mon, 7 Nov 2022 11:06:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3] PM/devfreq: governor: Add a private governor_data for
 governor
Content-Language: en-US
From:   Kant Fan <kant@allwinnertech.com>
To:     Chanwoo Choi <cwchoi00@gmail.com>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com, khilman@ti.com,
        rjw@rjwysocki.net, mturquette@ti.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221014094359.100995-1-kant@allwinnertech.com>
 <bdbed01c-0e86-14fc-4efa-32a010431d67@gmail.com>
 <f0d68beb-f115-88f8-9901-5e7dfac5da77@allwinnertech.com>
In-Reply-To: <f0d68beb-f115-88f8-9901-5e7dfac5da77@allwinnertech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/2022 3:57 PM, Kant Fan wrote:
> On 10/22/2022 7:41 AM, Chanwoo Choi wrote:
>> Hi,
>>
>> Looks good to me. But, you need to send it to the stable mailing list
>> too as I commented on previous mail.
>>
>> Please add stable@vger.kernel.org to Cc.
>>
> 
> Hi Chanwoo,
> Thanks for the notice. Please review this patch-v4 [1].
> 
> [1]
> https://lore.kernel.org/all/20221025072109.64025-1-kant@allwinnertech.com/
> 

Dear Chanwoo,
Is there any updated progress about this patch? Thank you

-- 
Best Regards,
Kant Fan
