Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE91A6223FD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 07:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiKIGfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 01:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiKIGfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 01:35:05 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C7F19C31;
        Tue,  8 Nov 2022 22:35:04 -0800 (PST)
Received: from kwepemi500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N6Zvd65lzzRp4W;
        Wed,  9 Nov 2022 14:34:53 +0800 (CST)
Received: from [10.136.108.160] (10.136.108.160) by
 kwepemi500002.china.huawei.com (7.221.188.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 14:35:01 +0800
Subject: Re: [PATCH] USB: gadget: Fix CFI failure during usb config switch.
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "Xuetao (kirin)" <xuetao09@huawei.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "jakobkoschel@gmail.com" <jakobkoschel@gmail.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "colin.i.king@gmail.com" <colin.i.king@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Caiyadong <caiyadong@huawei.com>,
        xuhaiyang <xuhaiyang5@hisilicon.com>,
        Suzhuangluan <suzhuangluan@hisilicon.com>
References: <b71e1b4b-4d33-fc36-a35f-ea40904a40b6@huawei.com>
 <32d2bf3e-6730-f598-afef-e8d6f4a509b0@huawei.com>
 <Y2pxoJySPpTkL6Rw@kroah.com>
From:   "Zhangjiantao (Kirin, nanjing)" <water.zhangjiantao@huawei.com>
Message-ID: <e87609eb-4dfa-6d49-857c-21b80b614aa7@huawei.com>
Date:   Wed, 9 Nov 2022 14:35:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <Y2pxoJySPpTkL6Rw@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.136.108.160]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500002.china.huawei.com (7.221.188.171)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

           I will fix my email client and rewrite a new patch.

在 2022/11/8 23:11, gregkh@linuxfoundation.org 写道:
> On Tue, Nov 08, 2022 at 08:39:52PM +0800, Zhangjiantao (Kirin, nanjing) wrote:
>
> <snip>
>
> Please fix your email client to not send HTML email, otherwise the
> mailing list rejects it.
>
> Fix that up and respond and I will be glad to reply.
>
> thanks,
>
> greg k-h
> .
