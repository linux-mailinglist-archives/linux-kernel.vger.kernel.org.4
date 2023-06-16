Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68327324AD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 03:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbjFPBee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 21:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFPBed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 21:34:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC832947;
        Thu, 15 Jun 2023 18:34:31 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qj1pN1CRWzMn87;
        Fri, 16 Jun 2023 09:31:24 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 09:34:29 +0800
Subject: Re: [PATCH net-next] xsk: Remove unused inline function
 xsk_buff_discard()
To:     Simon Horman <simon.horman@corigine.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC:     <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
        <jonathan.lemon@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
        <john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <maxtram95@gmail.com>
References: <20230615124612.37772-1-yuehaibing@huawei.com>
 <ZIsW47S1Pdzqxkxt@boxer> <ZIsXdcawAWc/9Izo@boxer>
 <ZIsiyKfr/WdzKlji@corigine.com>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <ca6b43b1-5b54-51c3-01f7-0cee6189e4be@huawei.com>
Date:   Fri, 16 Jun 2023 09:34:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <ZIsiyKfr/WdzKlji@corigine.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/15 22:40, Simon Horman wrote:
> On Thu, Jun 15, 2023 at 03:51:49PM +0200, Maciej Fijalkowski wrote:
>> On Thu, Jun 15, 2023 at 03:49:23PM +0200, Maciej Fijalkowski wrote:
>>> On Thu, Jun 15, 2023 at 08:46:12PM +0800, YueHaibing wrote:
>>>> commit f2f167583601 ("xsk: Remove unused xsk_buff_discard")
>>>> left behind this, remove it.
>>>>
>>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>>
>>> Yeah this is a stub for !CONFIG_XDP_SOCKETS...
>>
>> Wait, I am not sure if this should go to bpf tree and have fixes tag
>> pointing to the cited commit?
>>
>> Functionally this commit does not fix anything but it feels that
>> f2f167583601 was incomplete.
> 
> FWIIW, I think that bpf-next is appropriate for this patch
> as it doesn't address a bug.

Ok , will send v2 target to bpf-next.
> .
> 
