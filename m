Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BF3636A42
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238056AbiKWTzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239220AbiKWTzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:55:12 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F65D06C9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:53:38 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id F03CD32008FF;
        Wed, 23 Nov 2022 14:53:35 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 23 Nov 2022 14:53:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1669233215; x=1669319615; bh=L+4cp1X5OZ
        Nxuidf7VMRlD3A4ZgOp/CEmLqxx3dSlT8=; b=jkzvdh+bbVTNOMZDBxLUUFDTn5
        4ACXUVRl12OuaLLCC3lso46UqnGoZ8q+AUgfd7iM4RbUaMTXRlt3+wOmCGhL+IDA
        OUWmPn8WDejRSHaTS1uxG0zHa73EI2nZxNgz6zJ6Mw9uz37A9Em99q+E5ys3CJwq
        KH9RtDMD3RUOx5bWga6NMKVRM//XBr6bnMlmEmgLahX6IkgKhNX7YL9V+hAmobDQ
        zqDEsR1YRiD41xcv2RtKttG0Hg/IRE0oIo6AwbquDK7MBQipU6ImM599nyzXcNQ2
        rf3nETq3sdLTg4lb690mtZN+4wUWX/LoV1Egm5nCl1ZT2wmSJ53EbWXklrGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669233215; x=1669319615; bh=L+4cp1X5OZNxuidf7VMRlD3A4ZgO
        p/CEmLqxx3dSlT8=; b=YiTeNceAT+MSaMo+MlM7uvYLWI0S7BEk19shm7z7h3Lg
        RT6PlfXEKDgZv801NLzsA/QnCsqkrU14wmrtZecqaQUJeXAQtIjWCvzgWYPpJDxR
        5DiAwY3bPO1M5bJkok8wCZ+zrdgbYsRMax4NrDQzEQC+YMt6QQTMlSjTMGLn+ZdC
        s66dXEkRok0pcmYW/luqR/GMp3UL+WUmjSyDleKQntCLlfD1v+4I4E5d3ZiO5uOt
        ZsqBYszEJDuIqEcAqMKuwIko9PtxyZ3LXAzMWqlwm+fiwNjtoxrn4890TbJJcuYc
        jh4mx/DHK8KKdmYfMkzUsLqVNk3GxCbkbAOqp7Ebjg==
X-ME-Sender: <xms:P3p-Yx1Fx1VG_D92A6FX3cX77-rCaap8x8yduRckOTgW8hQiFWfNog>
    <xme:P3p-Y4GXorJlEA5zVk0CphNjYYUcAOnxf1IekZBF8dGw3iJc7zs1ADjuV2n5X3_HB
    rb-6nucrIdTy72Oc2o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedriedugdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:P3p-Yx7ApKMwuvofMF2eNXAnkxVgCcHh1CLT97ayrtKdcuP1fK9YLg>
    <xmx:P3p-Y-0sTBY2Mf6L9rzlMWAcOCZT7rX0NX9DFP9THIiQsrZ5A-6NoQ>
    <xmx:P3p-Y0HTixv-jSU72KSX9mo_LveQU5sHXcaKYK44cuRtTr0rRNxCAw>
    <xmx:P3p-Y5Snawm3j--pmFOAwfbJHSGvg8v_xHuVe517YIRWEdEt41iHow>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F3EF2B60086; Wed, 23 Nov 2022 14:53:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <7d95f4bb-01a3-44db-af08-275daa9ffb1e@app.fastmail.com>
In-Reply-To: <CANDhNCqCYkv7Ja4RT2_DEPh2zFFL+SD82wru_FC6dupCo6_4RA@mail.gmail.com>
References: <20221121055345.111567-1-jake.macneal@gmail.com>
 <CANDhNCqCYkv7Ja4RT2_DEPh2zFFL+SD82wru_FC6dupCo6_4RA@mail.gmail.com>
Date:   Wed, 23 Nov 2022 20:53:14 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "John Stultz" <jstultz@google.com>,
        "Jacob Macneal" <jake.macneal@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Stephen Boyd" <sboyd@kernel.org>
Subject: Re: [PATCH] time: copy tai value (International Atomic Time, in seconds) to
 output __user struct in get_old_timex32().
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022, at 19:54, John Stultz wrote:
> On Sun, Nov 20, 2022 at 9:54 PM Jacob Macneal <jake.macneal@gmail.com> wrote:
>>
>> Previously, this value was not copied into the output struct. This is
>> despite all other fields of the corresponding __kernel_timex struct being
>> copied to the old_timex32 __user struct in this function.
>>
>> Additionally, the matching function put_old_timex32() expects a tai value
>> to be supplied, and copies it appropriately. It would appear to be a
>> mistake that this value was never copied over in get_old_timex32().
>>
>> Signed-off-by: Jacob Macneal <jake.macneal@gmail.com>
>> ---
>>  kernel/time/time.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/time/time.c b/kernel/time/time.c
>> index 526257b3727c..7da9951b033a 100644
>> --- a/kernel/time/time.c
>> +++ b/kernel/time/time.c
>> @@ -311,6 +311,7 @@ int get_old_timex32(struct __kernel_timex *txc, const struct old_timex32 __user
>>         txc->calcnt = tx32.calcnt;
>>         txc->errcnt = tx32.errcnt;
>>         txc->stbcnt = tx32.stbcnt;
>> +       txc->tai = tx32.tai;
>>
>
> This does seem like something that was overlooked.
>
> Arnd: There isn't something more subtle I'm missing here, right?

I agree. Looking at the git history, it seems that the tai field
was added a long time ago in 153b5d054ac2 ("ntp: support for TAI").
The commit correctly did the conversion for copying the data out
of the kernel and did not copy the value in because it wasn't
needed at the time.

I don't see any user of the tai field that gets copied into
the kernel, so the bug appears harmless, but Jacob's fix is
nevertheless correct, as we should not use any uninitialized
data in a structure that comes from userspace.

> Otherwise:
>   Acked-by: John Stultz <jstultz@google.com>
>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
