Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4C0633E22
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbiKVNwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbiKVNwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:52:06 -0500
X-Greylist: delayed 377 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Nov 2022 05:52:04 PST
Received: from smtpout2.mo529.mail-out.ovh.net (smtpout2.mo529.mail-out.ovh.net [79.137.123.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB0957B66
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:52:04 -0800 (PST)
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.162])
        by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 94C771426594B;
        Tue, 22 Nov 2022 14:45:45 +0100 (CET)
Received: from kaod.org (37.59.142.109) by DAG4EX2.mxp5.local (172.16.2.32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 22 Nov
 2022 14:45:44 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-109S0031ced9bf8-c26d-4afa-afd8-010d38e12712,
                    A8CD6F91F189B906F64E5BA3194761AB3BAD0F40) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <9a59c0da-cdf2-d97f-2520-3cb803089bca@kaod.org>
Date:   Tue, 22 Nov 2022 14:45:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] virtio_console: Introduce an ID allocator for virtual
 console numbers
Content-Language: en-US
To:     Thomas Huth <thuth@redhat.com>, Amit Shah <amit@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <20221114173811.1977367-1-clg@kaod.org>
 <81612d82-7fc1-e2be-38a2-0db8314248cc@redhat.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <81612d82-7fc1-e2be-38a2-0db8314248cc@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.109]
X-ClientProxiedBy: DAG3EX1.mxp5.local (172.16.2.21) To DAG4EX2.mxp5.local
 (172.16.2.32)
X-Ovh-Tracer-GUID: 09e46093-3f6b-428a-9524-0bf6889ff4d1
X-Ovh-Tracer-Id: 15170656823834741609
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvgedrheelgddvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepffdufeeliedujeeffffhjeffiefghffhhfdvkeeijeehledvueffhfejtdehgeegnecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrddutdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeotghlgheskhgrohgurdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehthhhuthhhsehrvgguhhgrthdrtghomhdprghmihhtsehkvghrnhgvlhdrohhrghdprghrnhgusegrrhhnuggsrdguvgdpghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhvihhrthhurghlihiirghtihhonheslhhishhtshdrlhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhhsthesrhgvughhrghtrdgtohhmpdfovfetjfhoshhtpehmohehvdelpdhmohguvgepshhmth
 hpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/22 12:12, Thomas Huth wrote:
> On 14/11/2022 18.38, Cédric Le Goater wrote:
>> When a virtio console port is initialized, it is registered as an hvc
>> console using a virtual console number. If a KVM guest is started with
>> multiple virtio console devices, the same vtermno (or virtual console
>> number) can be used to allocate different hvc consoles, which leads to
>> various communication problems later on.
>>
>> This is also reported in debugfs :
>>
>>    # grep vtermno /sys/kernel/debug/virtio-ports/*
>>    /sys/kernel/debug/virtio-ports/vport1p1:console_vtermno: 1
>>    /sys/kernel/debug/virtio-ports/vport2p1:console_vtermno: 1
>>    /sys/kernel/debug/virtio-ports/vport3p1:console_vtermno: 2
>>    /sys/kernel/debug/virtio-ports/vport4p1:console_vtermno: 3
>>
>> Replace the next_vtermno global with an ID allocator and start the
>> allocation at 1 as it is today. Also recycle IDs when a console port
>> is removed.
> 
> Sounds like a good idea!
> 
>> @@ -1244,8 +1236,11 @@ static int init_port_console(struct port *port)
>>        * pointers.  The final argument is the output buffer size: we
>>        * can do any size, so we put PAGE_SIZE here.
>>        */
>> -    port->cons.vtermno = pdrvdata.next_vtermno;
>> +    ret = ida_alloc_range(&vtermno_ida, 1, ~0, GFP_KERNEL);
> 
> Just cosmetics: I think you could use ida_alloc_min() instead.
> 
>> +    if (ret < 0)
>> +        return ret;
>> +    port->cons.vtermno = ret;
>>       port->cons.hvc = hvc_alloc(port->cons.vtermno, 0, &hv_ops, PAGE_SIZE);
>>       if (IS_ERR(port->cons.hvc)) {
>>           ret = PTR_ERR(port->cons.hvc);
> 
> What if this if (IS_ERR()) error happens? The code seems to return early in this case - shouldn't the ID be freed again in this case?

Oh yes. I forgot that.

Thanks,

C.

