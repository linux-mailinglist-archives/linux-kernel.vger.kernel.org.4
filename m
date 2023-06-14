Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBCF7303F8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244008AbjFNPhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235947AbjFNPhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:37:09 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F6FC7;
        Wed, 14 Jun 2023 08:37:06 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q9SYQ-0005oK-Ao; Wed, 14 Jun 2023 17:37:02 +0200
Message-ID: <84110995-a99b-8b5a-cd34-8430866eb9b1@leemhuis.info>
Date:   Wed, 14 Jun 2023 17:37:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH] regulator: qcom-rpmh: Revert "regulator: qcom-rpmh: Use
 PROBE_FORCE_SYNCHRONOUS"
Content-Language: en-US, de-DE
To:     Doug Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <CAMi1Hd05z8uBotO4vs7Ropmt7W2gSA__tTu_=X1t0mze7bXrhg@mail.gmail.com>
 <CAD=FV=VSFDe445WEVTHXxU1WS_HGUV5jR5E8_Vgd4eyhn3rHyA@mail.gmail.com>
 <CAMi1Hd28FJUjB8A-9YF7xpKOzSyNWXX3qung4aDjpLBhOvw_eA@mail.gmail.com>
 <CAD=FV=W13L0H88G1gt8qRnXfpV-_7E9QfHufN_a23_B1bb=aww@mail.gmail.com>
 <CAMi1Hd1WCtNvNaY_kVMx5F8T0nMVHvsjk9LsSETCMWWQyaq_Vw@mail.gmail.com>
 <CAD=FV=W5Y_SHp0y2MEs8d1k255bm_PXdRYEmYei+g79pjnzYuA@mail.gmail.com>
 <CAMi1Hd2OeL940r7jq0=Z_oxE8MYVioy0YnJXQC_5e0vJONd2sQ@mail.gmail.com>
 <1bc79c48-7cba-476d-9a7e-5754a88fcdae@sirena.org.uk>
 <CAMi1Hd2BLB6H3QRLB5svRTkGoXaUeEsakNsmfCOjbDBcCEeqkA@mail.gmail.com>
 <CAD=FV=UKyjRNZG-ED2meUAR9aXdco+AbUTHiKixTzjCkaJbjTg@mail.gmail.com>
 <bb5c828a-b8c5-40a0-9b67-44e73abcbef0@sirena.org.uk>
 <CAD=FV=UXOse+yRUmZBUOkfpWXPRKBw2R-+BVzPGcuwwFV_VqQw@mail.gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <CAD=FV=UXOse+yRUmZBUOkfpWXPRKBw2R-+BVzPGcuwwFV_VqQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1686757026;ca67c72f;
X-HE-SMSGID: 1q9SYQ-0005oK-Ao
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thorsten here, the Linux kernel's regression tracker.

On 07.06.23 15:47, Doug Anderson wrote:
> 
> On Wed, Jun 7, 2023 at 6:18 AM Mark Brown <broonie@kernel.org> wrote:
>>
>> On Tue, Jun 06, 2023 at 04:29:29PM -0700, Doug Anderson wrote:
>>
>>> 2. Try adding some delays to some of the regulators with
>>> "regulator-enable-ramp-delay" and/or "regulator-settling-time-us".
>>> Without a scope, it'll be tricky to figure out exactly which
>>> regulators might need delays, but you could at least confirm if the
>>> "overkill" approach of having all the regulators have some delay
>>> helps... I guess you could also try putting a big delay for "ldo26".
>>> If that works, you could try moving it up (again using a bisect style
>>> approach) to see where the delay matters?
>>
>> This is information which should be in the datasheets for the part.
> 
> I was thinking more of something board-specific, not part specific. In
> theory with RPMH this is also all supposed to be abstracted out into
> the firmware code that sets up RPMH which magically takes care of
> things like this, but it certainly could be wrong.

/me waves friendly

That afaics was the last mail in this thread about a regression caused
by ad44ac082fd ("regulator: qcom-rpmh: Revert "regulator: qcom-rpmh: Use
PROBE_FORCE_SYNCHRONOUS"") from Doug; Amit's attempt to patch it (
https://lore.kernel.org/lkml/20230602161246.1855448-1-amit.pundir@linaro.org/
) also wasn't welcomed. Just like his earlier revert attempt
(https://lore.kernel.org/lkml/20230515145323.1693044-1-amit.pundir@linaro.org/
).

Does this mean this regression won't be addressed before 6.4 is
released? Or was there some progress and I just missed it? What should I
tell Linus in my next report?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke
