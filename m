Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710245B519D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 00:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiIKWv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 18:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiIKWvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 18:51:55 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EEA1F616
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 15:51:54 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id s10so7967413ljp.5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 15:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=yM7pyJPLpZr6W6HgiirCcLKrLf3hCJUXHi6htit82Vw=;
        b=F4gwHKGWrQRu6pQJx8cBbxgt54jl4czoZk8Z4XVyTLguTxfbTzp6sMpZu8nIopJM2r
         k3lLw7PnronxpJ83KSkAOswSbH5NguzrQ0aJ52dMv2/tgC7w6PtqBbJmP7e+eIzYJNjT
         OK4AlelOQbbd0CRd1YsxqERBq/nE1HX0r5lYzhvNDmjof/ooxKnjMBkKo9XYv6k1NQbZ
         h0ScnWs/6eZVeInjjf2LfRO0PClybPgCLZtW630AqifEb2u7Em2Z9xZvkKQ9qXSaSRNt
         YBxlTwZezBGCrDaV5nV4tOauakGCrfS+TiblC5MYYeHeJ6SwKmVGXfiqz/2BI6Tu3EJ0
         rVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yM7pyJPLpZr6W6HgiirCcLKrLf3hCJUXHi6htit82Vw=;
        b=1ktE0f8/afeJ6NTrKYM2g9tW21d/K/lOJLDDD8ByYNxdE48aOtcoOsn2HnYY95hEy1
         Oln/0ZicKhpOZQM+WUPFTWhc/ROLM4WAJrA6gACsdh6D07IWfjfv2A3H9+7JtWPa46sL
         OvAXm1xsH+dV33Fn8VErvd9ZlQAKOxRQEKGde7aZO/Ndb6A0Ldo1x0c3BUbSQ2PCby9f
         r9bOjidmVtANZioyrW2p51kWute9owpsExheI0fnVzuEqTxEUKatZ2A8IMlRoddnmAsG
         UUW75taLTb1MOLTfmK9yCC4SiCLSUXYlJo4BQIZezRbaMomvNi4kZk5VojcJ3dpk+/Wf
         aaTA==
X-Gm-Message-State: ACgBeo1ep4O1JVvF+8t2qZxeF1ygqCSsPvRqvQr8/sKdi6nDtc2+VJUu
        Ydx8FpLpNYh7VPWue0knwhEHJM/l5ymlcfC5/gc=
X-Google-Smtp-Source: AA6agR5FE2L8IC9yEVhYpJMTOZNPsrCj5VjsOUZA2VTB44ysrpFgzMSgWY/3NJH2N0zA6jcgT0doiinOz5DhHasfwHY=
X-Received: by 2002:a2e:98ce:0:b0:26b:e763:27d1 with SMTP id
 s14-20020a2e98ce000000b0026be76327d1mr3464714ljj.306.1662936712597; Sun, 11
 Sep 2022 15:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <YxAq2jYvGG8QOypu@gmail.com> <87czcfhsme.fsf@email.froward.int.ebiederm.org>
 <bdff6cf478fc29c80997a623a57dae5f@ispras.ru> <874jxkcfoa.fsf@email.froward.int.ebiederm.org>
 <da95e333b4c508ddf8130f8f2d2cbb92@ispras.ru> <YxjRx3+MipdFOudw@gmail.com>
 <20220908081003.sjuerd5wiyge4jos@wittgenstein> <87v8pxa51n.fsf@email.froward.int.ebiederm.org>
 <20220909075158.ed4linrpwwabxabl@wittgenstein> <202209110810.F7352A26@keescook>
In-Reply-To: <202209110810.F7352A26@keescook>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Sun, 11 Sep 2022 15:51:41 -0700
Message-ID: <CANaxB-yhmfRru4+n_+Q39QpkTzZjBHqkoq3JFwAG9mXDd0bjKA@mail.gmail.com>
Subject: Re: Potentially undesirable interactions between vfork() and time namespaces
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Izbyshev <izbyshev@ispras.ru>,
        Florian Weimer <fweimer@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2022 at 8:12 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Sep 09, 2022 at 09:51:58AM +0200, Christian Brauner wrote:
> > As stated above the proposed exec behavior we currently clearly emulate
> > in userspace. So that part is fine.
>
> It's not clear to me yet what the right solution is from this thread so
> far... what's needed for v6.0 release (since we're quickly running out
> of release candidates)?

Kees,

I think we reached a consensus to go with Eric's idea. We will send
the patch shortly.

Thanks,
Andrei
