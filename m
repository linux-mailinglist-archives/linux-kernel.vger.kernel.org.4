Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1B373AE12
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 02:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjFWA6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 20:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjFWA6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 20:58:32 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DFAE9;
        Thu, 22 Jun 2023 17:58:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VlkO6Zp_1687481893;
Received: from 30.121.14.202(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VlkO6Zp_1687481893)
          by smtp.aliyun-inc.com;
          Fri, 23 Jun 2023 08:58:25 +0800
Message-ID: <7f9ffecc-726f-5475-48e8-40a266cb43d7@linux.alibaba.com>
Date:   Fri, 23 Jun 2023 08:58:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 0/3] fixup potential cpu stall
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     arei.gonglei@huawei.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, amit@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230609131817.712867-1-xianting.tian@linux.alibaba.com>
 <20230622075819-mutt-send-email-mst@kernel.org>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
In-Reply-To: <20230622075819-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/6/22 下午7:59, Michael S. Tsirkin 写道:
> On Fri, Jun 09, 2023 at 09:18:14PM +0800, Xianting Tian wrote:
>> Cpu stall issue may happen if device is configured with multi queues
>> and large queue depth, so fix it.
>
> I applied this after tweaking commit log to address Greg's comments.
> In the future I expect you guys to do such tweaks yourself.
thanks.
>
>> Xianting Tian (3):
>>    virtio-crypto: fixup potential cpu stall when free unused bufs
>>    virtio_console: fixup potential cpu stall when free unused bufs
>>    virtio_bt: fixup potential cpu stall when free unused bufs
>>
>>   drivers/bluetooth/virtio_bt.c              | 1 +
>>   drivers/char/virtio_console.c              | 1 +
>>   drivers/crypto/virtio/virtio_crypto_core.c | 1 +
>>   3 files changed, 3 insertions(+)
>>
>> -- 
>> 2.17.1
