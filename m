Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F7E747E4F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjGEHci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjGEHc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:32:29 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BD01730
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 00:32:17 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Qwrvv6xkyz9sV2;
        Wed,  5 Jul 2023 09:32:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1688542332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AI3DGocrXf4ttby1kzh2+9/oP52TyrsDM0oPFJNnpR0=;
        b=sgewxDbBdS996EyKm8U6X/8anuMRbQ8VjPnqprCXd4dyVeRJOLG13jnSxMIVnaeAVDsdss
        VBoCThwuBa64zHroQXzWXF87f5IAG/RsP0CAHvcOad128Pp8MX+BJRipAicFg4Gam5fMzf
        8FfKGn0nEOj24pu04SdK5MhrZ/zF+ipk+JqMqpkz275mWKv5OqqzfgUokf5m+ABbACNUBu
        fnczHN/s2/mt9CQTGTqV/YiSftKH74/kJbnwWXBRK21+UkmocQ3ccr08edwmEHkkIwIxbC
        e3PWVgUxKrdWQKOYXCcUmmmJRYouthQkZ9quoIFHyjIVkBP7szPKRj8b+D26ew==
Message-ID: <2f993fe4-8e95-4a67-c2f1-6adc2c431834@mailbox.org>
Date:   Wed, 5 Jul 2023 09:32:07 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v5 1/1] drm/doc: Document DRM device reset expectations
To:     =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Cc:     Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
        Sebastian Wick <sebastian.wick@redhat.com>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        =?UTF-8?Q?Timur_Krist=c3=b3f?= <timur.kristof@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        kernel-dev@igalia.com,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20230627132323.115440-1-andrealmeid@igalia.com>
 <CA+hFU4z1pc=KUVVqyqfXEceUqMXQgh-qUnuB=1nkPELghvQO7w@mail.gmail.com>
 <CADnq5_MNVdtdcWKSz6dgmsjg+kEu8p5FVE+fkw_5BaXeG3QGow@mail.gmail.com>
 <afab1f5a-e581-3416-e2c2-238ea120655b@mailbox.org>
 <CAAxE2A5C96k5ua+r938VA_+w7gHHNTdF3n8LwDb98W0Bf9wCVA@mail.gmail.com>
 <7c1e6df5-1ad4-be3c-b95d-92dc62a8c537@mailbox.org>
 <CAAxE2A7RGDY4eRC85CsqfszNzyKvMU2MX1wa+3HZ1hgNeAw3cQ@mail.gmail.com>
 <cb0b6b51-3a94-481b-26a1-89ff398d7835@mailbox.org>
 <CAAxE2A7tNCWkL_M2YcE=RN+nqqcokgBR4hcD2sR3fGAY2t4uLg@mail.gmail.com>
Content-Language: de-CH-frami, en-CA
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <CAAxE2A7tNCWkL_M2YcE=RN+nqqcokgBR4hcD2sR3fGAY2t4uLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: c89kr5mge4ooe33mb7f4cpob9d4ckzwh
X-MBO-RS-ID: a9c4f1c5cb80503d0a6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/23 08:30, Marek Olšák wrote:
> On Tue, Jul 4, 2023, 03:55 Michel Dänzer <michel.daenzer@mailbox.org> wrote:
>     On 7/4/23 04:34, Marek Olšák wrote:
>     > On Mon, Jul 3, 2023, 03:12 Michel Dänzer <michel.daenzer@mailbox.org > wrote:
>     >     On 6/30/23 22:32, Marek Olšák wrote:
>     >     > On Fri, Jun 30, 2023 at 11:11 AM Michel Dänzer <michel.daenzer@mailbox.org> wrote:
>     >     >> On 6/30/23 16:59, Alex Deucher wrote:
>     >     >>> On Fri, Jun 30, 2023 at 10:49 AM Sebastian Wick
>     >     >>> <sebastian.wick@redhat.com <mailto:sebastian.wick@redhat.com> wrote:
>     >     >>>> On Tue, Jun 27, 2023 at 3:23 PM André Almeida <andrealmeid@igalia.com> wrote:
>     >     >>>>>
>     >     >>>>> +Robustness
>     >     >>>>> +----------
>     >     >>>>> +
>     >     >>>>> +The only way to try to keep an application working after a reset is if it
>     >     >>>>> +complies with the robustness aspects of the graphical API that it is using.
>     >     >>>>> +
>     >     >>>>> +Graphical APIs provide ways to applications to deal with device resets. However,
>     >     >>>>> +there is no guarantee that the app will use such features correctly, and the
>     >     >>>>> +UMD can implement policies to close the app if it is a repeating offender,
>     >     >>>>> +likely in a broken loop. This is done to ensure that it does not keep blocking
>     >     >>>>> +the user interface from being correctly displayed. This should be done even if
>     >     >>>>> +the app is correct but happens to trigger some bug in the hardware/driver.
>     >     >>>>
>     >     >>>> I still don't think it's good to let the kernel arbitrarily kill
>     >     >>>> processes that it thinks are not well-behaved based on some heuristics
>     >     >>>> and policy.
>     >     >>>>
>     >     >>>> Can't this be outsourced to user space? Expose the information about
>     >     >>>> processes causing a device and let e.g. systemd deal with coming up
>     >     >>>> with a policy and with killing stuff.
>     >     >>>
>     >     >>> I don't think it's the kernel doing the killing, it would be the UMD.
>     >     >>> E.g., if the app is guilty and doesn't support robustness the UMD can
>     >     >>> just call exit().
>     >     >>
>     >     >> It would be safer to just ignore API calls[0], similarly to what is done until the application destroys the context with robustness. Calling exit() likely results in losing any unsaved work, whereas at least some applications might otherwise allow saving the work by other means.
>     >     >
>     >     > That's a terrible idea. Ignoring API calls would be identical to a freeze. You might as well disable GPU recovery because the result would be the same.
>     >
>     >     No GPU recovery would affect everything using the GPU, whereas this affects only non-robust applications.
>     >
>     > which is currently the majority.
> 
>     Not sure where you're going with this. Applications need to use robustness to be able to recover from a GPU hang, and the GPU needs to be reset for that. So disabling GPU reset is not the same as what we're discussing here.
> 
> 
>     >     > - non-robust contexts: call exit(1) immediately, which is the best way to recover
>     >
>     >     That's not the UMD's call to make.
>     >
>     > That's absolutely the UMD's call to make because that's mandated by the hw and API design
> 
>     Can you point us to a spec which mandates that the process must be killed in this case?
> 
> 
>     > and only driver devs know this, which this thread is a proof of. The default behavior is to skip all command submission if a non-robust context is lost, which looks like a freeze. That's required to prevent infinite hangs from the same context and can be caused by the side effects of the GPU reset itself, not by the cause of the previous hang. The only way out of that is killing the process.
> 
>     The UMD killing the process is not the only way out of that, and doing so is overreach on its part. The UMD is but one out of many components in a process, not the main one or a special one. It doesn't get to decide when the process must die, certainly not under circumstances where it must be able to continue while ignoring API calls (that's required for robustness).
> 
> 
> You're mixing things up. Robust apps don't any special action from a UMD. Only non-robust apps need to be killed for proper recovery with the only other alternative being not updating the window/screen,

I'm saying they don't "need" to be killed, since the UMD must be able to keep going while ignoring API calls (or it couldn't support robustness). It's a choice, one which is not for the UMD to make.


> Also it's already used and required by our customers on Android because killing a process returns the user to the desktop screen and can generate a crash dump instead of keeping the app output frozen, and they agree that this is the best user experience given the circumstances.

Then some appropriate Android component needs to make that call. The UMD is not it.


>     >     >>     [0] Possibly accompanied by a one-time message to stderr along the lines of "GPU reset detected but robustness not enabled in context, ignoring OpenGL API calls".


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

