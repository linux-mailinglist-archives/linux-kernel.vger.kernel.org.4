Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8EA70635C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjEQIy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjEQIy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:54:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A95A1738
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:54:26 -0700 (PDT)
Received: from kwepemi500009.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QLmxq2XxqzTkwg;
        Wed, 17 May 2023 16:49:35 +0800 (CST)
Received: from [10.67.110.89] (10.67.110.89) by kwepemi500009.china.huawei.com
 (7.221.188.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 17 May
 2023 16:54:23 +0800
Message-ID: <484d25eb-bcc3-f64f-1182-ff50fb4aca9a@huawei.com>
Date:   Wed, 17 May 2023 16:54:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5] kobject: Fix global-out-of-bounds in
 kobject_action_type()
To:     Peter Rajnoha <prajnoha@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>
References: <20230516123719.117137-1-xiafukun@huawei.com>
 <24c413e6-75a5-254c-b776-1459da83f86f@redhat.com>
From:   Xia Fukun <xiafukun@huawei.com>
In-Reply-To: <24c413e6-75a5-254c-b776-1459da83f86f@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.89]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500009.china.huawei.com (7.221.188.199)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/5/16 22:02, Peter Rajnoha wrote:
> On 5/16/23 14:37, Xia Fukun wrote:

>> ---
>> v4 -> v5:
>> - Fixed build errors and warnings, and retested the patch.
>>
> 
> Please, also check this is still working:
> https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-uevent
> 
> When I try passing the example line "add
> fe4d7c9d-b8c6-4a70-9ef1-3d8a58d18eed A=1 B=abc", it doesn't recognize
> such input anymore and it incorrectly considers it as erroneous.
> 

Why did I receive the following error message when passing the example
line "add fe4d7c9d-b8c6-4a70-9ef1-3d8a58d18eed A=1 B=abc" using the
original mainline code?

synth uevent: /devices/virtual/block/ram12: incorrect uevent action arguments
block ram12: uevent: failed to send synthetic uevent: -22

Is there a problem with my test case, or is the original code unable
to successfully parse the sample?
