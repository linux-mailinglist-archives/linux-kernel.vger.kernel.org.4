Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4BB6A72C2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjCASJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjCASI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:08:59 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD5526A6;
        Wed,  1 Mar 2023 10:08:56 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5384ff97993so380328077b3.2;
        Wed, 01 Mar 2023 10:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677694136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vetzCZT//aXoqW+ear2H/1HiRM5zvhdG/vxqeKjVms0=;
        b=bC1hZHUj26dNa8Mv3NP+U34nD9Lcy002I+iLgDbZw3q+sK4y1CjEFoJ0N8oqUSWRGM
         71r65iYetAUixKwlDjFlp0fxXJp6aT/FQVyPVg9qnrqFSENvGyR60UePAm2pr92iVIou
         sLTD9oT2g8QHwOQ25+cMpiw+oAbtBFNJsxPaQJNsl40KKSxdXbgmZDBoTzqnofXeOVmN
         VNQ/OCyzi8gpnLETrFnVl1/UwhpK3SLHPKzP6I6GxTVyr3rUCCrA+8wczPjEI9kWXoZ5
         6nL37WN6l68T1xUz2vp4Y9V4UMXUlnz9g2NEOHN6Wjwm1sMj0+01NirptfbiOtrs8ODe
         671A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677694136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vetzCZT//aXoqW+ear2H/1HiRM5zvhdG/vxqeKjVms0=;
        b=Aa7JyjeGy874dSWdVSdrgRsRR2nOXoSbfl+TGjpAQynd27uOS5hc+UjcCDZM0nV8+9
         N3IVvojNARzu1oeY7lppc9JEDKQzWA0d4aMkaTBqyxDWGhqcHpiH5YgmF1ihdIeKQcVA
         JCAbpvgRWJmgjDigSl7XplqIOJTMkCXT9LIMfiWfLOAlKTVu7jHKoZqrRSuTMQZqSf1q
         FthzqAyNz2M8X30VGbKhnJKPZXZdeDtyVt3HkNOr6OXk3IYRJ4MbNH5Xc1SUsXns3mMN
         DgiemdEghtPN/eCRGMqWXb5GbiouUs5KRzW4UIvdi2j5oFNu2sl1QlqHD9T8icqDLK5A
         8/rg==
X-Gm-Message-State: AO0yUKUc+u2oydQPpjJ22G1K5VGHMPCBqyu6UxQkEu+ec87HR4Oglc7K
        DyS4VK+iC1+Z9bz1Xj+0ASNdXk4jmTMRiEKuYHeabKYciAE=
X-Google-Smtp-Source: AK7set9P9e4jFGN501oySTO3CTpvxtLxBLDMZB99wvNrvQGk/NzbJ/DO5QbUwZ2rqU09SZSIK3rwCDRu/5gFIYP7zhA=
X-Received: by 2002:a05:690c:e1c:b0:52e:ac97:115f with SMTP id
 cp28-20020a05690c0e1c00b0052eac97115fmr7140160ywb.5.1677694135831; Wed, 01
 Mar 2023 10:08:55 -0800 (PST)
MIME-Version: 1.0
References: <20230228175929.7534-1-ubizjak@gmail.com> <20230228175929.7534-4-ubizjak@gmail.com>
 <20230228164346.0691bb11@gandalf.local.home> <CAFULd4aGx=kGYYUz0BkFJz3abz97WOwDEgFHAOocT8SWT2oX-Q@mail.gmail.com>
 <20230301111850.768f8526@gandalf.local.home> <20230301112808.73d1e316@gandalf.local.home>
In-Reply-To: <20230301112808.73d1e316@gandalf.local.home>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 1 Mar 2023 19:08:44 +0100
Message-ID: <CAFULd4ZQFONC-q66nCxj4B7r+PmyAf5V0KEhgrsnwR4NNxT4+g@mail.gmail.com>
Subject: Re: [PATCH 3/3] ring_buffer: Use try_cmpxchg instead of cmpxchg
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 5:28=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Wed, 1 Mar 2023 11:18:50 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > But with gcc 12.2.0 I don't really see the benefit. And I'm worried tha=
t
> > the side effect of modifying the old variable could cause a bug in the
> > future, if it is used after the try_cmpxchg(). At least for the second =
case.
>
> Actually, I like Joel's recommendation of adding a cmpxchg_succeeded()
> function, that does the try_cmpxchg() without needing to save the old
> variable. That's my main concern, as it does have that side effect that
> could be missed when updating the code.

I understand your concern regarding updating of head_page_with_bit in
the middle of rb_insert_pages. OTOH, rb_head_page_replace is a small
utility function where update happens in a return clause, so there is
no chance of using val after the try_cmpxchg. If we can ignore the
"updating" issue in rb_head_page_replace, we can simply define
cmpxchg_success in front of rb_insert_pages (now its sole user) and be
done with it.

Uros.
