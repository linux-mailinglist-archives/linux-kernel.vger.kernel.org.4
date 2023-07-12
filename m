Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7930575031A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjGLJal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjGLJai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:30:38 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA151FB;
        Wed, 12 Jul 2023 02:30:37 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qJWB7-0004Ip-WA; Wed, 12 Jul 2023 11:30:34 +0200
Message-ID: <a97a37bf-86b5-cd8e-a8ce-00e38720cee4@leemhuis.info>
Date:   Wed, 12 Jul 2023 11:30:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <cover.1689008220.git.linux@leemhuis.info>
 <2023071002-phrasing-tranquil-49d6@gregkh>
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [RFC PATCH v1 0/3] docs: stable-kernel-rules: add delayed
 backporting option and a few tweaks
In-Reply-To: <2023071002-phrasing-tranquil-49d6@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1689154237;3fac27df;
X-HE-SMSGID: 1qJWB7-0004Ip-WA
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.07.23 21:51, Greg KH wrote:
> On Mon, Jul 10, 2023 at 07:10:10PM +0200, Thorsten Leemhuis wrote:
>> This is a RFC and a bit rough for now. I only set down to create the
>> first of the three patches. But while doing so I noticed a few things
>> that seemed odd for me with my background on writing and editing texts.
>> So I just quickly performed a few additional changes to fix those to see
>> if the stable team would appreciate them, as this document is clearly
>> their domain.
>>
>> If those changes or even the initial patch are not welcomed, I'll simply
>> drop them. I'd totally understand this, as texts like these are delicate
>> and it's easy to accidentlly change the intent or the meaning while
>> adjusting things in good faith.
>>
>> At the same time I might be willing to do a few more changes, if people
>> like the direction this takes and want a bit more fine tuning.
> 
> I do like it, many thanks for taking the time to do this work, it's much
> appreciated.
>
> If you resend the first 2 as a non-RFC patch, 

BTW: thx again for your uplifting feedback! And in case anyone missed
it, I send those two patches out yesterday here:
https://lore.kernel.org/all/cover.1689056247.git.linux@leemhuis.info/

> the last one needs some more work as mentioned.

I have that one in a separate branch now and spitted into four patches;
the first three basically move text around, which results in a much
cleaner diff for the last patch that contains actual content changes.
While working on the latter I noticed one more thing:

```
    .. warning::
       The -stable-rc tree is a snapshot in time of the stable-queue
tree and
       will change frequently, hence will be rebased often. It should
only be
       used for testing purposes (e.g. to be consumed by CI systems).
```

That sounded a bit odd to me, as it will scare people away that want to
test stable -rc's using git; and I think it doesn't match current
practices. I'll thus likely change the text to something like this,
unless I'm missing something or someone has a better idea:
```
  .. warning::
     The branches in the -stable-rc tree are rebased each time a new -rc
     is released, as they are created by taking the latest release and
     applying the patches from the stable-queue on top.
```

Ciao, Thorsten
