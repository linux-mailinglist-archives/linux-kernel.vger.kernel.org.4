Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2966E66D2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjDROMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjDROMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:12:30 -0400
X-Greylist: delayed 102 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 18 Apr 2023 07:12:18 PDT
Received: from out203-205-251-82.mail.qq.com (out203-205-251-82.mail.qq.com [203.205.251.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BD8146C5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1681827136;
        bh=axE0K9rAJNbZPTHu/N9msVmec+hFbIqczZ1zdflcDhE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Mpzshv91FLzUhE4r1ZjPjrCK1N0UnKbCQf6xL8GHe6pX4Sjc7FSSgDI0OMITxO8cN
         Eg/Rh2eOIXNevGwm6pdxQPGZpa0XVXooaTHNVSvVqRZj334Jg/w5qS7ZuUD4JGyZR8
         StxaXaWrVTrXTeX+1h4BZWz/aFAgeoeUt6VX46bk=
Received: from [192.168.31.3] ([106.92.97.36])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id 30EA7CEC; Tue, 18 Apr 2023 22:12:14 +0800
X-QQ-mid: xmsmtpt1681827134tm6lhrvj3
Message-ID: <tencent_D7FC79B0CA961A24A8651221FD8439C5EF05@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIeELuN70hYUcmLAIJT70aL9IYz/YbMJwDVzOH8qGwu/oeUScQiyu
         p+5tJRVphUagZm1aBfSzVOZY9fccZSXGoLNALdHJwHSxX7H2s62wGPsdM51QO4rW0g3K7C4ibbIb
         gMhUbLpTSwuZ3LZvEqohFuCSBY3XnxJyT0DejX3V2Asv0wD9IsDF9QRWoL4Ntbm5lYomCfbNeHXU
         gq44BcPJ4JuIZcuEhsbl6+Qjw67K3Ar+QPUdONyMQdhLHqYvMwzWbCz59VlDNOwNPMpn+QgQEbCV
         CVhWicwX0ApGCCi5mQo6SynTtX5ZOpxXAXk/ox3vg8ZXpXukymmmgzDIJI3dM1EWQtL0ARr7bHoj
         oXHz8HwyXK6w+pmuHkfuZdfvoJ7/NF6sLbqKza+vQbRoVl2W6vfMUgu5F6pyZxqSIo9eCAwHOpOc
         cInP1XMdWviUyAp6OejPwCQcicdKJPYmqdCEW/zxt+rsr6XgQ6E1mYJ/5L33ynsOUu/k0NIzVqpN
         zMXKgh8r+vKO8I8wfn1scRe6fZhTWsjGQ1dH7qMp6An5JSccf6TuWZMssvYqikg7vBZcGR5xplT7
         FtNr9Y7TG7bB84/R8+to/rYlM+N8/g9szZ97CiritKPShkeUNoCLmoXVzR7iD5d0pwuRTmoME18f
         k+ndn8ZJAlF5/KuNIA58UYDagA0k9rjZRO1WOkFrBB32VEMUNYRejZg5pnM+MOnHrNW+PwqkD5Gc
         3jOEdrwg9qjwlcHyiSGh94xNSqtVRbygvh+VjLogtgiYtGNc3X06S8MwFLPY74P8PZZcvOIGwkn2
         c7OvfbZnBLIuSP3D4G73cvJcQmr8H9Dc95kJdb2oZ09WHWf5OZVkQOFKvP1eZHRclCbh4tWmbNyh
         3ycN/Ke2ueb/Vpi5foORzxJmQfafQ4qsLQ76bqQ40I2uNYrG+iZokvb8AW51U+NOO4ElSU5xxExF
         89EfCHosupjaWSFtSmpbG0xmCWnJgK2tvI2fQqtzP+Yn3oHU2LlTV0Fi3vlxUQoWSOAQdccUs=
X-OQ-MSGID: <a0ab975d-a686-b28b-8e3d-056d8e2886a8@foxmail.com>
Date:   Tue, 18 Apr 2023 22:12:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] eventfd: support delayed wakeup for non-semaphore eventfd
 to reduce cpu utilization
To:     Hillf Danton <hdanton@sina.com>
Cc:     Christoph Hellwig <hch@lst.de>, Fu Wei <wefu@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20230417000711.1100-1-hdanton@sina.com>
From:   Wen Yang <wenyang.linux@foxmail.com>
In-Reply-To: <20230417000711.1100-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/4/17 08:07, Hillf Danton 写道:
> On 16 Apr 2023 19:31:55 +0800 Wen Yang <wenyang.linux@foxmail.com>
>> For the NON SEMAPHORE eventfd, if it's counter has a nonzero value,
>> then a read(2) returns 8 bytes containing that value, and the counter's
>> value is reset to zero. Therefore, in the NON SEMAPHORE scenario,
>> N event_writes vs ONE event_read is possible.
>>
>> However, the current implementation wakes up the read thread immediately
>> in eventfd_write so that the cpu utilization increases unnecessarily.
>>
>> By adding a configurable delay after eventfd_write, these unnecessary
>> wakeup operations are avoided, thereby reducing cpu utilization.
> If the EPOLLOUT wakeup in eventfd_read() breaks, feel free to specify it
> in the commit message after updating the comment below.
> 	/*
> 	 * Every time that a write(2) is performed on an eventfd, the
> 	 * value of the __u64 being written is added to "count" and a
> 	 * wakeup is performed on "wqh". A read(2) will return the "count"
> 	 * value to userspace, and will reset "count" to zero. The kernel
> 	 * side eventfd_signal() also, adds to the "count" counter and
> 	 * issue a wakeup.
> 	 */

Thanks

We will modify it according to your suggestion and then send v2 later.

--

Best wishes,

Wen




