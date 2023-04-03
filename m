Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3078F6D3B26
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 02:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjDCAj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 20:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDCAjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 20:39:25 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C1961AE;
        Sun,  2 Apr 2023 17:39:24 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 9AA57320094B;
        Sun,  2 Apr 2023 20:39:20 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Sun, 02 Apr 2023 20:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1680482360; x=1680568760; bh=o9/gTgTtxZDdobCbtphP2rM5o2FwK9EFZYs
        mc68loZo=; b=YZ+Y3UbgHiAwbPoAhCoVdoSZ2U+V+Qrf93NSPXiuKTYrtkYIltE
        wLfW1hnDTJc7Q8gTg96f+KC8Msr+o9OPBKRxxkrv7nWj/2LSvqnvwafhns3JRToj
        oz4h+Jy/LHOHMG44mV73fQ8Z+g6mUE5RELFob8rpgxvqQhNsKBKX6RV2Zwi6Tujn
        Jck0GtbMy4zEurUa1+FzTWIj8L8XohigisYG6uSmhJvP/NuuVF0MNuQ1SJJVk9bt
        dYhzQCZvhFi3NaV1vyCvEdDmaECzAMRQ8SckmIczNWr2+Hp8YsEYS4CAX+E5+SfW
        MEBpWHhUmGpSOEflZ59eS5yPW4ct1mXQY0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680482360; x=1680568760; bh=o9/gTgTtxZDdobCbtphP2rM5o2FwK9EFZYs
        mc68loZo=; b=WRS9LZ3TDOWSQSiC7tIRQBx+SgpHm2ETlqMUVZNN6QfmHg/9WnM
        ira8Kb2+j8xyA/fAAerJ0SUgUtDoapuIyhdBFmeB3ggMyk6s1cNLRL8ZJyM/2TWa
        gsJ4ZE5zRNJbHVyqoXV4ih6pmmJA99otHf3382eiPKIy3w6nIcPlS7F7VrlC5uum
        ApxyXV+rQALzz/JK2kduiiB19x0AVMYJ/FhxWDMjm4+J/kPmZfGy+QtBPH/JlXKa
        NMJ1TG8PXUXc8Mnzy+SFUNTK9zlP0hGvI396q9XcBUHhNLsLfjJyL2UeDDgTf/V/
        HAWOHE776+eUBghYq2LUc32FE0skXlbeuPA==
X-ME-Sender: <xms:NyAqZG7bRkfWUdSxWPTsdxirfcCHFQxhlcv7V2glGf0cpLiT99amPw>
    <xme:NyAqZP5drvea4qqbjK3DEPWVJhYmF2jnj22cKoHRpue5mFGoKkOcAKyFiHdEPC0mz
    PGZdzelAbr8i8xx23Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiiedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfo
    rghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsg
    gsrdgtrgeqnecuggftrfgrthhtvghrnhepfeejgedvudegvdekhedvffefjefhuedthfdt
    heehkeffuddvgfetjeegjeeufefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmphgvrghr
    shhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:NyAqZFeROP-QWgadU-vYxisoFHs2TSPK4hst7htJRZl38W-tVCq2Gg>
    <xmx:NyAqZDJ4wTAQvBsOORB0flIpx53aD1RT1WkkpuPOcW4lLck8cKBTcQ>
    <xmx:NyAqZKLduPrCtq1h_Bw-jqI15hGQydOpgqYJB23N9P6_VOMvxWttRg>
    <xmx:OCAqZMgSOLuhT6UNCWWIboZ_eCBKxZStkBUX84cIRtn6w6vLs5zx0g>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 22C80C60091; Sun,  2 Apr 2023 20:39:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <251eeef8-cba5-4b3c-89c2-525cac0d6829@app.fastmail.com>
In-Reply-To: <ea9b0d97-ddf6-cc22-652f-dde1ec6c1e89@amd.com>
References: <mpearson-lenovo@squebb.ca>
 <20230401184345.208960-1-mpearson-lenovo@squebb.ca>
 <f2bbd848-2079-d5cb-6a59-9040708dc429@amd.com>
 <dfd65bd6-26d8-4ef4-8eaa-3cc412f381ec@app.fastmail.com>
 <ea9b0d97-ddf6-cc22-652f-dde1ec6c1e89@amd.com>
Date:   Sun, 02 Apr 2023 20:38:58 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Hans de Goede" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "Armin Wolf" <W_Armin@gmx.de>,
        "Mirsad Goran Todorovac" <mirsad.todorovac@alu.unizg.hr>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] platform/x86: think-lmi: Fix memory leaks when parsing
 ThinkStation WMI strings
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 2, 2023, at 6:17 PM, Limonciello, Mario wrote:
> On 4/2/2023 14:23, Mark Pearson wrote:
>> Hi Mario
>>=20
>> On Sun, Apr 2, 2023, at 10:04 AM, Mario Limonciello wrote:
>>> On 4/1/23 13:43, Mark Pearson wrote:
>>>
>>>> My previous commit introduced a memory leak where the item allocated
>>>> from tlmi_setting was not freed.
>>>> This commit also renames it to avoid confusion with the similarly n=
ame
>>>> variable in the same function.
>>>>
>>>> Fixes: 8a02d70679fc ("platform/x86: think-lmi: Add possible_values =
for ThinkStation")
>>>> Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
>>>> Link: https://lore.kernel.org/lkml/df26ff45-8933-f2b3-25f4-6ee51ccd=
a7d8@gmx.de/T/
>>>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>>> ---
>>>> This patch series builds on top of the proposed patch from Armin Wo=
lf
>>>> "platform/x86: think-lmi: Fix memory leak when showing current sett=
ings"
>>>
>>> Which version of the patch did you do it from?=C2=A0 I tried to appl=
y v3 of
>>> Armin's patch
>>> to Linus' tree and then apply these two.
>>>
>>> The first applied, but the second had conflicts.=C2=A0 Here was my b=
ase (with
>>> patch 1 in
>>> this series applied).
>>=20
>> I was using v2 - but there shouldn't be any code changes between v3 a=
nd v2....so I hadn't re-based.
>>=20
>> I'm working in the fixes branch from pdx86.git (with the aim of makin=
g it easier for Hans to pull in the patches). It's possible I've goofed =
somehow...though not sure how :(
>>=20
>> I'll go double check - but likely won't be until tomorrow I'm afraid.=
 I should probably just wait for the patch to be accepted and then work =
from there....
>>=20
>> Mark
>
> Hmm, I just tried on platform-x86/for-next.
> commit e3271a5917d1501089b1a224d702aa053e2877f4 (tag:=20
> platform-drivers-x86-v6.3-4, platform-x86/fixes)
>
> I get the same problem there.  I just applied Armin's single v3 patch=20
> and then tried your series.

You're absolutely right...it doesn't apply if I start again from clean.=20
I have no idea why - it must have been something I did when applying the=
 patch in the first place but I'm at a loss as to what. Urgh :(

I'm regenerating the patch and will resend as a v2. Just going to run so=
me tests as a sanity check first.=20

Mark
