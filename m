Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA5F697EC5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 15:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjBOOw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 09:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBOOw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 09:52:56 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567D9F751;
        Wed, 15 Feb 2023 06:52:54 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pSJ9L-00082i-9y; Wed, 15 Feb 2023 15:52:47 +0100
Message-ID: <05f6936f-f8e0-d0e5-7f8f-d0278dc03753@leemhuis.info>
Date:   Wed, 15 Feb 2023 15:52:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] pinctrl: aspeed: Force to disable the function's signal
Content-Language: en-US, de-DE
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <20220818101839.28860-1-billy_tsai@aspeedtech.com>
 <CACRpkdYpp_1JJQmuX27pECxN0cjzciCuETLPTrSYKqpX0FPABQ@mail.gmail.com>
 <e501d2fb-aaa0-470d-a8d5-5f8e97898df7@beta.fastmail.com>
 <CACPK8XfQ=uarsOgJ7LaXqLyGG2vSF-47RkAEV=T2gruapx-yfg@mail.gmail.com>
 <3af98200-7240-9e93-bd6a-d0e2f71ab1c4@leemhuis.info>
In-Reply-To: <3af98200-7240-9e93-bd6a-d0e2f71ab1c4@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1676472774;c077c2a6;
X-HE-SMSGID: 1pSJ9L-00082i-9y
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
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

On 21.01.23 13:32, Linux kernel regression tracking (#adding) wrote:
> On 19.01.23 02:54, Joel Stanley wrote:
>> On Fri, 26 Aug 2022 at 22:48, Andrew Jeffery <andrew@aj.id.au> wrote:
>>> On Sat, 27 Aug 2022, at 07:26, Linus Walleij wrote:
>>>> On Thu, Aug 18, 2022 at 12:18 PM Billy Tsai <billy_tsai@aspeedtech.com> wrote:
>>>>
>>>>> When the driver want to disable the signal of the function, it doesn't
>>>>> need to query the state of the mux function's signal on a pin. The
>>>>> condition below will miss the disable of the signal:
>>
>>>> I can't see the verdict for this patch? Will there be a new
>>>> version, or are we in the middle of a discussion?
>>>> I'd really like Andrew's ACK on the result before merging.
>>>
>>> Apologies, it's been a bit of A Week :)
>>>
>>> Given the approach has been discussed with the IP designer and solves a bug I'm okay for it to be merged. If we run into issues it is easy enough to back it out.
>>
>> As foreseen by Andrew, this caused a regression. On the Romulus
>> machine the device tree contains a gpio hog for GPIO S7. With the
>> patch applied:
> 
> #regzbot ^introduced cf517fef601b
> #regzbot title pinctrl: aspeed-g5-pinctrl 1e6e2080.pinctrl: Failed to
> acquire regmap for IP block 1
> #regzbot ignore-activity

#regzbot fix: 606d4ef4922662

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

#regzbot ignore-activity
