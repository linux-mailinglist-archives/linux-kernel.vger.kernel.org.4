Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8947264D50B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 02:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiLOBe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 20:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLOBeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 20:34:25 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A724227DE0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 17:34:24 -0800 (PST)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NXZW66g8qzlXd9;
        Thu, 15 Dec 2022 09:33:22 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 15 Dec 2022 09:34:22 +0800
Message-ID: <bb2ddfaf-f8c8-a3b5-e8b5-bf7f1cbcd658@huawei.com>
Date:   Thu, 15 Dec 2022 09:34:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
CC:     <mawupeng1@huawei.com>, <naoya.horiguchi@nec.com>,
        <catalin.marinas@arm.com>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Qestion] UCE on pud-sized hugepage lead to kernel panic on
 lts5.10
Content-Language: en-US
To:     <willy@infradead.org>
References: <2b4d03bc-2b6e-45b0-655a-58b66672187e@huawei.com>
 <Y5oCM6dEewOPymZw@casper.infradead.org>
From:   mawupeng <mawupeng1@huawei.com>
In-Reply-To: <Y5oCM6dEewOPymZw@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/15 1:04, Matthew Wilcox wrote:
> On Wed, Dec 14, 2022 at 09:33:10AM +0800, mawupeng wrote:
>> On current arm64 stable 5.10(v5.10.158). If a UCE happnes pud-sized
> 
> What's a UCE?
>

uncorrected error.
