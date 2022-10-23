Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C25460943E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 17:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiJWPII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 11:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJWPIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 11:08:06 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81F8733F2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 08:08:05 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1omca3-0005bX-1k; Sun, 23 Oct 2022 17:08:03 +0200
Message-ID: <b108978a-77ff-68aa-8c7a-1f6e67629608@leemhuis.info>
Date:   Sun, 23 Oct 2022 17:08:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 1/1] mfd: syscon: Remove repetition of the
 regmap_get_val_endian()
Content-Language: en-US, de-DE
To:     regressions@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org
References: <20220808140811.26734-1-andriy.shevchenko@linux.intel.com>
 <20221009163942.GA630814@roeck-us.net>
From:   Thorsten Leemhuis <linux@leemhuis.info>
In-Reply-To: <20221009163942.GA630814@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1666537685;72467617;
X-HE-SMSGID: 1omca3-0005bX-1k
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.10.22 18:39, Guenter Roeck wrote:
> On Mon, Aug 08, 2022 at 05:08:11PM +0300, Andy Shevchenko wrote:
>> Since the commit 0dbdb76c0ca8 ("regmap: mmio: Parse endianness
>> definitions from DT") regmap MMIO parses DT itsef, no need to
>> repeat this in the caller(s).
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> This patch results in reboot failures for all big endian mips emulations.
> 
> Sample log:
> 
> Network interface test passed
> Boot successful.
> Rebooting
> reboot: Restarting system
> Unable to restart system
> Reboot failed -- System halted
> 
> The problem is not seen with little endian mips emulations. Reverting
> this patch fixes the problem. Bisect log attached.
> 
> #regzbot introduced: 72a95859728a
> #regzbot title: Reboot failure on big endian mips systems

#regzbot monitor: https://lore.kernel.org/all/Y0GZwkDwnak2ReTt@zx2c4.com/
