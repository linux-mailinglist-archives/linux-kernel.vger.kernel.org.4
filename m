Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4335BC0F8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 03:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiISBSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 21:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiISBSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 21:18:04 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70C31571A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 18:18:01 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MW6Br3NsBz14QZv;
        Mon, 19 Sep 2022 09:13:56 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 09:18:00 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 09:17:59 +0800
Subject: Re: [PATCH -next v2] habanalabs/gaudi2: fix free irq in error path in
 gaudi2_enable_msix()
To:     Oded Gabbay <ogabbay@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20220913030714.974259-1-yangyingliang@huawei.com>
 <CAFCwf12hQqWjVr==31hM4MjhVd35KwjQdRYY_qnzBNcV1PbQjA@mail.gmail.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <a54586a1-7928-4296-8b33-155a7ca032c0@huawei.com>
Date:   Mon, 19 Sep 2022 09:17:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFCwf12hQqWjVr==31hM4MjhVd35KwjQdRYY_qnzBNcV1PbQjA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/9/18 18:28, Oded Gabbay wrote:
> On Tue, Sep 13, 2022 at 6:00 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
>> Add two variables to store completion irq and event queue irq. And add
>> a new lable to free event queue irq in error path in gaudi2_enable_msix().
> I'm sorry, I already pushed a fix to the bug (I didn't get any reply
> from you for more than a week so I didn't know if you are going to fix
> it).
> Oded
It's OK.

Thanks,
Yang

