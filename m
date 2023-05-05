Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662576F7AC0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 03:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjEEBrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 21:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEEBrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 21:47:03 -0400
Received: from out28-76.mail.aliyun.com (out28-76.mail.aliyun.com [115.124.28.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DD9A246
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 18:47:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1829176|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0221483-0.00151375-0.976338;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=victor@allwinnertech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.SYL1QkS_1683251213;
Received: from 192.168.220.144(mailfrom:victor@allwinnertech.com fp:SMTPD_---.SYL1QkS_1683251213)
          by smtp.aliyun-inc.com;
          Fri, 05 May 2023 09:46:54 +0800
Message-ID: <7b3e8898-4768-1add-5223-298db3b7f91e@allwinnertech.com>
Date:   Fri, 5 May 2023 09:46:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] tick/broadcast: Do not set oneshot_mask except
 was_periodic was true
Content-Language: en-US
From:   Victor Hassan <victor@allwinnertech.com>
To:     Thomas Gleixner <tglx@linutronix.de>, fweisbec@gmail.com,
        mingo@kernel.org, jindong.yue@nxp.com
Cc:     linux-kernel@vger.kernel.org
References: <20230412003425.11323-1-victor@allwinnertech.com>
 <87sfd0yi4g.ffs@tglx>
 <e4d1f832-d95e-02c9-ae7d-2aca48a45fb1@allwinnertech.com>
 <875y9l16es.ffs@tglx> <87354p16af.ffs@tglx>
 <9b6ecb02-17ad-039f-cbe0-8cad5c79e684@allwinnertech.com>
In-Reply-To: <9b6ecb02-17ad-039f-cbe0-8cad5c79e684@allwinnertech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/26/2023 10:50 AM, Victor Hassan wrote:
> 
> 
> On 4/25/2023 2:31 AM, Thomas Gleixner wrote:
>> On Mon, Apr 24 2023 at 20:28, Thomas Gleixner wrote:
>>
>> Btw, does the patch fix your issue?
> This is a probabilistic problem and I am currently testing it.

I have tested for 7*24 hours and there have been no issues as before.
> 
>>
>> Thanks,
>>
>>           tglx
