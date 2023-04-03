Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB576D4579
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbjDCNRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjDCNRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:17:47 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2ED1994
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 06:17:46 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PqrvD4QXYzSqKr;
        Mon,  3 Apr 2023 21:14:00 +0800 (CST)
Received: from [10.67.110.73] (10.67.110.73) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 3 Apr
 2023 21:17:43 +0800
Message-ID: <1a974f41-83ec-9c7f-ddf1-cb093ae95046@huawei.com>
Date:   Mon, 3 Apr 2023 21:17:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] irq: fasteoi handler re-runs on concurrent invoke
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Gowans, James" <jgowans@amazon.com>,
        "zouyipeng@huawei.com" <zouyipeng@huawei.com>
CC:     "maz@kernel.org" <maz@kernel.org>,
        "Raslan, KarimAllah" <karahmed@amazon.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230317095300.4076497-1-jgowans@amazon.com>
 <f0879a30-6f88-30e0-ce30-e230df8f2936@huawei.com>
 <001d516c1bb6f0b6d2344f1ae160e796d003c24c.camel@amazon.com>
 <6d1859b0-20f3-05a8-d8d6-dfb0c9985985@huawei.com>
 <fd5588e5b0b1b5d21b1c0df7290844907ebcf367.camel@amazon.com>
 <871qlh9imb.ffs@tglx>
From:   "zhangjianhua (E)" <chris.zjh@huawei.com>
In-Reply-To: <871qlh9imb.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.6 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas

I have the same problem as James and Yipeng, while modify the irq affinity

concurrently during LPI interrupt processing, it does cause interrupt loss.

Fortunately, James and Yipeng give their patches separately with the similar

solutions, and hope you'll take this issue seriously, thanks.

在 2023/3/22 18:37, Thomas Gleixner 写道:
> On Wed, Mar 22 2023 at 07:48, James Gowans wrote:
>> On Wed, 2023-03-22 at 14:26 +0800, Yipeng Zou wrote:
>> Thomas, would you be open to taking the patch to tweak the handle_fasteoi_irq
>> handler? Or is there a different solution to this problem which you
>> prefer?
> It's in my backlog.
