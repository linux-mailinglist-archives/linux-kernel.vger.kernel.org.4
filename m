Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B277B6ECBEB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 14:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjDXMSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 08:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDXMR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 08:17:59 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7303426B7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 05:17:58 -0700 (PDT)
Received: from [IPV6:2001:250:4000:5113:4140:2ad:3e:4b54] ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33OCH9Aq011419-33OCH9Ar011419
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 24 Apr 2023 20:17:09 +0800
Message-ID: <4b1dcfd3-a82c-5165-7c0a-1767f97273e6@hust.edu.cn>
Date:   Mon, 24 Apr 2023 20:17:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] drivers: regulator: core: remove return value check of
 `rdev->debugfs`
To:     Mark Brown <broonie@kernel.org>,
        Yuchen Yang <u202114568@hust.edu.cn>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        hust-os-kernel-patches@googlegroups.com,
        Liam Girdwood <lrg@slimlogic.co.uk>,
        linux-kernel@vger.kernel.org
References: <20230424025738.34950-1-u202114568@hust.edu.cn>
 <1ea2bb36-af47-4651-8f37-b72736ca0367@sirena.org.uk>
From:   Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <1ea2bb36-af47-4651-8f37-b72736ca0367@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/4/24 19:56, Mark Brown wrote:
> On Mon, Apr 24, 2023 at 10:57:37AM +0800, Yuchen Yang wrote:
>> Smatch complains that:
>> rdev_init_debugfs() warn: 'rdev->debugfs' is an error pointer or valid
>>
>> According to the documentation of the debugfs_create_dir() function,
>> there is no need to check the return value of this function.
>> Just delete the dead code.
> Please stop sending these patches.

No problem. We will disable this Smatch checker in our daily use.

Thanks for your feedback.

