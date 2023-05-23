Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A2170D7E5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbjEWIwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjEWIw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:52:27 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F371FF
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:52:26 -0700 (PDT)
Received: from kwepemi500009.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QQSd81zhKz18LWg;
        Tue, 23 May 2023 16:47:56 +0800 (CST)
Received: from [10.67.110.89] (10.67.110.89) by kwepemi500009.china.huawei.com
 (7.221.188.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 23 May
 2023 16:52:23 +0800
Message-ID: <e27b1467-bf51-fc1f-b3ce-a45f06b5b795@huawei.com>
Date:   Tue, 23 May 2023 16:52:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v6] kobject: Fix global-out-of-bounds in
 kobject_action_type()
From:   Xia Fukun <xiafukun@huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <prajnoha@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20230517101957.14655-1-xiafukun@huawei.com>
 <2023051739-shrunk-reopen-b968@gregkh>
 <111fa8ed-9031-a393-401c-0266a9bf7544@huawei.com>
In-Reply-To: <111fa8ed-9031-a393-401c-0266a9bf7544@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.89]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500009.china.huawei.com (7.221.188.199)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping ...

On 2023/5/18 10:37, Xia Fukun wrote:
> On 2023/5/17 20:17, Greg KH wrote:
> 
>> And how was any of this tested?  Based on your prior submissions, we are
>> going to require some sort of proof.  What would you do if you were in
>> my position?
> 
> My testing method is to apply the patch, compile the kernel image,
> and start the QEMU virtual machine. Then compile and execute the code
> mentioned in the patch that triggers out-of-bounds issues.
> 
> In addition, the following operations will be performed to verify the
> functions mentioned by Peter Rajnoha <prajnoha@redhat.com>:
> 
> # echo "add fe4d7c9d-b8c6-4a70-9ef1-3d8a58d18eed A=1 B=abc" >
> /sys/block/ram0/uevent
> 
> # udevadm monitor --kernel --env
> monitor will print the received events for:
> KERNEL - the kernel uevent
> 
> KERNEL[189.376386] add      /devices/virtual/block/ram0 (block)
> ACTION=add
> DEVPATH=/devices/virtual/block/ram0
> SUBSYSTEM=block
> SYNTH_UUID=fe4d7c9d-b8c6-4a70-9ef1-3d8a58d18eed
> SYNTH_ARG_A=1
> SYNTH_ARG_B=abc
> DEVNAME=/dev/ram0
> DEVTYPE=disk
> DISKSEQ=14
> SEQNUM=3781
> MAJOR=1
> MINOR=0
> 
> Thank you for your suggestion. My submission was indeed negligent,
> and your guidance has benefited me greatly.

I have submitted v7 of the patch according to your suggestion and
tested it to ensure its functionality is correct.

Please take the time to review it.

Thank you very much.
