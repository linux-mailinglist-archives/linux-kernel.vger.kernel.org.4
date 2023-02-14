Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B4369567A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 03:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjBNCMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 21:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjBNCMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 21:12:49 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D46E1B312
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 18:12:47 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id f34so21534509lfv.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 18:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kMCxMCH1L4+9cT1pHLsHNKKaq2cQehscaOSyrMTKpDA=;
        b=ZBJ+0dq/wxiH3SUO7h6vKVAibQexGg9B9eGIINUtojj/8hW8hFZBfirZeJeFrn4Wep
         id4Kutu0gP7SJdyz/Q9Gjd3qbBXn+BuNpt6xNB66d7aNCSLSZZEu4IjUgC/8Gq4xTR4V
         CJrXV/McNb1v6gGT4vUeo5DwXYiQaDEB8SiPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kMCxMCH1L4+9cT1pHLsHNKKaq2cQehscaOSyrMTKpDA=;
        b=kMyAY+sPI4gqKTmKH4Y3N7wQqhRfNnDky8FboG1FGaNYy0DzMNNHW/SIQcfwCe6iKh
         21yhhvSGfBjFOy38OtNRzAD/P0TJJ52P8n8LQXDvgUwxv0mw0Gae1m/HPxhft2IqpEQr
         owGEuQ8XrNzy3By7aTuam6kqHHSerTXTY2tioUx6B5KirSHzqq2kykAb8sEQekgmGl5I
         Hcnw71nXv3ZH6ULrJZbwDwsoF7U5lRlw+ZdbfZka7+wwX9CNe+HguTuBulqq1nh45Ax3
         QdC6jxo9rlXTfRNmbenXvFRHiJlPkZzdojH//iVOvO/wDpjvyX62d8FnK+0mtmk6v63j
         Y0bw==
X-Gm-Message-State: AO0yUKXL9o+/jIUDvpGP3kZR7OVDft9R10ZMCABVUd/eYHPXmfyZTQrX
        EByOD+zqzdFWdG71G7hdCZjVKGbA8snKrDIWnGL8Ig==
X-Google-Smtp-Source: AK7set9dNYqU61hDtlW8MJdhEcGtsXJP+PyXXHPQQHrWox282TbPiivRma1lUTYcT4MMBl8MKHPfHefpMmSyi4I26MM=
X-Received: by 2002:ac2:5def:0:b0:4bd:5210:bd97 with SMTP id
 z15-20020ac25def000000b004bd5210bd97mr18162lfq.25.1676340765901; Mon, 13 Feb
 2023 18:12:45 -0800 (PST)
MIME-Version: 1.0
References: <20230204222411.GC2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9+41ctA54pjm/KG@google.com> <Y+FJSzUoGTgReLPB@rowland.harvard.edu>
 <Y+fN2fvUjGDWBYrv@google.com> <Y+f4TYZ9BPlt8y8B@rowland.harvard.edu>
 <CAEXW_YRuTfjc=5OAskTV0Qt_zSJTPP3-01=Y=SypMdPsF_weAQ@mail.gmail.com>
 <Y+hWAksfk4C0M2gB@rowland.harvard.edu> <CAEXW_YQUOgYxYUNkQ9W6PS-JPwPSOFU5B=COV7Vf+qNF1jFC7g@mail.gmail.com>
 <Y+ppzKlvzQIE18Hu@rowland.harvard.edu> <CAEXW_YRc0qtan5hbTFUeP7B8f-q5BQJS_d2TpKqZ8_aX5A=b2g@mail.gmail.com>
 <Y+rqi1avpv7obhrg@rowland.harvard.edu>
In-Reply-To: <Y+rqi1avpv7obhrg@rowland.harvard.edu>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 13 Feb 2023 21:12:34 -0500
Message-ID: <CAEXW_YQGKRnBwnNYu1EFSYi7FimRR2H8hjAzER3x7U9PxMre1g@mail.gmail.com>
Subject: Re: Current LKMM patch disposition
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 8:57 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Mon, Feb 13, 2023 at 07:36:42PM -0500, Joel Fernandes wrote:
> > Thanks, I agree with most of your last email, just replying to one thing:
> >
> > > > ->rf does because of data flow causality, ->ppo does because of
> > > > program structure, so that makes sense to be ->hb.
> > > >
> > > > IMHO, ->rfi should as well, because it is embodying a flow of data, so
> > > > that is a bit confusing. It would be great to clarify more perhaps
> > > > with an example about why ->rfi cannot be ->hb, in the
> > > > "happens-before" section.
> > >
> > > Maybe.  We do talk about store forwarding, and in fact the ppo section
> > > already says:
> > >
> > > ------------------------------------------------------------------------
> > >         R ->dep W ->rfi R',
> > >
> > > where the dep link can be either an address or a data dependency.  In
> > > this situation we know it is possible for the CPU to execute R' before
> > > W, because it can forward the value that W will store to R'.
> > > ------------------------------------------------------------------------
> >
> > Thank you for pointing this out! In the text that follows this, in
> > this paragraph:
> >
> > <quote>
> > where the dep link can be either an address or a data dependency.  In
> > this situation we know it is possible for the CPU to execute R' before
> > W, because it can forward the value that W will store to R'.  But it
> > cannot execute R' before R, because it cannot forward the value before
> > it knows what that value is, or that W and R' do access the same
> > location.
> > </quote>
> >
> > The "in this situation" should be clarified that the "situation" is a
> > data-dependency. Only in the case of data-dependency,  the ->rfi
> > cannot cause misordering if I understand it correctly. However, that
> > sentence does not mention data-dependency explicitly. Or let me know
> > if I missed something?
>
> The text explicitly says that the dep link can be either an address or a
> data dependency.  In either case, R' cannot be reordered before R.
>
> In theory this doesn't have to be true for address dependencies, because
> the CPU might realize that W and R' access the same address without
> knowing what that address is.  However, I've been reliably informed that
> no existing architectures do this sort of optimization.
>
> The case of a control dependency is different, because the CPU can
> speculate that W will be executed and can speculatively forward the
> value from W to R' before it knows what value R will read.
>

Sorry, I misread it. You are right. Got it now, Thanks.

 - Joel
