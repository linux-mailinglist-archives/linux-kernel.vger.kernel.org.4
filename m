Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828957492BE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 02:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjGFArC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 20:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbjGFArB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 20:47:01 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FB119B5;
        Wed,  5 Jul 2023 17:46:57 -0700 (PDT)
Received: from [IPV6:2001:250:4000:5122:7933:e60b:6f49:5f3c] ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 3660k7xe010427-3660k7xf010427
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 6 Jul 2023 08:46:07 +0800
Message-ID: <2f7d6544-c7f8-93e7-3963-79f42adafd01@hust.edu.cn>
Date:   Thu, 6 Jul 2023 08:46:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] wifi: ath9k: fix printk specifier
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230630130303.28308-1-dzm91@hust.edu.cn>
 <20230705141501.3f1a5d2f@kernel.org>
From:   Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <20230705141501.3f1a5d2f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/6/23 05:15, Jakub Kicinski wrote:
> On Fri, 30 Jun 2023 21:03:02 +0800 Dongliang Mu wrote:
>> Smatch reports:
>>
>> ath_pci_probe() warn: argument 4 to %lx specifier is cast from pointer
>> ath_ahb_probe() warn: argument 4 to %lx specifier is cast from pointer
>>
>> Fix it by modifying %lx to %px in printk.
> The patch does %p not %px.

Yes, checkpatch.pl suggests %p other than %px. So I revise it to %p, but 
forget to modify the commit message.

I will submit a v2 patch.

