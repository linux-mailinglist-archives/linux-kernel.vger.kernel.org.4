Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F49E6FDD50
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbjEJL7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236713AbjEJL7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:59:49 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D0135AE;
        Wed, 10 May 2023 04:59:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0ViFwRe._1683719981;
Received: from 30.221.130.59(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0ViFwRe._1683719981)
          by smtp.aliyun-inc.com;
          Wed, 10 May 2023 19:59:43 +0800
Message-ID: <663cccbd-e757-1156-4ee9-9f9c45a61005@linux.alibaba.com>
Date:   Wed, 10 May 2023 19:59:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [RFC PATCH net-next v5 0/9] net/smc: Introduce SMC-D-based OS
 internal communication acceleration
To:     Jan Karcher <jaka@linux.ibm.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandra Winter <wintera@linux.ibm.com>
References: <1682252271-2544-1-git-send-email-guwen@linux.alibaba.com>
 <1297b2c6-00c2-adc9-3abe-af12471e2838@linux.alibaba.com>
 <347c15c2-c18d-4823-3177-abaeb394c772@linux.ibm.com>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <347c15c2-c18d-4823-3177-abaeb394c772@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/10 17:56, Jan Karcher wrote:

> On 10/05/2023 04:02, Wen Gu wrote:
>> Hi Wenjia & Jan:
>>
>> Does this version work fine on your platform?
>>
>> And any comments on this version? :)
> 
> Hi Wen Gu,
> 
> as background for the others: IBM & Alibaba are having calls regarding SMC since Alibaba shows a lot of interest and 
> there is a lot to discuss (as you may have noticed).
> 
> As we have agreed in our calls, the information shared about SMC-D in specific doesn't make it easy to understand the 
> underlying concepts (e.g. role of GID, EIDs, DMB tokens, etc.).
> That's why one of the next calls is dedicated to explain some of the concepts in depth to you and see where we can 
> improve our flow of information to the community in the future.
> After that we can go over this RFC with a shared understanding of the concepts.
> 
> Thank you
> - Jan
> 

OK, Jan, Let's follow this plan and thank you for organizing this.

Thanks,
Wen Gu

