Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FE262C07E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbiKPOIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbiKPOHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:07:44 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F0B1EED5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 06:06:23 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-370547b8ca0so168723847b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 06:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiinT+QU+jSUfGUHpjn3RzfsD10BO3tHIkrOGMG6qQg=;
        b=sCCp0rDWjz6wgKDyaob43UT9wF8EJeIgXFYeRgf2y2ETIvFI/+xX+yphNLz/Ngq60H
         SVcceIGsX32NfODV8Sm7GEWRPXcGCFBeGXyoUJSAOe8aZjai2oMwrgGi1I5CY10GP3/t
         hma/6bgTNYonWG1cVWSV5mDc3uAwnvvlGRsKxZwLGXqfQV/CC6DjNmNy2+piF+S9a5FA
         SIk24NuJgubRgVPYBhsNcu5l3RpNSACJCDDnSci0yO8fabPypzGetwRfYKMkVYQu0HmG
         1dx/tbtvS8thp4c2ErzbG+Mi+8lNbvOtnXJhVnXpQtww0pTDPVfSxtqTS2ZtfhDlRPiM
         Eeqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jiinT+QU+jSUfGUHpjn3RzfsD10BO3tHIkrOGMG6qQg=;
        b=DldOE0LDqEO5ouwSVa2xSk/jNwDuUwkSJFHkZ3Vr/E6Lu+4X6DcEAOF3dMJJ3h98JC
         JVBTEQbiclb9JvfGA8GOeGhZzirw2rPsia7ilhd+0IBl6ezWm20ZFciz2yxNUxvqhNYC
         FjuCWg1cda8Z+HODOaaIxLIY9O5UVVS00mQGDOMr7z5KgIO/9saq1ik4cOHA82wa6Mwu
         Tnz5xD82W57ubJ5DYfvnBb31+pQVRj8jBsI/NeDV6vOafDnBU3PKBASrzZKc8yvDIqMM
         65SgqEfD8jMJ6H/4wzZCE2DFBy/gxxFfXoKk9Qq/Y9T9+R9xrtoOw68c7W3vnzH2E32D
         CWFA==
X-Gm-Message-State: ANoB5plJFlWWfrWCcFsj7QtMeQmgYcmlR+7VogNy+PRZheweiuUR1Vby
        3teLqNVLPNDJaqBJeeWbKcJnkWKB0LXBASIZ9rEozw==
X-Google-Smtp-Source: AA0mqf56GM4ixD11KWvfcmOEi9P2sroZwsDH4AHn0M7KNU+ZeXs9gufwyltn/UHp1ukNP1z2SDtYJNXb0PBbVY+C08Y=
X-Received: by 2002:a0d:cc12:0:b0:373:6d43:2ee6 with SMTP id
 o18-20020a0dcc12000000b003736d432ee6mr23333432ywd.443.1668607582163; Wed, 16
 Nov 2022 06:06:22 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYu0p4cFdkrkQyV4OC-iPpY18asV0VTP=O_sysLNaJJAQw@mail.gmail.com>
 <Y3TlVAgo9XSWKm1h@sirena.org.uk>
In-Reply-To: <Y3TlVAgo9XSWKm1h@sirena.org.uk>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 16 Nov 2022 19:36:10 +0530
Message-ID: <CA+G9fYuckvzw_t4iSQ5Kj_FvRb-bfWaT66DazEejrKXePaDGuA@mail.gmail.com>
Subject: Re: kselftest: Bad test result: from results parsing in LAVA
To:     Mark Brown <broonie@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Remi Duraffort <remi.duraffort@linaro.org>
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

On Wed, 16 Nov 2022 at 18:57, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Nov 16, 2022 at 05:46:33PM +0530, Naresh Kamboju wrote:
> > kselftest running on LAVA infrastures provides test results parser
> > from test-definitions repository.
> > which is getting  "Bad test result:".
> >
> > I have noticed this on kernelci [1] and LKFT LAVA instances [2].
> > We need to investigate and change parse_output [3] inside test-definiti=
ons.
> >
> > Report-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Test results parser showing =E2=80=9CBad test results: =E2=80=9C,
>
> When reporting an issue can you please try to provide some
> analysis which goes beyond the level of "I saw an error message"
> - for example here it's hard to tell if you think you're seeing
> an issue somewhere in your test automation system or if you're
> trying to report something in the tests.


Let me add more information about this,

Kees Cook, has done the work of a kselftest results parser in perl
which is in the test-definitions repository. which was working well
for two years now. please refer to the below commit log and link to
the kselftest test-definitions [3].

The new test cases output is not coping up with the old results parser
and both KernelCI [1] and LKFT [2] using LAVA have noticed.
Kselftest results parser problem [4].

---
Repo: test-definitions
commit id:  8bd338bbcfa5a03efcf1d12e25b5d341d5a29cbc
---
kselftest: Parse kTAP for test results

This stops mangling test output for humans and performs a best-effort
kTAP parsing for the kselftest output (including recursive kTAP output).

Signed-off-by: Kees Cook <keescook@chromium.org>


[1] https://storage.kernelci.org/next/master/next-20221116/arm64/defconfig+=
arm64-chromebook/gcc-10/lab-collabora/kselftest-arm64-mt8173-elm-hana.html#=
L3105
[2] https://linaro.atlassian.net/browse/LKQ-934
[3] https://github.com/Linaro/test-definitions/blob/master/automated/linux/=
kselftest/kselftest.sh#L124
[4] https://lkft.validation.linaro.org/scheduler/job/5729151#L2511

--
Linaro LKFT
https://lkft.linaro.org
