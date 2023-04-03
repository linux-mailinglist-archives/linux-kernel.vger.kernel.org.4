Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B03D6D3D60
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 08:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjDCGcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 02:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDCGcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 02:32:23 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760EC172B;
        Sun,  2 Apr 2023 23:32:22 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pjDjk-0004mY-CR; Mon, 03 Apr 2023 08:32:16 +0200
Message-ID: <8d55f6e3-b573-7f63-bfed-4aa73bdc473a@leemhuis.info>
Date:   Mon, 3 Apr 2023 08:32:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] Revert "venus: firmware: Correct non-pix start and end
 addresses"
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Leonard Lausen <leonard@lausen.nl>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Vikash Garodia <vgarodia@qti.qualcomm.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mka@chromium.org,
        Albert Esteve <aesteve@redhat.com>,
        stanimir.varbanov@linaro.org,
        Enric Balletbo i Serra <eballetb@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Vikash Garodia (QUIC)" <quic_vgarodia@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        Fritz Koenig <frkoenig@google.com>,
        "Rajeshwar Kurapaty (QUIC)" <quic_rkurapat@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
References: <87edq2dus1.fsf@minerva.mail-host-address-is-not-set>
 <ef09bc9f-d570-be11-238b-bd34063917fc@redhat.com>
 <70c01751-1dd7-c4bd-a96e-94dea437aa40@redhat.com>
 <DM8PR02MB81696369DBFE619E43F81EEFF3DE9@DM8PR02MB8169.namprd02.prod.outlook.com>
 <e87344c6-acef-7f3f-5cac-24961dbd9401@redhat.com>
 <6f97a117-0d9c-e21b-9adf-50f2233ba9e3@leemhuis.info>
 <ea283f0a-ca72-447e-ce87-68c1bbee793e@leemhuis.info>
 <CAFOAJEdBbzqkGVqw+vgNYNxyaTHwvjFyskTwjycP820L2tOctA@mail.gmail.com>
 <b548da46-bf91-6f1c-4b63-4002109056bc@leemhuis.info>
 <9a0bfef8-0b5d-f4d0-a8a5-4bbcacc5c0fb@leemhuis.info>
 <DM8PR02MB8169E16569616870A583B376F3AB9@DM8PR02MB8169.namprd02.prod.outlook.com>
 <87356wn6xf.fsf@minerva.mail-host-address-is-not-set>
 <87edq9hj4w.fsf@minerva.mail-host-address-is-not-set>
 <d18fac76-6b77-a446-5fe0-7236556e9187@quicinc.com>
 <0c84724d-08d4-ddcb-5f71-4eb8261240c6@quicinc.com>
 <a2fec0a5855150966fa5a920216c205032965f98@lausen.nl>
 <12c5a8f2-3082-68a2-e973-18fb957068ac@leemhuis.info>
In-Reply-To: <12c5a8f2-3082-68a2-e973-18fb957068ac@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1680503542;a339c812;
X-HE-SMSGID: 1pjDjk-0004mY-CR
X-Spam-Status: No, score=-2.4 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.04.23 07:02, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 01.04.23 22:53, Leonard Lausen wrote:
>>
>> the revert wasn't applied to v6.2 series. Can you please apply it and include it for v6.2.10?

I pointed Linus to this and he merged the revert directly; and it's
already queued for the next 6.2.y release:

https://lore.kernel.org/all/CAHk-%3DwhRs_MavKCqtV3%3DK31dq9Z6HzbaG8Uxo-EV%3DuRxdsXduA@mail.gmail.com/
https://git.kernel.org/torvalds/c/f95b8ea79c47c0ad3d18f45ad538f9970e414d1f
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=902f9eb696dfdd40e88d99bafa34ea25f1f9e927

Now to the remaining venus regression:

>> March 6, 2023 at 5:43 AM, "Javier Martinez Canillas" <javierm@redhat.com> wrote:
>>>> On 3/1/2023 3:15 PM, Dikshita Agarwal wrote:
>>>>> On 2/28/2023 9:33 PM, Javier Martinez Canillas wrote:
>>>>>> Javier Martinez Canillas<javierm@redhat.com>  writes:
>>>>>>> Vikash Garodia<vgarodia@qti.qualcomm.com>  writes:
>>>>>>>
>>>>>>>> Stan, could you please help with the revert and a pull request having this revert
>>>>>>>> alongwith other pending changes ?
>>>>>>>>
>>>>>>> Other fix posted is "media: venus: dec: Fix capture formats enumeration order":
>>>>>>>
>>>>>>> https://patchwork.kernel.org/project/linux-media/patch/20230210081835.2054482-1-javierm@redhat.com/
>>>>
>>>> Hi Javier,
>>>>
>>>> Thanks for this patch "media: venus: dec: Fix capture formats
>>>> enumeration order".
>>>>
>>>> Somehow I can't find it in my mailbox to be able to reply there.
>>>>
>>>> Could you please explain what is the regression you see here?
>>>>
>>>
>>> You can find the thread and explanation of the issue here:
>>>
>>> https://lore.kernel.org/lkml/Y+KPW18o%2FDa+N8UI@google.com/T/
>>>
>>> But Stanimir already picked it and sent a PR for v6.3 including it.
>>
>> While "media: venus: dec: Fix capture formats enumeration order" may have been
>> applied to v6.3,
> 
> To me it looks like it was submitted[1], but not yet applied even to the
> media tree[2] -- while guess, maybe due problems mentioned in[3]? Or am
> I missing something?
> 
> [1]
> https://lore.kernel.org/all/20230329211655.100276-1-stanimir.k.varbanov@gmail.com/
> [2] https://git.linuxtv.org/media_tree.git/log/?h=fixes
> [3]
> https://lore.kernel.org/all/20230329214310.2503484-1-jenkins@linuxtv.org/

I only notice now: from [1] above it looks like that regression fix was
applied to a tree that seems to be intended for 6.4. Is that okay for
everybody, or should we ask Linus to pick this up as well (unless of
course Mauro shows up and forwards the patch, of course)? They fix a
regression from 5.19 afaics, so not a fresh problem, but apparently one
that bugged a few people recently.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
