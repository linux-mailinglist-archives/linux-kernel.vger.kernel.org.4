Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE81609C54
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiJXIWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiJXIVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:21:42 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C025631CD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:19:18 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1omsd7-0001Dr-Dy; Mon, 24 Oct 2022 10:16:17 +0200
Message-ID: <424a274f-2095-42b0-6c93-67f7284ba309@leemhuis.info>
Date:   Mon, 24 Oct 2022 10:16:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 1/1] mfd: syscon: Remove repetition of the
 regmap_get_val_endian()
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     regressions@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org
References: <20220808140811.26734-1-andriy.shevchenko@linux.intel.com>
 <20221009163942.GA630814@roeck-us.net>
 <b108978a-77ff-68aa-8c7a-1f6e67629608@leemhuis.info>
In-Reply-To: <b108978a-77ff-68aa-8c7a-1f6e67629608@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1666599560;317a2967;
X-HE-SMSGID: 1omsd7-0001Dr-Dy
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.10.22 17:08, Thorsten Leemhuis wrote:
> On 09.10.22 18:39, Guenter Roeck wrote:
>> On Mon, Aug 08, 2022 at 05:08:11PM +0300, Andy Shevchenko wrote:
>>> Since the commit 0dbdb76c0ca8 ("regmap: mmio: Parse endianness
>>> definitions from DT") regmap MMIO parses DT itsef, no need to
>>> repeat this in the caller(s).
>>>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> This patch results in reboot failures for all big endian mips emulations.
>>
>> Sample log:
>>
>> Network interface test passed
>> Boot successful.
>> Rebooting
>> reboot: Restarting system
>> Unable to restart system
>> Reboot failed -- System halted
>>
>> The problem is not seen with little endian mips emulations. Reverting
>> this patch fixes the problem. Bisect log attached.
>>
>> #regzbot introduced: 72a95859728a
>> #regzbot title: Reboot failure on big endian mips systems
> 
> #regzbot monitor: https://lore.kernel.org/all/Y0GZwkDwnak2ReTt@zx2c4.com/

#regzbot fixed-by: ca4582c286aa4465
