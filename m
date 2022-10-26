Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D549C60D8BA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 03:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiJZBIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 21:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiJZBIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 21:08:48 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530C254C9C;
        Tue, 25 Oct 2022 18:08:46 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MxrGZ2SMMzJn9C;
        Wed, 26 Oct 2022 09:05:58 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 09:08:44 +0800
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 26 Oct
 2022 09:08:43 +0800
Subject: Re: [PATCH] ACPICA: add missing macro ACPI_FUNCTION_TRACE() for
 ns_repair_HID()
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <robert.moore@intel.com>, <rafael.j.wysocki@intel.com>,
        <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <devel@acpica.org>, <linux-kernel@vger.kernel.org>,
        <liwei391@huawei.com>
References: <20221025113643.79743-1-wangxiongfeng2@huawei.com>
 <20221025123846.o6ufodigshvyqhqj@bogus>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <8ddb1b39-9b77-8ae6-3964-c358c78f728c@huawei.com>
Date:   Wed, 26 Oct 2022 09:08:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20221025123846.o6ufodigshvyqhqj@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On 2022/10/25 20:38, Sudeep Holla wrote:
> Hi Xiongfeng,
> 
> On Tue, Oct 25, 2022 at 07:36:43PM +0800, Xiongfeng Wang wrote:
>> The following commit add function tracing macros for the namespace repair
>> mechanism.
>>
>>   commit 0766efdf9a9d24eaefe260c787f49af225018b16
>>   ACPICA: Add function trace macros to improve debugging
>>
>> But it missed the trace macro for the entry of ns_repair_HID(). Let's
>> add it.
>>
> 
> Generally all ACPICA changes need to be submitted to the upstream project
> via GitHub at https://github.com/acpica/acpica. It will be imported to the
> Linux project from there.

Thanks for your reply! I will submit it the ACPICA project on GitHub.

Thanks,
Xiongfeng

> 
