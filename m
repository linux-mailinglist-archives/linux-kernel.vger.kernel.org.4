Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA3973985F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjFVHrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjFVHrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:47:19 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664591A1;
        Thu, 22 Jun 2023 00:47:18 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qCF2B-0007GM-LL; Thu, 22 Jun 2023 09:47:15 +0200
Message-ID: <5240ce3f-37fa-2747-92ee-23d71619f3ef@leemhuis.info>
Date:   Thu, 22 Jun 2023 09:47:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-db845c: Move LVS regulator nodes
 up
Content-Language: en-US, de-DE
To:     Bjorn Andersson <andersson@kernel.org>,
        Doug Anderson <dianders@chromium.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Amit Pundir <amit.pundir@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20230602161246.1855448-1-amit.pundir@linaro.org>
 <358c69ad-fa8a-7386-fe75-92369883ee48@leemhuis.info>
 <0f6c9dcb-b7f6-fff9-6bed-f4585ea8e487@linaro.org>
 <CAD=FV=Xt2KYGY15+f+nHxkzKnwhHzw1A7=o+5kgCDWvHDv0DNg@mail.gmail.com>
 <20230620155902.clspxncyvpodixft@ripper>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230620155902.clspxncyvpodixft@ripper>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1687420038;6ef2419a;
X-HE-SMSGID: 1qCF2B-0007GM-LL
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

As Linus will likely release 6.4 on this or the following Sunday a quick
status inquiry so I can brief him appropriately: is there any hope the
regression this patch tried to fix will be resolved any time soon?
Doesn't look like it from below message and this thread, but maybe I
missed something.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

On 20.06.23 17:59, Bjorn Andersson wrote:
> On Wed, Jun 14, 2023 at 12:44:15PM -0700, Doug Anderson wrote:
>> Hi,
>>
>> On Wed, Jun 14, 2023 at 11:47 AM Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> On 14/06/2023 20:18, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>> On 02.06.23 18:12, Amit Pundir wrote:
>>>>> Move lvs1 and lvs2 regulator nodes up in the rpmh-regulators
>>>>> list to workaround a boot regression uncovered by the upstream
>>>>> commit ad44ac082fdf ("regulator: qcom-rpmh: Revert "regulator:
>>>>> qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS"").
>>>>>
>>>>> Without this fix DB845c fail to boot at times because one of the
>>>>> lvs1 or lvs2 regulators fail to turn ON in time.
>>>>
>>>> /me waves friendly
>>>>
>>>> FWIW, as it's not obvious: this...
>>>>
>>>>> Link: https://lore.kernel.org/all/CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com/
>>>>
>>>> ...is a report about a regression. One that we could still solve before
>>>> 6.4 is out. One I'll likely will point Linus to, unless a fix comes into
>>>> sight.
>>>>
>>>> When I noticed the reluctant replies to this patch I earlier today asked
>>>> in the thread with the report what the plan forward was:
>>>> https://lore.kernel.org/all/CAD%3DFV%3DV-h4EUKHCM9UivsFHRsJPY5sAiwXV3a1hUX9DUMkkxdg@mail.gmail.com/
>>>>
>>>> Dough there replied:
>>>>
>>>> ```
>>>> Of the two proposals made (the revert vs. the reordering of the dts),
>>>> the reordering of the dts seems better. It only affects the one buggy
>>>> board (rather than preventing us to move to async probe for everyone)
>>>> and it also has a chance of actually fixing something (changing the
>>>> order that regulators probe in rpmh-regulator might legitimately work
>>>> around the problem). That being said, just like the revert the dts
>>>> reordering is still just papering over the problem and is fragile /
>>>> not guaranteed to work forever.
>>>> ```
>>>>
>>>> Papering over obviously is not good, but has anyone a better idea to fix
>>>> this? Or is "not fixing" for some reason an viable option here?
>>>>
>>>
>>> I understand there is a regression, although kernel is not mainline
>>> (hash df7443a96851 is unknown) and the only solutions were papering the
>>> problem. Reverting commit is a temporary workaround. Moving nodes in DTS
>>> is not acceptable because it hides actual problem and only solves this
>>> one particular observed problem, while actual issue is still there. It
>>> would be nice to be able to reproduce it on real mainline with normal
>>> operating system (not AOSP) - with ramdiks/without/whatever. So far no
>>> one did it, right?
>>
>> The worry I have about the revert here is that it will never be able
>> to be undone and that doesn't seem great long term. I'm all for a
>> temporary revert to fix a problem while the root cause is understood,
>> but in this case I have a hard time believing that we'll make more
>> progress towards a root cause once the revert lands. All the
>> investigation we've done so far seems to indicate that the revert only
>> fixes the problem by luck...
>>
>> I completely agree that moving the nodes in the DTS is a hack and just
>> hides the problem. However, it also at least limits the workaround to
>> the one board showing the problem and doesn't mean we're stuck with
>> synchronous probe for rpmh-regulator for all eternity because nobody
>> can understand this timing issue on db845c.
>>
> 
> I agree that we shouldn't hide this by reverting the regulator change.
> 
> 
> And as has been stated a few times already, the symptom indicates that
> we have a misconfigured system.
> 
> Before accepting a patch just shuffling the bricks, I'd like to see some
> more analysis of what happens wrt the rpmh right before the timeout.
> Perhaps the landing team can assist here?
> 
> Regards,
> Bjorn
> 
> 
