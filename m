Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A69639353
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 03:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiKZCWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 21:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiKZCWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 21:22:43 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A0E15A33
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 18:22:40 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VVhEFQx_1669429354;
Received: from 30.25.195.131(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0VVhEFQx_1669429354)
          by smtp.aliyun-inc.com;
          Sat, 26 Nov 2022 10:22:36 +0800
Message-ID: <b8b08514-1d5c-ee21-b74f-5919d8ab5dfa@linux.alibaba.com>
Date:   Sat, 26 Nov 2022 10:22:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:107.0)
 Gecko/20100101 Thunderbird/107.0
To:     guro@fb.com
Cc:     akpm@linux-foundation.org, cl@linux.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, mhocko@kernel.org,
        shakeelb@google.com, tj@kernel.org, vbabka@suse.cz,
        zhengjun.xing@linux.intel.com
References: <YCcp7pwzlQy15v5H@carbon.dhcp.thefacebook.com>
Subject: Re: [LKP] Re: [mm] 10befea91b: hackbench.throughput -62.4% regression
Content-Language: en-US
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <YCcp7pwzlQy15v5H@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Roman

We also found the same regression of hackbench.throughput in our 
kernel-5.10, likes described in [1].

It seems that the mail thread in [2] doesn't show the last solution. So 
I wonder whether the upstream already has fix patch or solution can help 
us to solve this regression.

Thanks!

[1] 
https://lore.kernel.org/lkml/20210114025151.GA22932@xsang-OptiPlex-9020/.
[2] 
https://lore.kernel.org/lkml/YCcp7pwzlQy15v5H@carbon.dhcp.thefacebook.com/#R
