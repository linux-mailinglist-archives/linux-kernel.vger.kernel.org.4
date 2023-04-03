Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29446D40FA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjDCJo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjDCJoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:44:12 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CCB11E8D;
        Mon,  3 Apr 2023 02:43:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VfGcEDG_1680514966;
Received: from 30.221.149.0(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VfGcEDG_1680514966)
          by smtp.aliyun-inc.com;
          Mon, 03 Apr 2023 17:42:48 +0800
Message-ID: <112cd2a0-dad1-7039-9904-858c3c00e0ac@linux.alibaba.com>
Date:   Mon, 3 Apr 2023 17:42:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] perf/arm-cmn: fix regitster offset of
 CMN_MXP__CONNECT_INFO_P2-5
To:     Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Ruidong Tian <tianruidong@linux.alibaba.com>
References: <1680169620-26012-1-git-send-email-renyu.zj@linux.alibaba.com>
 <3b95e362-300a-12af-0d55-76672c60be9f@arm.com>
 <ZCqD/HlIRgewdnwA@FVFF77S0Q05N>
 <d232392a-dadb-ec53-9613-d9b561fe1e87@arm.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <d232392a-dadb-ec53-9613-d9b561fe1e87@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/4/3 下午5:40, Robin Murphy 写道:
> On 2023-04-03 08:45, Mark Rutland wrote:
>> On Thu, Mar 30, 2023 at 11:34:22AM +0100, Robin Murphy wrote:
>>> On 2023-03-30 10:47, Jing Zhang wrote:
>>>> In the CMN700 specification, it is described that the address offset
>>>> of the mxp_device_connect_info_p0-5 register is 16'h8 + #{8*index}.
>>>> Therefore, the address offset of the CMN_MXP__CONNECT_INFO_P2-5 macro
>>>> defined in the code is wrong, which causes the cmn700 topology map
>>>> incorrect printed in debugfs.
>>>>
>>>> So correct the address offset value to make the cmn700 topology map
>>>> correct in debugfs.
>>>>
>>>> Fixes: 60d1504070c2 ("perf/arm-cmn: Support new IP features")
>>>
>>> Ugh, these offsets are correct for CI-700, so strictly that commit is fine.
>>> What I failed to notice is that CMN-700 shuffled the mesh_port_connect_info
>>> registers out of the way, so it's commit 23760a014417 which should have
>>> added more handling for this difference.
>>
>> I'm assuming that means that this patch breaks !CMN-700 ?
>>
>> i.e. a more substantial fix is necessary, and it's not just a matter of
>> changing the Fixes tag.
> 
> Yes, indeed. I have half an idea, and the plan for this week was to work on other CMN stuff anyway, so I'll see what I can cook up.
> 
> Cheers,
> Robin.

Yes, I did ignore the CI700 situation, I don't know much about !CMN700.
Robin, can you please help to fix this problem? Thank you so much.

Thanks,
Jing
