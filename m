Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F384693178
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 15:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBKOXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 09:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKOXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 09:23:43 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC98D23C6C;
        Sat, 11 Feb 2023 06:23:41 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pQqmy-000309-Cp; Sat, 11 Feb 2023 15:23:40 +0100
Message-ID: <3d702234-88b3-42ae-9b12-0ccf19bd9bcb@leemhuis.info>
Date:   Sat, 11 Feb 2023 15:23:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/3] venus: firmware: Correct non-pix start and end
 addresses
Content-Language: en-US, de-DE
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Fritz Koenig <frkoenig@chromium.org>,
        Nathan Hebert <nhebert@chromium.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <20221005083730.963322-1-stanimir.varbanov@linaro.org>
 <20221005083730.963322-3-stanimir.varbanov@linaro.org>
 <Y9LSMap+jRxbtpC8@google.com>
 <b2007bc9-b05f-eb17-a373-9587b01d3788@leemhuis.info>
In-Reply-To: <b2007bc9-b05f-eb17-a373-9587b01d3788@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1676125421;f3f8427f;
X-HE-SMSGID: 1pQqmy-000309-Cp
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux regression tracking. A
change or fix related to the regression discussed in this thread was
posted or applied, but it did not use a Link: tag to point to the
report, as Linus and the documentation call for. Things happen, no
worries -- but now the regression tracking bot needs to be told manually
about the fix. See link in footer if these mails annoy you.]

On 05.02.23 12:00, Linux kernel regression tracking (#adding) wrote:
> On 26.01.23 20:19, Matthias Kaehlcke wrote:
>> On Wed, Oct 05, 2022 at 11:37:29AM +0300, Stanimir Varbanov wrote:
>>> The default values for those registers are zero.
>>>
>>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> [...]
>> I found that this commit prevents the AOSS from entering sleep mode during
>> system suspend at least on sc7180 and sc7280. AOSS not entering sleep mode
>> leads to a (apparently significant) increase in S3 power consumption, on
>> trogdor and herobrine it prevents the system from staying suspended, because
>> the embedded controller detect the condition and wakes the sytem up again.
> 
> Thanks for the report. To be sure the issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced a837e5161cfffbb32
> #regzbot title meida: venus: firmware: AOSS doesn't seel anymore on at
> least sc7180 and sc7280
> #regzbot ignore-activity

#regzbot monitor:
https://lore.kernel.org/all/20230207102254.1446461-1-javierm@redhat.com/
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.



