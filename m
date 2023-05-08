Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096246FA34D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjEHJaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEHJaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:30:00 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFDDFD
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 02:29:59 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-55a2cb9788dso62711957b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 02:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683538198; x=1686130198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqAxw1DW52bLgCcMTno0ZkGR11/VJi4+OpIzeXhQUmI=;
        b=nnGuxZymxzefK/dFHiKZhuz1+HHnC2j4mlOvmUseuz12RZr3CadHGU6BgD8Fab52OH
         pduBQVULghT9tSOtYY2kr5OM4KlNHz0SwPhUR2R9v5ilmCaARboTFPQAXNpVhVnrrikW
         pn6YgUnvLtFd04C8zLwm1bSczfk9WtGln8OqjJBwEc+LA8tdvOT1ZquB6at+b5/rI6cU
         o4vkdiO0QPHoH57fxNuL++zZ5AOfAIkXGG/aXvCQHr9jw8EUgn5SCB9fE9CoCj72VNrZ
         AdaypOmPi3W5DHUufe9kGTR+VtQnc+RYCd2FcOLmNVb+xAlYupcrZjziUcYNChh4+NpN
         +hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683538198; x=1686130198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqAxw1DW52bLgCcMTno0ZkGR11/VJi4+OpIzeXhQUmI=;
        b=gos7DKkpdo/s42hFIkerNGbsQ8HFCFR0KOdmugIYfb4hkegarqPaMOaX1pWc79g4rZ
         lwQ1qjNI8rK3SIyfxFh9mNySA4B52NAk1cT8HMLtA0+vgnjMeyPvCvZt1SctCwSpybLL
         4WUWhBYk7BhcHgQilWa75HfpWLs/cZIXVnutknNsedjJmgjhXaAZvcKWKISndXtEPT6n
         m5KjDivo2snoWCJiNtogGsRzhrywWfnqCCdKwh6rm+95fosJGbbZzqK6KHt8BqTIRHdg
         ss2cVGzllCRgwtqN5hyp/fbSfs0Aju+ithAleMvaA1dn+ibHJ7th/zMzsneEWtHn38G1
         F3lA==
X-Gm-Message-State: AC+VfDwz58G558jtw90ULaI5bzrDFWKElGMyPMkcTmRBMcdcRWNAUZ74
        CAtQZeGSD0PiA0V4V/7G97OpyBYV7H94mSkJd/w=
X-Google-Smtp-Source: ACHHUZ6KIYoRtkjtu8vVM9vcDdkRETcwmqYHCtGWIJVS0Q6sHtjmHnrwhRWXrt93UM6j6orWXlkcLZHpBQxXq+sedI8=
X-Received: by 2002:a81:84ce:0:b0:55a:3b80:c00d with SMTP id
 u197-20020a8184ce000000b0055a3b80c00dmr9799266ywf.25.1683538198614; Mon, 08
 May 2023 02:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230508055226.3183447-1-brpol@chromium.org>
In-Reply-To: <20230508055226.3183447-1-brpol@chromium.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 8 May 2023 11:29:47 +0200
Message-ID: <CANiq72kHP7SQNkY2iU6h3PacmRZUN3yRfk2VJjROz51YVBXoxw@mail.gmail.com>
Subject: Re: [PATCH v2] .gitignore: ignore smatch generated files
To:     Brandon Pollack <brpol@chromium.org>
Cc:     linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
        masahiroy@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
        keescook@chromium.org, nathan@kernel.org
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

On Mon, May 8, 2023 at 7:54=E2=80=AFAM Brandon Pollack <brpol@chromium.org>=
 wrote:
>
> ignore smatch generated files.

Sorry, I should have mentioned this in v1: this line just repeats the
title -- please also give the rationale for the change in the commit
message, not just what changed.

> Change-Id: I8ca4002128e53024ea8a3daef908ec5e49cec65c

Also, please avoid `Change-Id` (and run `scripts/checkpatch.pl`, which
looks for this sort of things).

Thanks!

Cheers,
Miguel
