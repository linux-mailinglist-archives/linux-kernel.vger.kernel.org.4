Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D59F6EEC83
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 04:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239034AbjDZCuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 22:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjDZCul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 22:50:41 -0400
Received: from out28-77.mail.aliyun.com (out28-77.mail.aliyun.com [115.124.28.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F19DE43
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 19:50:39 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2371994|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.0196946-0.00106663-0.979239;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=victor@allwinnertech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.SQnfq8v_1682477432;
Received: from 192.168.220.144(mailfrom:victor@allwinnertech.com fp:SMTPD_---.SQnfq8v_1682477432)
          by smtp.aliyun-inc.com;
          Wed, 26 Apr 2023 10:50:33 +0800
Message-ID: <9b6ecb02-17ad-039f-cbe0-8cad5c79e684@allwinnertech.com>
Date:   Wed, 26 Apr 2023 10:50:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] tick/broadcast: Do not set oneshot_mask except
 was_periodic was true
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, fweisbec@gmail.com,
        mingo@kernel.org, jindong.yue@nxp.com
Cc:     linux-kernel@vger.kernel.org
References: <20230412003425.11323-1-victor@allwinnertech.com>
 <87sfd0yi4g.ffs@tglx>
 <e4d1f832-d95e-02c9-ae7d-2aca48a45fb1@allwinnertech.com>
 <875y9l16es.ffs@tglx> <87354p16af.ffs@tglx>
From:   Victor Hassan <victor@allwinnertech.com>
In-Reply-To: <87354p16af.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/25/2023 2:31 AM, Thomas Gleixner wrote:
> On Mon, Apr 24 2023 at 20:28, Thomas Gleixner wrote:
> 
> Btw, does the patch fix your issue?
This is a probabilistic problem and I am currently testing it.

> 
> Thanks,
> 
>           tglx
