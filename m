Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3BF70F9EC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjEXPSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbjEXPSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:18:41 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0200119
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:18:39 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-75788255892so87324885a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684941518; x=1687533518;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R/hFOOQmfGx7+HJRZISAzOkWKz6d91kYsAkJvfc4b1M=;
        b=GlTpJV4kZRYGt/6lomvT7DI9jwAt1o3eaE6UKh0EbQ9UaYYH7oqHym1V0YSJT9FIzN
         eIz4btGMno/4jWk0e11WjlRcw5lX1s5gTophRENL8vx49mprjDbGNYDQBTGwK6DDmk8q
         2+7CRswWoVWQMRvii9AdgvAhzmNcNwU+jh3rWqwFu7YP9WMy1u7504zmB7yLGbAl9l2X
         eCzb/AQuhfJpNfx2NykzFTZgGGyZdI2ppo3g2Xtaicv8xkOERfxxX+Nu3qGdbHAY0BQg
         S1JysCiY+l9lEUdkC43zqR5jU021oSve+AiQDwKHE1iZfLiOcMqIKgb8z265k8Q5Uord
         a6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684941518; x=1687533518;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R/hFOOQmfGx7+HJRZISAzOkWKz6d91kYsAkJvfc4b1M=;
        b=bjIwwhnMwjXx5BOyEYM7RNBKlvpX2xKwuDBQJ4mgaNTvsRxr9CqT8LJRBdwdseMHZ9
         S5AUaKb5sIYpfK0eFpvdfC7hVJRupv7eEMgWGkKNN9BtTU8Sygu7KUY/F2g8waHGX5jV
         6zkuVoeVv/Cc12JAjKjGZ9+Sg5PG7SaPazfCYumALjuywiMvtSjXnpSJ14exOmlFDZ3t
         LX5DuqMVp3MvH9aNpujLV2/nsjWCfjEcS56Dxj0toAqjNaCnVNFNgqBAVB5S8erOBNoh
         q36woyqXjf8/msNU4zuSXJQH57e84UMQOi3/TDHvyXTuqxjfCarBzwDpVVlFQ1WYz4KB
         z3vg==
X-Gm-Message-State: AC+VfDxuPQr1boj6GldKGaU1+BISy6DjZOAunRdOF3XY7q53xFPkXgou
        /9VOZ2qMxayYhWYVw0FN9CP6JS1QDOJpXn9W3gnybw==
X-Google-Smtp-Source: ACHHUZ6kZRLtcm5Ivuq9/3a1vqVOZ2iGg8E7jPD0jtpCtTlhoIPAlGs2c2/MFBo5ONFujkNu2BUbVkjB++892s9FGsY=
X-Received: by 2002:a37:b55:0:b0:75b:23a1:8e42 with SMTP id
 82-20020a370b55000000b0075b23a18e42mr7412299qkl.19.1684941518604; Wed, 24 May
 2023 08:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230515145323.1693044-1-amit.pundir@linaro.org> <36e5798e-72e2-0212-fe61-94d0075099d2@leemhuis.info>
In-Reply-To: <36e5798e-72e2-0212-fe61-94d0075099d2@leemhuis.info>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Wed, 24 May 2023 20:48:02 +0530
Message-ID: <CAMi1Hd2ukv2iu343hJ+r9SzQ1eZjGB0YPHUB5oxjKwsJ4XKyww@mail.gmail.com>
Subject: Re: [PATCH] Revert "regulator: qcom-rpmh: Revert "regulator:
 qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS""
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023 at 19:21, Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> [CCing the regression list, as it should be in the loop for regressions:
> https://docs.kernel.org/admin-guide/reporting-regressions.html]
>
> On 15.05.23 16:53, Amit Pundir wrote:
> > This reverts commit ad44ac082fdff7ee57fe125432f7d9d7cb610a23.
> >
> > This patch restores the synchronous probing for
> > qcom-rpmh-regulator because asynchronous probing broke
> > Dragonboard 845c (SDM845) running AOSP. UFSHC fail to
> > initialize properly and DB845c fails to boot regardless
> > of "rootwait" bootarg being present or not
> > https://bugs.linaro.org/show_bug.cgi?id=5975.
> >
> > Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> > ---
> >  drivers/regulator/qcom-rpmh-regulator.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
> > index b0a58c62b1e2..30659922b0aa 100644
> > --- a/drivers/regulator/qcom-rpmh-regulator.c
> > +++ b/drivers/regulator/qcom-rpmh-regulator.c
> > @@ -1517,7 +1517,7 @@ MODULE_DEVICE_TABLE(of, rpmh_regulator_match_table);
> >  static struct platform_driver rpmh_regulator_driver = {
> >       .driver = {
> >               .name = "qcom-rpmh-regulator",
> > -             .probe_type = PROBE_PREFER_ASYNCHRONOUS,
> > +             .probe_type = PROBE_FORCE_SYNCHRONOUS,
> >               .of_match_table = of_match_ptr(rpmh_regulator_match_table),
> >       },
> >       .probe = rpmh_regulator_probe,
>
> Amit, just wondering: what happened to this? It seems there was some
> agreement to go down this route to fix your regression, but then nothing
> happened anymore since about a week. Or am I missing something?

Hi, I didn't get around to try out new things last week as suggested
on the original thread [1]. I'll get back to debugging it later in the
week hopefully.

Regards,
Amit Pundir
[1] https://lore.kernel.org/all/CAD=FV=VSFDe445WEVTHXxU1WS_HGUV5jR5E8_Vgd4eyhn3rHyA@mail.gmail.com/

>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>
> #regzbot ^backmonitor:
> https://lore.kernel.org/lkml/CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com/
