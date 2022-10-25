Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A86360CA9A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbiJYLGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbiJYLGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:06:03 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07A595277;
        Tue, 25 Oct 2022 04:05:51 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g7so21261499lfv.5;
        Tue, 25 Oct 2022 04:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=88eGjzyDfT38xxLQ5tzZTIJyXDBq2UZPkg4oygmJ6Xs=;
        b=nQnGk41zUOGnL0XwktJ8A+LdeMW+WyEBdkft4DZCLlcCa6yqA3Mj+Op/lnW4p3p6Yx
         7PxJUkwm89QvnDhCmjYeWEM6T5uOaX2ERpROoC7VOwVvOVj6EyciBMiwLt0ldWQQ/189
         G+ZtDqzGXcaHeYRw/pmtkg9dvnvJc1XVN0HmKzz3ocUp4M8OLyDmUABrpyXYp6rsW8mO
         bxGkki9ZKJcukzE5x16ffXOQMn73TbbDeW5O8P9EkGGlwhIFuo+PbCLHpq5j+MPj4Wpm
         8jTv8lIlpVi1Bs+TAYkQqa8PiiOeP9WJmd2v/sSFQ3JNnCTr1TihqcDYtdHYIE9dBzTG
         h0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88eGjzyDfT38xxLQ5tzZTIJyXDBq2UZPkg4oygmJ6Xs=;
        b=TC5i7AuZTEh2nA6lBOhVIrMSKJ7mb4zscGNxOwSrGjKzFv0CdnPgUxCcU6kreQZ3YX
         MamikqtGLqQH1o8gdAzlRbYsy33J8J33KeQdTO0sqe27q8mWGiaHYx/EdL05zJesBvjG
         fc3ZhXLXGIImOOQAf1XIg64FMNBGEP1zATyBc0t/+0yJTFb2OxDydJdbcup4VQfyOZSn
         OKepDEMvr4DFzj4o2nudGS3NNlRCeU1ME4cDLkCkOwMy6NMcrEaluqV20c1Duj7LEROF
         5qmIoGAxbQI3CnPJR1p6esCEpsFGIOwCvR9nxxfRr/vuDzERMowJ7x3XVnt8Jq2Cr4t7
         auRg==
X-Gm-Message-State: ACrzQf0gtin1Al31J8y/+wuI14qxsAsABq463wkHxBhgXc1VIVRfuUax
        S3f8ywkboFuMDwARZXEQIdmN//MLEmSUNdm0Vhs=
X-Google-Smtp-Source: AMsMyM4qZhGiKIvdGHbTfUg/jiQtfEnkV7YeWxXZ6P6WnEiigTG5MCM9ndQQT5PV8BoesnTJdOrCfEmO5gqh+kre08s=
X-Received: by 2002:a19:ad03:0:b0:4a0:56ab:7148 with SMTP id
 t3-20020a19ad03000000b004a056ab7148mr14960143lfc.430.1666695950095; Tue, 25
 Oct 2022 04:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221014142454.871196-2-carlos.bilbao@amd.com>
 <48b4a5a1-2a52-4159-699b-9db73a012892@gmail.com> <Y01pkubcT7FOwCjL@casper.infradead.org>
 <8e2a1da1-2914-b223-85b0-a769339d9c39@gmail.com> <9e65ba16-68d3-8d11-c6ac-c35c29026688@amd.com>
 <Y1aovvn7dAyo1nuW@casper.infradead.org> <87a65lfdqb.fsf@meer.lwn.net> <875yg9fdbm.fsf@meer.lwn.net>
In-Reply-To: <875yg9fdbm.fsf@meer.lwn.net>
From:   Alex Shi <seakeel@gmail.com>
Date:   Tue, 25 Oct 2022 19:05:13 +0800
Message-ID: <CAJy-AmnskpBqTspQ-krCi66S960CowqqTfnrnbPeS_JnCoa2Vg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Documentation: Start translations to Spanish
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        Akira Yokosawa <akiyks@gmail.com>, bilbao@vt.edu,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        miguel.ojeda.sandonis@gmail.com,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 11:31 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
>
> Resending without the screwy address that my mailer decided to put in
> for Alex, sorry for the noise.

Thanks for having me.
I am neutral about the change, and prefer less churn for code.
But if we have to, zh_hant/hans is better then CN and TW to comfort
other regions, like zh_SG, zh_HK etc.

Thanks
Alex

>
> Jonathan Corbet <corbet@lwn.net> writes:
>
> > [Adding some of the other folks interested in translations]
> >
> > Matthew Wilcox <willy@infradead.org> writes:
> >
> >> I think we're better off following BCP 47:
> >> https://www.rfc-editor.org/info/bcp47 rather than the libc locale format.
> >> That will imply renaming it_IT to simply "it", ja_JP to "ja" and
> >> ko_KR to "ko".  The two Chinese translations we have might be called
> >> "zh-Hant" and "zh-Hans", if the distinction is purely Traditional vs
> >> Simplified script.  If they really are region based, then they'd be
> >> zh-CN and zh-TW.
> >>
> >> I think you're right to conflate all dialects of Spanish together, just
> >> as we do all dialects of English.
> >>
> >> Jon, this feels like policy you should be setting.  Are you on board
> >> with this, or do you want to retain the mandatory geography tag that
> >> we've been using up to now?
> >
> > I want to go hide somewhere :)
> >
> > I'd kind of prefer to avoid renaming the existing translations, as that
> > is sure to create a certain amount of short-term pain.  But I guess we
> > could do that if the benefit somehow seems worth it.
> >
> > Of course, if we're thrashing things, we could also just call them
> > "Italian" (or "Italiano"), "Chinese", and so on.  I don't *think*
> > there's a need for the names to be machine-readable.  We should stick
> > with ASCII for these names just to help those of us who can't type in
> > other scripts.
> >
> > If asked to set a policy today, my kneejerk reaction would be to leave
> > things as they are just to avoid a bunch of churn.  But I don't have a
> > strong opinion on how this naming should actually be done, as long as we
> > can pick something and be happy with it thereafter.  What do the
> > translation maintainers think?
> >
> > Thanks,
> >
> > jon
