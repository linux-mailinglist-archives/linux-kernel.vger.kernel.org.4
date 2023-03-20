Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840086C0FDA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjCTK4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjCTK4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:56:01 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9442B2BE;
        Mon, 20 Mar 2023 03:52:44 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1peD7R-0000W1-Rv; Mon, 20 Mar 2023 11:52:01 +0100
Message-ID: <071cf060-9845-dbb4-0a5b-ac4e2183d6f6@leemhuis.info>
Date:   Mon, 20 Mar 2023 11:52:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
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
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1679309565;d124ce9e;
X-HE-SMSGID: 1peD7R-0000W1-Rv
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 05.02.23 12:00, Linux kernel regression tracking (#adding) wrote:

> On 26.01.23 20:19, Matthias Kaehlcke wrote:
>> On Wed, Oct 05, 2022 at 11:37:29AM +0300, Stanimir Varbanov wrote:
>>
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

#regzbot fix: media: Revert "venus: firmware: Correct non-pix start and
end addresses"
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.


