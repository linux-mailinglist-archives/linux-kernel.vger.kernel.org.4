Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FC5659416
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 02:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbiL3Bt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 20:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiL3Bty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 20:49:54 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A21BB7C8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 17:49:53 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Njp3x6lsNzqTKH;
        Fri, 30 Dec 2022 09:45:17 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 30 Dec 2022 09:49:51 +0800
Subject: Re: [BUG Report] undefined reference to `convert_to_fxsr'
To:     Borislav Petkov <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, <hpa@zytor.com>
References: <50aa72a7-043d-8091-78de-458cbcc6c356@huawei.com>
 <Y6w49Y1d3lpv3KFn@zn.tnic> <23e2907c-5188-5ac6-3db8-1c5a12120bf2@huawei.com>
 <Y62vbjBzHF4rmh1V@zn.tnic>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <e041533c-4005-b9bc-3985-02224985aa28@huawei.com>
Date:   Fri, 30 Dec 2022 09:49:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Y62vbjBzHF4rmh1V@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/29 23:17, Borislav Petkov wrote:
> On Thu, Dec 29, 2022 at 09:50:16AM +0800, Miaohe Lin wrote:
>> CONFIG_CC_VERSION_TEXT="gcc (GCC) 7.3.0"
> 
> Builds fine with gcc (Debian 12.2.0-9) 12.2.0
> 
> Lemme build 7.3 and test with it.

Many thanks for doing this. :) But it seems it's not the matter of gcc version. Somewhat confused...

Thanks,
Miaohe Lin


