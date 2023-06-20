Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCC5737186
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjFTQaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjFTQaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:30:04 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679B61708;
        Tue, 20 Jun 2023 09:30:02 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qBeEy-00008N-Jz; Tue, 20 Jun 2023 18:30:00 +0200
Message-ID: <7344a720-76c9-33b1-b4fa-81f600895f07@leemhuis.info>
Date:   Tue, 20 Jun 2023 18:30:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: PWM regression causing failures with the pwm-atmel driver
Content-Language: en-US, de-DE
To:     Peter Rosin <peda@axentia.se>, LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
References: <7e2cfb55-e39f-2e5c-7f43-e1d275428bb5@axentia.se>
 <6c622fd7-d79b-b7f2-50ee-00a0ec95a11b@leemhuis.info>
 <b70c5798-399d-25f9-e8b0-85ba0bb13a7f@axentia.se>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <b70c5798-399d-25f9-e8b0-85ba0bb13a7f@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1687278602;41ec27f2;
X-HE-SMSGID: 1qBeEy-00008N-Jz
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.06.23 17:43, Peter Rosin wrote:
> 
> 2023-06-20 at 16:24, Thorsten Leemhuis wrote:
>> On 22.05.23 17:19, Peter Rosin wrote:
>>>
>>> I have a device with a "sound card" that has an amplifier that needs
>>> an extra boost when high amplification is requested. This extra
>>> boost is controlled with a pwm-regulator.
>>>
>>> As of commit c73a3107624d ("pwm: Handle .get_state() failures") this
>>> device no longer works. I have tracked the problem to an unfortunate
>>> interaction between the underlying PWM driver and the PWM core.
>>> [...]>
>>> Approach 1. will maybe clobber the saved pwm->state such that
>>> it no longer works to get the period/duty_cycle if/when the
>>> PWM is disabled? Maybe only for some corner case? But that might
>>> be a significant corner case?
>>>
>>> Approach 2. will maybe mess up some unrelated functionality?
>>>
>>> Approach 3. is ugly, intrusive and is in all likelihood
>>> incomplete. It also needs a rebase from the culprit commit.
>>>
>>> #regzbot introduced c73a3107624d
>>
>> What happened to this? There was quite a bit of discussion, but then
>> nothing happened anymore.
> 
> I was seriously confused by another regression that caused my
> user space to fail similarly (The sound driver didn't behave, but
> for vastly different reasons). My bad, I should have made more
> thorough checks before crying wolf.

Happens, no worries.

> So, this regression had already been fixed when I reported it.
> For the curious, the other regression has also been fixed, merged
> and picked up by stable. For the really curious, 2a6c7e8cc74e
> ("dmaengine: at_hdmac: Repair bitfield macros for peripheral ID
> handling")
> 
> All in all, please close this one.

Okydo, thx for the update!

#regzbot resolve: "this regression had already been fixed when I
reported it"

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
