Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52AF6C0C91
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjCTIyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjCTIy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:54:29 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99DDBDE3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 01:54:27 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5416b0ab0ecso211514217b3.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 01:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679302467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VwCsLRx1BqoZCFKmvQkscs5AX5CM53X2foeYLp/it0=;
        b=kTQ2+k4ktXPkorygBmiiPssqIsjIfTv+lp5cN34Qm/XVt8ZAquFzTlEHBSNT7cNQVx
         a3XRr3oIkD3xDMGCZYSuKx25VC+KCKZwuD+FLmsLp+rTaZ9uZ/qj6ukVjqcglVR9pM1S
         iYFfPtSl2S6YFvcpD2YKN8hOP5nMcWC7bH4//qIW6gGbKw9NXAQVLKMULDK13KE556XT
         /ZmoZTcaksoRup1cu17dZWwBjJ2WIJdtiFGVIff/Q6h+HQVQTjKG9nY5WsXDn9rQO5MR
         eejLd9ZpXN41xqpwdOydlRoaWcggBgVvNwV34wVFGhJQa2xWoS4mhTaexYcAJSMjFgq+
         0z7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679302467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VwCsLRx1BqoZCFKmvQkscs5AX5CM53X2foeYLp/it0=;
        b=cqLLWc4yrL7TRZf2gdZFISyN3BQer/FGa8fhJHXsr6KFpJYlJvW467jTZVTr2wvIlp
         eyul6pKH7XUvwrlAtHAUKAI5h5CWhs3qf0Wsa8UpAygKn52s1atsNyLytYEYvrPHMt08
         8aC/JhVSw2qZj+Fp16wxYlPXqepSYVKWk5vVUm1/rAO/zeeIje0T7nMlUYrvtDd1BFk0
         +XaKkfR8aED0q3j4CflyWbm8202gIX01be9b355hHgliYkPhYb/b+A2evylagI/BqwE2
         mctkLhJveuLN2gI0WYORqZWUcY8gTuOq1jWJFLGZeAjeVgSqxJbGRoXsS6vtoO41B6LR
         qGjA==
X-Gm-Message-State: AO0yUKWlTDGSHxHkYPRXpFheOU3Vsq9k0pZZtVnn1Cho6Mvajnt1SQJt
        cAaaF8q7yCFAK6c6fMlmkJ1EaRSe3z7edzFCHNuICQ==
X-Google-Smtp-Source: AK7set9cIGT0nR09rLwg0UKkmrZo3q2jtFt7Xnztz809nAEgzPbiDoHduicc8RaVr7/eQUZ9wKC7+XPwFfILUV0Geo8=
X-Received: by 2002:a81:c749:0:b0:541:753d:32f9 with SMTP id
 i9-20020a81c749000000b00541753d32f9mr10032764ywl.9.1679302466888; Mon, 20 Mar
 2023 01:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <1679070482-8391-1-git-send-email-quic_mojha@quicinc.com>
 <1679070482-8391-2-git-send-email-quic_mojha@quicinc.com> <CACRpkdb95V5GC81w8fiuLfx_V1DtWYpO33FOfMnArpJeC9SDQA@mail.gmail.com>
 <20230320032238.xf5jlt43qebcewm4@ripper>
In-Reply-To: <20230320032238.xf5jlt43qebcewm4@ripper>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 20 Mar 2023 09:54:15 +0100
Message-ID: <CACRpkdYq96d=0hoBhNGYihVJbX-D4WLw3+GdQC5_NDXuBiaF7Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] firmware: qcom_scm: provide a read-modify-write function
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 4:19=E2=80=AFAM Bjorn Andersson <andersson@kernel.o=
rg> wrote:

> > This is starting to reimplement regmap.
> > In this case regmap_update_bits().
> >
> > What about just using regmap as accessor for these
> > registers instead?
> >
>
> I'm not sure it would be beneficial...

Me neither, I don't know the details, I just notice the similarity in the
accessors.

> The regmap interface provides a standardized representation of a block
> of registers, with the suitable accessors backing it. But in both cases
> touched upon in this series, the addressed registers are part of regions
> already handled by the kernel.
>
> So it wouldn't be suitable to create a regmap-abstraction for "a block
> of secure registers", at best that would give us two kinds of regmaps
> abstracting the same register block.

From my viewpoint regmap does three things:
- Abstract one coherent region of registers under a shared lock, with
  nifty accessors (such as mask-and-set with regmap_update_bits())
- Maps access patterns/permissions and permissible access range
- Optionally cache the contents

The way I would use it if these secure registers are in the same range as a
bunch of non-secure ones is for sharing a lock and the regmap accessors.

I wouldn't worry about access patterns and such. That usecase (block
access to certain registers or bits) is partly overdesign in some cases
IMO.

If regmap abstraction isn't helpful overall then we shouldn't do it.

Yours,
Linus Walleij
