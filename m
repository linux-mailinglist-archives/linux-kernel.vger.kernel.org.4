Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21190672EA3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 03:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjASCKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 21:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjASCKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:10:20 -0500
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7DD67946;
        Wed, 18 Jan 2023 18:10:17 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VZrtjWI_1674094213;
Received: from 30.13.161.5(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VZrtjWI_1674094213)
          by smtp.aliyun-inc.com;
          Thu, 19 Jan 2023 10:10:14 +0800
Message-ID: <202e4635-5233-9588-6c5e-ac61d280a431@linux.alibaba.com>
Date:   Thu, 19 Jan 2023 10:10:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH] ACPI: APEI: EINJ: Limit error type to 32-bit width
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Cc:     "lenb@kernel.org" <lenb@kernel.org>,
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
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <SJ1PR11MB60831C602B33D51DC6E604E6FCC79@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/1/19 AM12:37, Luck, Tony wrote:
>> The bit map of error types to inject is 32-bit width[1]. Add parameter
>> check to reflect the fact.
>>
>> [1] ACPI Specification 6.4, Section 18.6.4. Error Types
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> 
> -Tony

Thank you.

Cheers.
Shuai
