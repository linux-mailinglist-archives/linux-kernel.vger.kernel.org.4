Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC0073ABE3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 23:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjFVVwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 17:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjFVVwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 17:52:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EF2C3;
        Thu, 22 Jun 2023 14:52:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A87FB61923;
        Thu, 22 Jun 2023 21:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A15C433C8;
        Thu, 22 Jun 2023 21:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687470724;
        bh=dvLWGOBwNTXN6E/yM+CESlG/rZNvOG86KIsYDcJNubQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=baGy2bzOYdXCYc4YfBw/zVvO2zhb1DeCBmAjoIFxDO0dlvEJBA5BL+yzwZTGHr3BU
         cTMS9lrjn9wCt9Aw3eKcm+UdF5RMnm3T4E2V/x8YY7OFUPh6+ima/DX82wb3Z0oLAq
         Thh1meLV0NwX7iqtqYeKbazqI6h6NDvHtoKGT3SSpsWew2CE/fEnKY7os1UhRzXn4M
         FQ5Icj/D2+Y222kt6DT6306ESdc63LSl0oDcougFFwcha30t+7MSWmZ4Q6H3wpoqB9
         svVbiJoMH4wq6Dcy1WOszrrOvvIhKqsA3B105dWcJCU7Ixz1Yw48qMDRUHAqLd71Cd
         VpWzO/dDXf0lA==
Message-ID: <06ded84e-f5ba-c9e6-ce5b-72eaca56bc88@kernel.org>
Date:   Fri, 23 Jun 2023 06:52:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] ata: octeon: Add compile test support
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-ide@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230614173633.2430653-1-robh@kernel.org>
 <20230614173633.2430653-2-robh@kernel.org>
 <23325977-ba37-4360-afb5-4ab38a66107e@roeck-us.net>
 <feef6589-d0d6-8e64-fefd-914c234dcfba@kernel.org>
 <167e83a0-8666-27af-5e2c-4ddda917795a@roeck-us.net>
 <78cce73d-16d1-e357-bee7-2176479604f4@kernel.org>
 <CAL_JsqLdEoiiCR6n1XqQe-6_9-9Hu1t_r17hXG9rTmSAMBZ9OA@mail.gmail.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAL_JsqLdEoiiCR6n1XqQe-6_9-9Hu1t_r17hXG9rTmSAMBZ9OA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/23 22:41, Rob Herring wrote:
> On Wed, Jun 21, 2023 at 10:26 PM Damien Le Moal <dlemoal@kernel.org> wrote:
>>
>> On 6/22/23 12:01, Guenter Roeck wrote:
>>> On 6/21/23 17:57, Damien Le Moal wrote:
>>>> On 6/22/23 01:51, Guenter Roeck wrote:
>>>>> On Wed, Jun 14, 2023 at 11:36:33AM -0600, Rob Herring wrote:
>>>>>> Add COMPILE_TEST to enable building Cavium Octeon drivers in MIPS
>>>>>> allyesconfig/allmodconfig builds. There's a dependency on MIPS headers,
>>>>>> so other arches can't be enabled.
>>>>>>
>>>>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>>>>> ---
>>>>>> Tested on allmodconfig build. Not sure if there's other MIPS configs
>>>>>> where this doesn't work. We'll see what 0-day says.
>>>>>
>>>>> Odd, in next-20230621 I get:
>>>>>
>>>>> Building mips:allmodconfig ... failed
>>>>
>>>> Indeed odd. Given that this is an allmodconfig, I would assume that
>>>> CONFIG_CAVIUM_OCTEON_SOC is set ?
>>>>
>>>
>>> No, it is not. CONFIG_CAVIUM_OCTEON_SOC is a choice option,
>>> meaning only one of the choices can be set, and mips:allmodconfig
>>> selects a different choice.
>>
>> OK. Then I think I need to drop this patch as I do not see how to allow
>> COMPILE_TEST without CONFIG_CAVIUM_OCTEON_SOC being set.
>>
>> Rob ?
> 
> These could be fixed, but not sure it's worth the effort.

Agreed. And given that we are at rc7 already, this effort should not be now
anyway. I will drop this patch.


-- 
Damien Le Moal
Western Digital Research

