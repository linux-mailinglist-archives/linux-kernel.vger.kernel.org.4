Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE9A74888B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjGEPyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbjGEPyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:54:46 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F9D173E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:54:34 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbc77e76abso69336485e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 08:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688572473; x=1691164473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CZyzkzUMz1fXOQ881Ov7Y8cjX9OK+wAcM/N2Fl/7tk=;
        b=kpM+idAhMrvaBCu3Jtyd7+ErrWLoeJDtMOQaFwhQp23JjMJSxNpiF1Lbk3Jc8/DtTW
         O59rBXU+xgMzhOLHzH+i0EDlbz+zcEhI5mOAZxNq2en000xXCuE2yf9FHZtanNCKmja1
         TOwJftcnxSCl446i40J3UYq369wwjI1xX2uzErTlNzA8fV4DHRr2HHPoyU1UiTjz4545
         8EiwXG0XfUersmCjwJVPo8zr/L9gW3Y4yzphuldGbLw3PWc6FGrUSdH77t0PrziVNkla
         YaoXri8GlT17+Ql6BNF9VUritkFICJUFa5yZpj0ZanK40JTZQPRvIDt+xe+OgRGsetZi
         7FMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688572473; x=1691164473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CZyzkzUMz1fXOQ881Ov7Y8cjX9OK+wAcM/N2Fl/7tk=;
        b=cUbg9khguDbdjSr98jFi0wHHHacBGUH7bTb3epgNbbO9oh3sJa3e4Fd/qjtyfyj1rE
         cBoA0z6Ju6xtOTe5HsvCZbpT0DifEk8iPVubWZB30KD9EKTLduOTLMHcCJiH0qeDUxkK
         GECuy8nQlI0YF+PzRhvK+oq6q5Roa9pG6spRSmAIpNT5vIMjV8bUT3vAbokwVhPZgrRv
         tQAC1fLQ0UuyRgZNunI/Jpn3hNRuPitMQCms2z2ozWMkLEX4h9ve28NzCf1fJhCwTfZX
         /O2giOY6plOl2hN158RDkkubi9dS2MhrcjZX/KoB9NSpeZJuOSXYXfL7dTGa3ZWv3QZz
         C6+A==
X-Gm-Message-State: AC+VfDzeU/72lRc0eHYfo4GcCyv3JSWVpVI+O37EwbdXtZ5yrihVQfnb
        1DuOAFqbj2GfmsNaFPEuD8J78bir5BRWzGP6RPA=
X-Google-Smtp-Source: ACHHUZ51AikI0ltda0xwrPKgoViozpgiEIbk+gOp/vo8TXgdd+WFbbHp/gUy/0NYhbIg0aXGMaMdMNMvUMACRwo68Mc=
X-Received: by 2002:a05:600c:24d:b0:3f7:f884:7be3 with SMTP id
 13-20020a05600c024d00b003f7f8847be3mr13750491wmj.4.1688572472427; Wed, 05 Jul
 2023 08:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230627132323.115440-1-andrealmeid@igalia.com>
 <CA+hFU4z1pc=KUVVqyqfXEceUqMXQgh-qUnuB=1nkPELghvQO7w@mail.gmail.com>
 <CADnq5_MNVdtdcWKSz6dgmsjg+kEu8p5FVE+fkw_5BaXeG3QGow@mail.gmail.com>
 <afab1f5a-e581-3416-e2c2-238ea120655b@mailbox.org> <CAAxE2A5C96k5ua+r938VA_+w7gHHNTdF3n8LwDb98W0Bf9wCVA@mail.gmail.com>
 <7c1e6df5-1ad4-be3c-b95d-92dc62a8c537@mailbox.org> <CAAxE2A7RGDY4eRC85CsqfszNzyKvMU2MX1wa+3HZ1hgNeAw3cQ@mail.gmail.com>
 <cb0b6b51-3a94-481b-26a1-89ff398d7835@mailbox.org> <CAAxE2A7tNCWkL_M2YcE=RN+nqqcokgBR4hcD2sR3fGAY2t4uLg@mail.gmail.com>
 <2f993fe4-8e95-4a67-c2f1-6adc2c431834@mailbox.org>
In-Reply-To: <2f993fe4-8e95-4a67-c2f1-6adc2c431834@mailbox.org>
From:   =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date:   Wed, 5 Jul 2023 11:53:56 -0400
Message-ID: <CAAxE2A7s2ANMGkFizMJda4nzQO1Wi+oxkST0xZ2KgBM6wYXA5w@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] drm/doc: Document DRM device reset expectations
To:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc:     Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
        Sebastian Wick <sebastian.wick@redhat.com>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        kernel-dev@igalia.com,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 3:32=E2=80=AFAM Michel D=C3=A4nzer <michel.daenzer@m=
ailbox.org> wrote:
>
> On 7/5/23 08:30, Marek Ol=C5=A1=C3=A1k wrote:
> > On Tue, Jul 4, 2023, 03:55 Michel D=C3=A4nzer <michel.daenzer@mailbox.o=
rg> wrote:
> >     On 7/4/23 04:34, Marek Ol=C5=A1=C3=A1k wrote:
> >     > On Mon, Jul 3, 2023, 03:12 Michel D=C3=A4nzer <michel.daenzer@mai=
lbox.org > wrote:
> >     >     On 6/30/23 22:32, Marek Ol=C5=A1=C3=A1k wrote:
> >     >     > On Fri, Jun 30, 2023 at 11:11=E2=80=AFAM Michel D=C3=A4nzer=
 <michel.daenzer@mailbox.org> wrote:
> >     >     >> On 6/30/23 16:59, Alex Deucher wrote:
> >     >     >>> On Fri, Jun 30, 2023 at 10:49=E2=80=AFAM Sebastian Wick
> >     >     >>> <sebastian.wick@redhat.com <mailto:sebastian.wick@redhat.=
com> wrote:
> >     >     >>>> On Tue, Jun 27, 2023 at 3:23=E2=80=AFPM Andr=C3=A9 Almei=
da <andrealmeid@igalia.com> wrote:
> >     >     >>>>>
> >     >     >>>>> +Robustness
> >     >     >>>>> +----------
> >     >     >>>>> +
> >     >     >>>>> +The only way to try to keep an application working aft=
er a reset is if it
> >     >     >>>>> +complies with the robustness aspects of the graphical =
API that it is using.
> >     >     >>>>> +
> >     >     >>>>> +Graphical APIs provide ways to applications to deal wi=
th device resets. However,
> >     >     >>>>> +there is no guarantee that the app will use such featu=
res correctly, and the
> >     >     >>>>> +UMD can implement policies to close the app if it is a=
 repeating offender,
> >     >     >>>>> +likely in a broken loop. This is done to ensure that i=
t does not keep blocking
> >     >     >>>>> +the user interface from being correctly displayed. Thi=
s should be done even if
> >     >     >>>>> +the app is correct but happens to trigger some bug in =
the hardware/driver.
> >     >     >>>>
> >     >     >>>> I still don't think it's good to let the kernel arbitrar=
ily kill
> >     >     >>>> processes that it thinks are not well-behaved based on s=
ome heuristics
> >     >     >>>> and policy.
> >     >     >>>>
> >     >     >>>> Can't this be outsourced to user space? Expose the infor=
mation about
> >     >     >>>> processes causing a device and let e.g. systemd deal wit=
h coming up
> >     >     >>>> with a policy and with killing stuff.
> >     >     >>>
> >     >     >>> I don't think it's the kernel doing the killing, it would=
 be the UMD.
> >     >     >>> E.g., if the app is guilty and doesn't support robustness=
 the UMD can
> >     >     >>> just call exit().
> >     >     >>
> >     >     >> It would be safer to just ignore API calls[0], similarly t=
o what is done until the application destroys the context with robustness. =
Calling exit() likely results in losing any unsaved work, whereas at least =
some applications might otherwise allow saving the work by other means.
> >     >     >
> >     >     > That's a terrible idea. Ignoring API calls would be identic=
al to a freeze. You might as well disable GPU recovery because the result w=
ould be the same.
> >     >
> >     >     No GPU recovery would affect everything using the GPU, wherea=
s this affects only non-robust applications.
> >     >
> >     > which is currently the majority.
> >
> >     Not sure where you're going with this. Applications need to use rob=
ustness to be able to recover from a GPU hang, and the GPU needs to be rese=
t for that. So disabling GPU reset is not the same as what we're discussing=
 here.
> >
> >
> >     >     > - non-robust contexts: call exit(1) immediately, which is t=
he best way to recover
> >     >
> >     >     That's not the UMD's call to make.
> >     >
> >     > That's absolutely the UMD's call to make because that's mandated =
by the hw and API design
> >
> >     Can you point us to a spec which mandates that the process must be =
killed in this case?
> >
> >
> >     > and only driver devs know this, which this thread is a proof of. =
The default behavior is to skip all command submission if a non-robust cont=
ext is lost, which looks like a freeze. That's required to prevent infinite=
 hangs from the same context and can be caused by the side effects of the G=
PU reset itself, not by the cause of the previous hang. The only way out of=
 that is killing the process.
> >
> >     The UMD killing the process is not the only way out of that, and do=
ing so is overreach on its part. The UMD is but one out of many components =
in a process, not the main one or a special one. It doesn't get to decide w=
hen the process must die, certainly not under circumstances where it must b=
e able to continue while ignoring API calls (that's required for robustness=
).
> >
> >
> > You're mixing things up. Robust apps don't any special action from a UM=
D. Only non-robust apps need to be killed for proper recovery with the only=
 other alternative being not updating the window/screen,
>
> I'm saying they don't "need" to be killed, since the UMD must be able to =
keep going while ignoring API calls (or it couldn't support robustness). It=
's a choice, one which is not for the UMD to make.
>
>
> > Also it's already used and required by our customers on Android because=
 killing a process returns the user to the desktop screen and can generate =
a crash dump instead of keeping the app output frozen, and they agree that =
this is the best user experience given the circumstances.
>
> Then some appropriate Android component needs to make that call. The UMD =
is not it.

We can change it once Android and Linux have a better way to handle
non-robust apps. Until then, generating a core dump after a GPU crash
produces the best outcome for users and developers.

Marek
