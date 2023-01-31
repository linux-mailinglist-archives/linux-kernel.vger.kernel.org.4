Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192176821AF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 02:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjAaB6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 20:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjAaB6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 20:58:06 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C6ACDC6;
        Mon, 30 Jan 2023 17:58:04 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VaUebrP_1675130280;
Received: from 30.240.116.180(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VaUebrP_1675130280)
          by smtp.aliyun-inc.com;
          Tue, 31 Jan 2023 09:58:01 +0800
Message-ID: <926a3de3-ec6d-95e9-d799-c01e7ba9d2f9@linux.alibaba.com>
Date:   Tue, 31 Jan 2023 09:57:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH] ACPI: APEI: EINJ: Limit error type to 32-bit width
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Luck, Tony" <tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "jaylu102@amd.com" <jaylu102@amd.com>,
        "benjamin.cheatham@amd.com" <benjamin.cheatham@amd.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "zhuo.song@linux.alibaba.com" <zhuo.song@linux.alibaba.com>
References: <20230118063504.58026-1-xueshuai@linux.alibaba.com>
 <SJ1PR11MB60831C602B33D51DC6E604E6FCC79@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <202e4635-5233-9588-6c5e-ac61d280a431@linux.alibaba.com>
 <CAJZ5v0hJ=XVVyw-feraYmTkGKeis7wrxDehtHOYuRSPUzYrSHA@mail.gmail.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <CAJZ5v0hJ=XVVyw-feraYmTkGKeis7wrxDehtHOYuRSPUzYrSHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/1/30 PM11:41, Rafael J. Wysocki wrote:
> On Thu, Jan 19, 2023 at 3:10 AM Shuai Xue <xueshuai@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2023/1/19 AM12:37, Luck, Tony wrote:
>>>> The bit map of error types to inject is 32-bit width[1]. Add parameter
>>>> check to reflect the fact.
>>>>
>>>> [1] ACPI Specification 6.4, Section 18.6.4. Error Types
>>>>
>>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>>
>>> Reviewed-by: Tony Luck <tony.luck@intel.com>
> 
> Applied as 6.3 material, thanks!

Thank you.

Cheers
Shuai
