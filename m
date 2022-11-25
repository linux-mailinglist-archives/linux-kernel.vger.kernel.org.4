Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBB56382F3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 05:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiKYEAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 23:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiKYEAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 23:00:19 -0500
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0AB21E02;
        Thu, 24 Nov 2022 20:00:17 -0800 (PST)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 2AP3Yqrq036587;
        Fri, 25 Nov 2022 11:34:52 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from [192.168.2.115] (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 25 Nov
 2022 11:59:21 +0800
Message-ID: <0d58e557-3ed9-669a-febb-b4ac714af01e@aspeedtech.com>
Date:   Fri, 25 Nov 2022 11:59:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] media: aspeed: Use v4l2_dbg to replace v4l2_warn to avoid
 log spam
Content-Language: en-US
To:     Zev Weiss <zweiss@equinix.com>
CC:     "eajames@linux.ibm.com" <eajames@linux.ibm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "zev@bewilderbeest.net" <zev@bewilderbeest.net>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221110095611.522-1-jammy_huang@aspeedtech.com>
 <20221122231216.GF18848@packtop>
From:   Jammy Huang <jammy_huang@aspeedtech.com>
In-Reply-To: <20221122231216.GF18848@packtop>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 2AP3Yqrq036587
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zev,

On 2022/11/23 上午 07:12, Zev Weiss wrote:
> On Thu, Nov 10, 2022 at 01:56:11AM PST, Jammy Huang wrote:
>> If the host is powered off, there will be many warning log. To avoid the
>> log spam in this condition, replace v4l2_warn with v4l2_dbg.
>>
>> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
>> ---
>> drivers/media/platform/aspeed/aspeed-video.c | 16 ++++++++--------
>> 1 file changed, 8 insertions(+), 8 deletions(-)
>>
> Thanks Jammy -- after dropping the one hunk that wasn't applicable (due
> to not having all the prerequisite patches) this definitely fixed the
> log noise problems I'd been having.
>
> I'm assuming the prerequisite patches are from your aspeed-jpeg support
> patch series?  If so, since this is a smaller/simpler patch, I think it
> might make sense to reorder things to try to get this merged first and
> then fixing up that patchset to use v4l2_dbg() instead of v4l2_warn(),
> rather than introducing a new instance of it and then patching it back
> out later with this one.

Yes, the prerequisite patches are 'aspeed-jpeg support' patch series. 
And that patch series

has been accepted and pull for v6.2. Your suggestion is better to 
decouple these patches.

I would pay attention to the problem like this to avoid this condition 
in the future.

Many thanks for your kindly help.

>
>
> Thanks,
> Zev

-- 
Best Regards
Jammy

